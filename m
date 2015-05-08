From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v3, 5/6] powerpc/85xx: specify 'big-endian' property for eSDHC in dts
Date: Fri, 8 May 2015 14:51:03 +0800
Message-ID: <1431067863-41518-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0133.outbound.protection.outlook.com ([207.46.100.133]:34112
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751493AbbEHGyp (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 8 May 2015 02:54:45 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chris@printf.net, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
Changes for v3:
	- Specified 'big-endian' property for eSDHC of powerpc
---
 arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi   | 1 +
 arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi b/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
index 5743433..57f519e 100644
--- a/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/pq3-esdhc-0.dtsi
@@ -38,4 +38,5 @@ sdhc@2e000 {
 	interrupts = <72 0x2 0 0>;
 	/* Filled in by U-Boot */
 	clock-frequency = <0>;
+	big-endian;
 };
diff --git a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
index 20835ae..5ba211e 100644
--- a/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
+++ b/arch/powerpc/boot/dts/fsl/qoriq-esdhc-0.dtsi
@@ -37,4 +37,5 @@ sdhc: sdhc@114000 {
 	reg = <0x114000 0x1000>;
 	interrupts = <48 2 0 0>;
 	clock-frequency = <0>;
+	big-endian;
 };
-- 
2.1.0.27.g96db324

