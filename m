From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH V2 11/11] dts: mmc: fsl-imx-esdhc: remove fsl,cd-controller support
Date: Wed, 22 Jul 2015 20:53:10 +0800
Message-ID: <1437569590-5228-12-git-send-email-aisheng.dong@freescale.com>
References: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0126.outbound.protection.outlook.com ([65.55.169.126]:19727
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S965215AbbGVOEC (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Jul 2015 10:04:02 -0400
In-Reply-To: <1437569590-5228-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: fabio.estevam@freescale.com, marex@denx.de, ulf.hansson@linaro.org, s.trumtrar@pengutronix.de, smoch@web.de, linux-arm-kernel@lists.infradead.org, robertcnelson@gmail.com, s.hauer@pengutronix.de, chris@printf.net, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, lisovy@gmail.com, hs@denx.de, gwenhael.goavec-merou@armadeus.com, p.zabel@pengutronix.de, rmk+kernel@arm.linux.org.uk, shawn.guo@linaro.org, b29396@freescale.com, tharvey@gateworks.com, LW@KARO-electronics.de, ipaton0@gmail.com

It's not supported by driver anymore after using runtime pm
and there's no user of it, so delete it now.

Signed-off-by: Dong Aisheng <aisheng.dong@freescale.com>
---
 Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
index 5d0376b..211e778 100644
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-esdhc.txt
@@ -17,7 +17,6 @@ Required properties:
 	       "fsl,imx6sx-usdhc"
 
 Optional properties:
-- fsl,cd-controller : Indicate to use controller internal card detection
 - fsl,wp-controller : Indicate to use controller internal write protection
 - fsl,delay-line : Specify the number of delay cells for override mode.
   This is used to set the clock delay for DLL(Delay Line) on override mode
@@ -35,7 +34,6 @@ esdhc@70004000 {
 	compatible = "fsl,imx51-esdhc";
 	reg = <0x70004000 0x4000>;
 	interrupts = <1>;
-	fsl,cd-controller;
 	fsl,wp-controller;
 };
 
-- 
1.9.1

