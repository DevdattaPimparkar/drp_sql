--creating the table to mention SCDs

create table SCD_Type
(
    SCD_Type varchar(20),
    SP_Name varchar(20)
);

insert into SCD_Type
(
    SCD_Type,
    SP_Name
)
values
('SCD_Type_1', 'scd1'),
('SCD_Type_2', 'scd2')


---- Required SP


go
create or alter procedure execute_sp2 (@SCD_type varchar(100) = null)
as
begin
    declare @RowsToProcess int
    declare @proc_name varchar(20)
    declare @proc_tbl table
    (
        nos int identity,
        sp_name varchar(20)
    )
    if @SCD_type is null
        insert @proc_tbl
        select SP_name
        from SCD_type
    else
        insert @proc_tbl
        select SP_name
        from SCD_type
        where SCD_type = @SCD_type
    set @RowsToProcess = @@ROWCOUNT

    declare @sp_name varchar(20)
    while @RowsToProcess > 0
    begin
        select @sp_name = sp_name
        from @proc_tbl
        where nos = @RowsToProcess
        execute @sp_name
        set @RowsToProcess = @RowsToProcess - 1
    end

end

execute execute_sp2 @SCD_type = 'SCD_Type_2'