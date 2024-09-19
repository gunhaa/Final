package com.tlink.project.calendar.model.service;

import java.io.IOException;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.tlink.project.calendar.model.dto.CalendarData;
import com.tlink.project.notice.model.dto.NoticeFiles;

public interface CalendarService {

	/**모든 일정 조회하기
	 * @return
	 */
	List<CalendarData> selectAll();
	
	/**일정 추가하기
	 * @param calendar
	 * @return
	 */
	int insertEvent(CalendarData calendar);

	/**일정 수정하기
	 * @param calendar
	 * @return
	 */
	int updateEvent(CalendarData calendar);

	/**일정 삭제하기
	 * @param scheduleNo
	 * @param memberNo 
	 * @return
	 */
	int deleteEvent(int scheduleNo, int memberNo);

	
	/**휴가 추가하기
	 * @param calendar
	 * @param scheduleFile
	 * @param webPath
	 * @param filePath
	 * @return
	 */
	int insertHoliday(CalendarData calendar, MultipartFile scheduleFile, String webPath, String filePath) throws IllegalStateException, IOException;

	/**휴가 수정하기
	 * @param calendar
	 * @param webPath
	 * @param filePath
	 * @param deleteList
	 * @param scheduleFile
	 * @return
	 * @throws IllegalStateException
	 * @throws IOException
	 */
	int updateHoliday(CalendarData calendar, String webPath, String filePath, String deleteList, MultipartFile scheduleFile) throws IllegalStateException, IOException;

	/**휴가 삭제하기
	 * @param scheduleNo
	 * @param memberNo
	 * @return
	 */
	int deleteHoliday(int scheduleNo, int memberNo);




}
