/**
  * Run montecarlo.
  */
import pubsim.distributions.RealRandomVariable
import pubsim.distributions.UniformNoise
import pubsim.distributions.GaussianNoise
import pubsim.lattices.firstkind.FirstKindCheck
import pubsim.VectorFunctions.randomMatrix
import pubsim.VectorFunctions.randomMIMObasis
import Jama.Matrix
import scala.math.sqrt

val z = 1.96 //corresponds with 95% confidence intervals
val L = 5000 //the number of Monte Carlo iterations
val Ns = List(1,2,3,4,5,6)

runsim( n=>randomMatrix(n,n,UniformNoise.constructFromMinMax(0,1)), "uniform")
runsim( n=>randomMatrix(n,n,new GaussianNoise(0,1)), "gaussian")
runsim( n=>randomMIMObasis(n), "mimo")

def runsim( basisgen : Int => Matrix, name : String ) {

  val starttime = (new java.util.Date).getTime

  print(name + " ")

  val datalist = Ns.map{ n =>

    //run all the MonteCarlo iterations
    val bdata = (1 to L).par.map { i =>
      val B = basisgen(n)
      val fk = new FirstKindCheck(B)
      if(fk.isFirstKind) 1 else 0
    }.toList

    val phat = bdata.foldLeft(0.0) { (sum, v) => sum + v } / L
    val ci = z * sqrt(phat*(1-phat)/ L )

    print(".")
    (n,phat,ci)
  }.toList

  val file = new java.io.FileWriter("data/" + name)
  file.write("n" + "\t" + "proportion" + "\t" + "stddev" + "\n")
  datalist.foreach{ v =>
    val (n,p,d) = v
    file.write(n + "\t" + p + "\t" + d + "\n")
  }
  file.close

  val runtime = (new java.util.Date).getTime - starttime
  println(" finished in " + (runtime/1000.0) + " seconds.")

}
