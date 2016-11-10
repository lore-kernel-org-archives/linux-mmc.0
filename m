From: Yingjoe Chen <yingjoe.chen@mediatek.com>
Subject: Re: [PATCH 4/4] dts: arm64: enable mmc3 for supporting sdio feature
Date: Thu, 10 Nov 2016 10:08:10 +0800
Message-ID: <1478743690.19253.4.camel@mtksdaap41>
References: <1478585341-6749-1-git-send-email-yong.mao@mediatek.com>
         <1478585341-6749-5-git-send-email-yong.mao@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1478585341-6749-5-git-send-email-yong.mao@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yong Mao <yong.mao@mediatek.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, YH Huang <yh.huang@mediatek.com>, Nicolas Boichat <drinkcat@chromium.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, srv_heupstream@mediatek.com, Catalin Marinas <catalin.marinas@arm.com>, linux-mediatek@lists.infradead.org, Will Deacon <will.deacon@arm.com>, Douglas Anderson <dianders@chromium.org>, linux-kernel@vger.kernel.org, Chunfeng Yun <chunfeng.yun@mediatek.com>, Rob Herring <robh+dt@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, linux-arm-kernel@lists.infradead.org, Philipp Zabel <p.zabel@pengutronix.de>, Matthias Brugger <matthias.bgg@gmail.com>, linux-mmc@vger.kernel.org, Eddie Huang <eddie.huang@mediat>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2016-11-08 at 14:09 +0800, Yong Mao wrote:
> From: yong mao <yong.mao@mediatek.com>
> 
> Add description of mmc3 for supporting sdio feature
> 
> Signed-off-by: Yong Mao <yong.mao@mediatek.com>
> Signed-off-by: Chaotian Jing <chaotian.jing@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8173-evb.dts |   82 +++++++++++++++++++++++++++
>  1 file changed, 82 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> index 2a7f731..4dbd299 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> +++ b/arch/arm64/boot/dts/mediatek/mt8173-evb.dts
> @@ -43,6 +43,14 @@
>  		enable-active-high;
>  	};
>  
> +	sdio_fixed_3v3: fixedregulator@0 {

This should be regulator@1 instead of fixedregulator.

> +		compatible = "regulator-fixed";
> +		regulator-name = "3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		gpio = <&pio 85 GPIO_ACTIVE_HIGH>;
> +	};
> +
>  	connector {
>  		compatible = "hdmi-connector";
>  		label = "hdmi";
> @@ -139,6 +147,25 @@
>  	vqmmc-supply = <&mt6397_vmc_reg>;
>  };
>  
> +&mmc3 {
> +	status = "okay";
> +	pinctrl-names = "default", "state_uhs";
> +	pinctrl-0 = <&mmc3_pins_default>;
> +	pinctrl-1 = <&mmc3_pins_uhs>;
> +	bus-width = <4>;
> +	max-frequency = <200000000>;
> +	cap-sd-highspeed;
> +	sd-uhs-sdr50;
> +	sd-uhs-sdr104;
> +	sdr104-clk-delay = <5>;
> +	keep-power-in-suspend;
> +	enable-sdio-wakeup;
> +	cap-sdio-irq;
> +	vmmc-supply = <&sdio_fixed_3v3>;
> +	vqmmc-supply = <&mt6397_vgp3_reg>;
> +	non-removable;
> +};
> +
>  &pio {
>  	disp_pwm0_pins: disp_pwm0_pins {
>  		pins1 {
> @@ -197,6 +224,36 @@
>  		};
>  	};
>  
> +	mmc3_pins_default: mmc3default {

Please keep nodes in &pio sorted, move this one after mmc1_pins_uhs.

> +		pins_dat {
> +			pinmux = <MT8173_PIN_22_MSDC3_DAT0__FUNC_MSDC3_DAT0>,
> +				 <MT8173_PIN_23_MSDC3_DAT1__FUNC_MSDC3_DAT1>,
> +				 <MT8173_PIN_24_MSDC3_DAT2__FUNC_MSDC3_DAT2>,
> +				 <MT8173_PIN_25_MSDC3_DAT3__FUNC_MSDC3_DAT3>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_cmd {
> +			pinmux = <MT8173_PIN_27_MSDC3_CMD__FUNC_MSDC3_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_clk {
> +			pinmux = <MT8173_PIN_26_MSDC3_CLK__FUNC_MSDC3_CLK>;
> +			bias-pull-down;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +		};
> +
> +		pins_pdn {
> +			pinmux = <MT8173_PIN_85_AUD_DAT_MOSI__FUNC_GPIO85>;
> +			output-low;
> +		};

This one is used in regulator, not really an mmc pin.
Also, you don't need to add node for gpio usage, request_gpio will set
mode for you.
So please remove pins_pdn node.


> +	};
> +
>  	mmc0_pins_uhs: mmc0 {
>  		pins_cmd_dat {
>  			pinmux = <MT8173_PIN_57_MSDC0_DAT0__FUNC_MSDC0_DAT0>,
> @@ -243,6 +300,31 @@
>  			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
>  		};
>  	};
> +
> +	mmc3_pins_uhs: mmc3 {


Please keep nodes in &pio sorted, move this one after mmc1_pins_uhs.


Joe.C

> +		pins_dat {
> +			pinmux = <MT8173_PIN_22_MSDC3_DAT0__FUNC_MSDC3_DAT0>,
> +				 <MT8173_PIN_23_MSDC3_DAT1__FUNC_MSDC3_DAT1>,
> +				 <MT8173_PIN_24_MSDC3_DAT2__FUNC_MSDC3_DAT2>,
> +				 <MT8173_PIN_25_MSDC3_DAT3__FUNC_MSDC3_DAT3>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_cmd {
> +			pinmux = <MT8173_PIN_27_MSDC3_CMD__FUNC_MSDC3_CMD>;
> +			input-enable;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-up = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +
> +		pins_clk {
> +			pinmux = <MT8173_PIN_26_MSDC3_CLK__FUNC_MSDC3_CLK>;
> +			drive-strength = <MTK_DRIVE_8mA>;
> +			bias-pull-down = <MTK_PUPD_SET_R1R0_10>;
> +		};
> +	};
>  };
>  
>  &pwm0 {
