use mysql;

-- switch to a different delimiter
delimiter $$

create procedure drop_empty_databases()
begin

    declare table_schema varchar(200); -- will hold schema obtained from query
    declare schema_end int default 0;  -- temp variable that's set to 1 when reading of all schema is done

    -- cursor that lists all schemas with no tables
    declare cur cursor for 
        select s.schema_name
        from information_schema.schemata s
        left join information_schema.tables t on t.table_schema = s.schema_name
        group by s.schema_name
        having count(t.table_name) = 0;

    -- set schema_end to 1 when we run out of schemas while looping
    declare continue handler for not found set schema_end = 1;

    open cur;
    looper: loop
        fetch cur into table_schema;
        if schema_end = 1 then
            leave looper;
        end if;

        set @sql = concat('drop database ', table_schema);
        prepare stmt from @sql;
        execute stmt;
    end loop;
    close cur;

end
$$

-- switch back to semi-colon delimiter
delimiter ;

/*
Usage:
use mysql;
call drop_empty_databases();
*/
