From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v3 1/2] mmc: DT: sdhci-brcmstb: Bindings document for common sdhci-brcmstb
Date: Tue, 30 Aug 2016 15:30:09 +0900
Message-ID: <20160830063010.10171-2-jaedon.shin@gmail.com>
References: <20160830063010.10171-1-jaedon.shin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36375 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751804AbcH3Gab (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 30 Aug 2016 02:30:31 -0400
In-Reply-To: <20160830063010.10171-1-jaedon.shin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Al Cooper <alcooperx@gmail.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jaedon Shin <jaedon.shin@gmail.com>

- Renames the DT binding document to common for ARM and MIPS based SoCs
- Adds a compatible string "brcm,bcm7445-sdhci" that is representation
  for the Broadcom BCM7445 and family. It is initial and typical 28nm
  generation ARM based SoC.

Signed-off-by: Jaedon Shin <jaedon.shin@gmail.com>
---
 .../mmc/{brcm,bcm7425-sdhci.txt => brcm,sdhci-brcmstb.txt}        | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
 rename Documentation/devicetree/bindings/mmc/{brcm,bcm7425-sdhci.txt => brcm,sdhci-brcmstb.txt} (81%)

diff --git a/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
similarity index 81%
rename from Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
rename to Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
index 82847174c37d..555229367935 100644
--- a/Documentation/devicetree/bindings/mmc/brcm,bcm7425-sdhci.txt
+++ b/Documentation/devicetree/bindings/mmc/brcm,sdhci-brcmstb.txt
@@ -8,14 +8,16 @@ on Device Tree properties to enable them for SoC/Board combinations
 that support them.
 
 Required properties:
-- compatible: "brcm,bcm7425-sdhci"
+- compatible: should be one of the following
+  - "brcm,bcm7425-sdhci"
+  - "brcm,bcm7445-sdhci"
 
 Refer to clocks/clock-bindings.txt for generic clock consumer properties.
 
 Example:
 
 	sdhci@f03e0100 {
-		compatible = "brcm,bcm7425-sdhci";
+		compatible = "brcm,bcm7445-sdhci";
 		reg = <0xf03e0000 0x100>;
 		interrupts = <0x0 0x26 0x0>;
 		sdhci,auto-cmd12;
@@ -27,7 +29,7 @@ Example:
 	sdhci@f03e0300 {
 		non-removable;
 		bus-width = <0x8>;
-		compatible = "brcm,bcm7425-sdhci";
+		compatible = "brcm,bcm7445-sdhci";
 		reg = <0xf03e0200 0x100>;
 		interrupts = <0x0 0x27 0x0>;
 		sdhci,auto-cmd12;
-- 
2.9.3

