From: Alexandre Torgue <alexandre.torgue@st.com>
Subject: Re: [PATCH v2 7/9] DT: stm32f429: add node for SDIO controller
Date: Tue, 10 Jan 2017 10:15:23 +0100
Message-ID: <4a6f20ef-d064-9621-12bc-c54092973506@st.com>
References: <1484037736-25029-1-git-send-email-andrea.merello@gmail.com>
 <1484037736-25029-8-git-send-email-andrea.merello@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:38493 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1757626AbdAJJP2 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Jan 2017 04:15:28 -0500
In-Reply-To: <1484037736-25029-8-git-send-email-andrea.merello@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrea Merello <andrea.merello@gmail.com>, ulf.hansson@linaro.org, mcoquelin.stm32@gmail.com
Cc: linux-mmc@vger.kernel.org, bruherrera@gmail.com

Hi Andrea

On 01/10/2017 09:42 AM, Andrea Merello wrote:
> Signed-off-by: Andrea Merello <andrea.merello@gmail.com>

Can you please add a commit message.
Can you also change commit header like: "ARM: dts: stm32: add node for 
SDIO controller on stm32f429

> ---
>  arch/arm/boot/dts/stm32f429.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm/boot/dts/stm32f429.dtsi b/arch/arm/boot/dts/stm32f429.dtsi
> index de7b9c3..c12a64e 100644
> --- a/arch/arm/boot/dts/stm32f429.dtsi
> +++ b/arch/arm/boot/dts/stm32f429.dtsi
> @@ -388,6 +388,18 @@
>  			};
>  		};
>
> +		sdio: sdio@40012c00 {
> +			compatible = "st,stm32f4xx-sdio";
> +			reg = <0x40012c00 0x400>;
> +			clocks = <&rcc 0 171>;
> +			interrupts = <49>;
> +			status = "disabled";
> +			pinctrl-0 = <&sdio_pins>;
> +			pinctrl-1 = <&sdio_pins_od>;
> +			pinctrl-names = "default", "opendrain";
> +			max-frequency = <48000000>;
> +		};
> +
>  		rcc: rcc@40023810 {
>  			#reset-cells = <1>;
>  			#clock-cells = <2>;
>
