From: Jeremy McNicoll <jeremymc@redhat.com>
Subject: [PATCH V3 5/6] dts: arm64: Enable onboard SDHCI on msm8992
Date: Tue, 24 Jan 2017 01:36:27 -0800
Message-ID: <1485250588-24698-6-git-send-email-jeremymc@redhat.com>
References: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:49704 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750733AbdAXJgo (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 24 Jan 2017 04:36:44 -0500
In-Reply-To: <1485250588-24698-1-git-send-email-jeremymc@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org, git@kchr.de, ulf.hansson@linaro.org, jszhang@marvell.com, jeremymc@redhat.com

This enables SDHCI on the Nexus 5X as well creates common smd_rpm node
which can be shared between both 5X and 6P as per HW design.

Downstream code [msm-angler-3.10-marshmallow-mr1, msm8992.dtsi] eludes
to the fact that 8994-rpm-regulator is common between both msm8992
& msm8994.

Given the very early stage of development that we are in, it makes
sense for the 8994-rpm-regulator to be common until data suggests
otherwise.

Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
---
 .../boot/dts/qcom/msm8992-bullhead-rev-101.dts     |   2 +
 arch/arm64/boot/dts/qcom/msm8992-pins.dtsi         |  60 +++++
 arch/arm64/boot/dts/qcom/msm8992.dtsi              |  87 ++++++-
 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi      | 276 +++++++++++++++++++++
 4 files changed, 424 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
index 4542133..3fc9a33 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
+++ b/arch/arm64/boot/dts/qcom/msm8992-bullhead-rev-101.dts
@@ -39,3 +39,5 @@
 		};
 	};
 };
+
+#include "msm8994-smd-rpm.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi b/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
index d2a26f0..31bc9d9 100644
--- a/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992-pins.dtsi
@@ -35,4 +35,64 @@
 			bias-pull-down;
 		};
 	};
+
+	/* 0-3 for sdc1 4-6 for sdc2 */
+	/* Order of pins */
+	/* SDC1: CLK -> 0, CMD -> 1, DATA -> 2, RCLK -> 3 */
+	/* SDC2: CLK -> 4, CMD -> 5, DATA -> 6 */
+	sdc1_clk_on: clk-on {
+		pinconf {
+			pins = "sdc1_clk";
+			bias-disable = <0>; /* No pull */
+			drive-strength = <16>; /* 16mA */
+		};
+	};
+
+	sdc1_clk_off: clk-off {
+		pinconf {
+			pins = "sdc1_clk";
+			bias-disable = <0>; /* No pull */
+			drive-strength = <2>; /* 2mA */
+		};
+	};
+
+	sdc1_cmd_on: cmd-on {
+		pinconf {
+			pins = "sdc1_cmd";
+			bias-pull-up;
+			drive-strength = <8>;
+		};
+	};
+
+	sdc1_cmd_off: cmd-off {
+		pinconf {
+			pins = "sdc1_cmd";
+			bias-pull-up = <0x3>; /* same as 3.10 ?? */
+			drive-strength = <2>; /* 2mA */
+		};
+	};
+
+	sdc1_data_on: data-on {
+		pinconf {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <8>; /* 8mA */
+		};
+	};
+
+	sdc1_data_off: data-off {
+		pinconf {
+			pins = "sdc1_data";
+			bias-pull-up;
+			drive-strength = <2>;
+		};
+	};
+
+	sdc1_rclk_on: rclk-on {
+		bias-pull-down; /* pull down */
+	};
+
+	sdc1_rclk_off: rclk-off {
+		bias-pull-down; /* pull down */
+	};
 };
diff --git a/arch/arm64/boot/dts/qcom/msm8992.dtsi b/arch/arm64/boot/dts/qcom/msm8992.dtsi
index e5a0d91..2f865a8 100644
--- a/arch/arm64/boot/dts/qcom/msm8992.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8992.dtsi
@@ -192,6 +192,31 @@
 			reg = <0xfc400000 0x2000>;
 		};
 
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
+			regulator-always-on;
+			bus-width = <8>;
+			mmc-hs400-1_8v;
+			status = "okay";
+		};
+
 		rpm_msg_ram: memory@fc428000 {
 			compatible = "qcom,rpm-msg-ram";
 			reg = <0xfc428000 0x4000>;
@@ -234,7 +259,67 @@
 		};
 	};
 
+	smd_rpm: smd {
+		compatible = "qcom,smd";
+		rpm {
+			interrupts = <GIC_SPI 168 IRQ_TYPE_EDGE_RISING>;
+			qcom,ipc = <&apcs 8 0>;
+			qcom,smd-edge = <15>;
+			qcom,local-pid = <0>;
+			qcom,remote-pid = <6>;
+
+			rpm-requests {
+				compatible = "qcom,rpm-msm8994";
+				qcom,smd-channels = "rpm_requests";
+
+				pm8994-regulators {
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
+
+					pm8994_lvs1: lvs1 {};
+					pm8994_lvs2: lvs2 {};
+				};
+			};
+		};
+	};
 };
 
-
 #include "msm8992-pins.dtsi"
diff --git a/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi b/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
new file mode 100644
index 0000000..e9765e1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8994-smd-rpm.dtsi
@@ -0,0 +1,276 @@
+/* Copyright (c) 2015, LGE Inc. All rights reserved.
+ * Copyright (c) 2016, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
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
+				vin_lvs1_2 = <&pm8994_s4>;
+
+				s1 {
+					regulator-min-microvolt = <800000>;
+					regulator-max-microvolt = <800000>;
+				};
+
+				s2 {
+					/* TODO */
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
+					/* TODO */
+				};
+
+				l6 {
+					regulator-min-microvolt = <1800000>;
+					regulator-max-microvolt = <1800000>;
+				};
+
+				l7 {
+					/* TODO */
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
+					/* TODO: Unsupported voltage range.
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
+			};
+		};
+	};
+};
-- 
2.6.1

