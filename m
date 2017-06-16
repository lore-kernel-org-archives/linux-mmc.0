From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH/RFC 4/5] mmc: renesas_sdhi: add support for R-Car Gen3
 SDHI DMAC
Date: Fri, 16 Jun 2017 09:12:03 +0200
Message-ID: <20170616071201.GD16534@verge.net.au>
References: <1496927595-19521-1-git-send-email-horms+renesas@verge.net.au>
 <1496927595-19521-5-git-send-email-horms+renesas@verge.net.au>
 <CAMuHMdU8fqoi-zh4OKC_40xH3pZy+w_qDjtxm2pRLUsJieFmgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:43387 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbdFPHMY (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jun 2017 03:12:24 -0400
Content-Disposition: inline
In-Reply-To: <CAMuHMdU8fqoi-zh4OKC_40xH3pZy+w_qDjtxm2pRLUsJieFmgw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Ulf Hansson <ulf.hansson@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Linux-Renesas <linux-renesas-soc@vger.kernel.org>, Dirk Behme <dirk.behme@de.bosch.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Ai Kyuse <ai.kyuse.uw@renesas.com>

On Fri, Jun 09, 2017 at 09:39:49AM +0200, Geert Uytterhoeven wrote:
> Hi Simon,
> 
> On Thu, Jun 8, 2017 at 3:13 PM, Simon Horman <horms+renesas@verge.net.au> wrote:
> > R-Car Gen3 has a dedicated DMA controller for SDHI module. Since
> > the DMAC is in a part of SDHI module and is not suitable as dmaengine,
> 
> the DMAC is part of the SDHI module?
> 
> > this patch adds a different code as tmio_mmc_dma_gen3.c.
> 
> adds different code?
> 
> > --- a/drivers/mmc/host/Kconfig
> > +++ b/drivers/mmc/host/Kconfig
> > @@ -575,10 +575,27 @@ config MMC_SDHI
> >         depends on SUPERH || ARM || ARM64
> >         depends on SUPERH || ARCH_RENESAS || COMPILE_TEST
> >         select MMC_TMIO_CORE
> > +       select MMC_SDHI_SYS_DMAC if (SUPERH || ARM)
> > +       select MMC_SDHI_INTERNAL_DMAC if ARM64
> >         help
> >           This provides support for the SDHI SD/SDIO controller found in
> >           Renesas SuperH, ARM and ARM64 based SoCs
> >
> > +config MMC_SDHI_SYS_DMAC
> > +       tristate "DMA support use of SYS DMAC with SDHI SD/SDIO controller"
> 
> DMA support for SYS_DMAC?

How about this?

config MMC_SDHI_SYS_DMAC
	tristate "DMA for SDHI SD/SDIO controllers using SYS-DMAC"
	...
	help
	   This provides DMA support for the SDHI SD/SDIO controllers
	   using SYS-DMAC via DMA Engine. This supports the controllers
	   found in SuperH and Renesas ARM based SoCs.

config MMC_SDHI_INTERNAL_DMAC
	tristate "DMA for SDHI SD/SDIO controllers using on-chip bus mastering"
	...
	help
	   This provides DMA support for the SDHI SD/SDIO controllers
	   using on-chip bus mastering. This supports the controllers
	   found in arm64 based SoCs.

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
