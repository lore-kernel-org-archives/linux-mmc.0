From: =?UTF-8?q?Bastian=20K=C3=B6cher?= <git@kchr.de>
Subject: [PATCH] Add Nexus 6P(msm8994) SDHCI support
Date: Wed, 28 Dec 2016 17:21:34 +0100
Message-ID: <20161228162134.13687-1-git@kchr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.kompex-online.com ([46.38.242.72]:54579 "EHLO
        mail.kompex-online.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751807AbcL1QsC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 28 Dec 2016 11:48:02 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: jeremymc@redhat.com, robh+dt@kernel.org, andy.gross@linaro.org, david.brown@linaro.org, =?UTF-8?q?Bastian=20K=C3=B6cher?= <git@kchr.de>

Signed-off-by: Bastian Köcher <git@kchr.de>
---

Patch for enabling Nexus 6P(msm8994) SDHCI support.

The patch is based on the work of Jeremy McNicoll for 
the Nexus 5x:
https://www.spinics.net/lists/linux-arm-msm/msg24827.html

 .../arm64/boot/dts/qcom/msm8994-angler-rev-101.dts | 262 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/msm8994-pins.dtsi         |  82 +++++++
 arch/arm64/boot/dts/qcom/msm8994.dtsi              | 154 ++++++++++--
 3 files changed, 483 insertions(+), 15 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
index dfa08f513dc4..d0bf9072b614 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8994-angler-rev-101.dts
@@ -38,3 +38,265 @@
 		};
 	};
 };
+
+&smd_rpm {
+	rpm {
+		rpm_requests {
+			pm8994-regulators {
+
+				vdd_l1-supply = <&pm8994_s1>;
+				vdd_l2_26_28-supply = <&pm8994_s3>;
+				vdd_l3_11-supply = <&pm8994_s3>;
+				vdd_l4_27_31-supply = <&pm8994_s3>;
+				vdd_l5_7-supply = <&pm8994_s3>;
+				vdd_l6_12_32-supply = <&pm8994_s5>;
+				vdd_l8_16_30-supply = <&vreg_vph_pwr>;
+				vdd_l9_10_18_22-supply = <&vreg_vph_pwr>;
+				vdd_l13_19_23_24-supply = <&vreg_vph_pwr>;
+				vdd_l14_15-supply = <&pm8994_s5>;
+				vdd_l17_29-supply = <&vreg_vph_pwr>;
+				vdd_l20_21-supply = <&vreg_vph_pwr>;
+				vdd_l25-supply = <&pm8994_s5>;
+				/*vin_lvs1_2 = <&pm8994_s4>; */
+
+				s1 {
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <800000>;
+				};
+
+				s2 {
+				};
+
+				s3 {
+					regulator-min-microvolt = <1300000>;
+					regulator-max-microvolt = <1300000>;
+				};
+
+				s4 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-allow-set-load;
+					regulator-system-load = <325000>;
+				};
+
+				s5 {
+					regulator-min-microvolt = <2150000>;
+					regulator-max-microvolt = <2150000>;
+				};
+
+				s7 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+				};
+
+				l1 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+				};
+
+				l2 {
+					regulator-min-microvolt = <1250000>;
+					regulator-max-microvolt = <1250000>;
+				};
+
+				l3 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+				};
+
+				l4 {
+					regulator-min-microvolt = <1225000>;
+					regulator-max-microvolt = <1225000>;
+				};
+
+				l5 {
+				};
+
+				l6 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				l7 {
+				};
+
+				l8 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				l9 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				l10 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,init-voltage = <1800000>;
+				};
+
+				l11 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					qcom,init-voltage = <1200000>;
+				};
+
+				l12 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,init-voltage = <1800000>;
+					proxy-supply = <&pm8994_l12>;
+					qcom,proxy-consumer-enable;
+					qcom,proxy-consumer-current = <10000>;
+					status = "okay";
+				};
+
+				l13 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <2950000>;
+					qcom,init-voltage = <2950000>;
+					status = "okay";
+				};
+
+				l14 {
+					regulator-min-microvolt = <1200000>;
+					regulator-max-microvolt = <1200000>;
+					qcom,init-voltage = <1200000>;
+					proxy-supply = <&pm8994_l14>;
+					qcom,proxy-consumer-enable;
+					qcom,proxy-consumer-current = <10000>;
+					status = "okay";
+				};
+
+				l15 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,init-voltage = <1800000>;
+					status = "okay";
+				};
+
+				l16 {
+					regulator-min-microvolt = <2700000>;
+					regulator-max-microvolt = <2700000>;
+					qcom,init-voltage = <2700000>;
+					status = "okay";
+				};
+
+				l17 {
+					regulator-min-microvolt = <2700000>;
+					regulator-max-microvolt = <2700000>;
+					qcom,init-voltage = <2700000>;
+					status = "okay";
+				};
+
+				l18 {
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
+					regulator-always-on;
+					qcom,init-voltage = <3000000>;
+					qcom,init-ldo-mode = <1>;
+				};
+
+				l19 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,init-voltage = <1800000>;
+					status = "okay";
+				};
+
+				l20 {
+					regulator-min-microvolt = <2950000>;
+					regulator-max-microvolt = <2950000>;
+					regulator-always-on;
+					regulator-boot-on;
+					regulator-allow-set-load;
+					regulator-system-load = <570000>;
+				};
+
+				l21 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					regulator-always-on;
+					qcom,init-voltage = <1800000>;
+				};
+
+				l22 {
+					regulator-min-microvolt = <3100000>;
+					regulator-max-microvolt = <3100000>;
+					qcom,init-voltage = <3100000>;
+				};
+
+				l23 {
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					qcom,init-voltage = <2800000>;
+				};
+
+				l24 {
+					regulator-min-microvolt = <3075000>;
+					regulator-max-microvolt = <3150000>;
+					qcom,init-voltage = <3075000>;
+				};
+
+				l25 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,init-voltage = <1800000>;
+				};
+
+				l26 {
+					/* TODO: value from downstream
+					regulator-min-microvolt = <987500>;
+					fails to apply */
+				};
+
+				l27 {
+					regulator-min-microvolt = <1050000>;
+					regulator-max-microvolt = <1050000>;
+					qcom,init-voltage = <1050000>;
+				};
+
+				l28 {
+					regulator-min-microvolt = <1000000>;
+					regulator-max-microvolt = <1000000>;
+					qcom,init-voltage = <1000000>;
+					proxy-supply = <&pm8994_l28>;
+					qcom,proxy-consumer-enable;
+					qcom,proxy-consumer-current = <10000>;
+				};
+
+				l29 {
+					/* TODO: Unsupported voltage range..
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					qcom,init-voltage = <2800000>;
+					*/
+				};
+
+				l30 {
+					/* TODO: get this verified
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,init-voltage = <1800000>;
+					*/
+				};
+
+				l31 {
+					regulator-min-microvolt = <1262500>;
+					regulator-max-microvolt = <1262500>;
+					qcom,init-voltage = <1262500>;
+				};
+
+				l32 {
+					/* TODO: get this verified
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+					qcom,init-voltage = <1800000>;
+					*/
+				};
+
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/msm8994-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
index 0e4eea0df25d..66c46b8f9e83 100644
--- a/arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994-pins.dtsi
@@ -35,4 +35,86 @@
 			bias-pull-down;
 		};
 	};
+
+	/* 0-3 for sdc1 4-6 for sdc2 */
+	/* Order of pins */
+	/* SDC1: CLK -> 0, CMD -> 1, DATA -> 2, RCLK -> 3 */
+	/* SDC2: CLK -> 4, CMD -> 5, DATA -> 6 */
+	pmx_sdc1_clk {
+		sdc1_clk_on: clk_on {
+			pinmux {
+				pins = "sdc1_clk";
+			};
+			pinconf {
+				pins = "sdc1_clk";
+				bias-disable = <0>; /* No pull */
+				drive-strength = <16>; /* 16mA */
+			};
+		};
+		sdc1_clk_off: clk_off {
+			pinmux {
+				pins = "sdc1_clk";
+			};
+			pinconf {
+				pins = "sdc1_clk";
+				bias-disable = <0>; /* No pull */
+				drive-strength = <2>; /* 2mA */
+			};
+		};
+	};
+
+	pmx_sdc1_cmd {
+		sdc1_cmd_on: cmd_on {
+			pinmux {
+				pins = "sdc1_cmd";
+			};
+			pinconf {
+				pins = "sdc1_cmd";
+				bias-pull-up;
+				drive-strength = <8>;
+			};
+		};
+		sdc1_cmd_off: cmd_off {
+			pinmux {
+				pins = "sdc1_cmd";
+			};
+			pinconf {
+				pins = "sdc1_cmd";
+				bias-pull-up = <0x3>; /* same as 3.10 ?? */
+				drive-strength = <2>; /* 2mA */
+			};
+		};
+	};
+
+	pmx_sdc1_data {
+		sdc1_data_on: data_on {
+			pinmux {
+				pins = "sdc1_data";
+			};
+			pinconf {
+				pins = "sdc1_data";
+				bias-pull-up;
+				drive-strength = <8>; /* 8mA */
+			};
+		};
+		sdc1_data_off: data_off {
+			pinmux {
+				pins = "sdc1_data";
+			};
+			pinconf {
+				pins = "sdc1_data";
+				bias-pull-up;
+				drive-strength = <2>;
+			};
+		};
+	};
+
+	pmx_sdc1_rclk {
+		sdc1_rclk_on: rclk_on {
+			bias-pull-down; /* pull down */
+		};
+		sdc1_rclk_off: rclk_off {
+			bias-pull-down; /* pull down */
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8994.dtsi b/arch/arm64/boot/dts/qcom/msm8994.dtsi
index f33c41d01c86..703888d608c6 100644
--- a/arch/arm64/boot/dts/qcom/msm8994.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8994.dtsi
@@ -73,6 +73,11 @@
 				  <0xf9002000 0x1000>;
 		};
 
+		apcs: syscon@f900d000 {
+			compatible = "syscon";
+			reg = <0xf900d000 0x2000>;
+		};
+
 		timer@f9020000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
@@ -156,11 +161,6 @@
 				 <&clock_gcc GCC_BLSP1_AHB_CLK>;
 		};
 
-		tcsr_mutex_regs: syscon@fd484000 {
-			compatible = "syscon";
-			reg = <0xfd484000 0x2000>;
-		};
-
 		clock_gcc: clock-controller@fc400000 {
 			compatible = "qcom,gcc-msm8994";
 			#clock-cells = <1>;
@@ -168,6 +168,75 @@
 			#power-domain-cells = <1>;
 			reg = <0xfc400000 0x2000>;
 		};
+
+		sdhci1: mmc@f9824900 {
+			compatible = "qcom,sdhci-msm-v4";
+			reg = <0xf9824900 0x1a0>, <0xf9824000 0x800>;
+			reg-names = "hc_mem", "core_mem";
+
+			interrupts = <GIC_SPI 123 IRQ_TYPE_NONE>,
+					<GIC_SPI 138 IRQ_TYPE_NONE>;
+			interrupt-names = "hc_irq", "pwr_irq";
+
+			clocks = <&clock_gcc GCC_SDCC1_APPS_CLK>,
+				<&clock_gcc GCC_SDCC1_AHB_CLK>;
+			clock-names = "core", "iface";
+
+			pinctrl-names = "default", "sleep";
+			pinctrl-0 = <&sdc1_clk_on &sdc1_cmd_on &sdc1_data_on
+					&sdc1_rclk_on>;
+			pinctrl-1 = <&sdc1_clk_off &sdc1_cmd_off &sdc1_data_off
+					&sdc1_rclk_off>;
+
+			vdd-supply = <&pm8994_l20>;
+			qcom,vdd-voltage-level = <2950000 2950000>;
+			qcom,vdd-current-level = <200 570000>;
+
+			vdd-io-supply = <&pm8994_s4>;
+			qcom,vdd-io-voltage-level = <1800000 1800000>;
+			qcom,vdd-io-current-level = <200 325000>;
+
+			regulator-always-on;
+			bus-width = <8>;
+			mmc-hs400-1_8v;
+			status = "okay";
+		};
+
+		vreg_vph_pwr: vreg-vph-pwr {
+			compatible = "regulator-fixed";
+			status = "okay";
+			regulator-name = "vph-pwr";
+
+			regulator-min-microvolt = <3600000>;
+			regulator-max-microvolt = <3600000>;
+
+			regulator-always-on;
+		};
+
+		rpm_msg_ram: memory@fc428000 {
+			compatible = "qcom,rpm-msg-ram";
+			reg = <0xfc428000 0x4000>;
+		};
+
+		sfpb_mutex_regs: syscon@fd484000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "syscon";
+			reg = <0xfd484000 0x400>;
+		};
+
+		sfpb_mutex: hwmutex {
+			compatible = "qcom,sfpb-mutex";
+			syscon = <&sfpb_mutex_regs 0x0 0x100>;
+			#hwlock-cells = <1>;
+		};
+
+		smem {
+			compatible = "qcom,smem";
+			memory-region = <&smem_region>;
+			qcom,rpm-msg-ram = <&rpm_msg_ram>;
+			hwlocks = <&sfpb_mutex 3>;
+		};
 	};
 
 	memory {
@@ -193,22 +262,77 @@
 		#size-cells = <2>;
 		ranges;
 
-		smem_mem: smem_region@6a00000 {
+		smem_region: smem@6a00000 {
 			reg = <0x0 0x6a00000 0x0 0x200000>;
 			no-map;
 		};
 	};
 
-	tcsr_mutex: hwlock {
-		compatible = "qcom,tcsr-mutex";
-		syscon = <&tcsr_mutex_regs 0 0x80>;
-		#hwlock-cells = <1>;
-	};
+	smd_rpm: smd {
+		compatible = "qcom,smd";
+
+		rpm {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+			qcom,local-pid = <0>;
+			qcom,remote-pid = <6>;
+
+			rpm_requests {
+				compatible = "qcom,rpm-msm8994";
+				qcom,smd-channels = "rpm_requests";
+
+				rpmcc: qcom,rpmcc {
+					/* TODO: update when rpmcc-msm8994 support added */
+					compatible = "qcom,rpmcc-msm8916",
+							"qcom,rpmcc";
+					#clock-cells = <1>;
+				};
 
-	qcom,smem@6a00000 {
-		compatible = "qcom,smem";
-		memory-region = <&smem_mem>;
-		hwlocks = <&tcsr_mutex 3>;
+				smd_rpm_regulators: pm8994-regulators {
+					compatible = "qcom,rpm-pm8994-regulators";
+
+					pm8994_s1: s1 {};
+					pm8994_s2: s2 {};
+					pm8994_s3: s3 {};
+					pm8994_s4: s4 {};
+					pm8994_s5: s5 {};
+					pm8994_s6: s6 {};
+					pm8994_s7: s7 {};
+
+					pm8994_l1: l1 {};
+					pm8994_l2: l2 {};
+					pm8994_l3: l3 {};
+					pm8994_l4: l4 {};
+					pm8994_l6: l6 {};
+					pm8994_l8: l8 {};
+					pm8994_l9: l9 {};
+					pm8994_l10: l10 {};
+					pm8994_l11: l11 {};
+					pm8994_l12: l12 {};
+					pm8994_l13: l13 {};
+					pm8994_l14: l14 {};
+					pm8994_l15: l15 {};
+					pm8994_l16: l16 {};
+					pm8994_l17: l17 {};
+					pm8994_l18: l18 {};
+					pm8994_l19: l19 {};
+					pm8994_l20: l20 {};
+					pm8994_l21: l21 {};
+					pm8994_l22: l22 {};
+					pm8994_l23: l23 {};
+					pm8994_l24: l24 {};
+					pm8994_l25: l25 {};
+					pm8994_l26: l26 {};
+					pm8994_l27: l27 {};
+					pm8994_l28: l28 {};
+					pm8994_l29: l29 {};
+					pm8994_l30: l30 {};
+					pm8994_l31: l31 {};
+					pm8994_l32: l32 {};
+				};
+			};
+		};
 	};
 };
 
-- 
2.11.0

