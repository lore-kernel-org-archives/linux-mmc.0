From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 03/10] ARM: STi: DT: Add sdhci pins for stih416
Date: Wed,  4 Jun 2014 17:07:27 +0100
Message-ID: <1401898054-686-4-git-send-email-peter.griffin@linaro.org>
References: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38013 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752208AbaFDQHn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 12:07:43 -0400
Received: by mail-wi0-f179.google.com with SMTP id bs8so1798062wib.6
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 09:07:41 -0700 (PDT)
In-Reply-To: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: peter.griffin@linaro.org, chris@printf.net, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

This adds the required pin config for both SDHCI controllers on
the stih416 SoC.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih416-pinctrl.dtsi | 39 ++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/stih416-pinctrl.dtsi b/arch/arm/boot/dts/stih416-pinctrl.dtsi
index 6252188..dad1f24 100644
--- a/arch/arm/boot/dts/stih416-pinctrl.dtsi
+++ b/arch/arm/boot/dts/stih416-pinctrl.dtsi
@@ -467,6 +467,45 @@
 					};
 				};
 			};
+
+			mmc0 {
+				pinctrl_mmc0: mmc0 {
+					st,pins {
+						mmcclk  = <&PIO13 4 ALT4 BIDIR_PU NICLK 0 CLK_B>;
+						data0   = <&PIO14 4 ALT4 BIDIR_PU BYPASS 0>;
+						data1   = <&PIO14 5 ALT4 BIDIR_PU BYPASS 0>;
+						data2   = <&PIO14 6 ALT4 BIDIR_PU BYPASS 0>;
+						data3   = <&PIO14 7 ALT4 BIDIR_PU BYPASS 0>;
+						cmd     = <&PIO15 1 ALT4 BIDIR_PU BYPASS 0>;
+						wp      = <&PIO15 3 ALT4 IN>;
+						data4   = <&PIO16 4 ALT4 BIDIR_PU BYPASS 0>;
+						data5   = <&PIO16 5 ALT4 BIDIR_PU BYPASS 0>;
+						data6   = <&PIO16 6 ALT4 BIDIR_PU BYPASS 0>;
+						data7   = <&PIO16 7 ALT4 BIDIR_PU BYPASS 0>;
+						pwr     = <&PIO17 1 ALT4 OUT>;
+						cd      = <&PIO17 2 ALT4 IN>;
+						led     = <&PIO17 3 ALT4 OUT>;
+					};
+				};
+			};
+			mmc1 {
+				pinctrl_mmc1: mmc1 {
+					st,pins {
+						mmcclk  = <&PIO15 0 ALT3 BIDIR_PU NICLK 0 CLK_B>;
+						data0   = <&PIO13 7 ALT3 BIDIR_PU BYPASS 0>;
+						data1   = <&PIO14 1 ALT3 BIDIR_PU BYPASS 0>;
+						data2   = <&PIO14 2 ALT3 BIDIR_PU BYPASS 0>;
+						data3   = <&PIO14 3 ALT3 BIDIR_PU BYPASS 0>;
+						cmd     = <&PIO15 4 ALT3 BIDIR_PU BYPASS 0>;
+						data4   = <&PIO15 6 ALT3 BIDIR_PU BYPASS 0>;
+						data5   = <&PIO15 7 ALT3 BIDIR_PU BYPASS 0>;
+						data6   = <&PIO16 0 ALT3 BIDIR_PU BYPASS 0>;
+						data7   = <&PIO16 1 ALT3 BIDIR_PU BYPASS 0>;
+						pwr     = <&PIO16 2 ALT3 OUT>;
+						nreset  = <&PIO13 6 ALT3 OUT>;
+					};
+				};
+			};
 		};
 
 		pin-controller-fvdp-fe {
-- 
1.9.1

