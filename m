From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 5/5] ARM: dts: imx51-babbage: Fix esdhc setup
Date: Mon, 9 Jun 2014 11:41:00 +0800
Message-ID: <20140609034058.GF11061@dragon>
References: <1400848384-3226-1-git-send-email-s.hauer@pengutronix.de>
 <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1400848384-3226-6-git-send-email-s.hauer@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-mmc@vger.kernel.org, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On Fri, May 23, 2014 at 02:33:04PM +0200, Sascha Hauer wrote:
> - Move cd/wp pinctrl from the hog group to the esdhc groups
> - use gpio for card detection / write protection on esdhc2 since
>   the controller based detection does not work
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

The pad config value 0x20d5 still makes sense here when switching to
GPIO function?  Probably should be 0x100 like what we have in esdhc2grp?

Shawn

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
