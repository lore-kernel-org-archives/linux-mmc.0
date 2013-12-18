From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH 1/4] iMX6SL frequency table
Date: Tue, 17 Dec 2013 17:17:28 -0800
Message-ID: <1387329451-17480-1-git-send-email-john.tobias.ph@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:38797 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab3LRBRj (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Dec 2013 20:17:39 -0500
Received: by mail-pd0-f182.google.com with SMTP id v10so7539705pde.13
        for <linux-mmc@vger.kernel.org>; Tue, 17 Dec 2013 17:17:38 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, shawn.guo@linaro.org, festevam@gmail.com, cjb@laptop.org
Cc: John Tobias <john.tobias.ph@gmail.com>

    Device tree for iMX6SL doesn't have an existing cpu frequency table.

Signed-off-by: John Tobias <john.tobias.ph@gmail.com>
---
 arch/arm/boot/dts/imx6sl.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..0a2c73c 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -38,6 +38,20 @@
 			device_type = "cpu";
 			reg = <0x0>;
 			next-level-cache = <&L2>;
+			operating-points = <
+				/* kHz    uV */
+				996000  1250000 /* for consumer grade only */
+				792000  1150000
+				396000  1050000
+			>;
+			clock-latency = <61036>; /* two CLK32 periods */
+			clocks = <&clks IMX6SL_CLK_ARM>, <&clks IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
+				 <&clks IMX6SL_CLK_PLL1_SW>, <&clks IMX6SL_CLK_PLL1_SYS>;
+			clock-names = "arm", "pll2_pfd2_396m", "step",
+				      "pll1_sw", "pll1_sys";
+			arm-supply = <&reg_arm>;
+			pu-supply = <&reg_pu>;
+			soc-supply = <&reg_soc>;
 		};
 	};
 
-- 
1.8.3.2

