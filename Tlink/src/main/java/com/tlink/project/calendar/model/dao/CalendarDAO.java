package com.tlink.project.calendar.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.tlink.project.calendar.model.dto.CalendarData;
import com.tlink.project.notice.model.dto.NoticeFiles;

@Repository
public class CalendarDAO {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	/**모든 일정 조회하기
	 * @return
	 */
	public List<CalendarData> selectAll() {
		List<CalendarData> cal =sqlSession.selectList("calendarDataMapper.selectAll");
		return cal;
	}
	
	/**일정 추가하기(여기서 휴가 추가까지 실행)
	 * @param calendar
	 * @return
	 */
	public int insertEvent(CalendarData calendar) {
		return sqlSession.insert("calendarDataMapper.insertEvent", calendar);
	}

	/**일정 수정하기
	 * @param calendar
	 * @return
	 */
	public int updateEvent(CalendarData calendar) {
		return sqlSession.update("calendarDataMapper.updateEvent", calendar);
	}

	/**일정 삭제하기
	 * @param scheduleNo
	 * @param memberNo 
	 * @return
	 */
	public int deleteEvent(int scheduleNo, int memberNo) {
	    Map<String, Integer> deleteHoliday = new HashMap<>();
	    deleteHoliday.put("scheduleNo", scheduleNo);
	    deleteHoliday.put("memberNo", memberNo);

		return sqlSession.delete("calendarDataMapper.deleteEvent", deleteHoliday);
	}
	
	
	/**휴가 파일 등록하기
	 * @param fileData
	 * @return
	 */
	public int insertScheduleFile(NoticeFiles fileData) {
		return sqlSession.insert("calendarDataMapper.insertScheduleFile", fileData);
	}

	/**휴가 파일 수정하기
	 * @param fileData
	 * @return
	 */
	public int updateScheduleFile(NoticeFiles fileData) {
		return sqlSession.update("calendarDataMapper.updateScheduleFile", fileData);
	}

	/**휴가 파일 삭제하기
	 * @param scheduleNo
	 * @return
	 */
	public int deleteHolidayFile(int scheduleNo) {
		return sqlSession.delete("calendarDataMapper.deleteHolidayFile", scheduleNo);
	}





	
	
}
