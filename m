From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v2 07/10] ARM: STi: DT: Enable mmc0 for both stih415 and stih416 SoCs
Date: Wed,  4 Jun 2014 17:07:31 +0100
Message-ID: <1401898054-686-8-git-send-email-peter.griffin@linaro.org>
References: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:60549 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679AbaFDQHq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Jun 2014 12:07:46 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so8582351wgg.13
        for <linux-mmc@vger.kernel.org>; Wed, 04 Jun 2014 09:07:45 -0700 (PDT)
In-Reply-To: <1401898054-686-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: peter.griffin@linaro.org, chris@printf.net, ulf.hansson@linaro.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org

Because the first sdhci controller is present on both stih415 and
stih416 SoC which can both populate the b2020 board, it can be
enabled in the generic DT file.

Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
Acked-by: Lee Jones <lee.jones@linaro.org>
Acked-by: Maxime Coquelin <maxime.coquelin@st.com>
---
 arch/arm/boot/dts/stih41x-b2020.dtsi  | 4 ++++
 arch/arm/boot/dts/stih41x-b2020x.dtsi | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/stih41x-b2020.dtsi b/arch/arm/boot/dts/stih41x-b2020.dtsi
index d8a8429..5c2df46 100644
--- a/arch/arm/boot/dts/stih41x-b2020.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020.dtsi
@@ -74,5 +74,9 @@
 
 			pinctrl-0	= <&pinctrl_rgmii1>;
 		};
+
+		mmc0: sdhci@fe81e000 {
+			bus-width = <8>;
+		};
 	};
 };
diff --git a/arch/arm/boot/dts/stih41x-b2020x.dtsi b/arch/arm/boot/dts/stih41x-b2020x.dtsi
index df01c12..f797a06 100644
--- a/arch/arm/boot/dts/stih41x-b2020x.dtsi
+++ b/arch/arm/boot/dts/stih41x-b2020x.dtsi
@@ -8,6 +8,10 @@
  */
 / {
 	soc {
+		mmc0: sdhci@fe81e000 {
+			status = "okay";
+		};
+
 		spifsm: spifsm@fe902000 {
 			#address-cells = <1>;
 			#size-cells    = <1>;
-- 
1.9.1

