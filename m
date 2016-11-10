From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH 6/9] DT: stm32f429: add pin map for SDIO controller
Date: Thu, 10 Nov 2016 11:51:22 +0100
Message-ID: <3ec978cc-c80e-f350-f387-83b3e145dbe3@st.com>
References: <1478612625-23256-1-git-send-email-andrea.merello@gmail.com>
 <1478612625-23256-7-git-send-email-andrea.merello@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:64610 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755201AbcKJKv0 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Nov 2016 05:51:26 -0500
In-Reply-To: <1478612625-23256-7-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Merello <andrea.merello@gmail.com>, ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com
Cc: linux-mmc@vger.kernel.org

Hi Andrea,

Some minor remarks.

On 11/08/2016 02:43 PM, Andrea Merello wrote:
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index 336ee4f..961bc0c 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -313,6 +313,37 @@
>  				};
>  			};
>
> +			sdio_pins:sdio_pins@0 {
Add a space after ":"
> +				pins {
> +					pinmux = <STM32F429_PC8_FUNC_SDIO_D0>,
> +						 <STM32F429_PC9_FUNC_SDIO_D1>,
> +						 <STM32F429_PC10_FUNC_SDIO_D2>,
> +						 <STM32F429_PC11_FUNC_SDIO_D3>,
> +						 <STM32F429_PC12_FUNC_SDIO_CK>,
> +						 <STM32F429_PD2_FUNC_SDIO_CMD>;
> +					drive-push-pull;
> +					slew-rate = <2>;
> +				};
> +			};
> +
> +			sdio_pins_od:sdio_pins_od@0 {
same
> +				pins {
> +					pinmux = <STM32F429_PC8_FUNC_SDIO_D0>,
> +						 <STM32F429_PC9_FUNC_SDIO_D1>,
> +						 <STM32F429_PC10_FUNC_SDIO_D2>,
> +						 <STM32F429_PC11_FUNC_SDIO_D3>,
> +						 <STM32F429_PC12_FUNC_SDIO_CK>;
> +					drive-push-pull;
> +					slew-rate = <2>;
> +				};
> +
> +				pins_od {
> +					pinmux = <STM32F429_PD2_FUNC_SDIO_CMD>;
> +					drive-open-drain;
> +					slew-rate = <2>;
> +				};
Why don't use "pins1" and "pins2" instead of "pins" and "pins_od" like 
it is done for usart1?

regards
Alex

> +			};
> +




>  			ethernet0_mii: mii@0 {
>  				pins {
>  					pinmux = <STM32F429_PG13_FUNC_ETH_MII_TXD0_ETH_RMII_TXD0>,
>
