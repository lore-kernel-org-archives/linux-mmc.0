From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Subject: [PATCH v3 2/3] ARM: davinci: da850: add mmc DT entries
Date: Tue, 12 Feb 2013 12:07:37 +0530
Message-ID: <1360651058-5255-3-git-send-email-prakash.pm@ti.com>
References: <1360651058-5255-1-git-send-email-prakash.pm@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:51551 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754981Ab3BLGhA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 12 Feb 2013 01:37:00 -0500
In-Reply-To: <1360651058-5255-1-git-send-email-prakash.pm@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: grant.likely@secretlab.ca, rob.herring@calxeda.com, rob@landley.net, linux@arm.linux.org.uk, nsekhar@ti.com, hs@denx.de, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, cjb@laptop.org, davinci-linux-open-source@linux.davincidsp.com, "Manjunathappa, Prakash" <prakash.pm@ti.com>

Add DT entry for MMC. Also add entry for pinmux information.
Tested:
1) Without GPIO card detection and EDMA support as DT support for
   GPIO and EDMA are yet come.
2) By creating/deleting files and mounting/unmounting the partition.

Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
Cc: linux-mmc@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: davinci-linux-open-source@linux.davincidsp.com
Cc: devicetree-discuss@lists.ozlabs.org
Cc: cjb@laptop.org
Cc: Sekhar Nori <nsekhar@ti.com>
---
Since v2:
Remove properties specifying for highspeed card capability.
Since v1:
Removed bitfields for specifying the device capabilty and accomodate
controller revision in compatible field.

 arch/arm/boot/dts/da850-evm.dts |    7 +++++++
 arch/arm/boot/dts/da850.dtsi    |   14 ++++++++++++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/arch/arm/boot/dts/da850-evm.dts b/arch/arm/boot/dts/da850-evm.dts
index f712fb6..78c8e54 100644
--- a/arch/arm/boot/dts/da850-evm.dts
+++ b/arch/arm/boot/dts/da850-evm.dts
@@ -39,6 +39,13 @@
 		wdt: wdt@1c21000 {
 			status = "okay";
 		};
+		mmc0: mmc@1c40000 {
+			max-frequency = <50000000>;
+			bus-width = <4>;
+			status = "okay";
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins>;
+		};
 	};
 	nand_cs3@62000000 {
 		status = "okay";
diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
index 4b2262a..ebe7386 100644
--- a/arch/arm/boot/dts/da850.dtsi
+++ b/arch/arm/boot/dts/da850.dtsi
@@ -67,6 +67,15 @@
 					0x10 0x00002200 0x0000ff00
 				>;
 			};
+			mmc0_pins: pinmux_mmc_pins {
+				pinctrl-single,bits = <
+					/* MMCSD0_DAT[3] MMCSD0_DAT[2]
+					 * MMCSD0_DAT[1] MMCSD0_DAT[0]
+					 * MMCSD0_CMD    MMCSD0_CLK
+					 */
+					0x28 0x00222222  0x00ffffff
+				>;
+			};
 		};
 		serial0: serial@1c42000 {
 			compatible = "ns16550a";
@@ -110,6 +119,11 @@
 		wdt: wdt@1c21000 {
 			compatible = "ti,davinci-wdt";
 			reg = <0x21000 0x1000>;
+		};
+		mmc0: mmc@1c40000 {
+			compatible = "ti,davinci-mmc-da830";
+			reg = <0x40000 0x1000>;
+			interrupts = <16>;
 			status = "disabled";
 		};
 	};
-- 
1.7.4.1

