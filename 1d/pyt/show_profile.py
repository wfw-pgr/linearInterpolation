import sys
import numpy                      as np
import nkUtilities.LoadConfig     as lcf
import nkUtilities.plot1D         as pl1
import nkUtilities.configSettings as cfs


# ========================================================= #
# ===  display                                          === #
# ========================================================= #
def display( datFile1=None, datFile2=None, pngFile=None, config=None ):
    # ------------------------------------------------- #
    # --- [1] Arguments                             --- #
    # ------------------------------------------------- #
    if ( datFile1 is None ): datFile1 = "dat/xa_fa.dat"
    if ( datFile2 is None ): datFile2 = "dat/xp_fp.dat"
    if ( pngFile  is None ): pngFile  = "png/out.png"
    if ( config   is None ): config   = lcf.LoadConfig()

    # ------------------------------------------------- #
    # --- [2] Fetch Data                            --- #
    # ------------------------------------------------- #
    with open( datFile1, "r" ) as f:
        Data = np.loadtxt( f )
    xa = Data[:,0]
    fa = Data[:,1]
    with open( datFile2, "r" ) as f:
        Data = np.loadtxt( f )
    xp = Data[:,0]
    fp = Data[:,1]
    
    # ------------------------------------------------- #
    # --- [3] config Settings                       --- #
    # ------------------------------------------------- #
    cfs.configSettings( configType="plot1D_def", config=config )
    config["xTitle"]         = "X"
    config["yTitle"]         = "Y"
    config["plt_xAutoRange"] = True
    config["plt_yAutoRange"] = True
    config["plt_xRange"]     = [-5.0,+5.0]
    config["plt_yRange"]     = [-5.0,+5.0]
    config["plt_linewidth"]  = 1.0
    config["xMajor_Nticks"]  = 5
    config["yMajor_Nticks"]  = 5

    # ------------------------------------------------- #
    # --- [4] plot Figure                           --- #
    # ------------------------------------------------- #
    fig = pl1.plot1D( config=config, pngFile=pngFile )
    fig.add__plot( xAxis=xa, yAxis=fa, label="fa" )
    fig.add__plot( xAxis=xp, yAxis=fp, label="fp", linestyle="--" )
    fig.add__legend()
    fig.set__axis()
    fig.save__figure()
    

# ======================================== #
# ===  実行部                          === #
# ======================================== #
if ( __name__=="__main__" ):
    display()
