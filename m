From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [PATCH v4 3/3] ARM: dts: Add nodes for dw_mmc controllers for
 Samsung Exynos5250 platforms
Date: Wed, 05 Sep 2012 19:43:13 +0900
Message-ID: <006301cd8b53$40024750$c006d5f0$%jun@samsung.com>
References: <1346238072-7324-4-git-send-email-thomas.abraham@linaro.org>
 <1346788173-23845-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ks_c_5601-1987
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:29134 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758122Ab2IEKnP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Sep 2012 06:43:15 -0400
In-reply-to: <1346788173-23845-1-git-send-email-thomas.abraham@linaro.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Thomas Abraham' <thomas.abraham@linaro.org>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, jh80.chung@samsung.com, patches@linaro.org

On Wednesday, September 05, 2012, Thomas Abraham <thomas.abraham@linaro.org> wrote:
> Add device nodes for the four instances of dw_mmc controllers in Exynos5250
> and enable instance 0 and 2 for the smdk5250 board.
> 
> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
> ---
>  arch/arm/boot/dts/exynos5250-smdk5250.dts |   57 +++++++++++++++++++++++++++++
>  arch/arm/boot/dts/exynos5250.dtsi         |   32 ++++++++++++++++
>  2 files changed, 89 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/exynos5250-smdk5250.dts b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> index 8a5e348..ae1cffe 100644
> --- a/arch/arm/boot/dts/exynos5250-smdk5250.dts
> +++ b/arch/arm/boot/dts/exynos5250-smdk5250.dts
> @@ -16,6 +16,13 @@
>  	model = "SAMSUNG SMDK5250 board based on EXYNOS5250";
>  	compatible = "samsung,smdk5250", "samsung,exynos5250";
> 
> +	aliases {
> +		mshc0 = &dwmmc_0;
> +		mshc1 = &dwmmc_1;
> +		mshc2 = &dwmmc_2;
> +		mshc3 = &dwmmc_3;
> +	};
> +
>  	memory {
>  		reg = <0x40000000 0x80000000>;
>  	};
> @@ -72,6 +79,56 @@
>  		status = "disabled";
>  	};
> 
> +	dwmmc_0: dwmmc0@12200000 {
> +		num-slots = <1>;
> +		supports-highspeed;
> +		broken-cd;
> +		fifo-depth = <0x80>;
> +		card-detect-delay = <200>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <2 3 3>;
> +		samsung,dw-mshc-ddr-timing = <1 2 3>;
As adding dw-mshc-ciu-div, third field of dw-mshc-ddr-timing can be removed.

Thanks,
Seungwon Jeon

> +
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <8>;
> +			gpios = <&gpc0 0 2 0 3>, <&gpc0 1 2 0 3>,
> +				<&gpc1 0 2 3 3>, <&gpc1 1 2 3 3>,
> +				<&gpc1 2 2 3 3>, <&gpc1 3 2 3 3>,
> +				<&gpc0 3 2 3 3>, <&gpc0 4 2 3 3>,
> +				<&gpc0 5 2 3 3>, <&gpc0 6 2 3 3>;
> +		};
> +	};
> +
> +	dwmmc_1: dwmmc1@12210000 {
> +		status = "disabled";
> +	};
> +
> +	dwmmc_2: dwmmc2@12220000 {
> +		num-slots = <1>;
> +		supports-highspeed;
> +		fifo-depth = <0x80>;
> +		card-detect-delay = <200>;
> +		samsung,dw-mshc-ciu-div = <3>;
> +		samsung,dw-mshc-sdr-timing = <2 3 3>;
> +		samsung,dw-mshc-ddr-timing = <1 2 3>;
> +
> +		slot@0 {
> +			reg = <0>;
> +			bus-width = <4>;
> +			samsung,cd-pinmux-gpio = <&gpc3 2 2 3 3>;
> +			gpios = <&gpc3 0 2 0 3>, <&gpc3 1 2 0 3>,
> +				<&gpc3 3 2 3 3>, <&gpc3 4 2 3 3>,
> +				<&gpc3 5 2 3 3>, <&gpc3 6 2 3 3>,
> +				<&gpc4 3 3 3 3>, <&gpc4 3 3 3 3>,
> +				<&gpc4 5 3 3 3>, <&gpc4 6 3 3 3>;
> +		};
> +	};
> +
> +	dwmmc_3: dwmmc3@12230000 {
> +		status = "disabled";
> +	};
> +
>  	spi_0: spi@12d20000 {
>  		status = "disabled";
>  	};
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index 004aaa8..f69e389 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -182,6 +182,38 @@
>  		#size-cells = <0>;
>  	};
> 
> +	dwmmc0@12200000 {
> +		compatible = "samsung,exynos5250-dw-mshc";
> +		reg = <0x12200000 0x1000>;
> +		interrupts = <0 75 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	dwmmc1@12210000 {
> +		compatible = "samsung,exynos5250-dw-mshc";
> +		reg = <0x12210000 0x1000>;
> +		interrupts = <0 76 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	dwmmc2@12220000 {
> +		compatible = "samsung,exynos5250-dw-mshc";
> +		reg = <0x12220000 0x1000>;
> +		interrupts = <0 77 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
> +	dwmmc3@12230000 {
> +		compatible = "samsung,exynos5250-dw-mshc";
> +		reg = <0x12230000 0x1000>;
> +		interrupts = <0 78 0>;
> +		#address-cells = <1>;
> +		#size-cells = <0>;
> +	};
> +
>  	amba {
>  		#address-cells = <1>;
>  		#size-cells = <1>;
> --
> 1.6.6.rc2
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

