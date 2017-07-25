From: Ivan Mikhaylov <ivan@de.ibm.com>
Subject: [PATCH v2 2/2] 44x/fsp2: enable eMMC arasan for fsp2 platform
Date: Tue, 25 Jul 2017 14:40:04 +0300
Message-ID: <20170725114004.17819-1-ivan@de.ibm.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55322 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750972AbdGYLkQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jul 2017 07:40:16 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id v6PBccwl085961
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jul 2017 07:40:15 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bx05w5wme-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jul 2017 07:40:15 -0400
Received: from localhost
        by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-mmc@vger.kernel.org> from <ivan@de.ibm.com>;
        Tue, 25 Jul 2017 12:40:13 +0100
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alistair Popple <alistair@popple.id.au>, Matt Porter <mporter@kernel.crashing.org>, Adrian Hunter <adrian.hunter@intel.com>, Patrice Chotard <patrice.chotard@st.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Joel Stanley <joel@jms.id.au>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linux-mmc@vger.kernel.org, kernel@stlinux.com, Rob Herring <robh@kernel.org>

Add mmc0 changes for enabling arasan emmc and change
defconfig appropriately.

Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>
---
 arch/powerpc/boot/dts/fsp2.dts          |   33 +++++++++++++++++-------------
 arch/powerpc/configs/44x/fsp2_defconfig |    2 +
 2 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/boot/dts/fsp2.dts b/arch/powerpc/boot/dts/fsp2.dts
index 475953a..6a63026 100644
--- a/arch/powerpc/boot/dts/fsp2.dts
+++ b/arch/powerpc/boot/dts/fsp2.dts
@@ -52,6 +52,7 @@
 	clocks {
 		mmc_clk: mmc_clk {
 			compatible = "fixed-clock";
+			#clock-cells = <0>;
 			clock-frequency = <50000000>;
 			clock-output-names = "mmc_clk";
 		};
@@ -359,20 +360,6 @@
 		interrupts = <31 0x4 15 0x84>;
 	};
 
-	mmc0: sdhci@020c0000 {
-		compatible	= "st,sdhci-stih407", "st,sdhci";
-		status		= "disabled";
-		reg		= <0x020c0000 0x20000>;
-		reg-names	= "mmc";
-		interrupt-parent = <&UIC1_3>;
-		interrupts	= <21 0x4 22 0x4>;
-		interrupt-names	= "mmcirq";
-		pinctrl-names	= "default";
-		pinctrl-0	= <>;
-		clock-names	= "mmc";
-		clocks		= <&mmc_clk>;
-	};
-
 	plb6 {
 		compatible = "ibm,plb6";
 		#address-cells = <2>;
@@ -501,6 +488,24 @@
 					 /*RXDE*/  4 &UIC1_2 13 0x4>;
 		};
 
+		mmc0: mmc@20c0000 {
+			compatible	= "st,sdhci-stih407", "st,sdhci";
+			reg		= <0x020c0000 0x20000>;
+			reg-names	= "mmc";
+			interrupts	= <21 0x4>;
+			interrupt-parent = <&UIC1_3>;
+			interrupt-names	= "mmcirq";
+			pinctrl-names	= "default";
+			pinctrl-0	= <>;
+			clock-names	= "mmc";
+			clocks		= <&mmc_clk>;
+			bus-width	= <4>;
+			non-removable;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			sd-uhs-ddr50;
+		};
+
 		opb {
 			compatible = "ibm,opb";
 			#address-cells = <1>;
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index e8e6a69..935aabe 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -92,8 +92,10 @@ CONFIG_MMC_DEBUG=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_OF_ARASAN=y
+CONFIG_MMC_SDHCI_ST=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_M41T80=y
+CONFIG_RESET_CONTROLLER=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT4_FS=y
 CONFIG_EXT4_FS_POSIX_ACL=y
-- 
1.7.1

