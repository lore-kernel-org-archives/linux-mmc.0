From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 3/5] arm64: dts: Enable SDHCI for Nexus 5X (msm8992)
Date: Mon, 28 Nov 2016 15:53:01 -0600
Message-ID: <20161128215301.on7vuynyy6jez2l4@rob-hp-laptop>
References: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
 <1479863388-23678-4-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1479863388-23678-4-git-send-email-jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Nov 22, 2016 at 05:09:46PM -0800, Jeremy McNicoll wrote:
> Add Nexus 5X (msm8992) SDHCI support, including initial regulator
> entries to support enabling the main SDHCI/MMC.
> 
> The msm8994 RPM regulator talks over SMD to the APPS processor.
> 
> Signed-off-by: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
>  .../bindings/regulator/qcom,smd-rpm-regulator.txt  |  40 ++++
>  .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     | 262 +++++++++++++++++++++
>  arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  82 +++++++
>  arch/arm64/boot/dts/qcom/msm8992.dtsi              | 153 ++++++++++++
>  drivers/regulator/qcom_smd-regulator.c             |  49 ++++
>  5 files changed, 586 insertions(+)

A few nits, otherwise,

Acked-by: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>

> 
> diff --git a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
> index 1f8d6f8..126989b 100644
> --- a/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
> +++ b/Documentation/devicetree/bindings/regulator/qcom,smd-rpm-regulator.txt
> @@ -23,6 +23,7 @@ Regulator nodes are identified by their compatible:
>  		    "qcom,rpm-pm8916-regulators"
>  		    "qcom,rpm-pm8941-regulators"
>  		    "qcom,rpm-pma8084-regulators"
> +		    "qcom,rpm-pm8994-regulators"
>  
>  - vdd_s1-supply:
>  - vdd_s2-supply:
> @@ -97,6 +98,40 @@ Regulator nodes are identified by their compatible:
>  	Definition: reference to regulator supplying the input pin, as
>  		    described in the data sheet
>  
> +- vdd_s1-supply:
> +- vdd_s2-supply:
> +- vdd_s3-supply:
> +- vdd_s4-supply:
> +- vdd_s5-supply:
> +- vdd_s6-supply:
> +- vdd_s7-supply:
> +- vdd_l1_l11-supply:
> +- vdd_l2_l3_l4_l27-supply:
> +- vdd_l5_l7-supply:
> +- vdd_l6_l12_l14_l15_l26-supply:
> +- vdd_l8-supply:
> +- vdd_l9_l10_l13_l20_l23_l24-supply:
> +- vdd_l1_l11-supply:
> +- vdd_l6_l12_l14_l15_l26-supply:
> +- vdd_l16_l25-supply:
> +- vdd_l17-supply:
> +- vdd_l18-supply:
> +- vdd_l19-supply:
> +- vdd_l21-supply:
> +- vdd_l22-supply:
> +- vdd_l16_l25-supply:
> +- vdd_l27-supply:
> +- vdd_l28-supply:
> +- vdd_l29-supply:
> +- vdd_l30-supply:
> +- vdd_l31-supply:
> +- vdd_l32-supply:
> +	Usage: optional (pm8994 only)
> +	Value type: <phandle>
> +	Definition: reference to regulator supplying the input pin, as
> +		    described in the data sheet.
> +
> +
>  The regulator node houses sub-nodes for each regulator within the device. Each
>  sub-node is identified using the node's name, with valid values listed for each
>  of the pmics below.
> @@ -118,6 +153,11 @@ pma8084:
>  	l6, l7, l8, l9, l10, l11, l12, l13, l14, l15, l16, l17, l18, l19, l20,
>  	l21, l22, l23, l24, l25, l26, l27, lvs1, lvs2, lvs3, lvs4, 5vs1
>  
> +pm8994:
> +	s1, s2, s3, s4, s5, s6, s7, l1, l2, l3, l4, l5, l6, l7, l8, l9, l10, l11,
> +	l12, l13, l14, l15, l16, l17, l18, l19, l20, l21, l22, l23, l24, l25, l26,
> +	l27, l28, l29, l30, l31, l32, lvs1, lvs2
> +
>  The content of each sub-node is defined by the standard binding for regulators -
>  see regulator.txt.
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
> index 4542133..2ce8798 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
> @@ -39,3 +39,265 @@
>  		};
>  	};
>  };
> +
> +&smd_rpm {
> +	rpm {
> +		rpm_requests {
> +			pm8994-regulators {
> +
> +				vdd_l1-supply = <&pm8994_s1>;
> +				vdd_l2_26_28-supply = <&pm8994_s3>;
> +				vdd_l3_11-supply = <&pm8994_s3>;
> +				vdd_l4_27_31-supply = <&pm8994_s3>;
> +				vdd_l5_7-supply = <&pm8994_s3>;
> +				vdd_l6_12_32-supply = <&pm8994_s5>;
> +				vdd_l8_16_30-supply = <&vreg_vph_pwr>;
> +				vdd_l9_10_18_22-supply = <&vreg_vph_pwr>;
> +				vdd_l13_19_23_24-supply = <&vreg_vph_pwr>;
> +				vdd_l14_15-supply = <&pm8994_s5>;
> +				vdd_l17_29-supply = <&vreg_vph_pwr>;
> +				vdd_l20_21-supply = <&vreg_vph_pwr>;
> +				vdd_l25-supply = <&pm8994_s5>;
> +				/*vin_lvs1_2 = <&pm8994_s4>; */
> +
> +				s1 {
> +					regulator-min-microvolt = <800000>;
> +					regulator-max-microvolt = <800000>;
> +				};
> +
> +				s2 {
> +				};
> +
> +				s3 {
> +					regulator-min-microvolt = <1300000>;
> +					regulator-max-microvolt = <1300000>;
> +				};
> +
> +				s4 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-allow-set-load;
> +					regulator-system-load = <325000>;
> +				};
> +
> +				s5 {
> +					regulator-min-microvolt = <2150000>;
> +					regulator-max-microvolt = <2150000>;
> +				};
> +
> +				s7 {
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +				};
> +
> +				l1 {
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +				};
> +
> +				l2 {
> +					regulator-min-microvolt = <1250000>;
> +					regulator-max-microvolt = <1250000>;
> +				};
> +
> +				l3 {
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +				};
> +
> +				l4 {
> +					regulator-min-microvolt = <1225000>;
> +					regulator-max-microvolt = <1225000>;
> +				};
> +
> +				l5 {
> +				};
> +
> +				l6 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +				};
> +
> +				l7 {
> +				};
> +
> +				l8 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +				};
> +
> +				l9 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +				};
> +
> +				l10 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,init-voltage = <1800000>;
> +				};
> +
> +				l11 {
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					qcom,init-voltage = <1200000>;
> +				};
> +
> +				l12 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,init-voltage = <1800000>;
> +					proxy-supply = <&pm8994_l12>;
> +					qcom,proxy-consumer-enable;
> +					qcom,proxy-consumer-current = <10000>;
> +					status = "okay";
> +				};
> +
> +				l13 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <2950000>;
> +					qcom,init-voltage = <2950000>;
> +					status = "okay";
> +				};
> +
> +				l14 {
> +					regulator-min-microvolt = <1200000>;
> +					regulator-max-microvolt = <1200000>;
> +					qcom,init-voltage = <1200000>;
> +					proxy-supply = <&pm8994_l14>;
> +					qcom,proxy-consumer-enable;
> +					qcom,proxy-consumer-current = <10000>;
> +					status = "okay";
> +				};
> +
> +				l15 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,init-voltage = <1800000>;
> +					status = "okay";
> +				};
> +
> +				l16 {
> +					regulator-min-microvolt = <2700000>;
> +					regulator-max-microvolt = <2700000>;
> +					qcom,init-voltage = <2700000>;
> +					status = "okay";
> +				};
> +
> +				l17 {
> +					regulator-min-microvolt = <2700000>;
> +					regulator-max-microvolt = <2700000>;
> +					qcom,init-voltage = <2700000>;
> +					status = "okay";
> +				};
> +
> +				l18 {
> +					regulator-min-microvolt = <3000000>;
> +					regulator-max-microvolt = <3000000>;
> +					regulator-always-on;
> +					qcom,init-voltage = <3000000>;
> +					qcom,init-ldo-mode = <1>;
> +				};
> +
> +				l19 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,init-voltage = <1800000>;
> +					status = "okay";
> +				};
> +
> +				l20 {
> +					regulator-min-microvolt = <2950000>;
> +					regulator-max-microvolt = <2950000>;
> +					regulator-always-on;
> +					regulator-boot-on;
> +					regulator-allow-set-load;
> +					regulator-system-load = <570000>;
> +				};
> +
> +				l21 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					regulator-always-on;
> +					qcom,init-voltage = <1800000>;
> +				};
> +
> +				l22 {
> +					regulator-min-microvolt = <3100000>;
> +					regulator-max-microvolt = <3100000>;
> +					qcom,init-voltage = <3100000>;
> +				};
> +
> +				l23 {
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +					qcom,init-voltage = <2800000>;
> +				};
> +
> +				l24 {
> +					regulator-min-microvolt = <3075000>;
> +					regulator-max-microvolt = <3150000>;
> +					qcom,init-voltage = <3075000>;
> +				};
> +
> +				l25 {
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,init-voltage = <1800000>;
> +				};
> +
> +				l26 {
> +					/* TODO: value from downstream
> +					regulator-min-microvolt = <987500>;
> +					fails to apply */
> +				};
> +
> +				l27 {
> +					regulator-min-microvolt = <1050000>;
> +					regulator-max-microvolt = <1050000>;
> +					qcom,init-voltage = <1050000>;
> +				};
> +
> +				l28 {
> +					regulator-min-microvolt = <1000000>;
> +					regulator-max-microvolt = <1000000>;
> +					qcom,init-voltage = <1000000>;
> +					proxy-supply = <&pm8994_l28>;
> +					qcom,proxy-consumer-enable;
> +					qcom,proxy-consumer-current = <10000>;
> +				};
> +
> +				l29 {
> +					/* TODO: Unsupported voltage range.. 
> +					regulator-min-microvolt = <2800000>;
> +					regulator-max-microvolt = <2800000>;
> +					qcom,init-voltage = <2800000>;
> +					*/
> +				};
> +
> +				l30 {
> +					/* TODO: get this verified
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,init-voltage = <1800000>;
> +					*/
> +				};
> +
> +				l31 {
> +					regulator-min-microvolt = <1262500>;
> +					regulator-max-microvolt = <1262500>;
> +					qcom,init-voltage = <1262500>;
> +				};
> +
> +				l32 {
> +					/* TODO: get this verified
> +					regulator-min-microvolt = <1800000>;
> +					regulator-max-microvolt = <1800000>;
> +					qcom,init-voltage = <1800000>;
> +					*/
> +				};
> +
> +			};
> +		};
> +	};
> +};
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
> index d2a26f0..15202c8 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
> @@ -35,4 +35,86 @@
>  			bias-pull-down;
>  		};
>  	};
> +
> +	/* 0-3 for sdc1 4-6 for sdc2 */
> +	/* Order of pins */
> +	/* SDC1: CLK -> 0, CMD -> 1, DATA -> 2, RCLK -> 3 */
> +	/* SDC2: CLK -> 4, CMD -> 5, DATA -> 6 */
> +	pmx_sdc1_clk {
> +		sdc1_clk_on: clk_on {

Use '-' rather than '_' for node names. (Labels don't matter)

> +			pinmux {
> +				pins = "sdc1_clk";
> +			};
> +			pinconf {
> +				pins = "sdc1_clk";
> +				bias-disable = <0>; /* No pull */
> +				drive-strength = <16>; /* 16mA */
> +			};
> +		};
> +		sdc1_clk_off: clk_off {
> +			pinmux {
> +				pins = "sdc1_clk";
> +			};
> +			pinconf {
> +				pins = "sdc1_clk";
> +				bias-disable = <0>; /* No pull */
> +				drive-strength = <2>; /* 2mA */
> +			};
> +		};
> +	};
> +
> +	pmx_sdc1_cmd {
> +		sdc1_cmd_on: cmd_on {
> +			pinmux {
> +				pins = "sdc1_cmd";
> +			};
> +			pinconf {
> +				pins = "sdc1_cmd";
> +				bias-pull-up;
> +				drive-strength = <8>;
> +			};
> +		};
> +		sdc1_cmd_off: cmd_off {
> +			pinmux {
> +				pins = "sdc1_cmd";
> +			};
> +			pinconf {
> +				pins = "sdc1_cmd";
> +				bias-pull-up = <0x3>; /* same as 3.10 ?? */
> +				drive-strength = <2>; /* 2mA */
> +			};
> +		};
> +	};
> +
> +	pmx_sdc1_data {
> +		sdc1_data_on: data_on {
> +			pinmux {
> +				pins = "sdc1_data";
> +			};
> +			pinconf {
> +				pins = "sdc1_data";
> +				bias-pull-up;
> +				drive-strength = <8>; /* 8mA */
> +			};
> +		};
> +		sdc1_data_off: data_off {
> +			pinmux {
> +				pins = "sdc1_data";
> +			};
> +			pinconf {
> +				pins = "sdc1_data";
> +				bias-pull-up;
> +				drive-strength = <2>;
> +			};
> +		};
> +	};
> +
> +	pmx_sdc1_rclk {
> +		sdc1_rclk_on: rclk_on {
> +			bias-pull-down; /* pull down */
> +		};
> +		sdc1_rclk_off: rclk_off {
> +			bias-pull-down; /* pull down */
> +		};
> +	};
>  };
> diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> index 44b2d37..d104770 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> @@ -82,6 +82,12 @@
>  				<0xf9002000 0x1000>;
>  		};
>  
> +		apcs: syscon@0xf900d000 {

Drop the '0x'.

> +			compatible = "syscon";
> +			reg = <0xf900d000 0x2000>;
> +		};
> +
> +
>  		timer@f9020000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -172,12 +178,159 @@
>  			#power-domain-cells = <1>;
>  			reg = <0xfc400000 0x2000>;
>  		};
> +
> +		sdhci1: qcom,sdhci@f9824900 {

mmc@...

> +			compatible = "qcom,sdhci-msm-v4";
> +			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
> +			reg-names = "hc_mem", "core_mem";
> +
> +			interrupts = <GIC_SPI 123 IRQ_TYPE_NONE>,
> +					<GIC_SPI 138 IRQ_TYPE_NONE>;
> +			interrupt-names = "hc_irq", "pwr_irq";
> +
> +			clocks = <&clock_gcc GCC_SDCC1_APPS_CLK>,
> +				<&clock_gcc GCC_SDCC1_AHB_CLK>;
> +			clock-names = "core", "iface";
> +
> +			pinctrl-names = "default", "sleep";
> +			pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on
> +					&sdc1_rclk_on>;
> +			pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off
> +					&sdc1_rclk_off>;
> +
> +			vdd-supply = <&pm8994_l20>;
> +			qcom,vdd-voltage-level = <2950000 2950000>;
> +			qcom,vdd-current-level = <200 570000>;
> +
> +			vdd-io-supply = <&pm8994_s4>;
> +			qcom,vdd-io-voltage-level = <1800000 1800000>;
> +			qcom,vdd-io-current-level = <200 325000>;
> +
> +			regulator-always-on;
> +			bus-width = <8>;
> +			mmc-hs400-1_8v;
> +			status = "okay";
> +		};
> +
> +		vreg_vph_pwr: vreg-vph-pwr {
> +			compatible = "regulator-fixed";
> +			status = "okay";
> +			regulator-name = "vph-pwr";
> +
> +			regulator-min-microvolt = <3600000>;
> +			regulator-max-microvolt = <3600000>;
> +
> +			regulator-always-on;
> +		};
> +
> +		rpm_msg_ram: memory@fc428000 {
> +			compatible = "qcom,rpm-msg-ram";
> +			reg = <0xfc428000 0x4000>;
> +		};
> +
> +		sfpb_mutex_regs: syscon@fd484000 {
> +			#address-cells = <1>;
> +			#size-cells = <1>;
> +			compatible = "syscon";
> +			reg = <0xfd484000 0x400>;
> +		};
> +
> +		sfpb_mutex: hwmutex {
> +			compatible = "qcom,sfpb-mutex";
> +			syscon = <&sfpb_mutex_regs 0x0 0x100>;
> +			#hwlock-cells = <1>;
> +		};
> +
> +		smem {
> +			compatible = "qcom,smem";
> +			memory-region = <&smem_region>;
> +			qcom,rpm-msg-ram = <&rpm_msg_ram>;
> +			hwlocks = <&sfpb_mutex 3>;
> +		};
>  	};
>  
>  	memory {
>  		device_type = "memory";
>  		reg = <0 0 0 0>; // bootloader will update
>  	};
> +
> +	reserved-memory {
> +		#address-cells = <2>;
> +		#size-cells = <2>;
> +		ranges;
> +
> +		smem_region: smem@6a00000 {
> +			reg = <0x0 0x6a00000 0x0 0x200000>;
> +			no-map;
> +		};
> +	};
> +
> +	smd_rpm: smd {
> +		compatible = "qcom,smd";
> +
> +		rpm {
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,ipc = <&apcs 8 0>;
> +			qcom,smd-edge = <15>;
> +			qcom,local-pid = <0>;
> +			qcom,remote-pid = <6>;
> +
> +			rpm_requests {
> +				compatible = "qcom,rpm-msm8994";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				rpmcc: qcom,rpmcc {
> +					/* TODO: update when rpmcc-msm8994 support added */
> +					compatible = "qcom,rpmcc-msm8916",
> +							"qcom,rpmcc";
> +					#clock-cells = <1>;
> +				};
> +
> +				smd_rpm_regulators: pm8994-regulators {
> +					compatible = "qcom,rpm-pm8994-regulators";
> +
> +					pm8994_s1: s1 {};
> +					pm8994_s2: s2 {};
> +					pm8994_s3: s3 {};
> +					pm8994_s4: s4 {};
> +					pm8994_s5: s5 {};
> +					pm8994_s6: s6 {};
> +					pm8994_s7: s7 {};
> +
> +					pm8994_l1: l1 {};
> +					pm8994_l2: l2 {};
> +					pm8994_l3: l3 {};
> +					pm8994_l4: l4 {};
> +					pm8994_l6: l6 {};
> +					pm8994_l8: l8 {};
> +					pm8994_l9: l9 {};
> +					pm8994_l10: l10 {};
> +					pm8994_l11: l11 {};
> +					pm8994_l12: l12 {};
> +					pm8994_l13: l13 {};
> +					pm8994_l14: l14 {};
> +					pm8994_l15: l15 {};
> +					pm8994_l16: l16 {};
> +					pm8994_l17: l17 {};
> +					pm8994_l18: l18 {};
> +					pm8994_l19: l19 {};
> +					pm8994_l20: l20 {};
> +					pm8994_l21: l21 {};
> +					pm8994_l22: l22 {};
> +					pm8994_l23: l23 {};
> +					pm8994_l24: l24 {};
> +					pm8994_l25: l25 {};
> +					pm8994_l26: l26 {};
> +					pm8994_l27: l27 {};
> +					pm8994_l28: l28 {};
> +					pm8994_l29: l29 {};
> +					pm8994_l30: l30 {};
> +					pm8994_l31: l31 {};
> +					pm8994_l32: l32 {};
> +				};
> +			};
> +		};
> +	};
>  };
>  
>  
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
> index 8ed46a9..a7e8ce7 100644
> --- a/drivers/regulator/qcom_smd-regulator.c
> +++ b/drivers/regulator/qcom_smd-regulator.c
> @@ -443,11 +443,60 @@ static const struct rpm_regulator_data rpm_pma8084_regulators[] = {
>  	{}
>  };
>  
> +static const struct rpm_regulator_data rpm_pm8994_regulators[] = {
> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pma8084_ftsmps, "vdd_s1" },
> +	{ "s2", QCOM_SMD_RPM_SMPA, 2, &pma8084_ftsmps, "vdd_s2" },
> +	{ "s3", QCOM_SMD_RPM_SMPA, 3, &pma8084_hfsmps, "vdd_s3" },
> +	{ "s4", QCOM_SMD_RPM_SMPA, 4, &pma8084_hfsmps, "vdd_s4" },
> +	{ "s5", QCOM_SMD_RPM_SMPA, 5, &pma8084_hfsmps, "vdd_s5" },
> +	{ "s6", QCOM_SMD_RPM_SMPA, 6, &pma8084_ftsmps, "vdd_s6" },
> +	{ "s7", QCOM_SMD_RPM_SMPA, 7, &pma8084_ftsmps, "vdd_s7" },
> +
> +	{ "l1", QCOM_SMD_RPM_LDOA, 1, &pma8084_nldo, "vdd_l1_l11" },
> +	{ "l2", QCOM_SMD_RPM_LDOA, 2, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
> +	{ "l3", QCOM_SMD_RPM_LDOA, 3, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
> +	{ "l4", QCOM_SMD_RPM_LDOA, 4, &pma8084_nldo, "vdd_l2_l3_l4_l27" },
> +	{ "l5", QCOM_SMD_RPM_LDOA, 5, &pma8084_pldo, "vdd_l5_l7" },
> +	{ "l6", QCOM_SMD_RPM_LDOA, 6, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
> +	{ "l7", QCOM_SMD_RPM_LDOA, 7, &pma8084_pldo, "vdd_l5_l7" },
> +	{ "l8", QCOM_SMD_RPM_LDOA, 8, &pma8084_pldo, "vdd_l8" },
> +	{ "l9", QCOM_SMD_RPM_LDOA, 9, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
> +	{ "l10", QCOM_SMD_RPM_LDOA, 10, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
> +	{ "l11", QCOM_SMD_RPM_LDOA, 11, &pma8084_nldo, "vdd_l1_l11" },
> +	{ "l12", QCOM_SMD_RPM_LDOA, 12, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
> +	{ "l13", QCOM_SMD_RPM_LDOA, 13, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
> +	{ "l14", QCOM_SMD_RPM_LDOA, 14, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
> +	{ "l15", QCOM_SMD_RPM_LDOA, 15, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
> +	{ "l16", QCOM_SMD_RPM_LDOA, 16, &pma8084_pldo, "vdd_l16_l25" },
> +	{ "l17", QCOM_SMD_RPM_LDOA, 17, &pma8084_pldo, "vdd_l17" },
> +	{ "l18", QCOM_SMD_RPM_LDOA, 18, &pma8084_pldo, "vdd_l18" },
> +	{ "l19", QCOM_SMD_RPM_LDOA, 19, &pma8084_pldo, "vdd_l19" },
> +	{ "l20", QCOM_SMD_RPM_LDOA, 20, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
> +	{ "l21", QCOM_SMD_RPM_LDOA, 21, &pma8084_pldo, "vdd_l21" },
> +	{ "l22", QCOM_SMD_RPM_LDOA, 22, &pma8084_pldo, "vdd_l22" },
> +	{ "l23", QCOM_SMD_RPM_LDOA, 23, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
> +	{ "l24", QCOM_SMD_RPM_LDOA, 24, &pma8084_pldo, "vdd_l9_l10_l13_l20_l23_l24" },
> +	{ "l25", QCOM_SMD_RPM_LDOA, 25, &pma8084_pldo, "vdd_l16_l25" },
> +	{ "l26", QCOM_SMD_RPM_LDOA, 26, &pma8084_pldo, "vdd_l6_l12_l14_l15_l26" },
> +	{ "l27", QCOM_SMD_RPM_LDOA, 27, &pma8084_nldo, "vdd_l27" },
> +	{ "l28", QCOM_SMD_RPM_LDOA, 28, &pma8084_nldo, "vdd_l28" },
> +	{ "l29", QCOM_SMD_RPM_LDOA, 29, &pma8084_nldo, "vdd_l29" },
> +	{ "l30", QCOM_SMD_RPM_LDOA, 30, &pma8084_nldo, "vdd_l30" },
> +	{ "l31", QCOM_SMD_RPM_LDOA, 31, &pma8084_nldo, "vdd_l31" },
> +	{ "l32", QCOM_SMD_RPM_LDOA, 32, &pma8084_nldo, "vdd_l32" },
> +
> +	{ "lvs1", QCOM_SMD_RPM_VSA, 1, &pma8084_switch },
> +	{ "lvs2", QCOM_SMD_RPM_VSA, 2, &pma8084_switch },
> +
> +	{}
> +};
> +
>  static const struct of_device_id rpm_of_match[] = {
>  	{ .compatible = "qcom,rpm-pm8841-regulators", .data = &rpm_pm8841_regulators },
>  	{ .compatible = "qcom,rpm-pm8916-regulators", .data = &rpm_pm8916_regulators },
>  	{ .compatible = "qcom,rpm-pm8941-regulators", .data = &rpm_pm8941_regulators },
>  	{ .compatible = "qcom,rpm-pma8084-regulators", .data = &rpm_pma8084_regulators },
> +	{ .compatible = "qcom,rpm-pm8994-regulators", .data = &rpm_pm8994_regulators },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, rpm_of_match);
> -- 
> 2.6.1
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
