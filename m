From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH 8/9] DT: stm32f469-disco: add node for SDIO controller
Date: Thu, 10 Nov 2016 11:54:46 +0100
Message-ID: <ffdc246c-0197-f1a7-f848-a02b4e7df13c@st.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
 <1478612625-23256-9-git-send-email-andrea.merello@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13926 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754563AbcKJKyv (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2016 05:54:51 -0500
In-Reply-To: <1478612625-23256-9-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Merello <andrea.merello@gmail.com>, ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com
Cc: linux-mmc@vger.kernel.org

Hi Andrea

On 11/08/2016 02:43 PM, Andrea Merello wrote:
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi      |  2 +-
>  arch/arm/boot/dts/stm32f469-disco.dts | 30 ++++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index d6d0548..23e6a5e 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -185,7 +185,7 @@
>  			interrupts = <1>, <2>, <3>, <6>, <7>, <8>, <9>, <10>, <23>, <40>, <41>, <42>, <62>, <76>;
>  		};
>
> -		pin-controller {
> +		pinctrl:pin-controller {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
>  			compatible = "st,stm32f429-pinctrl";
> diff --git a/arch/arm/boot/dts/stm32f469-disco.dts b/arch/arm/boot/dts/stm32f469-disco.dts
> index e911af8..e16dfc3 100644
> --- a/arch/arm/boot/dts/stm32f469-disco.dts
> +++ b/arch/arm/boot/dts/stm32f469-disco.dts
> @@ -64,12 +64,42 @@
>  	aliases {
>  		serial0 = &usart3;
>  	};
> +
> +	mmc_vcard: mmc_vcard {
> +		compatible = "regulator-fixed";
> +		regulator-name = "mmc_vcard";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
As I assume you will send a v2 (due to kbuild issue) remove empty line 
please.
> +
> +	};
>  };
>
>  &clk_hse {
>  	clock-frequency = <8000000>;
>  };
>
> +&pinctrl {
> +	sdio-cd {
> +		sdio_cd: sdio-cd {
> +			pins {
> +				pinmux = <STM32F429_PG2_FUNC_GPIO>;
> +				bias-pull-up;
> +			};
> +		};
> +	};
> +};
> +
> +&sdio {
> +	status = "okay";
> +	vmmc-supply = <&mmc_vcard>;
> +	cd-gpios = <&gpiog 2 0>;
> +	cd-inverted;
> +	pinctrl-names = "default", "opendrain", "cd";
> +	pinctrl-0 = <&sdio_pins>, <&sdio_cd>;
> +	pinctrl-1 = <&sdio_pins_od>, <&sdio_cd>;
> +	bus-width = <4>;
> +};
> +
>  &usart3 {
>  	status = "okay";
>  };
>
