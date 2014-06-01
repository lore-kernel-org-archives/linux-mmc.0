From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/5] ARM: dts: imx51-babbage: Fix esdhc setup
Date: Sun, 1 Jun 2014 23:22:19 +0800
Message-ID: <20140601152216.GD11061@dragon>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
 <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bn1blp0190.outbound.protection.outlook.com ([207.46.163.190]:42433
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752353AbaFAPWc (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 1 Jun 2014 11:22:32 -0400
Content-Disposition: inline
In-Reply-To: <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de, Dong Aisheng <b29396@freescale.com>

On Fri, May 23, 2014 at 02:33:04PM +0200, Sascha Hauer wrote:
> - Move cd/wp pinctrl from the hog group to the esdhc groups
> - use gpio for card detection / write protection on esdhc2 since
>   the controller based detection does not work

I tracked it a little bit and found that the controller based detection
works fine with v3.13 and starts being broken from v3.14-rc1.  The
offending commit seems to be 89d7e5c13122 (mmc: sdhci-esdhc-imx: add
runtime pm support).

I will probably apply the patch as it is anyway.  But I'm wondering if
we should fix the regression and keep maintaining the support of
controller based cd/wp in sdhci-esdhc-imx driver.

Shawn

> - Fix cd gpio polarity for esdhc1. This is wrong and currently
>   only works because the imx esdhc driver ignores the polarity.
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/boot/dts/imx51-babbage.dts | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/imx51-babbage.dts b/arch/arm/boot/dts/imx51-babbage.dts
> index 9e9deb2..28d4553 100644
> --- a/arch/arm/boot/dts/imx51-babbage.dts
> +++ b/arch/arm/boot/dts/imx51-babbage.dts
> @@ -134,15 +134,15 @@
>  &esdhc1 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc1>;
> -	fsl,cd-controller;
> -	fsl,wp-controller;
> +	cd-gpios = <&gpio1 0 GPIO_ACTIVE_LOW>;
> +	wp-gpios = <&gpio1 1 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
>  };
>  
>  &esdhc2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&pinctrl_esdhc2>;
> -	cd-gpios = <&gpio1 6 GPIO_ACTIVE_HIGH>;
> +	cd-gpios = <&gpio1 6 GPIO_ACTIVE_LOW>;
>  	wp-gpios = <&gpio1 5 GPIO_ACTIVE_HIGH>;
>  	status = "okay";
>  };
> @@ -300,10 +300,6 @@
>  	imx51-babbage {
>  		pinctrl_hog: hoggrp {
>  			fsl,pins = <
> -				MX51_PAD_GPIO1_0__SD1_CD     0x20d5
> -				MX51_PAD_GPIO1_1__SD1_WP     0x20d5
> -				MX51_PAD_GPIO1_5__GPIO1_5    0x100
> -				MX51_PAD_GPIO1_6__GPIO1_6    0x100
>  				MX51_PAD_EIM_A27__GPIO2_21   0x5
>  				MX51_PAD_CSPI1_SS0__GPIO4_24 0x85
>  				MX51_PAD_CSPI1_SS1__GPIO4_25 0x85
> @@ -330,6 +326,8 @@
>  
>  		pinctrl_esdhc1: esdhc1grp {
>  			fsl,pins = <
> +				MX51_PAD_GPIO1_0__GPIO1_0		0x20d5
> +				MX51_PAD_GPIO1_1__GPIO1_1		0x20d5
>  				MX51_PAD_SD1_CMD__SD1_CMD		0x400020d5
>  				MX51_PAD_SD1_CLK__SD1_CLK		0x20d5
>  				MX51_PAD_SD1_DATA0__SD1_DATA0		0x20d5
> @@ -341,6 +339,8 @@
>  
>  		pinctrl_esdhc2: esdhc2grp {
>  			fsl,pins = <
> +				MX51_PAD_GPIO1_5__GPIO1_5		0x100
> +				MX51_PAD_GPIO1_6__GPIO1_6		0x100
>  				MX51_PAD_SD2_CMD__SD2_CMD		0x400020d5
>  				MX51_PAD_SD2_CLK__SD2_CLK		0x20d5
>  				MX51_PAD_SD2_DATA0__SD2_DATA0		0x20d5
> -- 
> 2.0.0.rc0
> 
