From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH V2 00/15] a few sdhci/imx clean up and fix patches
Date: Tue, 12 Jul 2016 15:54:22 +0200
Message-ID: <20160712135422.GE8540@lunn.ch>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:40875 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937AbcGLNy3 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Jul 2016 09:54:29 -0400
Content-Disposition: inline
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org

On Tue, Jul 12, 2016 at 03:46:09PM +0800, Dong Aisheng wrote:
> Patch 1~10 are mainly sdhci cleanup patches while patch 7,9,10
> are fixes which seems needed for stable tree as well.

Hi Dong

Fixed should be first, so they can be cherry-picked into stable.
Cleanups come afterwards, since they will not be back ported into
stable.

Please change the order of the patches within the series.

       Andrew


> 
> The main work is:
> 1) using more robust mmc_regulator_set_vqmmc 
> 2) add auto retune support
> 3) improve sdhci-esdhc-imx stability
> 4) add state save and restore for low power mode
> 
> Change Log:
> v1->v2:
>  * address all Andrian's comments
>  * below patches are dropped
>   mmc: sdhci: move sdhci_get_cd() forward to avoid declaration
>   mmc: core: fix a comment typo
>   mmc: sdhci: re-factor sdhci_start_signal_voltage()
>   mmc: core: mmc_regulator_set_vqmmc not return error if vqmmc/vmmc not
>     exist
>   mmc: sdhci: check SDHCI_QUIRK2_NO_1_8_V when do voltage switch
>   mmc: sdhci: rename quirk SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12
> 	Above clean up is not needed so far according to Andrian.
> 
>   mmc: sdhci: fix incorrect get data interrupt during no data transfer
> 	This one is not needed anymore cause Andrian had another fix
> 	already in tree.
> 	(commit 0e0a35d2d4058 mmc: sdhci: Track whether a reset is pending)
> 
>   mmc: core: disable auto retune during card detection process
> 	This one will sent out in another patch series to fix in CORE.
> 
> v1:
> http://www.spinics.net/lists/linux-mmc/msg36316.html
> 
> Dong Aisheng (15):
>   mmc: sdhci: using common mmc_regulator_set_vqmmc()
>   mmc: sdhci-esdhc-imx: remove SDHCI_QUIRK_BROKEN_TIMEOUT_VAL
>   mmc: sdhci-esdhc-imx: add esdhc specific suspend resume callback
>   mmc: sdhci-esdhc-imx: restore watermark level setting after resume
>   mmc: sdhci-esdhci-imx: disable DLL delay line settings explicitly
>   mmc: sdhci-esdhc-imx: support setting tuning start point
>   doc: dt: fsl-imx-esdhc: add set tuning start point binding
>   mmc: sdhci: add standard hw auto retuning support
>   mmc: sdhci-esdhc-imx: enable hw auto retuning for STD_TUNING
>   mmc: sdhci-esdhc-imx: enable hw auto retuning for MAN_TUNING
>   mmc: sdhci-esdhc-imx: fix strobe DLL lock wrong clock issue
>   mmc: sdhci-esdhc-imx: factor out hw related initialization into
>     function
>   mmc: sdhci-esdhc-imx: move tuning static configuration into hwinit
>     function
>   mmc: sdhci-esdhci-imx: re-initialize hw state after resume
>   mmc: sdhci-esdhc-imx: clear tuning bits during driver probe
> 
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   2 +
>  drivers/mmc/host/sdhci-esdhc-imx.c                 | 149 ++++++++++++++-------
>  drivers/mmc/host/sdhci.c                           |  24 ++--
>  drivers/mmc/host/sdhci.h                           |   3 +
>  include/linux/platform_data/mmc-esdhc-imx.h        |   1 +
>  5 files changed, 122 insertions(+), 57 deletions(-)
> 
> -- 
> 1.9.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
