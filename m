From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/2] ARM64: dts: meson-gxbb: add MMC support
Date: Fri, 23 Sep 2016 08:45:00 -0500
Message-ID: <20160923134500.GA27686@rob-hp-laptop>
References: <20160914004314.682-1-khilman@baylibre.com>
 <20160914004314.682-3-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36856 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965693AbcIWNpC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 23 Sep 2016 09:45:02 -0400
Content-Disposition: inline
In-Reply-To: <20160914004314.682-3-khilman@baylibre.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Victor Wan <victor.wan@amlogic.com>, Jerry Cao <jerry.cao@amlogic.com>, Xing Wu <xing.xu@amlogic.com>, yonghui.yu@amlogic.com

On Tue, Sep 13, 2016 at 05:43:14PM -0700, Kevin Hilman wrote:
> Add binding and basic support for the SD/eMMC controller on Amlogic
> S905/GXBB devices.
> 
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
>  .../devicetree/bindings/mmc/amlogic,meson-gxbb.txt | 29 ++++++++
>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 87 ++++++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi   | 78 +++++++++++++++++++
>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi        | 37 ++++++++-
>  4 files changed, 230 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt

Some nits below, otherwise:

Acked-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt b/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
> new file mode 100644
> index 000000000000..39cbe528b7de
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-gxbb.txt
> @@ -0,0 +1,29 @@
> +Amlogic SD / eMMC controller for S905/GXBB family SoCs
> +
> +The MMC 5.1 compliant host controller on Amlogic provides the
> +interface for SD, eMMC and SDIO devices.
> +
> +This file documents the properties in addition to those available in
> +the MMC core bindings, documented by mmc.txt.
> +
> +Required properties:
> +- compatible : contains "amlogic,meson-gxbb-mmc"
> +- clocks     : A list of phandle + clock-specifier pairs for the clocks listed in clock-names.
> +- clock-names: Should contain the following:
> +	"core" - Main peripheral bus clock
> +	"clkin0" - Parent clock of internal mux
> +	"clkin1" - Other parent clock of internal mux
> +  The driver has an interal mux clock which switches between clkin0 and clkin1 depending on the
> +  clock rate requested by the MMC core.
> +
> +Example:
> +
> +	sd_emmc_a: mmc@70000 {
> +        	compatible = "amlogic,meson-gxbb-mmc";
> +		reg = <0x0 0x70000 0x0 0x2000>;
> +                interrupts = < GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
> +		clocks = <&clkc CLKID_SD_EMMC_A>, <&xtal>, <&clkc CLKID_FCLK_DIV2>;
> +		clock-names = "core", "clkin0", "clkin1";
> +		pinctrl-0 = <&emmc_pins>;
> +	};
> +
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> index 90a84c514d3d..2a9303e7fab8 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
> @@ -73,6 +73,56 @@
>  			default-state = "off";
>  		};
>  	};
> +
> +	tflash_vdd: regulator-tflash_vdd {

Use '-' not '_' in node names.

> +		/*
> +		 * signal name from schematics: TFLASH_VDD_EN
> +		 */
> +		compatible = "regulator-fixed";
> +
> +		regulator-name = "TFLASH_VDD";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpio = <&gpio_ao GPIOAO_12 GPIO_ACTIVE_HIGH>;
> +		enable-active-high;
> +	};
> +
> +	tf_io: gpio-regulator-tf_io {

ditto

> +		compatible = "regulator-gpio";
> +
> +		regulator-name = "TF_IO";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		/*
> +		 * signal name from schematics: TF_3V3N_1V8_EN
> +		 */
> +		gpios = <&gpio_ao GPIOAO_3 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <0>;
> +
> +		states = <3300000 0
> +			  1800000 1>;
> +	};
> +
> +	vcc1v8: regulator-vcc1v8 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC1V8";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	vcc3v3: regulator-vcc3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  &uart_AO {
> @@ -87,3 +137,40 @@
>  	pinctrl-names = "default";
>  };
>  
> +/* SD */
> +&sd_emmc_b {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-names = "default";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <100000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +
> +	vmmc-supply = <&tflash_vdd>;
> +	vqmmc-supply = <&tf_io>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status = "okay";
> +	pinctrl-0 = <&emmc_pins>;
> +	pinctrl-names = "default";
> +
> +	bus-width = <8>;
> +	cap-sd-highspeed;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	disable-wp;
> +	cap-mmc-highspeed;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	vmmc-supply = <&vcc3v3>;
> +	vqmmc-supply = <&vcc1v8>;
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> index f4f30f674b4c..77c4d5eb48a2 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p20x.dtsi
> @@ -57,6 +57,47 @@
>  		device_type = "memory";
>  		reg = <0x0 0x0 0x0 0x40000000>;
>  	};
> +
> +	vddio_card: gpio-regulator {
> +		compatible = "regulator-gpio";
> +
> +		regulator-name = "VDDIO_CARD";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <3300000>;
> +
> +		gpios = <&gpio_ao GPIOAO_5 GPIO_ACTIVE_HIGH>;
> +		gpios-states = <1>;
> +
> +		/* Based on P200 schematics, signal CARD_1.8V/3.3V_CTR */
> +		states = <1800000 0
> +			  3300000 1>;
> +	};
> +
> +	vddio_boot: regulator-vddio_boot {

ditto

> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDIO_BOOT";
> +		regulator-min-microvolt = <1800000>;
> +		regulator-max-microvolt = <1800000>;
> +	};
> +
> +	vddao_3v3: regulator-vddao_3v3 {

ditto

> +		compatible = "regulator-fixed";
> +		regulator-name = "VDDAO_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	vcc_3v3: regulator-vcc_3v3 {

ditto

> +		compatible = "regulator-fixed";
> +		regulator-name = "VCC_3V3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +	};
> +
> +	emmc_pwrseq: emmc-pwrseq {
> +		compatible = "mmc-pwrseq-emmc";
> +		reset-gpios = <&gpio BOOT_9 GPIO_ACTIVE_LOW>;
> +	};
>  };
>  
>  /* This UART is brought out to the DB9 connector */
> @@ -72,3 +113,40 @@
>  	pinctrl-names = "default";
>  };
>  
> +/* SD card */
> +&sd_emmc_b {
> +	status = "okay";
> +	pinctrl-0 = <&sdcard_pins>;
> +	pinctrl-names = "default";
> +
> +	bus-width = <4>;
> +	cap-sd-highspeed;
> +	max-frequency = <100000000>;
> +	disable-wp;
> +
> +	cd-gpios = <&gpio CARD_6 GPIO_ACTIVE_HIGH>;
> +	cd-inverted;
> +
> +	vmmc-supply = <&vddao_3v3>;
> +	vqmmc-supply = <&vddio_card>;
> +};
> +
> +/* eMMC */
> +&sd_emmc_c {
> +	status = "okay";
> +	pinctrl-0 = <&emmc_pins>;
> +	pinctrl-names = "default";
> +
> +	bus-width = <8>;
> +	cap-sd-highspeed;
> +	cap-mmc-highspeed;
> +	max-frequency = <200000000>;
> +	non-removable;
> +	disable-wp;
> +	mmc-ddr-1_8v;
> +	mmc-hs200-1_8v;
> +
> +	mmc-pwrseq = <&emmc_pwrseq>;
> +	vmmc-supply = <&vcc_3v3>;
> +	vqmmc-supply = <&vddio_boot>;
> +};
> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> index e502c24b0ac7..3723007146ac 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi
> @@ -45,6 +45,7 @@
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/gpio/meson-gxbb-gpio.h>
>  #include <dt-bindings/reset/amlogic,meson-gxbb-reset.h>
> +#include <dt-bindings/clock/gxbb-clkc.h>
>  
>  / {
>  	compatible = "amlogic,meson-gxbb";
> @@ -246,7 +247,8 @@
>  					mux {
>  						groups = "emmc_nand_d07",
>  						       "emmc_cmd",
> -						       "emmc_clk";
> +						       "emmc_clk",
> +						       "emmc_ds";
>  						function = "emmc";
>  					};
>  				};
> @@ -329,6 +331,39 @@
>  			#address-cells = <2>;
>  			#size-cells = <2>;
>  			ranges = <0x0 0x0 0x0 0xd0000000 0x0 0x200000>;
> +
> +			sd_emmc_a: mmc@70000 {
> +				compatible = "amlogic,meson-gxbb-mmc";
> +				reg = <0x0 0x70000 0x0 0x2000>;
> +				interrupts = <GIC_SPI 216 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc CLKID_SD_EMMC_A>,
> +					 <&xtal>,
> +					 <&clkc CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				status = "disabled";
> +			};
> +
> +			sd_emmc_b: mmc@72000 {
> +				compatible = "amlogic,meson-gxbb-mmc";
> +				reg = <0x0 0x72000 0x0 0x2000>;
> +				interrupts = <GIC_SPI 217 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc CLKID_SD_EMMC_B>,
> +					 <&xtal>,
> +					 <&clkc CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				status = "disabled";
> +			};
> +
> +			sd_emmc_c: mmc@74000 {
> +				compatible = "amlogic,meson-gxbb-mmc";
> +				reg = <0x0 0x74000 0x0 0x2000>;
> +				interrupts = <GIC_SPI 218 IRQ_TYPE_EDGE_RISING>;
> +				clocks = <&clkc CLKID_SD_EMMC_C>,
> +					 <&xtal>,
> +					 <&clkc CLKID_FCLK_DIV2>;
> +				clock-names = "core", "clkin0", "clkin1";
> +				status = "disabled";
> +			};
>  		};
>  
>  		ethmac: ethernet@c9410000 {
> -- 
> 2.9.3
> 
