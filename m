Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EFFCC433E4
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 18:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7281361994
	for <linux-mmc@archiver.kernel.org>; Mon, 22 Mar 2021 18:59:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232302AbhCVS7d (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 22 Mar 2021 14:59:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:40100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231802AbhCVS7X (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 22 Mar 2021 14:59:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF46E6199F;
        Mon, 22 Mar 2021 18:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616439562;
        bh=y1ZkXj1p9qb2LpsafIaIzi+n5YFdfgSKB2+GzEoekEI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGZp0km82YYtIIZJ1y3Eqz/ipHYqARAf4K34McixWHy3ntDWvuqi29tI6ScpjeRL5
         emytAe/owDssH0WhKUJa4RNP9uxv0P1KQl96j+GpZTbudc6i8hP4fMuzR0oAaAPY+K
         BpnsNRcKu+g5QC6YrzFSZNQY4ffg5EMRdsxVTvkbxT80XAM/89yOb0Qpwt7LDO/Swo
         d3EuzOmDOSmcThb78/R1mi29tTAXxf77izAoVF4BlNvgxFCY7/BAFHbwYZNdxL2ECz
         FZgs0wollp1HKmNUi71ETvdJ6yZRJg3cymEwo9tidjvlEJmQiI0uDxYMxDFdzzZH96
         tHBbtwFWGh30A==
From:   Nicolas Saenz Julienne <nsaenz@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Saenz Julienne <nsaenz@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>
Cc:     f.fainelli@gmail.com, phil@raspberrypi.com,
        tim.gover@raspberrypi.com, adrian.hunter@intel.com,
        alcooperx@gmail.com, nsaenzjulienne@suse.de,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH 1/4] dt-bindings: mmc: iproc-sdhci: Convert to json-schema
Date:   Mon, 22 Mar 2021 19:58:14 +0100
Message-Id: <20210322185816.27582-2-nsaenz@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210322185816.27582-1-nsaenz@kernel.org>
References: <20210322185816.27582-1-nsaenz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the brcm,iproc-sdhci binding to DT schema format using json-schema

Signed-off-by: Nicolas Saenz Julienne <nsaenz@kernel.org>
---
 .../bindings/mmc/brcm,iproc-sdhci.yaml        | 58 +++++++++++++++++++
 .../bindings/mmc/brcm,sdhci-iproc.txt         | 37 ------------
 2 files changed, 58 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
 delete mode 100644 Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt

diff --git a/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
new file mode 100644
index 000000000000..19d84f3ef9e6
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/brcm,iproc-sdhci.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/brcm,iproc-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom IPROC SDHCI controller
+
+maintainers:
+  - Nicolas Saenz Julienne <nsaenz@kernel.org>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - brcm,bcm2835-sdhci
+      - brcm,bcm2711-emmc2
+      - brcm,sdhci-iproc-cygnus
+      - brcm,sdhci-iproc
+
+  reg:
+    minItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description:
+      Handle to core clock for the sdhci controller.
+
+  sdhci,auto-cmd12:
+    type: boolean
+    description: Specifies that controller should use auto CMD12
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sdhci0: sdhci@18041000 {
+      compatible = "brcm,sdhci-iproc-cygnus";
+      reg = <0x18041000 0x100>;
+      interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
+      bus-width = <4>;
+      sdhci,auto-cmd12;
+      no-1-8-v;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt b/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
deleted file mode 100644
index 09d87cc1182a..000000000000
--- a/Documentation/devicetree/bindings/mmc/brcm,sdhci-iproc.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-Broadcom IPROC SDHCI controller
-
-This file documents differences between the core properties described
-by mmc.txt and the properties that represent the IPROC SDHCI controller.
-
-Required properties:
-- compatible : Should be one of the following
-	       "brcm,bcm2835-sdhci"
-	       "brcm,bcm2711-emmc2"
-	       "brcm,sdhci-iproc-cygnus"
-	       "brcm,sdhci-iproc"
-
-Use brcm2835-sdhci for the eMMC controller on the BCM2835 (Raspberry Pi) and
-bcm2711-emmc2 for the additional eMMC2 controller on BCM2711.
-
-Use sdhci-iproc-cygnus for Broadcom SDHCI Controllers
-restricted to 32bit host accesses to SDHCI registers.
-
-Use sdhci-iproc for Broadcom SDHCI Controllers that allow standard
-8, 16, 32-bit host access to SDHCI register.
-
-- clocks : The clock feeding the SDHCI controller.
-
-Optional properties:
-  - sdhci,auto-cmd12: specifies that controller should use auto CMD12.
-
-Example:
-
-sdhci0: sdhci@18041000 {
-	compatible = "brcm,sdhci-iproc-cygnus";
-	reg = <0x18041000 0x100>;
-	interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>;
-	clocks = <&lcpll0_clks BCM_CYGNUS_LCPLL0_SDIO_CLK>;
-	bus-width = <4>;
-	sdhci,auto-cmd12;
-	no-1-8-v;
-};
-- 
2.30.2

