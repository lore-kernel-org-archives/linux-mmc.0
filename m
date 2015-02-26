From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 8/8] ARM: STi: DT: STiH407: Add dt nodes for sdhci and emmc.
Date: Thu, 26 Feb 2015 13:10:27 +0000
Message-ID: <1424956227-18258-9-git-send-email-peter.griffin@linaro.org>
References: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f170.google.com ([74.125.82.170]:45378 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932310AbbBZNKv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 26 Feb 2015 08:10:51 -0500
Received: by wesp10 with SMTP id p10so8362280wes.12
        for <linux-mmc@vger.kernel.org>; Thu, 26 Feb 2015 05:10:50 -0800 (PST)
In-Reply-To: <1424956227-18258-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com

The nodes have been split to allow as much commonality as possible.
The stih407 has a silicon bug with eMMC UHS modes (with top regs)
and as such doesn't have any of the uhs dt properties.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih407-family.dtsi | 30 ++++++++++++++++++++++++++++++
 arch/arm/boot/dts/stih410-b2120.dts   | 10 ++++++++++
 arch/arm/boot/dts/stihxxx-b2120.dtsi  |  8 ++++++++
 3 files changed, 48 insertions(+)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index c06a546..77614a5 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -336,5 +336,35 @@
 				resets = <&softreset STIH407_MIPHY2_SOFTRESET>;
 			};
 		};
+
+		mmc0: sdhci@09060000 {
+			compatible = "st,sdhci-stih407", "st,sdhci";
+			status = "disabled";
+			reg = <0x09060000 0x7ff>, <0x9061008 0x20>;
+			reg-names = "mmc", "top-mmc-delay";
+			interrupts = <GIC_SPI 92 IRQ_TYPE_NONE>;
+			interrupt-names = "mmcirq";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_mmc0>;
+			clock-names = "mmc";
+			clocks = <&clk_s_c0_flexgen CLK_MMC_0>;
+			bus-width = <8>;
+			non-removable;
+		};
+
+		mmc1: sdhci@09080000 {
+			compatible = "st,sdhci-stih407", "st,sdhci";
+			status = "disabled";
+			reg = <0x09080000 0x7ff>;
+			reg-names = "mmc";
+			interrupts = <GIC_SPI 90 IRQ_TYPE_NONE>;
+			interrupt-names = "mmcirq";
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_sd1>;
+			clock-names = "mmc";
+			clocks = <&clk_s_c0_flexgen CLK_MMC_1>;
+			resets = <&softreset STIH407_MMC1_SOFTRESET>;
+			bus-width = <4>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih410-b2120.dts b/arch/arm/boot/dts/stih410-b2120.dts
index 2f61a99..16f02c5 100644
--- a/arch/arm/boot/dts/stih410-b2120.dts
+++ b/arch/arm/boot/dts/stih410-b2120.dts
@@ -26,4 +26,14 @@
 	aliases {
 		ttyAS0 = &sbc_serial0;
 	};
+
+	soc {
+
+		mmc0: sdhci@09060000 {
+			max-frequency = <200000000>;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			sd-uhs-ddr50;
+		};
+	};
 };
diff --git a/arch/arm/boot/dts/stihxxx-b2120.dtsi b/arch/arm/boot/dts/stihxxx-b2120.dtsi
index c1d8590..64fa0b5 100644
--- a/arch/arm/boot/dts/stihxxx-b2120.dtsi
+++ b/arch/arm/boot/dts/stihxxx-b2120.dtsi
@@ -47,6 +47,14 @@
 			status = "okay";
 		};
 
+		mmc0: sdhci@09060000 {
+			status = "okay";
+		};
+
+		mmc1: sdhci@09080000 {
+			status = "okay";
+		};
+
 		/* SSC11 to HDMI */
 		hdmiddc: i2c@9541000 {
 			status = "okay";
-- 
1.9.1

