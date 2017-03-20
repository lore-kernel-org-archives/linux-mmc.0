From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH v12 3/9] mmc: cavium: Add MMC platform driver for Octeon
 SOCs
Date: Mon, 20 Mar 2017 15:40:50 +0100
Message-ID: <20170320144050.GA18823@hardcore>
References: <20170310132507.32025-1-jglauber@cavium.com>
 <20170310132507.32025-4-jglauber@cavium.com>
 <CAPDyKFqTf7qGMb5b-ZEdYJUrF-kr-kzLO-mR_N5Xx06eohgtCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqTf7qGMb5b-ZEdYJUrF-kr-kzLO-mR_N5Xx06eohgtCQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>, David Daney <david.daney@cavium.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 17, 2017 at 02:35:34PM +0100, Ulf Hansson wrote:
> On 10 March 2017 at 14:25, Jan Glauber <jglauber@cavium.com> wrote:
> > Add a platform driver for Octeon MIPS SOCs.
> >
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > Signed-off-by: David Daney <david.daney@cavium.com>
> > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> > ---
> >  drivers/mmc/host/Kconfig               |  10 ++
> >  drivers/mmc/host/Makefile              |   2 +
> >  drivers/mmc/host/cavium-pltfm-octeon.c | 183 +++++++++++++++++++++++++++++++++
> >  3 files changed, 195 insertions(+)
> >  create mode 100644 drivers/mmc/host/cavium-pltfm-octeon.c
> 
> Please rename the file to cavium-octeon.c

OK.

> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index f08691a..68cc811 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -622,6 +622,16 @@ config SDH_BFIN_MISSING_CMD_PULLUP_WORKAROUND
> >         help
> >           If you say yes here SD-Cards may work on the EZkit.
> >
> > +config MMC_CAVIUM_OCTEON
> > +       tristate "Cavium OCTEON SD/MMC Card Interface support"
> > +       depends on CAVIUM_OCTEON_SOC
> > +       help
> > +         This selects Cavium OCTEON SD/MMC card Interface.
> > +         If you have an OCTEON board with a Multimedia Card slot,
> > +         say Y or M here.
> > +
> > +         If unsure, say N.
> > +
> 
> Adding more new cavium variants becomes a bit messy in this approach.
> May I suggest something similar we are using for SDHCI mmc driver.

There will be no more new variants.

> That is:
>
> For the core mmc cavium driver:
> config MMC_CAVIUM (to build cavium-mmc.o)
> I would also appreciate to rename that file to cavium.c
> This also means you need to export the functions you provide from the
> header cavium-mmc.h (rename to cavium.h)
> 
> For the octeon variant:
> config MMC_CAVIUM_OCTEON (to build cavium-octeon.o)
> depends on MMC_CAVIUM && CAVIUM_OCTEON_SOC

Why is this better? It creates a module out of the shared code that only
has one single user, the ThunderX or the Octeon driver and they will
never run both at the same time.

Why not just link the shared code to the driver that uses it? Calling
accross modules is also slower, although that doesn't matter here.

--Jan

> >  config MMC_DW
> >         tristate "Synopsys DesignWare Memory Card Interface"
> >         depends on HAS_DMA
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 6d548c4..c7f0ccf 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -42,6 +42,8 @@ obj-$(CONFIG_MMC_SDHI)                += sh_mobile_sdhi.o
> >  obj-$(CONFIG_MMC_CB710)                += cb710-mmc.o
> >  obj-$(CONFIG_MMC_VIA_SDMMC)    += via-sdmmc.o
> >  obj-$(CONFIG_SDH_BFIN)         += bfin_sdh.o
> > +octeon-mmc-objs := cavium-mmc.o cavium-pltfm-octeon.o
> > +obj-$(CONFIG_MMC_CAVIUM_OCTEON) += octeon-mmc.o
> 
> By changing according to above, we get two build objects instead of
> two. Nice an clean.
> 
> >  obj-$(CONFIG_MMC_DW)           += dw_mmc.o
> >  obj-$(CONFIG_MMC_DW_PLTFM)     += dw_mmc-pltfm.o
> >  obj-$(CONFIG_MMC_DW_EXYNOS)    += dw_mmc-exynos.o
> > diff --git a/drivers/mmc/host/cavium-pltfm-octeon.c b/drivers/mmc/host/cavium-pltfm-octeon.c
> > new file mode 100644
> > index 0000000..e83d143
> 
> [...]
> 
> Changing the name of the files, may also lead to that you perhaps want
> to change the prefix of the functions.
> 
> Otherwise this looks good to me.
> 
> Kind regards
> Uffe
