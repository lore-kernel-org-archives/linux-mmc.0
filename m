Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6015C10F29
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 806A120738
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:41:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbgCQJk7 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:40:59 -0400
Received: from v6.sk ([167.172.42.174]:50636 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727092AbgCQJk4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 05:40:56 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 1B63C61095;
        Tue, 17 Mar 2020 09:40:54 +0000 (UTC)
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Brown <broonie@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-media@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-spi@vger.kernel.org, linux-usb@vger.kernel.org,
        Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 20/28] dt-bindings: phy: Convert phy-mmp3-usb to json-schema
Date:   Tue, 17 Mar 2020 10:39:14 +0100
Message-Id: <20200317093922.20785-21-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

A rather straightforward conversion of the phy-mmp3-usb binding to DT
schema format using json-schema.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 .../bindings/phy/marvell,mmp3-usb-phy.yaml    | 40 +++++++++++++++++++
 .../devicetree/bindings/phy/phy-mmp3-usb.txt  | 13 ------
 2 files changed, 40 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml
 delete mode 100644 Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt

diff --git a/Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml b/Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml
new file mode 100644
index 0000000000000..1307703d9b627
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/marvell,mmp3-usb-phy.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+# Copyright 2019,2020 Lubomir Rintel <lkundrak@v3.sk>
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/phy/marvell,mmp3-usb-phy.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Marvell MMP3 USB PHY bindings
+
+maintainers:
+  - Lubomir Rintel <lkundrak@v3.sk>
+
+properties:
+  $nodename:
+    pattern: '^usb-phy@[a-f0-9]+$'
+
+  compatible:
+    const: marvell,mmp3-usb-phy
+
+  reg:
+    maxItems: 1
+    description: base address of the device
+
+  '#phy-cells':
+    const: 0
+
+required:
+  - compatible
+  - reg
+  - '#phy-cells'
+
+examples:
+  - |
+    usb-phy@d4207000 {
+      compatible = "marvell,mmp3-usb-phy";
+      reg = <0xd4207000 0x40>;
+      #phy-cells = <0>;
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt b/Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
deleted file mode 100644
index 7183b9102f917..0000000000000
--- a/Documentation/devicetree/bindings/phy/phy-mmp3-usb.txt
+++ /dev/null
@@ -1,13 +0,0 @@
-Marvell MMP3 USB PHY
---------------------
-
-Required properties:
-- compatible: must be "marvell,mmp3-usb-phy"
-- #phy-cells: must be 0
-
-Example:
-	usb-phy: usb-phy@d4207000 {
-		compatible = "marvell,mmp3-usb-phy";
-		reg = <0xd4207000 0x40>;
-		#phy-cells = <0>;
-	};
-- 
2.25.1

