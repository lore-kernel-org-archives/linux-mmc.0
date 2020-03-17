Return-Path: <SRS0=U+Jx=5C=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0BD8C4CECE
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3BEF20736
	for <linux-mmc@archiver.kernel.org>; Tue, 17 Mar 2020 09:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbgCQJkp (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 17 Mar 2020 05:40:45 -0400
Received: from v6.sk ([167.172.42.174]:50518 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727016AbgCQJkn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Tue, 17 Mar 2020 05:40:43 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 7531A61091;
        Tue, 17 Mar 2020 09:40:41 +0000 (UTC)
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
Subject: [PATCH 17/28] dt-bindings: mmc: Fix up clk-phase-sd-hs in an example
Date:   Tue, 17 Mar 2020 10:39:11 +0100
Message-Id: <20200317093922.20785-18-lkundrak@v3.sk>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200317093922.20785-1-lkundrak@v3.sk>
References: <20200317093922.20785-1-lkundrak@v3.sk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

This way the validator can know that the two cells constitute a singlej
pair of clock phase degrees value, not separate items Otherwise it is
unhappy:

  mmc-controller.example.dt.yaml: mmc@ab000000: clk-phase-sd-hs:0:
      [63] is too short
  mmc-controller.example.dt.yaml: mmc@ab000000: clk-phase-sd-hs:1:
      [72] is too short

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
---
 Documentation/devicetree/bindings/mmc/mmc-controller.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
index 8fded83c519ad..c9384ed685b8f 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-controller.yaml
@@ -363,7 +363,7 @@ examples:
         keep-power-in-suspend;
         wakeup-source;
         mmc-pwrseq = <&sdhci0_pwrseq>;
-        clk-phase-sd-hs = <63>, <72>;
+        clk-phase-sd-hs = <63 72>;
     };
 
   - |
-- 
2.25.1

