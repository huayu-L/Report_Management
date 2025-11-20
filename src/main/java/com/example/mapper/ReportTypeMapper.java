package com.example.mapper;

import com.example.entity.ReportType;
import org.apache.ibatis.annotations.*;

import java.util.List;

@Mapper
public interface ReportTypeMapper {
    @Select("SELECT * FROM report_types")
    List<ReportType> findAll();

    @Select("SELECT * FROM report_types WHERE id=#{id}")
    ReportType findById(Integer id);

    @Insert("INSERT INTO report_types(type_name, description) VALUES(#{typeName}, #{description})")
    @Options(useGeneratedKeys = true, keyProperty = "id")
    int insert(ReportType reportType);

    @Update("UPDATE report_types SET type_name=#{typeName}, description=#{description} WHERE id=#{id}")
    int update(ReportType reportType);

    @Delete("DELETE FROM report_types WHERE id=#{id}")
    int delete(Integer id);
}
