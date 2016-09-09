From: Jaedon Shin <jaedon.shin@gmail.com>
Subject: [v4 1/2] mmc: DT: sdhci-brcmstb: Bindings document for common sdhci-brcmstb
Date: Fri,  9 Sep 2016 11:08:39 +0900
Message-ID: <20160909020840.2718-2-jaedon.shin@gmail.com>
References: <20160909020840.2718-1-jaedon.shin@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36835 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751375AbcIICJn (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 8 Sep 2016 22:09:43 -0400
In-Reply-To: <20160909020840.2718-1-jaedon.shin@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Rob Herring <robh+dt@kernel.org>, Al Cooper <alcooperx@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com, devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jaedon Shin <jaedon.shin@gmail.com>

Changes to the DT binding document to separate the BCM7425 and the
BCM7445.

A compatible string "brcm,bcm7425-sdhci" was representing the BCM7425
SDHCI host controller with all BRCMSTB SoCs including the BCM7445. Now
it should be separated because vary a bit in initialize each host
controller.

- Renames the DT binding document to common name.
- Adds a compatible string "brcm,bcm7445-sdhci" that is representing the
  BCM7445 with thereafter 28nm generation ARM based SoCs.
- Updates example nodes to represent the BCM7445.

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
2.10.0

