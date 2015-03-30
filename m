From: Peter Griffin <peter.griffin@linaro.org>
Subject: [PATCH v3 9/9] ARM: STi: DT: STiH418: Add dt nodes for sdhci and emmc.
Date: Mon, 30 Mar 2015 15:40:02 +0100
Message-ID: <1427726402-7513-10-git-send-email-peter.griffin@linaro.org>
References: <1427726402-7513-1-git-send-email-peter.griffin@linaro.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:36793 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbbC3Ok3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 30 Mar 2015 10:40:29 -0400
Received: by wibg7 with SMTP id g7so105747636wib.1
        for <linux-mmc@vger.kernel.org>; Mon, 30 Mar 2015 07:40:28 -0700 (PDT)
In-Reply-To: <1427726402-7513-1-git-send-email-peter.griffin@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, maxime.coquelin@st.com, patrice.chotard@st.com, srinivas.kandagatla@gmail.com, chris@printf.net, ulf.hansson@linaro.org
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, peppe.cavallaro@st.com

Add dt nodes to enable sdhci / eMMC for stih418-b2199 board.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 arch/arm/boot/dts/stih418-b2199.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/stih418-b2199.dts b/arch/arm/boot/dts/stih418-b2199.dts
index 926235c..a2fdada 100644
--- a/arch/arm/boot/dts/stih418-b2199.dts
+++ b/arch/arm/boot/dts/stih418-b2199.dts
@@ -74,5 +74,17 @@
 			st,i2c-min-scl-pulse-width-us = <0>;
 			st,i2c-min-sda-pulse-width-us = <5>;
 		};
+
+		mmc1: sdhci@09080000 {
+			status = "okay";
+		};
+
+		mmc0: sdhci@09060000 {
+			status = "okay";
+			max-frequency = <200000000>;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			sd-uhs-ddr50;
+		};
 	};
 };
-- 
1.9.1

