From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc-exynos: Common bindings for dw-mshc timing
Date: Fri, 09 Aug 2013 11:54:01 +0900
Message-ID: <520459C9.8020305@samsung.com>
References: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:31522 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758252Ab3HICx5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Aug 2013 22:53:57 -0400
In-reply-to: <1376002520-7461-1-git-send-email-dinguyen@altera.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: dinguyen@altera.com
Cc: dinh.linux@gmail.com, Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, Ian Campbell <ian.campbell@citrix.com>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hi Dinh

On 08/09/2013 07:55 AM, dinguyen@altera.com wrote:
> From: Dinh Nguyen <dinguyen@altera.com>
> 
> Remove the "samsung" in "samsung,dw-mshc-ciu-div", "samsung,dw-mshc-sdr-timing",
> and "samsung,dw-mshc-ddr-timing". These characteristics are not applicable to
> just Samsung platforms, but to any platform that uses the Synopsis SD/MMC IP.
> 
> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
> CC: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Jaehoon Chung <jh80.chung@samsung.com>
> Cc: Seungwon Jeon <tgih.jun@samsung.com>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Stephen Warren <swarren@wwwdotorg.org>
> Cc: Ian Campbell <ian.campbell@citrix.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mmc@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> ---
>  .../devicetree/bindings/mmc/exynos-dw-mshc.txt     |   30 --------------------
>  .../devicetree/bindings/mmc/synopsis-dw-mshc.txt   |   29 +++++++++++++++++++
>  arch/arm/boot/dts/cros5250-common.dtsi             |   18 ++++++------
>  arch/arm/boot/dts/exynos4412-odroidx.dts           |    6 ++--
>  arch/arm/boot/dts/exynos4412-origen.dts            |    6 ++--
>  arch/arm/boot/dts/exynos5250-arndale.dts           |   12 ++++----
>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |   12 ++++----
>  drivers/mmc/host/dw_mmc-exynos.c                   |    6 ++--
>  8 files changed, 59 insertions(+), 60 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> index 6d1c098..ddb1d95 100644
> --- a/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/exynos-dw-mshc.txt
> @@ -17,33 +17,6 @@ Required Properties:
>  	- "samsung,exynos5250-dw-mshc": for controllers with Samsung Exynos5250
>  	  specific extensions.
>  
> -* samsung,dw-mshc-ciu-div: Specifies the divider value for the card interface
> -  unit (ciu) clock. This property is applicable only for Exynos5 SoC's and
> -  ignored for Exynos4 SoC's. The valid range of divider value is 0 to 7.
> -
> -* samsung,dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
> -  in transmit mode and CIU clock phase shift value in receive mode for single
> -  data rate mode operation. Refer notes below for the order of the cells and the
> -  valid values.
> -
> -* samsung,dw-mshc-ddr-timing: Specifies the value of CUI clock phase shift value
> -  in transmit mode and CIU clock phase shift value in receive mode for double
> -  data rate mode operation. Refer notes below for the order of the cells and the
> -  valid values.
> -
> -  Notes for the sdr-timing and ddr-timing values:
> -
> -    The order of the cells should be
> -      - First Cell: CIU clock phase shift value for tx mode.
> -      - Second Cell: CIU clock phase shift value for rx mode.
> -
> -    Valid values for SDR and DDR CIU clock timing for Exynos5250:
> -      - valid value for tx phase shift and rx phase shift is 0 to 7.
> -      - when CIU clock divider value is set to 3, all possible 8 phase shift
> -        values can be used.
> -      - if CIU clock divider value is 0 (that is divide by 1), both tx and rx
> -        phase shift clocks should be 0.
> -
>  Required properties for a slot:
>  
>  * gpios: specifies a list of gpios used for command, clock and data bus. The
> @@ -71,9 +44,6 @@ Example:
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
>  
>  		slot@0 {
>  			reg = <0>;
> diff --git a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
> index cdcebea..cf85a8c 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsis-dw-mshc.txt
> @@ -71,6 +71,32 @@ Optional properties:
>  * vmmc-supply: The phandle to the regulator to use for vmmc.  If this is
>    specified we'll defer probe until we can find this regulator.
>  
> +* dw-mshc-ciu-div: Specifies the divider value for the card interface
> +  unit (ciu) clock. The valid range of divider value is 0 to 7.
> +
> +* dw-mshc-sdr-timing: Specifies the value of CIU clock phase shift value
> +  in transmit mode and CIU clock phase shift value in receive mode for single
> +  data rate mode operation. Refer notes below for the order of the cells and the
> +  valid values.
> +
> +* dw-mshc-ddr-timing: Specifies the value of CUI clock phase shift value
> +  in transmit mode and CIU clock phase shift value in receive mode for double
> +  data rate mode operation. Refer notes below for the order of the cells and the
> +  valid values.
> +
> +	Notes for the sdr-timing and ddr-timing values:
> +
> +	The order of the cells should be
> +		- First Cell: CIU clock phase shift value for tx mode.
> +		- Second Cell: CIU clock phase shift value for rx mode.
> +
> +	Valid values for SDR and DDR CIU clock timing for Exynos5250:
Exynos5250? Maybe It should be mentioned common SoC.
> +		- valid value for tx phase shift and rx phase shift is 0 to 7.
> +		- when CIU clock divider value is set to 3, all possible 8 phase shift
> +			values can be used.
> +		- if CIU clock divider value is 0 (that is divide by 1), both tx and rx
> +			phase shift clocks should be 0.
> +
>  Aliases:
>  
>  - All the MSHC controller nodes should be represented in the aliases node using
> @@ -99,6 +125,9 @@ board specific portions as listed below.
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
>  		vmmc-supply = <&buck8>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  
>  		slot@0 {
>  			reg = <0>;
> diff --git a/arch/arm/boot/dts/cros5250-common.dtsi b/arch/arm/boot/dts/cros5250-common.dtsi
> index dc259e8b..93d3c85 100644
> --- a/arch/arm/boot/dts/cros5250-common.dtsi
> +++ b/arch/arm/boot/dts/cros5250-common.dtsi
> @@ -235,9 +235,9 @@
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_cd &sd0_bus4 &sd0_bus8>;
>  
> @@ -256,9 +256,9 @@
>  		supports-highspeed;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>  
> @@ -275,9 +275,9 @@
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  		/* See board-specific dts files for pin setup */
>  
>  		slot@0 {
> diff --git a/arch/arm/boot/dts/exynos4412-odroidx.dts b/arch/arm/boot/dts/exynos4412-odroidx.dts
> index 46c678e..e6c3b23 100644
> --- a/arch/arm/boot/dts/exynos4412-odroidx.dts
> +++ b/arch/arm/boot/dts/exynos4412-odroidx.dts
> @@ -51,9 +51,9 @@
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  
>  		slot@0 {
>  			reg = <0>;
> diff --git a/arch/arm/boot/dts/exynos4412-origen.dts b/arch/arm/boot/dts/exynos4412-origen.dts
> index 7993641..b403a57 100644
> --- a/arch/arm/boot/dts/exynos4412-origen.dts
> +++ b/arch/arm/boot/dts/exynos4412-origen.dts
> @@ -122,9 +122,9 @@
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  
>  		slot@0 {
>  			reg = <0>;
> diff --git a/arch/arm/boot/dts/exynos5250-arndale.dts b/arch/arm/boot/dts/exynos5250-arndale.dts
> index abc7272..72aa743 100644
> --- a/arch/arm/boot/dts/exynos5250-arndale.dts
> +++ b/arch/arm/boot/dts/exynos5250-arndale.dts
> @@ -324,9 +324,9 @@
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  		vmmc-supply = <&mmc_reg>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
> @@ -346,9 +346,9 @@
>  		supports-highspeed;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  		vmmc-supply = <&mmc_reg>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 49f18c2..220da19 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -146,9 +146,9 @@
>  		broken-cd;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd0_clk &sd0_cmd &sd0_bus4 &sd0_bus8>;
>  
> @@ -167,9 +167,9 @@
>  		supports-highspeed;
>  		fifo-depth = <0x80>;
>  		card-detect-delay = <200>;
> -		samsung,dw-mshc-ciu-div = <3>;
> -		samsung,dw-mshc-sdr-timing = <2 3>;
> -		samsung,dw-mshc-ddr-timing = <1 2>;
> +		dw-mshc-ciu-div = <3>;
> +		dw-mshc-sdr-timing = <2 3>;
> +		dw-mshc-ddr-timing = <1 2>;
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&sd2_clk &sd2_cmd &sd2_cd &sd2_bus4>;
>  
> diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
> index 866edef..553f3c1 100644
> --- a/drivers/mmc/host/dw_mmc-exynos.c
> +++ b/drivers/mmc/host/dw_mmc-exynos.c
> @@ -131,18 +131,18 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
>  	u32 div = 0;
>  	int ret;
>  
> -	of_property_read_u32(np, "samsung,dw-mshc-ciu-div", &div);
> +	of_property_read_u32(np, "dw-mshc-ciu-div", &div);
>  	priv->ciu_div = div;
>  
>  	ret = of_property_read_u32_array(np,
> -			"samsung,dw-mshc-sdr-timing", timing, 2);
> +			"dw-mshc-sdr-timing", timing, 2);
>  	if (ret)
>  		return ret;
>  
>  	priv->sdr_timing = SDMMC_CLKSEL_TIMING(timing[0], timing[1], div);
>  
>  	ret = of_property_read_u32_array(np,
> -			"samsung,dw-mshc-ddr-timing", timing, 2);
> +			"dw-mshc-ddr-timing", timing, 2);
>  	if (ret)
>  		return ret;
Then we can move functions related with clksel from dw-mmc-exynos.c to dw-mmc.c, isn't it?

Best Regards,
Jaehoon Chung
>  
> 

