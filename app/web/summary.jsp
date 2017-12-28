<%-- 
    Document   : summary
    Created on : 14 Dec, 2017, 4:06:38 PM
    Author     : Kwtam
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="dao.ConsultDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
            
            int cardiovascularCases = 0; 
            int dentalCases = 0; 
            int dermatologyCases = 0; 
            int endocrineCases = 0; 
            int entCases = 0; 
            int eyeCases = 0; 
            int gastrointestinalCases = 0; 
            int gynaecologyCases = 0; 
            int infectiousDiseasesCases = 0; 
            int musculoskeletalCases = 0; 
            int neurologyCases = 0; 
            int oncologyCases = 0; 
            int psychologyCases = 0; 
            int renalCases = 0; 
            int respiratoryCases = 0; 
            int urologyCases = 0; 
            int surgeryCases = 0;
            int uncategorisedCases = 0;
            
            ConsultDAO consultDAO = new ConsultDAO();
            ArrayList<String> problems = consultDAO.getSummaryOfProblems();
            for(String problemString:problems){
                if(!problemString.trim().isEmpty()){
                    String [] problemArray = problemString.split(",");
                    for(String individualProblem:problemArray){
                        System.out.println("individualProblem"+individualProblem);
                        switch(individualProblem.trim()){
                            case "Cardiovascular":
                                cardiovascularCases++;
                                break;
                            case "Dental":
                                dentalCases++;
                                break;
                            case "Dermatology":
                                dermatologyCases++;
                                break;
                            case "Endocrine":
                                endocrineCases++;
                                break;
                            case "ENT":
                                entCases++;
                                break;
                            case "Eye":
                                eyeCases++;
                                break;
                            case "Gastrointestinal":
                                gastrointestinalCases++;
                                break;
                            case "Gynaecology":
                                gynaecologyCases++;
                                break;
                            case "Infectious Diseases":
                                infectiousDiseasesCases++;
                                break;
                            case "Musculo-skeletal":
                                musculoskeletalCases++;
                                break;
                            case "Neurology":
                                neurologyCases++;
                                break;
                            case "Oncology":
                                oncologyCases++;
                                break;
                            case "Psychology":
                                psychologyCases++;
                                break;
                            case "Renal":
                                renalCases++;
                                break;
                            case "Respiratory":
                                respiratoryCases++;
                                break;
                            case "Urology":
                                urologyCases++;
                                break;
                            case "Surgery":
                                surgeryCases++;
                                break;
                            default:
                                uncategorisedCases++;
                                break;
                        }
                    }
                }
            }
            
            System.out.println("cardiovascularCases"+cardiovascularCases);
            System.out.println("dentalCases"+dentalCases);
            System.out.println("dermatologyCases"+dermatologyCases);
            System.out.println("endocrineCases"+endocrineCases);
            System.out.println("entCases"+entCases);
            System.out.println("eyeCases"+eyeCases);
            System.out.println("gastrointestinalCases"+gastrointestinalCases);
            System.out.println("gynaecologyCases"+gynaecologyCases);
            System.out.println("infectiousDiseasesCases"+infectiousDiseasesCases);
            System.out.println("musculoskeletalCases"+musculoskeletalCases);
            System.out.println("neurologyCases"+neurologyCases);
            System.out.println("oncologyCases"+oncologyCases);
            System.out.println("psychologyCases"+psychologyCases);
            System.out.println("renalCases"+renalCases);
            System.out.println("respiratoryCases"+respiratoryCases);
            System.out.println("urologyCases"+urologyCases);
            System.out.println("surgeryCases"+surgeryCases);
            System.out.println("uncategorisedCases"+uncategorisedCases);
        %>
        
    </body>
</html>
