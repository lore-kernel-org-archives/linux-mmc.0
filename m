From: John Tobias <john.tobias.ph@gmail.com>
Subject: [PATCH 1/3]: Support cpu frequency scaling and power management for iMX6SL
Date: Mon, 16 Dec 2013 17:40:15 -0800
Message-ID: <CACUGKYPLSdih0_+Dt5LP2E1JACfU7NbAvtCibWftKbzTf6R8FA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f181.google.com ([209.85.214.181]:64524 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019Ab3LQBkP (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Dec 2013 20:40:15 -0500
Received: by mail-ob0-f181.google.com with SMTP id uy5so5703177obc.40
        for <linux-mmc@vger.kernel.org>; Mon, 16 Dec 2013 17:40:15 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, Chris Ball <cjb@laptop.org>

iMX6SL device tree doesn't have a configuration settings to enable the
frequency scaling and power management.

From: John Tobias <john.tobias.ph@gmail.com>


diff --git a/arch/arm/boot/dts/imx6sl.dtsi b/arch/arm/boot/dts/imx6sl.dtsi
index 28558f1..0ad2f6a 100644
--- a/arch/arm/boot/dts/imx6sl.dtsi
+++ b/arch/arm/boot/dts/imx6sl.dtsi
@@ -38,6 +38,19 @@
                        device_type = "cpu";
                        reg = <0x0>;
                        next-level-cache = <&L2>;
+                       operating-points = <
+                               /* kHz    uV */
+                               1000000 1275000
+                               792000  1150000
+                       >;
+                       clock-latency = <61036>; /* two CLK32 periods */
+                       clocks = <&clks IMX6SL_CLK_ARM>, <&clks
IMX6SL_CLK_PLL2_PFD2>, <&clks IMX6SL_CLK_STEP>,
+                                <&clks IMX6SL_CLK_PLL1_SW>, <&clks
IMX6SL_CLK_PLL1_SYS>;
+                       clock-names = "arm", "pll2_pfd2_396m", "step",
+                                     "pll1_sw", "pll1_sys";
+                       arm-supply = <&reg_arm>;
+                       pu-supply = <&reg_pu>;
+                       soc-supply = <&reg_soc>;
                };
        };
