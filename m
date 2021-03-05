Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41A4FC433DB
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 02:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E648F6500D
	for <linux-mmc@archiver.kernel.org>; Fri,  5 Mar 2021 02:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhCECCD (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 4 Mar 2021 21:02:03 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:50742 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbhCECCD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 4 Mar 2021 21:02:03 -0500
X-Greylist: delayed 429 seconds by postgrey-1.27 at vger.kernel.org; Thu, 04 Mar 2021 21:02:02 EST
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 714A2C7879;
        Fri,  5 Mar 2021 09:54:41 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P19729T140184970585856S1614909278778031_;
        Fri, 05 Mar 2021 09:54:41 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <a791826a7deeea1e23b63ecb992322a0>
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
Subject: [PATCH v2 2/3] dt-bindings: mmc: sdhci-of-dwcmhsc: Add rockchip support
Date:   Fri,  5 Mar 2021 09:54:21 +0800
Message-Id: <1614909262-205658-2-git-send-email-shawn.lin@rock-chips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1614909262-205658-1-git-send-email-shawn.lin@rock-chips.com>
References: <1614909262-205658-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This patch adds rockchip support in sdhci-of-dwcmhsc.yaml

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 .../devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml  | 26 ++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
index 9d717a8..efec5d5 100755
--- a/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-of-dwcmshc.yaml
@@ -16,6 +16,7 @@ allOf:
 properties:
   compatible:
     enum:
+      - rockchip,dwcmshc-sdhci
       - snps,dwcmshc-sdhci
 
   reg:
@@ -27,16 +28,26 @@ properties:
 
   clocks:
     minItems: 1
-    maxItems: 2
+    maxItems: 5
     description:
       Handle to "core" for core clock and "bus" for optional bus clock.
+      "axi", "block" and "timer" are for Rockchip specified which aims for
+      DMA, pipe and internal timer respectively.
 
   clock-names:
     minItems: 1
-    maxItems: 2
+    maxItems: 5
     items:
       - const: core
       - const: bus
+      - const: axi
+      - const: block
+      - const: timer
+
+  rockchip,txclk-tapnum:
+    description: Specify the number of delay for tx sampling.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 
 required:
   - compatible
@@ -49,6 +60,17 @@ unevaluatedProperties: false
 
 examples:
   - |
+    mmc@fe310000 {
+      compatible = "rockchip,dwcmshc-sdhci";
+      reg = <0xfe310000 0x10000>;
+      interrupts = <0 25 0x4>;
+      clocks = <&cru 17>, <&cru 18>, <&cru 19>, <&cru 20>, <&cru 21>;
+      clock-names = "core", "bus", "axi", "block", "timer";
+      bus-width = <8>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+    };
+  - |
     mmc@aa0000 {
       compatible = "snps,dwcmshc-sdhci";
       reg = <0xaa000 0x1000>;
-- 
2.7.4



