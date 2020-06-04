Return-Path: <SRS0=N8Xy=7R=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6BBBC433E3
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 01:52:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC037207D8
	for <linux-mmc@archiver.kernel.org>; Thu,  4 Jun 2020 01:52:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgFDBwC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:52:02 -0400
Received: from inva021.nxp.com ([92.121.34.21]:35584 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbgFDBwB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Jun 2020 21:52:01 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1C100200F09;
        Thu,  4 Jun 2020 03:51:59 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 39045200130;
        Thu,  4 Jun 2020 03:51:54 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id DD49D402AD;
        Thu,  4 Jun 2020 09:51:47 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     ulf.hansson@linaro.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        mpa@pengutronix.de, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 2/3] dt-bindings: mmc: Convert imx mmc to json-schema
Date:   Thu,  4 Jun 2020 09:41:25 +0800
Message-Id: <1591234886-15351-3-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591234886-15351-1-git-send-email-Anson.Huang@nxp.com>
References: <1591234886-15351-1-git-send-email-Anson.Huang@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Convert the i.MX MMC binding to DT schema format using json-schema

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- add "unevaluatedProperties: false".
---
 .../devicetree/bindings/mmc/fsl-imx-mmc.txt        | 23 ----------
 .../devicetree/bindings/mmc/fsl-imx-mmc.yaml       | 53 ++++++++++++++++++++++
 2 files changed, 53 insertions(+), 23 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
 create mode 100644 Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
deleted file mode 100644
index 184ccff..0000000
--- a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.txt
+++ /dev/null
@@ -1,23 +0,0 @@
-* Freescale Secure Digital Host Controller for i.MX2/3 series
-
-This file documents differences to the properties defined in mmc.txt.
-
-Required properties:
-- compatible : Should be "fsl,<chip>-mmc", chip can be imx21 or imx31
-
-Optional properties:
-- dmas: One DMA phandle with arguments as defined by the devicetree bindings
-	of the used DMA controller.
-- dma-names: Has to be "rx-tx".
-
-Example:
-
-sdhci1: sdhci@10014000 {
-	compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
-	reg = <0x10014000 0x1000>;
-	interrupts = <11>;
-	dmas = <&dma 7>;
-	dma-names = "rx-tx";
-	bus-width = <4>;
-	cd-gpios = <&gpio3 29>;
-};
diff --git a/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
new file mode 100644
index 0000000..ffa1627
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/fsl-imx-mmc.yaml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/fsl-imx-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale Secure Digital Host Controller for i.MX2/3 series
+
+maintainers:
+  - Markus Pargmann <mpa@pengutronix.de>
+
+allOf:
+  - $ref: "mmc-controller.yaml"
+
+properties:
+  compatible:
+    oneOf:
+      - const: fsl,imx21-mmc
+      - const: fsl,imx31-mmc
+      - items:
+          - const: fsl,imx27-mmc
+          - const: fsl,imx21-mmc
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rx-tx
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    mmc@10014000 {
+        compatible = "fsl,imx27-mmc", "fsl,imx21-mmc";
+        reg = <0x10014000 0x1000>;
+        interrupts = <11>;
+        dmas = <&dma 7>;
+        dma-names = "rx-tx";
+        bus-width = <4>;
+        cd-gpios = <&gpio3 29>;
+    };
-- 
2.7.4

