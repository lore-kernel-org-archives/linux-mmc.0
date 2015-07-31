From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [v4, 5/6] powerpc/85xx: specify 'big-endian' property for eSDHC in dts
Date: Fri, 31 Jul 2015 11:55:01 +0800
Message-ID: <1438314901-47763-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0142.outbound.protection.outlook.com ([207.46.100.142]:18560
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750724AbbGaEAH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 31 Jul 2015 00:00:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org
Cc: Yangbo Lu <yangbo.lu@freescale.com>

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
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

