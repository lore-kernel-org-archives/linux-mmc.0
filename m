From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC v2 1/5] mmc: sh_mobile_sdhi, tmio: make dma more
 modular
Date: Wed, 6 Jul 2016 21:57:30 +0200
Message-ID: <20160706195721.GA4845@verge.net.au>
References: <1467237940-24388-1-git-send-email-horms+renesas@verge.net.au>
 <1467237940-24388-2-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdUtvFW8K=Ggo_nDg_uFKyOZsiqh4rVSNB_HX6So6YfwYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMuHMdUtvFW8K=Ggo_nDg_uFKyOZsiqh4rVSNB_HX6So6YfwYg@mail.gmail.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jul 05, 2016 at 07:05:55PM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Jun 30, 2016 at 12:05 AM, Simon Horman
> <horms+renesas@verge.net.au> wrote:
> > Refactor DMA support to allow it to be provided by a set of call-backs
> > that are provided by a host driver. The motivation is to allow multiple
> > DMA implementations to be provided and instantiated at run-time.
> >
> > Instantiate the existing DMA implementation from the sh_mobile_sdhi driver
> > which appears to match the current use-case. This has the side effect
> > of moving the DMA code from the tmio_core to the sh_mobile_sdhi driver.
> >
> > A follow-up patch will change the source file for the SDHI DMA
> > implementation accordingly.
> >
> > Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> > ---
> > v2
> > * Fix compilation issue due to error in Makefile
> > * Use MMC_SDHI_SYSC_DMA rather than MMC_SDHI_DMA as new Kconfig symbole
> >   to better reflect revamped file rename in a follow-up patch.
> >
> > Todo: Investigate removing ifdef
> > ---
> >  drivers/mmc/host/Kconfig          |  9 ++++++++
> >  drivers/mmc/host/Makefile         |  4 +++-
> >  drivers/mmc/host/sh_mobile_sdhi.c | 13 +++++++++++
> >  drivers/mmc/host/tmio_mmc.h       | 39 ++++++++------------------------
> >  drivers/mmc/host/tmio_mmc_dma.c   | 26 +++++++++++++++++-----
> >  drivers/mmc/host/tmio_mmc_pio.c   | 47 +++++++++++++++++++++++++++++++++++++++
> >  6 files changed, 102 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 5274f503a39a..a0b6c1773e33 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -554,10 +554,19 @@ config MMC_SDHI
> >         depends on SUPERH || ARM || ARM64
> >         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> >         select MMC_TMIO_CORE
> > +       select MMC_SDHI_SYSC_DMA if (SUPERH || ARM)
> 
> MMC_SDHI_SYS_DMAC?
> 
> >         help
> >           This provides support for the SDHI SD/SDIO controller found in
> >           SuperH and ARM SH-Mobile SoCs
> >
> > +config MMC_SDHI_SYSC_DMA
> 
> MMC_SDHI_SYS_DMAC??
> 
> > +       tristate "DMA support use of SYSC DMAC with SDHI SD/SDIO controller"
> 
> SYS DMAC
> 
> (SYSC is the System Controller for Power Areas)

Thanks, I will use SYS DMAC (everywhere).

> > +       depends on SUPERH || ARM || COMPILE_TEST
> > +       depends on MMC_SDHI
> > +       help
> > +         This provides DMA support for the SDHI SD/SDIO controller
> > +         found in SuperH and Renesas ARM based SoCs.
> > +
> >  config MMC_CB710
> >         tristate "ENE CB710 MMC/SD Interface support"
> >         depends on PCI
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index e2bdaaf43184..4ed6f250213a 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> > @@ -37,8 +37,10 @@ obj-$(CONFIG_MMC_SDRICOH_CS) += sdricoh_cs.o
> >  obj-$(CONFIG_MMC_TMIO)         += tmio_mmc.o
> >  obj-$(CONFIG_MMC_TMIO_CORE)    += tmio_mmc_core.o
> >  tmio_mmc_core-y                        := tmio_mmc_pio.o
> > -tmio_mmc_core-$(subst m,y,$(CONFIG_MMC_SDHI))  += tmio_mmc_dma.o
> >  obj-$(CONFIG_MMC_SDHI)         += sh_mobile_sdhi.o
> > +ifeq ($(subst m,y,$(CONFIG_MMC_SDHI_SYSC_DMA)),y)
> > +obj-$(CONFIG_MMC_SDHI)         += tmio_mmc_dma.o
> > +endif
> >  obj-$(CONFIG_MMC_CB710)                += cb710-mmc.o
> >  obj-$(CONFIG_MMC_VIA_SDMMC)    += via-sdmmc.o
> >  obj-$(CONFIG_SDH_BFIN)         += bfin_sdh.o
> > diff --git a/drivers/mmc/host/sh_mobile_sdhi.c b/drivers/mmc/host/sh_mobile_sdhi.c
> > index c3b651bf89cb..45543ed37e5f 100644
> > --- a/drivers/mmc/host/sh_mobile_sdhi.c
> > +++ b/drivers/mmc/host/sh_mobile_sdhi.c
> > @@ -106,6 +106,15 @@ struct sh_mobile_sdhi {
> >         struct pinctrl_state *pins_default, *pins_uhs;
> >  };
> >
> > +#if IS_ENABLED(MMC_SDHI_SYSC_DMA)
> 
> This should be "#if IS_ENABLED(CONFIG_MMC_SDHI_SYSC_DMA)",
> else probing fails on all platforms where SDHI uses the SYS DMAC:
> 
>     sh_mobile_sdhi: probe of ee100000.sd failed with error -22

Ooops, I will fix that.

> > +int tmio_mmc_init_dma(void);
> > +#else
> > +static int tmio_mmc_init_dma(void)
> > +{
> > +       return -EINVAL;
> 
> Still, I don't know if this is the right approach: if CONFIG_MMC_SDHI_SYSC_DMA
> is ever disabled, the driver will just fail during probing, instead of falling
> back to PIO.

I will switch things around to allow fallback to PIO.

> 
> > +}
> > +#endif
> > +
> 
> And there's another issue:
> 
>     WARNING: modpost: Found 1 section mismatch(es).
>     To see full details build your kernel with:
>     'make CONFIG_DEBUG_SECTION_MISMATCH=y'
> 
> Doing that doesn't help much, though:
> 
>     WARNING: drivers/built-in.o(.text+0x190f7c): Section mismatch in
> reference from
>     the function tmio_mmc_init_dma() to the (unknown reference)
>     .init.data:(unknown)
>     The function tmio_mmc_init_dma() references
>     the (unknown reference) __initdata (unknown).
>     This is often because tmio_mmc_init_dma lacks a __initdata
>     annotation or the annotation of (unknown) is wrong.
> 
> The warning goes away later in the series, though.

I think this is due to the __initdata annotation of
tmio_mmc_dma_ops which is removed later in the series. I will remove it
here.

> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
