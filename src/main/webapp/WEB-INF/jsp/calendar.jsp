<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	
<style type="text/css">

	div.fc-row>table>thead > tr:first-child {
	background-color: orange;
	}
	td.fc-day{
	background-color: #F5EE90;
	}

	body {
		font-family: "Lucida Grande",Helvetica,Arial,Verdana,sans-serif;
		font-size: 14px;
	}

	#calendar {
		max-width: 900px;
		margin: 0 auto;
	}

</style>


<script>

	$(document).ready(function() {
		var eventdata;
		var insTitle;
		var insStart;
		var insEnd;
		
		var Appointment = function(id,title,detail,applicant_name,day,time){
			this.Id = id;
			this.Title = title;
			this.Detail = detail;
			this.Applicant_name = applicant_name;
			this.Day = day;
			this.Time = time;
		}
		
		var app1 = new Appointment('1','java senior','first interview','appname','2015-10-01','16:00');
		
		
		$('#calendar').fullCalendar({
			header: {
				left: 'prev,next today',
				center: 'title',
				right: 'month,agendaWeek,agendaDay'
			},
			defaultDate: '2015-10-01',
			selectable: true,
			selectHelper: true,
			select: function(start, end) {
				$('#insModal').modal('show');
				insStart = start;
				insEnd = end;
				$('#calendar').fullCalendar('unselect');
			},
			editable: true,
			eventLimit: true, // allow "more" link when too many events
			events: [
				{
					id: app1.Id,
					title: app1.Title,
					className : app1.Detail,
					start: app1.Day
				},
				{
					id:2,
					title: 'Dot net interview',
					start: '2015-09-29',
					end: '2015-10-01'
				},
				{
					id: 3,
					title: 'Repeating Interview',
					start: '2015-10-07T16:00:00'
				},
				{
					id: 4,
					title: 'Repeating Interview',
					start: '2015-10-12T16:00:00'
				}
			],
			eventClick: function(event, element) {
		        $("#myModal").modal("show");
				$("#detail_title").text(event.title);
				//$("#detail_desciption").text(event.className);
				$("#detail_datetime").text(event.start);
				eventdata = event;
		    }
		}); // end full calendar

		
		
		$("#deleteBtn" ).on('click',function(){
			$('#delModal').modal("show");
			
		})
		
	 	$('#confirmDel').on('click',function(){
			$('#calendar').fullCalendar('removeEvents',eventdata.id )
			$('#myModal').modal("hide");
			$('#delModal').modal("hide");
		})
		
		$("#insBtn").on('click',function(){
			insTitle = $("#topic").val();
			var insData;
			if (insTitle) {
				insData = {
					id : 33,
					title: insTitle,
					start: insStart,
					end: insEnd
				};
				$('#calendar').fullCalendar('renderEvent', insData, true); // stick? = true
				$('#insModal').modal('hide');	
				$('#formInsert').trigger('reset');
			}
		})
		
		
		
	});

</script>


<div class="container-fluid">
	<div id='calendar'></div>
	
	
	
	<!-- Insert Modal -->
	<div class="modal fade" id="insModal">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title">Insert new appointment</h4>
	      </div>
	      <div class="modal-body">
	        	<div class="container-fluid">
	        		<div clas="row">
	        		 <form id="formInsert">
	        		 	<div class="row">
	        			<div class="col-md-6 ">
			        		<label for="applicant_fname">Firstname</label>
			        		<input id="applicant_fname"class="form-control" placeholder="Firstname"></input>
			        	</div>
			        	<div class="col-md-6 ">
			        		<label for="applicant_lname">Lastname</label>
			        		<input id="applicant_lname"class="form-control" placeholder="Lastname"></input>
			        	</div>
	        			<div class="col-md-6">
	        				<label for="applicant_email">Email</label>
	        				<input id="applicant_email" class="form-control" placeholder="ex : applicant@gmail.com"></input>
	        			</div>
	        			<div class="col-md-6">
	        				<label for="applicant_tel">Tel</label>
	        				<input id="applicant_tel" class="form-control" placeholder="ex : 082-xxxxxxx"></input>
	        			</div>
	        			<div class="col-md-6">
	        				<label for="applicant_position">Position</label>
	        				<input id="applicant_position" class="form-control" placeholder="Title"></input>
	        			</div>
	        			</div>
	        			<hr>
	        			<div class="row">
	        			<div class="col-md-6">
	        				<label for="appointment_title">Appointment Title</label>
	        				<input id="appointment_title" class="form-control" placeholder="Title"></input>
	        			</div>
	        			<div class="col-md-12">
	        				<label for="appoint_detail">Detail</label>
	        				<textarea id="appoint_detail" class="form-control" rows="4" placeholder="Insert detail here..."></textarea>
	        			</div>
	        			</div>
	        		</form>
	        		</div>
	        	</div>
	      </div>
	      <div class="modal-footer">
	        <button id="insBtn" type="button" class="btn btn-primary">Insert</button>
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div><!-- /.modal-content -->
	  </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->
	
	<!-- Detail Modal -->
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  <div class="modal-dialog" role="document">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        <h4 class="modal-title" id="myModalLabel">Appointment Detail</h4>
	      </div>
	      <div class="modal-body">
	        	<table class="table">
	        		<tr>
	        			<td><h4>Name</h4></td>
	        			<td><h4 id="detail_app_fname"></h4></td>
	        			<td><h4 id="detail_app_lname"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4>Date</h4></td>
	        			<td colspan="2"><h4 id="detail_datetime"></h4></td>
	        		</tr>
	        		<tr>
	        			<td><h4>Title</h4></td>
	        			<td colspan="2"><h4 id="detail_title"></h4></td>
	        		</tr>
	        		<tr>
	        			<td colspan="1"><h4 >Detail</h4></td>
	        		
	        			<td colspan="2"><h4 id="detail_desciption">If you are using the indented form, place your address at
  the top, with the left edge of the address aligned with the
  center of the page. Skip a line and type the date so that it
  lines up underneath your address.  Type the inside address and
  salutation flush left; the salutation should be followed by a
  colon. For formal letters, avoid abbreviations.</h4></td>
	        		</tr>
	        	</table>
	        
	        <div class="text-right">
		        <button type="button" class="btn btn-warning" data-dissmiss="modal">Edit</button>
		        <button id="deleteBtn" type="button" class="btn btn-danger" data-dissmiss="modal">Delete</button><br><br>
	        </div>
	      </div>
	      <div class="modal-footer">
	        <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	
	
	<!-- Delete Modal -->
		<div class="modal fade" id="delModal">
		  <div class="modal-dialog modal-sm">
		    <div class="modal-content">
		      <div class="modal-header">
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
		        <h4>Confirm Delete</h4>
		      </div>
		      <div class="modal-body">
		        <p>Are you sure you want to delete this ?</p>
		      </div>
		      <div class="modal-footer">
		        <button type="button" class="btn btn-default glyphicon glyphicon-remove" data-dismiss="modal"> Close</button>
		        <button type="button" id="confirmDel" class="btn btn-danger glyphicon glyphicon-trash" > Delete</button>
		      </div>
		    </div><!-- /.modal-content -->
		  </div><!-- /.modal-dialog -->
		</div><!-- /.modal -->
	
</div>
