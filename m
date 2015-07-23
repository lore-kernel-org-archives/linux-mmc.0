From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 00/11] mmc: sdhci-esdhci-imx: fix cd/wp regression
Date: Thu, 23 Jul 2015 11:11:58 +0200
Message-ID: <CAPDyKFqX-9e3+Ciefp2afjiZOUUg2KbzGuy=5DgVxjtz86XW7w@mail.gmail.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:35997 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752784AbbGWJL7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Jul 2015 05:11:59 -0400
Received: by qkdv3 with SMTP id v3so169314981qkd.3
        for <linux-mmc@vger.kernel.org>; Thu, 23 Jul 2015 02:11:58 -0700 (PDT)
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <aisheng.dong@freescale.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Fabio Estevam <fabio.estevam@freescale.com>, =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marex@denx.de>, Steffen Trumtrar <s.trumtrar@pengutronix.de>, smoch@web.de, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Robert Nelson <robertcnelson@gmail.com>, Sascha Hauer <s.hauer@pengutronix.de>, Chris Ball <chris@printf.net>, Rabeeh Khoury <rabeeh@solid-run.com>, troy.kisky@boundarydevices.com, =?UTF-8?Q?Rostislav_Lisov=C3=BD?= <lisovy@gmail.com>, hs@denx.de, gwenhael.goavec-merou@armadeus.com, Philipp Zabel <p.zabel@pengutronix.de>, Russell King <rmk+kernel@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Dong Aisheng <b29396@freescale.com>, tharvey@gateworks.com, LW@karo-electronics.de, ipaton0@gmail.com, Johan Derycke <johan.derycke@barco.com>

+Johan Derycke

On 22 July 2015 at 14:52, Dong Aisheng <aisheng.dong@freescale.com> wrote:
> This is a rebase version of former two patch series:
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-June/351167.html
> http://www.spinics.net/lists/arm-kernel/msg426156.html
>
> No other changes.
>
> Commit 8d86e4f mmc: sdhci-esdhc-imx: Call mmc_of_parse()
> seriously break the sd card detect/write protect function
> of most IMX platforms since a lot of GPIO flags of cd-gpios/wp-gpios
> are wrongly set in devicetree.
>
> It breaks the following things:
> 1) cd-gpio function enable
> Most IMX boards GPIO card detect function becomes unwork and using card
> polling mode instead by mistake.
> Openning CONFIG_MMC_DEBUG will easily see that.
> It is caused by the default quirk SDHCI_QUIRK_BROKEN_CARD_DETECTION
> is not cleared for dt platform by commit 8d86e4f, then
> MMC_CAP_NEEDS_POLL is wrongly set.
>
> This is fixed by patch 6~7
>
> 2) cd-gpio/wp-gpio polarity
> Before commit 8d86e4f, we do not use GPIO flags passed from
> devicetree. But after it, GPIO flags specfied in dt becomes valid
> and will affect the normal cd/wp function.
>
> This is fixed by patch 1~5
>
> 3) max-frequency not work in sdhci
> mmc_of_parse will parse the max-frequency from devicetree,
> however, its value will be overwritten by common sdhci driver
> finnally,so it does not actually work.
> Patch 8 is to fix it.
>
> 4) patch 9~11 clear unneeded parsing code after switch to mmc_of_parse().
>
> The series is based on ulf/next tree.
>
> I also CCed this patch series to all board maintainer related in this
> change, hope they can help test it.
> I only tested some freescale IMX boards.
>
> Dong Aisheng (11):
>   dts: imx51: fix sd card gpio polarity specified in device tree
>   dts: imx53: fix sd card gpio polarity specified in device tree
>   dts: imx6: fix sd card gpio polarity specified in device tree
>   dts: imx25: fix sd card gpio polarity specified in device tree
>   dts: imx7: fix sd card gpio polarity specified in device tree
>   mmc: sdhci-esdhc-imx: fix cd regression for dt platform
>   mmc: sdhci-esdhc-imx: move all non dt probe code into one function
>   mmc: sdhci: make max-frequency property in device tree work
>   mmc: sdhci-esdhc-imx: remove duplicated dts parsing
>   mmc: sdhci-esdhc-imx: clear f_max in boarddata
>   dts: mmc: fsl-imx-esdhc: remove fsl,cd-controller support
>
>  .../devicetree/bindings/mmc/fsl-imx-esdhc.txt      |   2 -
>  arch/arm/boot/dts/imx25-pdk.dts                    |   4 +-
>  arch/arm/boot/dts/imx51-apf51dev.dts               |   2 +-
>  arch/arm/boot/dts/imx53-ard.dts                    |   4 +-
>  arch/arm/boot/dts/imx53-m53evk.dts                 |   4 +-
>  arch/arm/boot/dts/imx53-qsb-common.dtsi            |   4 +-
>  arch/arm/boot/dts/imx53-smd.dts                    |   4 +-
>  arch/arm/boot/dts/imx53-tqma53.dtsi                |   4 +-
>  arch/arm/boot/dts/imx53-tx53.dtsi                  |   4 +-
>  arch/arm/boot/dts/imx53-voipac-bsb.dts             |   4 +-
>  arch/arm/boot/dts/imx6dl-riotboard.dts             |   8 +-
>  arch/arm/boot/dts/imx6q-arm2.dts                   |   5 +-
>  arch/arm/boot/dts/imx6q-gk802.dts                  |   3 +-
>  arch/arm/boot/dts/imx6q-tbs2910.dts                |   4 +-
>  arch/arm/boot/dts/imx6qdl-aristainetos.dtsi        |   4 +-
>  arch/arm/boot/dts/imx6qdl-aristainetos2.dtsi       |   4 +-
>  arch/arm/boot/dts/imx6qdl-cubox-i.dtsi             |   2 +-
>  arch/arm/boot/dts/imx6qdl-dfi-fs700-m60.dtsi       |   4 +-
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi              |   2 +-
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi              |   2 +-
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi              |   2 +-
>  arch/arm/boot/dts/imx6qdl-hummingboard.dtsi        |   2 +-
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi          |   4 +-
>  arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi       |   8 +-
>  arch/arm/boot/dts/imx6qdl-rex.dtsi                 |   4 +-
>  arch/arm/boot/dts/imx6qdl-sabreauto.dtsi           |   4 +-
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi           |   6 +-
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |   8 +-
>  arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |   4 +-
>  arch/arm/boot/dts/imx6qdl-wandboard.dtsi           |   6 +-
>  arch/arm/boot/dts/imx6sl-evk.dts                   |  10 +-
>  arch/arm/boot/dts/imx6sx-sabreauto.dts             |   4 +-
>  arch/arm/boot/dts/imx6sx-sdb.dtsi                  |   4 +-
>  arch/arm/boot/dts/imx7d-sdb.dts                    |   4 +-
>  drivers/mmc/host/sdhci-esdhc-imx.c                 | 210 ++++++++++-----------
>  drivers/mmc/host/sdhci.c                           |   9 +-
>  include/linux/platform_data/mmc-esdhc-imx.h        |   1 -
>  37 files changed, 185 insertions(+), 179 deletions(-)
>
> --
> 1.9.1
>

I have applied this for my fixes branch, with a small change to fix
some white-spaces in patch3 which  checkpatch complained about.

Thanks!

Kind regards
Uffe
