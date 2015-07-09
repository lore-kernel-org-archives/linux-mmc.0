From: Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH 0/6] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Thu, 9 Jul 2015 15:50:32 +0800
Message-ID: <20150709075032.GD23464@tiger>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51751 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750805AbbGIHuv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 9 Jul 2015 03:50:51 -0400
Content-Disposition: inline
In-Reply-To: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: linux-mmc@vger.kernel.org, fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com

On Thu, Jun 18, 2015 at 02:05:31AM +0800, Dong Aisheng wrote:
> Commit 8d86e4f mmc: sdhci-esdhc-imx: Call mmc_of_parse()
> seriously break the sd card detect/write protect function
> of most IMX platforms since a lot of GPIO flags of cd-gpios/wp-gpios
> are wrongly set in devicetree.
> 
> It breaks the following things:

My opinion would be that we revert the commit 8d86e4f for v4.2, as it's
so broken.

> 1) cd-gpio function enable
> Most IMX boards GPIO card detect function becomes unwork and using card
> polling mode instead by mistake.
> Openning CONFIG_MMC_DEBUG will easily see that.
> It is caused by the default quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION
> is not cleared for dt platform by commit 8d86e4f, then
> MMC_CAP_NEEDS_POLL is wrongly set.
> Patch 1~2 is to fix it.
> 
> 2) cd-gpio/wp-gpio polarity
> Before commit 8d86e4f, we do not use GPIO flags passed from
> devicetree. But after it, GPIO flags specfied in dt becomes valid
> and will affect the normal cd/wp function.
> 
> This is fixed by another dts fix patch series:
> [PATCH 0/5] dts: imx: fix sd card gpio polarity specified in device tree
> http://www.spinics.net/lists/arm-kernel/msg426156.html
> 
> Since it needs to change a lot board dts files, so i cook the patch
> based on Shawn/for-next branch to make sure all board dts file are
> changed in the same time.
> 
> The dts fix patches series should be picked before this series since
> the driver fixes depend on the correct dts(correct GPIO polarity)
> to work properly.

So this is a device tree ABI breakage.  All the existing DTBs already
installed on devices will be broken with the new kernel.  You can argue
that the device trees are buggy and we're fixing bugs.  But if a bugfix
breaks things, we should be conservative.  Here is my suggestion:

1. Revert commit 8d86e4f for v4.2
2. I queue up your dts fixing series for v4.2
3. Keep things as they are for a few releases and then consider to move
   to mmc_of_parse() with the hope that those buggy DTBs have been
   upgraded during that period.

Shawn

> 
> 3) max-frequency not work in sdhci
> mmc_of_parse will parse the max-frequency from devicetree,
> however, its value will be overwritten by common sdhci driver
> finnally,so it does not actually work.
> Patch 3 is to fix it.
> 
> 4) patch 4~6 clear unneeded parsing code after switch to mmc_of_parse().
> 
> The series is based on ulf/next tree.
> 
> I also CCed this patch series to all board maintainer related in this
> change, hope they can help test it.
> I only tested some freescale IMX boards.
> 
> BTW, There's indeed a problem here that dts fix patch series needs to
> be picked before this series, but it can't go through Ulf tree
> since some board dts changed does not in Ulf's tree.
> And this patch series also can not go through Shawn's tree,
> since mmc part change depends on some patches in Ulf tree.
> Two series are cross dependant.
> Hope you guy can find a solution for it.
> 
> Those two patch series is an important fix, hopefully can catch up the
> final 4.1 merge window.
> 
> Dong Aisheng (6):
>   mmc: sdhci-esdhc-imx: fix cd regression for dt platform
>   mmc: sdhci-esdhc-imx: move all non dt probe code into one function
>   mmc: sdhci: make max-frequency property in device tree work
>   mmc: sdhci-esdhc-imx: remove duplicated dts parsing
>   mmc: sdhci-esdhc-imx: clear f_max in boarddata
>   dts: mmc: fsl-imx-esdhc: remove fsl,cd-controller support
> 
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   2 -
>  drivers/mmc/host/sdhci-esdhc-imx.c                 | 210 ++++++++++-----------
>  drivers/mmc/host/sdhci.c                           |   9 +-
>  include/linux/platform_data/mmc-esdhc-imx.h        |   1 -
>  4 files changed, 111 insertions(+), 111 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
