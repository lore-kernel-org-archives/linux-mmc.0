From: Al Cooper <alcooperx@gmail.com>
Subject: [PATCH V7 2/2] mmc: DT: sdhci-brcmstb: Add device tree bindings
Date: Thu, 16 Jun 2016 12:47:17 -0400
Message-ID: <1466095637-27895-3-git-send-email-alcooperx@gmail.com>
References: <1466095637-27895-1-git-send-email-alcooperx@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32924 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754130AbcFPR06 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 16 Jun 2016 13:26:58 -0400
Received: by mail-pf0-f196.google.com with SMTP id c74so4437997pfb.0
        for <linux-mmc@vger.kernel.org>; Thu, 16 Jun 2016 10:26:57 -0700 (PDT)
In-Reply-To: <1466095637-27895-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

The example includes the properties required to enable UHS modes.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt | 36 ++++++++++++++++++++++
 1 file changed, 36 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
new file mode 100644
index 0000000..8284717
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
@@ -0,0 +1,36 @@
+* BROADCOM BRCMSTB/BMIPS SDHCI Controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-brcmstb driver.
+
+NOTE: The driver disables all UHS speed modes by default and depends
+on Device Tree properties to enable them for SoC/Board combinations
+that support them.
+
+Required properties:
+- compatible: "brcm,bcm7425-sdhci"
+
+Refer to clocks/clock-bindings.txt for generic clock consumer properties.
+
+Example:
+
+	sdhci@f03e0100 {
+		compatible = "brcm,bcm7425-sdhci";
+		reg = <0xf03e0000 0x100>;
+		interrupts = <0x0 0x26 0x0>;
+		sdhci,auto-cmd12;
+		clocks = <&sw_sdio>;
+		sd-uhs-sdr50;
+		sd-uhs-ddr50;
+	};
+
+	sdhci@f03e0300 {
+		non-removable;
+		bus-width = <0x8>;
+		compatible = "brcm,bcm7425-sdhci";
+		reg = <0xf03e0200 0x100>;
+		interrupts = <0x0 0x27 0x0>;
+		sdhci,auto-cmd12;
+		clocks = <sw_sdio>;
+		mmc-hs200-1_8v;
+	};
-- 
1.9.0.138.g2de3478

