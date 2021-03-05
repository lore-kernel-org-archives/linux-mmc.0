Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17666C43381
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 01:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D498164E68
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 01:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbhCEByy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 20:54:54 -0500
Received: from lucky1.263xmail.com ([211.157.147.135]:34398 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229750AbhCEByy (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 20:54:54 -0500
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 7E4E4A7DBA;
        Fri,  5 Mar 2021 09:54:39 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19729T140184970585856S1614909278778031_;
        Fri, 05 Mar 2021 09:54:39 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <88c5651cd2d978ad78e325badf42c0b1>
X-RL-SENDER: shawn.lin@rock-chips.com
X-SENDER: lintao@rock-chips.com
X-LOGIN-NAME: shawn.lin@rock-chips.com
X-FST-TO: robh+dt@kernel.org
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-System-Flag: 0
From:   Shawn Lin <shawn.lin@rock-chips.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 1/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Convert to yaml file
Date:   Fri,  5 Mar 2021 09:54:20 +0800
Message-Id: <1614909262-205658-1-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch converts sdhci-of-dwcmshc.txt to sdhci-of-dwcmshc.yaml

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 .../devicetree/bindings/mmc/sdhci-of-dwcmshc.txt   | 20 -------
 .../devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml  | 63 ++++++++++++++++++++++
 2 files changed, 63 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
 create mode 100755 Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
deleted file mode 100644
index ee4253b..0000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* Synopsys DesignWare Cores Mobile Storage Host Controller
-
-Required properties:
-- compatible: should be one of the following:
-    "snps,dwcmshc-sdhci"
-- reg: offset and length of the register set for the device.
-- interrupts: a single interrupt specifier.
-- clocks: Array of clocks required for SDHCI; requires at least one for
-    core clock.
-- clock-names: Array of names corresponding to clocks property; shall be
-    "core" for core clock and "bus" for optional bus clock.
-
-Example:
-	sdhci2: sdhci@aa0000 {
-		compatible = "snps,dwcmshc-sdhci";
-		reg = <0xaa0000 0x1000>;
-		interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-		clocks = <&emmcclk>;
-		bus-width = <8>;
-	}
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
new file mode 100755
index 0000000..9d717a8
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: GPL-2.0-only
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/sdhci-of-dwcmshc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Synopsys Designware Mobile Storage Host Controller Binding
+
+maintainers:
+  - Ulf Hansson <ulf.hansson@linaro.org>
+  - Jisheng Zhang <Jisheng.Zhang@synaptics.com>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - snps,dwcmshc-sdhci
+
+  reg:
+    minItems: 1
+    maxItems: 3
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 1
+    maxItems: 2
+    description:
+      Handle to "core" for core clock and "bus" for optional bus clock.
+
+  clock-names:
+    minItems: 1
+    maxItems: 2
+    items:
+      - const: core
+      - const: bus
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@aa0000 {
+      compatible = "snps,dwcmshc-sdhci";
+      reg = <0xaa000 0x1000>;
+      interrupts = <0 25 0x4>;
+      clocks = <&cru 17>, <&cru 18>;
+      clock-names = "core", "bus";
+      bus-width = <8>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+
+...
-- 
2.7.4



