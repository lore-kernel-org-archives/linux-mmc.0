From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 8/9] ARM: STi: DT: STiH407: Add dt nodes for sdhci and emmc.
Date: Mon, 30 Mar 2015 15:40:01 +0100
Message-ID: <1427726402-7513-9-git-send-email-peter.griffin@linaro.org>
References: <1427726402-7513-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38643 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752783AbbC3Okx (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 10:40:53 -0400
Received: by wibgn9 with SMTP id gn9so133136731wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 07:40:52 -0700 (PDT)
In-Reply-To: <1427726402-7513-1-git-send-email-peter.griffin@linaro.org>
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

