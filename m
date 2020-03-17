Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6A2BC5ACD6
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B28A120738
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726890AbgCQJk2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:40:28 -0400
Received: from v6.sk ([167.172.42.174]:50380 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbgCQJk1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 05:40:27 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 00A2C6108D;
        Tue, 17 Mar 2020 09:40:25 +0000 (UTC)
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
Subject: [PATCH 13/28] dt-bindings: serial: move Marvell compatible string to 8250 binding doc
Date:   Tue, 17 Mar 2020 10:39:07 +0100
Message-Id: <20200317093922.20785-14-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

These ports are compatible with NS8250 and handled by the same driver.
Get rid of the extra document that fails to document the properties that
are actually supported.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/serial/8250.txt        | 2 ++
 Documentation/devicetree/bindings/serial/mrvl-serial.txt | 4 ----
 2 files changed, 2 insertions(+), 4 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/serial/mrvl-serial.txt

diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
index 55700f20f6ee8..a543702859e2f 100644
--- a/Documentation/devicetree/bindings/serial/8250.txt
+++ b/Documentation/devicetree/bindings/serial/8250.txt
@@ -26,6 +26,8 @@ Required properties:
 	- "aspeed,ast2400-vuart"
 	- "aspeed,ast2500-vuart"
 	- "nuvoton,npcm750-uart"
+	- "mrvl,mmp-uart"
+	- "mrvl,pxa-uart"
 	- "serial" if the port type is unknown.
 - reg : offset and length of the register set for the device.
 - interrupts : should contain uart interrupt.
diff --git a/Documentation/devicetree/bindings/serial/mrvl-serial.txt b/Documentation/devicetree/bindings/serial/mrvl-serial.txt
deleted file mode 100644
index d744340de887c..0000000000000
--- a/Documentation/devicetree/bindings/serial/mrvl-serial.txt
+++ /dev/null
@@ -1,4 +0,0 @@
-PXA UART controller
-
-Required properties:
-- compatible : should be "mrvl,mmp-uart" or "mrvl,pxa-uart".
-- 
2.25.1

