From: Al Cooper <alcooperx@gmail.com>
Subject: [RESEND PATCH V5 2/2] mmc: DT: sdhci-brcmstb: Add device tree bindings
Date: Mon, 13 Jun 2016 08:19:00 -0400
Message-ID: <1465820340-16722-3-git-send-email-alcooperx@gmail.com>
References: <1465820340-16722-1-git-send-email-alcooperx@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:32787 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965049AbcFMMTi (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 13 Jun 2016 08:19:38 -0400
Received: by mail-pf0-f196.google.com with SMTP id c74so10575241pfb.0
        for <linux-mmc@vger.kernel.org>; Mon, 13 Jun 2016 05:19:37 -0700 (PDT)
In-Reply-To: <1465820340-16722-1-git-send-email-alcooperx@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com
Cc: Al Cooper <alcooperx@gmail.com>

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 .../devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
new file mode 100644
index 0000000..4c73671
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
@@ -0,0 +1,32 @@
+* BROADCOM BRCMSTB/BMIPS SDHCI Controller
+
+This file documents differences between the core properties in mmc.txt
+and the properties used by the sdhci-brcmstb driver.
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

