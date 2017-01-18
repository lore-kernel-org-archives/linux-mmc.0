From: Bjorn Andersson <bjorn.andersson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V2 3/4] arm64: dts: Enable SDHCI for Nexus 5X (msm8992)
Date: Wed, 18 Jan 2017 11:02:57 -0800
Message-ID: <20170118190257.GQ10531@minitux>
References: <1484614729-26751-1-git-send-email-jeremymc@redhat.com>
 <1484614729-26751-4-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1484614729-26751-4-git-send-email-jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, git-LJ92rlH3Dns@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, jszhang-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Mon 16 Jan 16:58 PST 2017, Jeremy McNicoll wrote:

> Add Nexus 5X (msm8992) SDHCI support, including initial regulator
> entries to support enabling the main SDHCI/MMC.
> 
> The RPM is common between 8992 & 8994 simply reflect reality with
> a shared DT entry.
> 
> The msm8994 RPM regulator talks over SMD to the APPS processor.
> 
> Signed-off-by: Jeremy McNicoll <jeremymc-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
> ---
> 
> Dropped RobH's ACK explicitly after addressing all feedback.
> The reason is that msm8994-smd-rpm.dtsi was created to allow
> for sharing between 8992 & 8994 as the RPM is common between
> the two. 
> 
>  .../bindings/regulator/qcom,smd-rpm-regulator.txt  |  40 +++
>  .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |   2 +
>  arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  82 ++++++
>  arch/arm64/boot/dts/qcom/msm8992.dtsi              | 153 ++++++++++++
>  arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi      | 276 +++++++++++++++++++++
>  drivers/regulator/qcom_smd-regulator.c             |  49 ++++
>  6 files changed, 602 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
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

This is not entirely correct and should be part of a "arm64: dts" patch.

It seems to be compatible with the pm8994 patch we've had sitting in the
Linaro tree for msm8996 for some time, so I did send this out; with you
Cc. Please give it a spin.

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
> index 4542133..3fc9a33 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
> +++ b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
> @@ -39,3 +39,5 @@
>  		};
>  	};
>  };
> +
> +#include "msm8994-smd-rpm.dtsi"
> diff --git a/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
> index d2a26f0..d3ae5ab 100644
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
> +	pmx-sdc1-clk {
> +		sdc1_clk_on: clk-on {
> +			pinmux {
> +				pins = "sdc1_clk";
> +			};

The name of these nodes are insignificant, so you don't have to have a
pinmux and a pinconf, you can describe all properties in one node. I
even think you can flatten this and drop the inner subnode.

> +			pinconf {
> +				pins = "sdc1_clk";
> +				bias-disable = <0>; /* No pull */
> +				drive-strength = <16>; /* 16mA */
> +			};
> +		};
[..]
> diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> index 44b2d37..77edffc 100644
> --- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
> +++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
> @@ -82,6 +82,12 @@
>  				<0xf9002000 0x1000>;
>  		};
>  
> +		apcs: syscon@f900d000 {
> +			compatible = "syscon";
> +			reg = <0xf900d000 0x2000>;
> +		};
> +
> +

Please send the SMEM/SMD-ification in a separate patch from the sdhci
addition.

>  		timer@f9020000 {
>  			#address-cells = <1>;
>  			#size-cells = <1>;
> @@ -172,12 +178,159 @@
>  			#power-domain-cells = <1>;
>  			reg = <0xfc400000 0x2000>;
>  		};
> +
> +		sdhci1: mmc@f9824900 {
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

These properties are not recognized upstream, please drop.

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

This doesn't have a "reg", so please move it outside "soc"

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

The smem enablement here looks reasonable, please split into a separate
patch.

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

You don't have to reference this by label, just saying "/smd" will work
just as well.

> +		compatible = "qcom,smd";
> +
> +		rpm {
> +			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
> +			qcom,ipc = <&apcs 8 0>;
> +			qcom,smd-edge = <15>;
> +			qcom,local-pid = <0>;
> +			qcom,remote-pid = <6>;
> +
> +			rpm-requests {
> +				compatible = "qcom,rpm-msm8994";
> +				qcom,smd-channels = "rpm_requests";
> +
> +				rpmcc: qcom,rpmcc {
> +					/* TODO: update when rpmcc-msm8994 support added */
> +					compatible = "qcom,rpmcc-msm8916",
> +							"qcom,rpmcc";
> +					#clock-cells = <1>;
> +				};

You're not compatible with qcom,rpmcc-msm8916, so don't fool the kernel
to think you are. Just drop this node until you have a rpmcc and need
it.

> +
> +				smd_rpm_regulators: pm8994-regulators {

This label is unused.

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

Add lvs1 & lvs2.

> +				};
> +			};
> +		};
> +	};
>  };
>  
>  
> diff --git a/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi b/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi

These rpm settings are not for msm8994, they are for your device. So
please drop this file and move below nodes into your device dts.

[..]
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

I added this to the pm8994 regulator patch I just sent out, called it
"vdd_lvs1_2".

> +
[..]
> diff --git a/drivers/regulator/qcom_smd-regulator.c b/drivers/regulator/qcom_smd-regulator.c
[..]
>  
> +static const struct rpm_regulator_data rpm_pm8994_regulators[] = {
> +	{ "s1", QCOM_SMD_RPM_SMPA, 1, &pma8084_ftsmps, "vdd_s1" },

As with the binding, this isn't entirely correct. Please see my
submitted patch.

Regards,
Bjorn
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
