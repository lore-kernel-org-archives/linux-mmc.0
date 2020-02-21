Return-Path: <SRS0=+wZv=4J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A48C11D24
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 03:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0742208C4
	for <linux-mmc@archiver.kernel.org>; Fri, 21 Feb 2020 03:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="sKSyyk3M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729630AbgBUDot (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 20 Feb 2020 22:44:49 -0500
Received: from condef-10.nifty.com ([202.248.20.75]:27754 "EHLO
        condef-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729539AbgBUDot (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Feb 2020 22:44:49 -0500
Received: from conuserg-09.nifty.com ([10.126.8.72])by condef-10.nifty.com with ESMTP id 01L3eYow010301
        for <linux-mmc@vger.kernel.org>; Fri, 21 Feb 2020 12:40:34 +0900
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 01L3cSHA001563;
        Fri, 21 Feb 2020 12:38:28 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 01L3cSHA001563
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1582256309;
        bh=9fN7Ow7rqVeONqx0lv47MnGX/K8QzO8kQz42Q/AlqEY=;
        h=From:To:Cc:Subject:Date:From;
        b=sKSyyk3MdpVI9hgmbZBZCbe8knOjzRwkd1aM5Aq3/pCEL1TZ0qJl4sa8awPcFMNAY
         OcFY4tgqfqmKSR5mXwGVw5nJvyAlC1Vbf2cs6bAKDLoPc0nM/ghXSxt8LKL31nHPXk
         lpbmK06RWoeuNYWXUP5LAvJTaxODD9WgnydAlv8tilS8VhULiSHJMspbqGCat2unk9
         Q3CI4xcLlv36JjuI2SDwvvx8KYzS5hMrCRCVxps2/bZ/tlEGtVgXGWnq3i9YwbwlBy
         tIJRVz0+OlzL79B2fxIYNriSjWmo32SdG5jgo3eN+p0GCCqSvcCGI1qYVWF31Aw/Sy
         Cu94nMTizwgYw==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Piotr Sroka <piotrs@cadence.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Subject: [PATCH] dt-bindings: mmc: Convert Cadence SD/SDIO/eMMC controller to json-schema
Date:   Fri, 21 Feb 2020 12:38:19 +0900
Message-Id: <20200221033819.2966-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the Cadence SD/SDIO/eMMC host controller IP (a.k.a. SD4HC)
binding to DT schema format.

Socionext UniPhier ARM 64-bit SoCs are integrated with this IP.

Cc: Piotr Sroka <piotrs@cadence.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

I wanted to kept some precious comments, which apply to multiple
properties.

I do not think 'description:' is a good fit for this.

I was searching for a way to insert a comment line that does not
affect the schema.

The $comment did not work. I just use '#', which is YAML comment.
If there is a better way, please let me know.


 .../devicetree/bindings/mmc/cdns,sdhci.yaml   | 143 ++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-cadence.txt |  80 ----------
 2 files changed, 143 insertions(+), 80 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-cadence.txt

diff --git a/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
new file mode 100644
index 000000000000..caf765721eb2
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/cdns,sdhci.yaml
@@ -0,0 +1,143 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/cdns,sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Cadence SD/SDIO/eMMC Host Controller (SD4HC)
+
+maintainers:
+  - Masahiro Yamada <yamada.masahiro@socionext.com>
+  - Piotr Sroka <piotrs@cadence.com>
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+         - socionext,uniphier-sd4hc
+      - const: cdns,sd4hc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  # PHY DLL input delays:
+  # They are used to delay the data valid window, and align the window to
+  # sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
+  # and it is increased by 2.5ns in each step.
+
+  cdns,phy-input-delay-sd-highspeed:
+    description: Value of the delay in the input path for SD high-speed timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-legacy:
+    description: Value of the delay in the input path for legacy timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-sd-uhs-sdr12:
+    description: Value of the delay in the input path for SD UHS SDR12 timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-sd-uhs-sdr25:
+    description: Value of the delay in the input path for SD UHS SDR25 timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-sd-uhs-sdr50:
+    description: Value of the delay in the input path for SD UHS SDR50 timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-sd-uhs-ddr50:
+    description: Value of the delay in the input path for SD UHS DDR50 timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-mmc-highspeed:
+    description: Value of the delay in the input path for MMC high-speed timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  cdns,phy-input-delay-mmc-ddr:
+    description: Value of the delay in the input path for eMMC high-speed DDR timing
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x1f
+
+  # PHY DLL clock delays:
+  # Each delay property represents the fraction of the clock period.
+  # The approximate delay value will be
+  # (<delay property value>/128)*sdmclk_clock_period.
+
+  cdns,phy-dll-delay-sdclk:
+    description: |
+      Value of the delay introduced on the sdclk output for all modes except
+      HS200, HS400 and HS400_ES.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x7f
+
+  cdns,phy-dll-delay-sdclk-hsmmc:
+    description: |
+      Value of the delay introduced on the sdclk output for HS200, HS400 and
+      HS400_ES speed modes.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x7f
+
+  cdns,phy-dll-delay-strobe:
+    description: |
+      Value of the delay introduced on the dat_strobe input used in
+      HS400 / HS400_ES speed modes.
+    allOf:
+      - $ref: "/schemas/types.yaml#/definitions/uint32"
+      - minimum: 0
+      - maximum: 0x7f
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+examples:
+  - |
+    emmc: sdhci@5a000000 {
+        compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
+        reg = <0x5a000000 0x400>;
+        interrupts = <0 78 4>;
+        clocks = <&clk 4>;
+        bus-width = <8>;
+        mmc-ddr-1_8v;
+        mmc-hs200-1_8v;
+        mmc-hs400-1_8v;
+        cdns,phy-dll-delay-sdclk = <0>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt b/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
deleted file mode 100644
index fa423c277853..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-cadence.txt
+++ /dev/null
@@ -1,80 +0,0 @@
-* Cadence SD/SDIO/eMMC Host Controller
-
-Required properties:
-- compatible: should be one of the following:
-    "cdns,sd4hc"               - default of the IP
-    "socionext,uniphier-sd4hc" - for Socionext UniPhier SoCs
-- reg: offset and length of the register set for the device.
-- interrupts: a single interrupt specifier.
-- clocks: phandle to the input clock.
-
-Optional properties:
-For eMMC configuration, supported speed modes are not indicated by the SDHCI
-Capabilities Register.  Instead, the following properties should be specified
-if supported.  See mmc.txt for details.
-- mmc-ddr-1_8v
-- mmc-ddr-1_2v
-- mmc-hs200-1_8v
-- mmc-hs200-1_2v
-- mmc-hs400-1_8v
-- mmc-hs400-1_2v
-
-Some PHY delays can be configured by following properties.
-PHY DLL input delays:
-They are used to delay the data valid window, and align the window
-to sampling clock. The delay starts from 5ns (for delay parameter equal to 0)
-and it is increased by 2.5ns in each step.
-- cdns,phy-input-delay-sd-highspeed:
-  Value of the delay in the input path for SD high-speed timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-legacy:
-  Value of the delay in the input path for legacy timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-sd-uhs-sdr12:
-  Value of the delay in the input path for SD UHS SDR12 timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-sd-uhs-sdr25:
-  Value of the delay in the input path for SD UHS SDR25 timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-sd-uhs-sdr50:
-  Value of the delay in the input path for SD UHS SDR50 timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-sd-uhs-ddr50:
-  Value of the delay in the input path for SD UHS DDR50 timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-mmc-highspeed:
-  Value of the delay in the input path for MMC high-speed timing
-  Valid range = [0:0x1F].
-- cdns,phy-input-delay-mmc-ddr:
-  Value of the delay in the input path for eMMC high-speed DDR timing
-  Valid range = [0:0x1F].
-
-PHY DLL clock delays:
-Each delay property represents the fraction of the clock period.
-The approximate delay value will be
-(<delay property value>/128)*sdmclk_clock_period.
-- cdns,phy-dll-delay-sdclk:
-  Value of the delay introduced on the sdclk output
-  for all modes except HS200, HS400 and HS400_ES.
-  Valid range = [0:0x7F].
-- cdns,phy-dll-delay-sdclk-hsmmc:
-  Value of the delay introduced on the sdclk output
-  for HS200, HS400 and HS400_ES speed modes.
-  Valid range = [0:0x7F].
-- cdns,phy-dll-delay-strobe:
-  Value of the delay introduced on the dat_strobe input
-  used in HS400 / HS400_ES speed modes.
-  Valid range = [0:0x7F].
-
-Example:
-	emmc: sdhci@5a000000 {
-		compatible = "socionext,uniphier-sd4hc", "cdns,sd4hc";
-		reg = <0x5a000000 0x400>;
-		interrupts = <0 78 4>;
-		clocks = <&clk 4>;
-		bus-width = <8>;
-		mmc-ddr-1_8v;
-		mmc-hs200-1_8v;
-		mmc-hs400-1_8v;
-		cdns,phy-dll-delay-sdclk = <0>;
-	};
-- 
2.17.1

