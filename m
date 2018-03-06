From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V2 3/5] ARM: dts: stm32: add sdmmc support for stm32h743
Date: Mon, 5 Mar 2018 19:41:42 -0600
Message-ID: <20180306014142.kehlb55qc6c2tbaa@rob-hp-laptop>
References: <1519832844-28068-1-git-send-email-ludovic.Barre@st.com>
 <1519832844-28068-4-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1519832844-28068-4-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Barre <ludovic.Barre@st.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, Gerald Baeza <gerald.baeza@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, Feb 28, 2018 at 04:47:22PM +0100, Ludovic Barre wrote:
> From: Ludovic Barre <ludovic.barre@st.com>
> 
> This patch adds sdmmc support for stm32h743.
> 2×SD/SDIO/MMC interfaces (up to 125 MHz)
> 
> Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
> ---
>  arch/arm/boot/dts/stm32h743.dtsi | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32h743.dtsi b/arch/arm/boot/dts/stm32h743.dtsi
> index bbfcbac..5e85538 100644
> --- a/arch/arm/boot/dts/stm32h743.dtsi
> +++ b/arch/arm/boot/dts/stm32h743.dtsi
> @@ -217,6 +217,19 @@
>  			};
>  		};
>  
> +		sdmmc2: sdmmc@48022400 {

Like I said in the binding example:

mmc@...

> +			compatible = "st,stm32h7-sdmmc";
> +			reg = <0x48022400 0x400>;
> +			reg-names = "sdmmc";

Not in the binding definition (And don't add it, -names for a single 
item is pointless).

> +			interrupts = <124>;
> +			clocks = <&rcc SDMMC2_CK>;
> +			resets = <&rcc STM32H7_AHB2_RESET(SDMMC2)>;
> +			cap-sd-highspeed;
> +			cap-mmc-highspeed;
> +			max-frequency = <125000000>;
> +			status = "disabled";
> +		};
> +
>  		mdma1: dma@52000000 {
>  			compatible = "st,stm32h7-mdma";
>  			reg = <0x52000000 0x1000>;
> @@ -227,6 +240,19 @@
>  			dma-requests = <32>;
>  		};
>  
> +		sdmmc1: sdmmc@52007000 {
> +			compatible = "st,stm32h7-sdmmc";
> +			reg = <0x52007000 0x1000>;
> +			reg-names = "sdmmc";
> +			interrupts = <49>;
> +			clocks = <&rcc SDMMC1_CK>;
> +			resets = <&rcc STM32H7_AHB3_RESET(SDMMC1)>;
> +			cap-sd-highspeed;
> +			cap-mmc-highspeed;
> +			max-frequency = <125000000>;
> +			status = "disabled";
> +		};
> +
>  		lptimer2: timer@58002400 {
>  			#address-cells = <1>;
>  			#size-cells = <0>;
> -- 
> 2.7.4
> 
