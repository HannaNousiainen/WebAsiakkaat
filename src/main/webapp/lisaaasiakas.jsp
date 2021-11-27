<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<script src="scripts/main.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="http://ajax.aspnetcdn.com/ajax/jquery.validate/1.15.0/jquery.validate.min.js"></script>
<title>Lis�� asiakas</title>
<style>

.oikealle{
	text-align: right;
}
body {
	font-family: sans-serif;
}
th, td {
  padding: 8px;
  text-align: left;
}
table {
  width: 80%;
  border-collapse: collapse;

}
tr:hover {background-color: #ECF2DD;}

.otsikko {
	font-weight: bold;
	background-color: #b0d4de;  
}

#takaisin{
	cursor: pointer;
}

</style>
</head>
<body>

<form id="tiedot">
	<table>
		<thead>	
			<tr>
				<th colspan="5" class="oikealle"><span id="takaisin">Takaisin listaukseen</span></th>
			</tr>		
			<tr class="otsikko">
				<th>Asiakastunnus</th>
				<th>Etunimi</th>
				<th>Sukunimi</th>
				<th>Puhelin</th>
				<th>S�hk�posti</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td><input type="text" name="asiakas_id" id="asiakas_id"></td>
				<td><input type="text" name="etunimi" id="etunimi"></td>
				<td><input type="text" name="sukunimi" id="sukunimi"></td>
				<td><input type="text" name="puhelin" id="puhelin"></td> 
				<td><input type="text" name="sposti" id="sposti"></td> 
				<td><input type="submit" id="tallenna" value="Lis��"></td>
			</tr>
		</tbody>
	</table>
</form>
<span id="ilmo"></span>
</body>
<script>
$(document).ready(function(){
	
	$("#takaisin").click(function(){
		document.location="listaa.jsp";
	});
	
	$("#tiedot").validate({
		rules: {
			asiakas_id: {
				required: true,
				minlength:1
			},
			etunimi: {
				required: true,
				minlength:2
			},
			sukunimi: {
				required: true,
				minlength:2
			},
			puhelin: {
				required: true,
				minlength: 7
			},
			sposti: {
				required: true,
				minlength:10
			}
		},
		messages: {
			asiakas_id:{
				required: "Puuttuu",
				minlenght: "Liian lyhyt"
			},
			etunimi:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sukunimi:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			puhelin:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			},
			sposti:{
				required: "Puuttuu",
				minlength: "Liian lyhyt"
			}
			
		},
		submitHandler: function(form) {
			lisaaTiedot();
		}
	});
});

//POST /autot/
function lisaaTiedot(){	
	var formJsonStr = formDataJsonStr($("#tiedot").serializeArray()); //muutetaan lomakkeen tiedot json-stringiksi
	$.ajax({url:"asiakkaat", data:formJsonStr, type:"POST", dataType:"json", success:function(result) { //result on joko {"response:1"} tai {"response:0"}       
		if(result.response==0){
      	$("#ilmo").html("Asiakkaan lis��minen ep�onnistui.");
      }else if(result.response==1){			
      	$("#ilmo").html("Asiakkaan lis��minen onnistui.");
      	$("#asiakas_id", "#etunimi", "#sukunimi", "#puhelin", "#sposti").val("");
		}
  }});	
}
</script>

</html>