Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D004C433B4
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 01:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D30F2613BC
	for <linux-mmc@archiver.kernel.org>; Mon,  3 May 2021 01:43:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhECBov (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 2 May 2021 21:44:51 -0400
Received: from twspam01.aspeedtech.com ([211.20.114.71]:29492 "EHLO
        twspam01.aspeedtech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230368AbhECBov (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 2 May 2021 21:44:51 -0400
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 1431WAMe085691;
        Mon, 3 May 2021 09:32:10 +0800 (GMT-8)
        (envelope-from steven_lee@aspeedtech.com)
Received: from localhost.localdomain (192.168.100.253) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 09:43:46 +0800
From:   Steven Lee <steven_lee@aspeedtech.com>
To:     Andrew Jeffery <andrew@aj.id.au>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Ryan Chen <ryanchen.aspeed@gmail.com>,
        "moderated list:ASPEED SD/MMC DRIVER" <linux-aspeed@lists.ozlabs.org>,
        "moderated list:ASPEED SD/MMC DRIVER" <openbmc@lists.ozlabs.org>,
        "open list:ASPEED SD/MMC DRIVER" <linux-mmc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <Hongweiz@ami.com>, <ryan_chen@aspeedtech.com>,
        <chin-ting_kuo@aspeedtech.com>
Subject: [PATCH v2 1/3] dt-bindings: mmc: sdhci-of-aspeed: Add description for AST2600 EVB.
Date:   Mon, 3 May 2021 09:43:34 +0800
Message-ID: <20210503014336.20256-2-steven_lee@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210503014336.20256-1-steven_lee@aspeedtech.com>
References: <20210503014336.20256-1-steven_lee@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.100.253]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 1431WAMe085691
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Add the description for describing the AST 2600 EVB reference design of
GPIO regulators and provide the example in the document.

AST2600-A2 EVB has the reference design for enabling SD bus
power and toggling SD bus signal voltage by GPIO pins.

In the reference design, GPIOV0 of AST2600-A2 EVB is connected to
power load switch that providing 3.3v to SD1 bus vdd. GPIOV1 is
connected to a 1.8v and a 3.3v power load switch that providing
signal voltage to
SD1 bus.

If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
disabled.
If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
signal voltage is 3.3v. Otherwise, 1.8v power load switch will be
enabled, SD1 signal voltage becomes 1.8v.

AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and
GPIOV3 as power-switch-gpio.

Signed-off-by: Steven Lee <steven_lee@aspeedtech.com>
---
 .../devicetree/bindings/mmc/aspeed,sdhci.yaml | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index 987b287f3bff..dd894aba0bb7 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -20,6 +20,19 @@ description: |+
   the slots are dependent on the common configuration area, they are described
   as child nodes.
 
+  The signal voltage of SDHCIs on AST2600-A2 EVB is able to be toggled by GPIO
+  pins. In the reference design, GPIOV0 of AST2600-A2 EVB is connected to the
+  power load switch that providing 3.3v to SD1 bus vdd, GPIOV1 is connected to
+  a 1.8v and a 3.3v power load switch that providing signal voltage to
+  SD1 bus.
+  If GPIOV0 is active high, SD1 bus is enabled. Otherwise, SD1 bus is
+  disabled. If GPIOV1 is active high, 3.3v power load switch is enabled, SD1
+  signal voltage is 3.3v. Otherwise, 1.8v power load switch will be enabled, SD1
+  signal voltage becomes 1.8v.
+  AST2600-A2 EVB also support toggling signal voltage for SD2 bus.
+  The design is the same as SD1 bus. It uses GPIOV2 as power-gpio and GPIOV3
+  as power-switch-gpio.
+
 properties:
   compatible:
     enum:
@@ -78,6 +91,7 @@ required:
   - clocks
 
 examples:
+  //Example 1
   - |
     #include <dt-bindings/clock/aspeed-clock.h>
     sdc@1e740000 {
@@ -104,3 +118,88 @@ examples:
                     clocks = <&syscon ASPEED_CLK_SDIO>;
             };
     };
+
+  //Example 2 (AST2600EVB with GPIO regulator)
+  - |
+    #include <dt-bindings/clock/aspeed-clock.h>
+    #include <dt-bindings/gpio/aspeed-gpio.h>
+    vcc_sdhci0: regulator-vcc-sdhci0 {
+            compatible = "regulator-fixed";
+
+            regulator-name = "SDHCI0 Vcc";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            gpios = <&gpio0 ASPEED_GPIO(V, 0)
+                            GPIO_ACTIVE_HIGH>;
+            enable-active-high;
+    };
+
+    vccq_sdhci0: regulator-vccq-sdhci0 {
+            compatible = "regulator-gpio";
+
+            regulator-name = "SDHCI0 VccQ";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3300000>;
+            gpios = <&gpio0 ASPEED_GPIO(V, 1)
+                            GPIO_ACTIVE_HIGH>;
+            gpios-states = <1>;
+            states = <3300000 1
+                      1800000 0>;
+    };
+
+    vcc_sdhci1: regulator-vcc-sdhci1 {
+            compatible = "regulator-fixed";
+
+            regulator-name = "SDHCI1 Vcc";
+            regulator-min-microvolt = <3300000>;
+            regulator-max-microvolt = <3300000>;
+            gpios = <&gpio0 ASPEED_GPIO(V, 2)
+                            GPIO_ACTIVE_HIGH>;
+            enable-active-high;
+    };
+
+    vccq_sdhci1: regulator-vccq-sdhci1 {
+            compatible = "regulator-gpio";
+
+            regulator-name = "SDHCI1 VccQ";
+            regulator-min-microvolt = <1800000>;
+            regulator-max-microvolt = <3300000>;
+            gpios = <&gpio0 ASPEED_GPIO(V, 3)
+                            GPIO_ACTIVE_HIGH>;
+            gpios-states = <1>;
+            states = <3300000 1
+                      1800000 0>;
+    };
+
+    sdc@1e740000 {
+            compatible = "aspeed,ast2600-sd-controller";
+            reg = <0x1e740000 0x100>;
+            #address-cells = <1>;
+            #size-cells = <1>;
+            ranges = <0 0x1e740000 0x20000>;
+            clocks = <&syscon ASPEED_CLK_GATE_SDCLK>;
+
+            sdhci0: sdhci@100 {
+                    compatible = "aspeed,ast2600-sdhci", "sdhci";
+                    reg = <0x100 0x100>;
+                    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+                    sdhci,auto-cmd12;
+                    clocks = <&syscon ASPEED_CLK_SDIO>;
+                    vmmc-supply = <&vcc_sdhci0>;
+                    vqmmc-supply = <&vccq_sdhci0>;
+                    sd-uhs-sdr104;
+                    clk-phase-uhs-sdr104 = <180>, <180>;
+            };
+
+            sdhci1: sdhci@200 {
+                    compatible = "aspeed,ast2600-sdhci", "sdhci";
+                    reg = <0x200 0x100>;
+                    interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+                    sdhci,auto-cmd12;
+                    clocks = <&syscon ASPEED_CLK_SDIO>;
+                    vmmc-supply = <&vcc_sdhci1>;
+                    vqmmc-supply = <&vccq_sdhci1>;
+                    sd-uhs-sdr104;
+                    clk-phase-uhs-sdr104 = <0>, <0>;
+            };
+    };
-- 
2.17.1

