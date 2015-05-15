From: Yangbo Lu <yangbo.lu@freescale.com>
Subject: [PATCH v2, 1/2] powerpc/dts: add eSDHC compatible list
Date: Fri, 15 May 2015 10:46:02 +0800
Message-ID: <1431657962-42443-1-git-send-email-yangbo.lu@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0112.outbound.protection.outlook.com ([207.46.100.112]:53843
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1423235AbbEOCuH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 14 May 2015 22:50:07 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, chrisball@gmail.com
Cc: scottwood@freescale.com, Yangbo Lu <yangbo.lu@freescale.com>

Add eSDHC compatible list for P2041/P3041/P4080/P5020/P5040.

Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
---
 arch/powerpc/boot/dts/fsl/p2041si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p3041si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p4080si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p5020si-post.dtsi | 1 +
 arch/powerpc/boot/dts/fsl/p5040si-post.dtsi | 1 +
 5 files changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
index efd74db..67ea0e9 100644
--- a/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p2041si-post.dtsi
@@ -363,6 +363,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p2041-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
diff --git a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
index d7425ef..b6d92c5 100644
--- a/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p3041si-post.dtsi
@@ -390,6 +390,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p3041-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
diff --git a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
index 7005a4a..bf3dad3 100644
--- a/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p4080si-post.dtsi
@@ -462,6 +462,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p4080-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		voltage-ranges = <3300 3300>;
diff --git a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
index 5583421..dbc2c8b 100644
--- a/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5020si-post.dtsi
@@ -377,6 +377,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p5020-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu1>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
diff --git a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
index 6e4cd6c..207d02f 100644
--- a/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
+++ b/arch/powerpc/boot/dts/fsl/p5040si-post.dtsi
@@ -355,6 +355,7 @@
 
 /include/ "qoriq-esdhc-0.dtsi"
 	sdhc@114000 {
+		compatible = "fsl,p5040-esdhc", "fsl,esdhc";
 		fsl,iommu-parent = <&pamu2>;
 		fsl,liodn-reg = <&guts 0x530>; /* eSDHCLIODNR */
 		sdhci,auto-cmd12;
-- 
2.1.0.27.g96db324

