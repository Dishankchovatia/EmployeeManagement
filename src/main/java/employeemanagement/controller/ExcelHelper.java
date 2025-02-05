package employeemanagement.controller;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.CellType;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import employeemanagement.dao.EmployeeDao;
import employeemanagement.model.Employee;
import employeemanagement.service.EmailService;

@Controller
public class ExcelHelper {
	@Autowired
	private EmployeeDao employeeDao;

	@Autowired
	private EmailService emailService;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@PostMapping("/importEmployees")
	public String importEmployees(@RequestParam("file") MultipartFile file, RedirectAttributes redirectAttributes) {
		if (file.isEmpty()) {
			redirectAttributes.addFlashAttribute("message", "Please select a file to upload.");
			return "redirect:/admin/listofemployees";
		}

		List<String> errors = new ArrayList<>();
		int successCount = 0;
		int rowNumber = 0;

		try (InputStream inputStream = file.getInputStream()) {
			Workbook workbook = new XSSFWorkbook(inputStream);
			Sheet sheet = workbook.getSheetAt(0);

			for (Row row : sheet) {
				rowNumber++;
				if (row.getRowNum() == 0) {
					continue;
				}

				try {

					int id = (int) row.getCell(0).getNumericCellValue();
					String name = getCellValueAsString(row.getCell(1));
					String employeeId = getCellValueAsString(row.getCell(2));

					Cell mobileCell = row.getCell(3);
					String mobile;
					if (mobileCell.getCellType() == CellType.NUMERIC) {

						mobile = String.format("%.0f", mobileCell.getNumericCellValue());
					} else {
						mobile = mobileCell.getStringCellValue();
					}
					String email = getCellValueAsString(row.getCell(4));
					String gender = getCellValueAsString(row.getCell(5));
					String dob = getCellValueAsString(row.getCell(6));
					String doj = getCellValueAsString(row.getCell(7));
					String plainPassword = getCellValueAsString(row.getCell(8));

					Employee existingEmployeeByEmail = employeeDao.findEmployeeByEmail(email);
					boolean isMobileExists = employeeDao.isMobileNumberExists(mobile);

					Employee existingEmployee = employeeDao.getEmployee(id);

					if (existingEmployee != null) {
						// Update existing employee
						if (existingEmployeeByEmail != null && existingEmployeeByEmail.getId() != id) {
							errors.add(
									"Row " + rowNumber + ": Email '" + email + "' already exists for another employee");
							continue;
						}
						if (isMobileExists && !mobile.equals(existingEmployee.getEmpNumber())) {
							errors.add("Row " + rowNumber + ": Mobile number '" + mobile
									+ "' already exists for another employee");
							continue;
						}

						existingEmployee.setEmpName(name);
						existingEmployee.setEmployeeId(employeeId);
						existingEmployee.setEmpNumber(mobile);
						existingEmployee.setEmailId(email);
						existingEmployee.setGender(gender);
						existingEmployee.setDob(dob);
						existingEmployee.setDoj(doj);
						String encryptedPassword = passwordEncoder.encode(plainPassword);
						existingEmployee.setPassword(encryptedPassword);
						employeeDao.updateEmployee(existingEmployee);
					} else {
						// Add new employee
						if (existingEmployeeByEmail != null) {
							errors.add("Row " + rowNumber + ": Email '" + email + "' already exists");
							continue;
						}
						if (isMobileExists) {
							errors.add("Row " + rowNumber + ": Mobile number '" + mobile + "' already exists");
							continue;
						}

						Employee newEmployee = new Employee();
						newEmployee.setId(id);
						newEmployee.setEmpName(name);
						newEmployee.setEmployeeId(employeeId);
						newEmployee.setEmpNumber(mobile);
						newEmployee.setEmailId(email);
						newEmployee.setGender(gender);
						newEmployee.setDob(dob);
						newEmployee.setDoj(doj);
						String encryptedPassword = passwordEncoder.encode(plainPassword);
						newEmployee.setPassword(encryptedPassword);

						employeeDao.createEmployee(newEmployee);

						try {
							emailService.sendCredentialEmail(newEmployee, plainPassword);
						} catch (Exception e) {
							errors.add("Row " + rowNumber + ": Employee created but failed to send email - "
									+ e.getMessage());
						}
					}
					successCount++;

				} catch (Exception e) {
					errors.add("Row " + rowNumber + ": " + e.getMessage());
				}
			}

			StringBuilder message = new StringBuilder();
			if (successCount > 0) {
				message.append(successCount).append(" employees imported successfully. ");
			}
			if (!errors.isEmpty()) {
				message.append("Errors occurred: \n").append(String.join("\n", errors));
			}
			redirectAttributes.addFlashAttribute("message", message.toString());

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

	// export through excel
	@GetMapping("/export")
	public void downloadExcel(HttpServletResponse response) throws IOException {
		response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
		response.setHeader("Content-Disposition", "attachment; filename=employees.xlsx");

		List<Employee> employees = employeeDao.getEmployees();

		try (Workbook workbook = new XSSFWorkbook()) {
			Sheet sheet = workbook.createSheet("Employees");
			Row headerRow = sheet.createRow(0);
			String[] columns = { "ID", "Name", "EmployeeID", "Mobile No", "Email", "Gender", "DOB", "DOJ", "PASSWORD" };

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
				row.createCell(2).setCellValue(emp.getEmployeeId());
				row.createCell(3).setCellValue(emp.getEmpNumber());
				row.createCell(4).setCellValue(emp.getEmailId());
				row.createCell(5).setCellValue(emp.getGender());
				row.createCell(6).setCellValue(emp.getDob().toString());
				row.createCell(7).setCellValue(emp.getDoj().toString());
				row.createCell(8).setCellValue(emp.getPassword().toString());
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
