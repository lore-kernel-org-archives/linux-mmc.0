From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH v3 6/6] ARM: at91: dts: add MCI DMA support
Date: Fri, 19 Apr 2013 11:43:32 +0200
Message-ID: <517111C4.3090808@atmel.com>
References: <1366362683-14496-1-git-send-email-ludovic.desroches@atmel.com> <1366362683-14496-7-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:20333 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S968096Ab3DSJnh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Apr 2013 05:43:37 -0400
In-Reply-To: <1366362683-14496-7-git-send-email-ludovic.desroches@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ludovic.desroches@atmel.com
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-i2c@vger.kernel.org, plagnioj@jcrosoft.com

On 04/19/2013 11:11 AM, ludovic.desroches@atmel.com :
> From: Ludovic Desroches <ludovic.desroches@atmel.com>
> 
> Add DMA resources to MCI nodes.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>

I have made little corrections, but do not bother, it is already in my tree:

[nicolas.ferre@atmel.com: correct 9g45, 9n12 dma phandle name]
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

And stacked in at91-3.10-soc.

thanks,

> ---
>  arch/arm/boot/dts/at91sam9g45.dtsi | 4 ++++
>  arch/arm/boot/dts/at91sam9n12.dtsi | 2 ++
>  arch/arm/boot/dts/at91sam9x5.dtsi  | 4 ++++
>  arch/arm/boot/dts/sama5d3.dtsi     | 6 ++++++
>  4 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/at91sam9g45.dtsi b/arch/arm/boot/dts/at91sam9g45.dtsi
> index 275e768..de2abc0 100644
> --- a/arch/arm/boot/dts/at91sam9g45.dtsi
> +++ b/arch/arm/boot/dts/at91sam9g45.dtsi
> @@ -513,6 +513,8 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xfff80000 0x600>;
>  				interrupts = <11 4 0>;
> +				dmas = <&dma0 1 0>;

single dma controller in 9g45:
s/dma0/dma/


> +				dma-names = "rxtx";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				status = "disabled";
> @@ -522,6 +524,8 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xfffd0000 0x600>;
>  				interrupts = <29 4 0>;
> +				dmas = <&dma0 1 13>;

Ditto

> +				dma-names = "rxtx";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				status = "disabled";
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index f912124..0b61c41 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -89,6 +89,8 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xf0008000 0x600>;
>  				interrupts = <12 4 0>;
> +				dmas = <&dma0 1 0>

single dma controller in 9n12:
s/dma0/dma/
+ do not forget the tailing ";"

> +				dma-names = "rxtx";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				status = "disabled";
> diff --git a/arch/arm/boot/dts/at91sam9x5.dtsi b/arch/arm/boot/dts/at91sam9x5.dtsi
> index 16c9b81..5f42e7a 100644
> --- a/arch/arm/boot/dts/at91sam9x5.dtsi
> +++ b/arch/arm/boot/dts/at91sam9x5.dtsi
> @@ -449,6 +449,8 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xf0008000 0x600>;
>  				interrupts = <12 4 0>;
> +				dmas = <&dma0 1 0>;
> +				dma-names = "rxtx";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				status = "disabled";
> @@ -458,6 +460,8 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xf000c000 0x600>;
>  				interrupts = <26 4 0>;
> +				dmas = <&dma1 1 0>;
> +				dma-names = "rxtx";
>  				#address-cells = <1>;
>  				#size-cells = <0>;
>  				status = "disabled";
> diff --git a/arch/arm/boot/dts/sama5d3.dtsi b/arch/arm/boot/dts/sama5d3.dtsi
> index 8e87277..2e643ea 100644
> --- a/arch/arm/boot/dts/sama5d3.dtsi
> +++ b/arch/arm/boot/dts/sama5d3.dtsi
> @@ -60,6 +60,8 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xf0000000 0x600>;
>  				interrupts = <21 4 0>;
> +				dmas = <&dma0 2 0>;
> +				dma-names = "rxtx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_mmc0_clk_cmd_dat0 &pinctrl_mmc0_dat1_3 &pinctrl_mmc0_dat4_7>;
>  				status = "disabled";
> @@ -173,6 +175,8 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xf8000000 0x600>;
>  				interrupts = <22 4 0>;
> +				dmas = <&dma1 2 0>;
> +				dma-names = "rxtx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
>  				status = "disabled";
> @@ -184,6 +188,8 @@
>  				compatible = "atmel,hsmci";
>  				reg = <0xf8004000 0x600>;
>  				interrupts = <23 4 0>;
> +				dmas = <&dma1 2 1>;
> +				dma-names = "rxtx";
>  				pinctrl-names = "default";
>  				pinctrl-0 = <&pinctrl_mmc2_clk_cmd_dat0 &pinctrl_mmc2_dat1_3>;
>  				status = "disabled";
> 


-- 
Nicolas Ferre
