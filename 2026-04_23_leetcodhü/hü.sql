180
select Distinct (eins.num) as ConsecutiveNums from Logs eins 
 join Logs zwei on eins.id = zwei.id +1 
 join Logs drei on zwei.id = drei.id+1 where eins.num = zwei.num and zwei.num= drei.num;

586
select customer_number
from Orders
group by customer_number
order by count(order_number) desc
limit 1;

 596
 select class 
 from Courses 
 group by class 
 having count(student) >=5;