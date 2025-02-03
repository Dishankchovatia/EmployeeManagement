package employeemanagement.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Employee;

@Controller
public class ExcelHelper {

	@Autowired
	private EmployeeDao employeeDao;

	// import through excel
	@PostMapping("/importEmployees")
	public String importEmployees(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
		if (file.isEmpty()) {
			redirectAttributes.addFlashAttribute("message", "Please select a file to upload.");
			return "redirect:/listofemployees";
		}

		try (InputStream inputStream = file.getInputStream()) {
			Workbook workbook = new XSSFWorkbook(inputStream);
			Sheet sheet = workbook.getSheetAt(0);

			for (Row row : sheet) {
				if (row.getRowNum() == 0) {
					continue;
				}

				int id = (int) row.getCell(0).getNumericCellValue();
				String name = getCellValueAsString(row.getCell(1));
				String mobile = getCellValueAsString(row.getCell(2));
				String email = getCellValueAsString(row.getCell(3));
				String gender = getCellValueAsString(row.getCell(4));
				String dob = getCellValueAsString(row.getCell(5));
				String doj = getCellValueAsString(row.getCell(6));

				Employee existingEmployee = employeeDao.getEmployee(id);
				if (existingEmployee != null) {
					// Update existing employee
					existingEmployee.setEmpName(name);
					existingEmployee.setEmpNumber(mobile);
					existingEmployee.setEmailId(email);
					existingEmployee.setGender(gender);
					existingEmployee.setDob(dob);
					existingEmployee.setDoj(doj);
					employeeDao.updateEmployee(existingEmployee); // Update in the database
				} else {
					// Add new
					Employee newEmployee = new Employee();
					newEmployee.setId(id);
					newEmployee.setEmpName(name);
					newEmployee.setEmpNumber(mobile);
					newEmployee.setEmailId(email);
					newEmployee.setGender(gender);
					newEmployee.setDob(dob);
					newEmployee.setDoj(doj);
					employeeDao.createEmployee(newEmployee);
				}
			}

			redirectAttributes.addFlashAttribute("message", "Employees imported successfully!");
		} catch (Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("message", "Failed to import employees: " + e.getMessage());
		}

		return "redirect:/listofemployees";
	}

	private String getCellValueAsString(Cell cell) {
		if (cell == null) {
			return "";
		}

		switch (cell.getCellType()) {
		case STRING:
			return cell.getStringCellValue();
		case NUMERIC:
			if (DateUtil.isCellDateFormatted(cell)) {
				return cell.getDateCellValue().toString(); // Handle date cells
			} else {
				return String.valueOf((int) cell.getNumericCellValue()); // Handle numeric cells
			}
		case BOOLEAN:
			return String.valueOf(cell.getBooleanCellValue());
		case FORMULA:
			return cell.getCellFormula();
		default:
			return "";
		}
	}

	//export through excel
	@GetMapping("/employees/export")
	public void downloadExcel(HttpServletResponse response) throws IOException {
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=employees.xlsx");

		List<Employee> employees = employeeDao.getEmployees();

		try (Workbook workbook = new XSSFWorkbook()) {
			Sheet sheet = workbook.createSheet("Employees");
			Row headerRow = sheet.createRow(0);
			String[] columns = { "ID", "Name", "Mobile No", "Email", "Gender", "DOB", "DOJ" };

			for (int i = 0; i < columns.length; i++) {
				Cell cell = headerRow.createCell(i);
				cell.setCellValue(columns[i]);
				cell.setCellStyle(getHeaderStyle(workbook));
			}

			int rowNum = 1;
			for (Employee emp : employees) {
				Row row = sheet.createRow(rowNum++);
				row.createCell(0).setCellValue(emp.getId());
				row.createCell(1).setCellValue(emp.getEmpName());
				row.createCell(2).setCellValue(emp.getEmpNumber());
				row.createCell(3).setCellValue(emp.getEmailId());
				row.createCell(4).setCellValue(emp.getGender());
				row.createCell(5).setCellValue(emp.getDob().toString());
				row.createCell(6).setCellValue(emp.getDoj().toString());
			}

			workbook.write(response.getOutputStream());
		}
	}

	private CellStyle getHeaderStyle(Workbook workbook) {
		CellStyle style = workbook.createCellStyle();
		Font font = workbook.createFont();
		font.setBold(true);
		style.setFont(font);
		return style;
	}
}
