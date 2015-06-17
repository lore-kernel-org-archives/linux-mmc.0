From: Dong Aisheng <aisheng.dong@freescale.com>
Subject: [PATCH 6/6] dts: mmc: fsl-imx-esdhc: remove fsl,cd-controller support
Date: Thu, 18 Jun 2015 02:05:37 +0800
Message-ID: <1434564337-24720-7-git-send-email-aisheng.dong@freescale.com>
References: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0126.outbound.protection.outlook.com ([207.46.100.126]:37717
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755312AbbFQSJb (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 17 Jun 2015 14:09:31 -0400
In-Reply-To: <1434564337-24720-1-git-send-email-aisheng.dong@freescale.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, chris@printf.net, shawn.guo@linaro.org, b29396@freescale.com, fabio.estevam@freescale.com, gwenhael.goavec-merou@armadeus.com, marex@denx.de, s.trumtrar@pengutronix.de, s.hauer@pengutronix.de, lisovy@gmail.com, ipaton0@gmail.com, smoch@web.de, hs@denx.de, rmk+kernel@arm.linux.org.uk, tharvey@gateworks.com, rabeeh@solid-run.com, troy.kisky@boundarydevices.com, p.zabel@pengutronix.de, robertcnelson@gmail.com, LW@KARO-electronics.de, linux-arm-kernel@lists.infradead.org

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

