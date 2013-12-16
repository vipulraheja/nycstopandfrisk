$(document).ready(function(){
    $("select").change(function(){
        $("select option:selected").each(function(){
            if($(this).attr("value")=="2006_income_white"){
				$(".map").hide();
                $("#2006_income_white").show();
            }

            else if($(this).attr("value")=="2008_income_white"){
				$(".map").hide();	                  		                	
				$("#2008_income_white").show();
            }

           	else if ($(this).attr("value")=="2006_sf_income_white"){		               		
				$(".map").hide();	                  		               		
				$("#2006_sf_income_white").show();
            }

           	else if($(this).attr("value")=="2008_sf_income_white"){
				$(".map").hide();	                  		               		
           		$("#2008_sf_income_white").show();
            }

	       	else if($(this).attr("value")=="2008_income_hispanic"){
				$(".map").hide();	                  		               		
				$("#2008_income_hispanic").show();
	        }	

	       	else if($(this).attr("value")=="2006_income_hispanic"){
				$(".map").hide();	                  		               		
				$("#2006_income_hispanic").show();
	        }		                       

	    	else if($(this).attr("value")=="2008_sf_income_hispanic"){
				$(".map").hide();	                  		            		
				$("#2008_sf_income_hispanic").show();
	        }		 

	    	else if($(this).attr("value")=="2006_sf_income_hispanic"){
				$(".map").hide();	                  		            		
				$("#2006_sf_income_hispanic").show();
	        }	                         

			else if($(this).attr("value")=="2008_income_black"){
				$(".map").hide();	                  		        			
				$("#2008_income_black").show();
	        }

	        else if($(this).attr("value")=="2006_income_black"){
				$(".map").hide();	                  		                	
				$("#2006_income_black").show();
	        }

	        else if($(this).attr("value")=="2008_sf_income_black"){
				$(".map").hide();	                  		                	
				$("#2008_sf_income_black").show();
	        }		 

	        else if($(this).attr("value")=="2006_sf_income_black"){
				$(".map").hide();	                  		                	
				$("#2006_sf_income_black").show();
	        }

	        else if($(this).attr("value")=="2008_income_asian"){
				$(".map").hide();	                  		                	
				$("#2008_income_asian").show();
	        }		

	        else if($(this).attr("value")=="2006_income_asian"){
				$(".map").hide();	                  		                	
				$("#2006_income_asian").show();
	        }		 

	        else if($(this).attr("value")=="2008_sf_income_asian"){
				$(".map").hide();	                  		                	
				$("#2008_sf_income_asian").show();
	        }	

	        else if($(this).attr("value")=="2006_sf_income_asian"){
				$(".map").hide();	                  		                	
				$("#2006_sf_income_asian").show();
	        }

	        else if($(this).attr("value")=="2008_pop_white"){
				$(".map").hide();	                  		                	
				$("#2008_pop_white").show();
	        }

	        else if($(this).attr("value")=="2006_pop_white"){
				$(".map").hide();	                  		                	
				$("#2006_pop_white").show();
	        }

	        else if($(this).attr("value")=="2008_sf_pop_white"){
				$(".map").hide();	                  		                	
				$("#2008_sf_pop_white").show();
	        }

	        else if($(this).attr("value")=="2006_sf_pop_white"){
				$(".map").hide();	                  		                	
				$("#2006_sf_pop_white").show();
	        }	

	        else if($(this).attr("value")=="2008_pop_hispanic"){
				$(".map").hide();	                  		                	
				$("#2008_pop_hispanic").show();
	        }	

	        else if($(this).attr("value")=="2006_pop_hispanic"){
				$(".map").hide();	                  		                	
				$("#2006_pop_hispanic").show();
	        }

	        else if($(this).attr("value")=="2008_sf_pop_hispanic"){
				$(".map").hide();	                  		                	
				$("#2008_sf_pop_hispanic").show();
	        }		                		                	                	                		                	

	        else if($(this).attr("value")=="2006_sf_pop_hispanic"){
				$(".map").hide();	                  		                	
				$("#2006_sf_pop_hispanic").show();
	        }

	        else if($(this).attr("value")=="2008_pop_black"){
				$(".map").hide();	                  		                	
	        	$("#2008_pop_black").show();
	        }

	        else if($(this).attr("value")=="2006_pop_black"){
				$(".map").hide();	                  		                	
	        	$("#2006_pop_black").show();
	        }

	        else if($(this).attr("value")=="2008_sf_pop_black"){
				$(".map").hide();	                  		                	
	        	$("#2008_sf_pop_black").show();
	        }

	        else if($(this).attr("value")=="2006_sf_pop_black"){
				$(".map").hide();	                  		                	
	        	$("#2006_sf_pop_black").show();
	        }

	        else if($(this).attr("value")=="2008_pop_asian"){
				$(".map").hide();	                  		                	
				$("#2008_pop_asian").show();
			}
			
			else if($(this).attr("value")=="2006_pop_asian"){
				$(".map").hide();	                  							
				$("#2006_pop_asian").show();
			}
			
			else if($(this).attr("value")=="2008_sf_pop_asian"){
				$(".map").hide();	                  							
				$("#2008_sf_pop_asian").show();
			}

			else if($(this).attr("value")=="2006_sf_pop_asian"){
				$(".map").hide();	                  							
				$("#2006_sf_pop_asian").show();
			}

	        else if($(this).attr("value")=="2006_sf_edu_bach"){
				$(".map").hide();	                  	                    	
	        	$("#2006_sf_edu_bach").show();
	        }

	        else if($(this).attr("value")=="2008_sf_edu_bach"){
				$(".map").hide();	                  	                    	
	        	$("#2008_sf_edu_bach").show();
	        }

			else if($(this).attr("value")=="2006_edu_bach"){
				$(".map").hide();	                  							
	        	$("#2006_edu_bach").show();
	        }

	        else if($(this).attr("value")=="2008_edu_bach"){
				$(".map").hide();	                  	                    	
	        	$("#2008_edu_bach").show();
	        }

	        else if($(this).attr("value")=="2006_sf_edu_hs"){
				$(".map").hide();	                  	                    	
	        	$("#2006_sf_edu_hs").show();
	        }

	        else if($(this).attr("value")=="2008_sf_edu_hs"){
				$(".map").hide();	                  	                    	
	           	$("#2008_sf_edu_hs").show();
	        }

	        else if($(this).attr("value")=="2006_edu_hs"){
				$(".map").hide();	                  	                    	
	        	$("#2006_edu_hs").show();
	        }

	        else if($(this).attr("value")=="2008_edu_hs"){
				$(".map").hide();	                  	                    	
	        	$("#2008_edu_hs").show();
	        }

	        else if($(this).attr("value")=="2006_apartment_rents_count"){
				$(".map").hide();	                  	                    	
	        	$("#2006_apartment_rents_count").show();
	        }

	        else if($(this).attr("value")=="2008_apartment_rents_count"){
				$(".map").hide();	                  	                    	
	        	$("#2008_apartment_rents_count").show();
	        }
			
			else if($(this).attr("value")=="2006_apartment_rents_ratio"){
				$(".map").hide();	                  							
				$("#2006_apartment_rents_ratio").show();
			}

			else if($(this).attr("value")=="2008_apartment_rents_ratio"){
				$(".map").hide();	                  							
				$("#2008_apartment_rents_ratio").show();
			}

			else if($(this).attr("value")=="pet_ownership_count"){
				$(".map").hide();	                  							
				$("#pet_ownership_count").show();
			}

			else if($(this).attr("value")=="pet_ownership_ratio"){
				$(".map").hide();	                  							
				$("#pet_ownership_ratio").show();
			}						

			else if($(this).attr("value")=="predictions"){
				$(".map").hide();	                  							
				$("#predictions").show();
			}
	    });
	}).change();
});

function fctCheck(analysis) {
console.log(analysis);
	var elems = document.getElementsByName("subselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}
	document.getElementById(analysis).style.display = "block";

	var elems = document.getElementsByName("subsubselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}

	var elems = document.getElementsByName("subsubsubselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}

	var elems = document.getElementsByName("subsubsubsubselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}
}

function fctCheck_sub(analysis) {
console.log(analysis);
	var elems = document.getElementsByName("subsubselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}
	document.getElementById(analysis).style.display = "block";

	var elems = document.getElementsByName("subsubsubselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}

	var elems = document.getElementsByName("subsubsubsubselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}
//document.getElementById(analysis).style.display = "block";  				
}

function fctCheck_sub_sub(analysis) {
console.log(analysis);
	var elems = document.getElementsByName("subsubsubselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}
	document.getElementById(analysis).style.display = "block";

	var elems = document.getElementsByName("subsubsubsubselector");
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}
//document.getElementById(analysis).style.display = "block";  				
}

function fctCheck_sub_sub_sub(analysis) {
console.log(analysis);
	var elems = document.getElementsByName("subsubsubsubselector");
	console.log(elems.id)
	for (var i = 0; i < elems.length; i++) {
		elems.item(i).style.display = "none";
	}
	document.getElementById(analysis).style.display = "block";  		
}