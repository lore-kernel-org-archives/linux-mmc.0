From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 04/10] ARM: STi: DT: Add sdhci controller for stih416
Date: Wed,  4 Jun 2014 17:07:28 +0100
Message-ID: <1401898054-686-5-git-send-email-peter.griffin@linaro.org>
References: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-we0-f171.google.com ([74.125.82.171]:35595 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbaFDQHo (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 12:07:44 -0400
Received: by mail-we0-f171.google.com with SMTP id w62so8832029wes.16
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 09:07:42 -0700 (PDT)
In-Reply-To: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: peter.griffin@linaro.org, chris@printf.net, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

This patch adds device tree config for both sdhci controllers
on the stih416 SoC.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih416.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/stih416.dtsi b/arch/arm/boot/dts/stih416.dtsi
index 06473c5..6473287 100644
--- a/arch/arm/boot/dts/stih416.dtsi
+++ b/arch/arm/boot/dts/stih416.dtsi
@@ -236,5 +236,29 @@
 			resets	= <&powerdown STIH416_KEYSCAN_POWERDOWN>,
 				  <&softreset STIH416_KEYSCAN_SOFTRESET>;
 		};
+
+		mmc0: sdhci@fe81e000 {
+			compatible	= "st,sdhci";
+			status		= "disabled";
+			reg		= <0xfe81e000 0x1000>;
+			interrupts	= <GIC_SPI 127 IRQ_TYPE_NONE>;
+			interrupt-names	= "mmcirq";
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_mmc0>;
+			clock-names	= "mmc";
+			clocks		= <&clk_s_a1_ls 1>;
+		};
+
+		mmc1: sdhci@fe81f000 {
+			compatible	= "st,sdhci";
+			status		= "disabled";
+			reg		= <0xfe81f000 0x1000>;
+			interrupts	= <GIC_SPI 128 IRQ_TYPE_NONE>;
+			interrupt-names	= "mmcirq";
+			pinctrl-names	= "default";
+			pinctrl-0	= <&pinctrl_mmc1>;
+			clock-names	= "mmc";
+			clocks		= <&clk_s_a1_ls 8>;
+		};
 	};
 };
-- 
1.9.1

