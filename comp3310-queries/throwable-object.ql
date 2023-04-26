/**
 * @name Throwable objects need to be logged
 * @kind problem
 * @problem.severity warning
 * @id java/throwable-object
 */

 import java

 from MethodAccess ma, MethodAccess mam
 where 
   ma.getMethod().getNumberOfParameters() = 0 and
   ma.getMethod().getName() = "printStackTrace" and 
   ma.getMethod().getDeclaringType().getQualifiedName() = "java.lang.Throwable"
 or
   // Identify calls to System.out.println
   ma.getMethod().hasName("println") and
   ma.getMethod().getDeclaringType().getQualifiedName() = "java.io.PrintStream" and
   mam.getMethod().hasName("getMessage") and
   mam.getMethod().getDeclaringType().getQualifiedName() = "java.lang.Throwable" and
   ma.getAChildExpr() = mam
 select ma, "Throwable objects need to be logged with a proper logger"
 