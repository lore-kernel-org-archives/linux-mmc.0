From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH mmc/next v2 3/4] mmc: renesas-sdhi: add support for R-Car
 Gen3 SDHI DMAC
Date: Wed, 21 Jun 2017 11:01:31 +0200
Message-ID: <20170621090129.GA27507@verge.net.au>
References: <1497607134-10241-1-git-send-email-horms+renesas@verge.net.au>
 <1497607134-10241-4-git-send-email-horms+renesas@verge.net.au>
 <20170617205547.GA12971@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:36379 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbdFUJCG (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 21 Jun 2017 05:02:06 -0400
Content-Disposition: inline
In-Reply-To: <20170617205547.GA12971@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

On Sat, Jun 17, 2017 at 10:55:50PM +0200, Simon Horman wrote:
> On Fri, Jun 16, 2017 at 11:58:53AM +0200, Simon Horman wrote:
> > Add a new variant of the SDHI driver to support R-Car Gen3 with DMA via
> > on-chip bus mastering.  Since the DMAC is in a part of the SDHI module it
> > is not suitable to be used via DMA Engine.
> > 
> > Clearing of DM_CM_INFO1 after DMA thanks to Dirk Behme
> > 
> > Cc: Dirk Behme <dirk.behme@de.bosch.com>
> > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > Signed-off-by: Ai Kyuse <ai.kyuse.uw@renesas.com>
> > ---
> > v2
> > * Enhanced help text and changelog
> > ---
> >  drivers/mmc/host/Kconfig                      |  19 ++
> >  drivers/mmc/host/Makefile                     |   8 +-
> >  drivers/mmc/host/renesas_sdhi_internal_dmac.c | 275 ++++++++++++++++++++++++++
> >  drivers/mmc/host/renesas_sdhi_sys_dmac.c      |   2 +-
> >  drivers/mmc/host/tmio_mmc.h                   |   1 +
> >  5 files changed, 303 insertions(+), 2 deletions(-)
> >  create mode 100644 drivers/mmc/host/renesas_sdhi_internal_dmac.c
> > 
> > diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> > index 5755b69f2f72..81c81ed19735 100644
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -575,10 +575,29 @@ config MMC_SDHI
> >  	depends on SUPERH || ARM || ARM64
> >  	depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> >  	select MMC_TMIO_CORE
> > +	select MMC_SDHI_SYS_DMAC if (SUPERH || ARM)
> > +	select MMC_SDHI_INTERNAL_DMAC if ARM64
> >  	help
> >  	  This provides support for the SDHI SD/SDIO controller found in
> >  	  Renesas SuperH, ARM and ARM64 based SoCs
> >  
> > +config MMC_SDHI_SYS_DMAC
> > +	tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
> > +	depends on MMC_SDHI
> > +	help
> > +	  This provides DMA support for SDHI SD/SDIO controllers
> > +	  using SYS-DMAC via DMA Engine. This supports the controllers
> > +	  found in SuperH and Renesas ARM based SoCs.
> > +
> > +config MMC_SDHI_INTERNAL_DMAC
> > +	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
> 
> 0-day tells me that building fails on arm/allmodconfig due to
> writeq not being defined. I believe this is because it only exists on
> 64bit systems. My proposed fix for v3 is:
> 
> 	depends on 64BIT

New proposal:

	#include <linux/io-64-nonatomic-hi-lo.h>

> > +	depends on ARM64 || COMPILE_TEST
> > +	depends on MMC_SDHI
> > +	help
> > +	  This provides DMA support for SDHI SD/SDIO controllers
> > +	  using on-chip bus mastering. This supports the controllers
> > +	  found in arm64 based SoCs.
> > +
> >  config MMC_CB710
> >  	tristate "ENE CB710 MMC/SD Interface support"
> >  	depends on PCI
> 
> > diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> > index 4d4547116311..8c46766c000c 100644
> > --- a/drivers/mmc/host/Makefile
> > +++ b/drivers/mmc/host/Makefile
> 
> ...
> 
> > +static void
> > +renesas_sdhi_internal_dmac_dm_write(struct tmio_mmc_host *host,
> > +				    int addr, u64 val)
> > +{
> > +	writeq(val, host->ctl + addr);
> > +}
> 
> ...
> 
