From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH 4/6 v2] dt-bindings: MMC: Add X1000 bindings.
Date: Sat, 12 Oct 2019 13:13:18 +0800
Message-ID: <1570857203-49192-5-git-send-email-zhouyanjie@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org, ulf.hansson@linaro.org, linus.walleij@linaro.org, armijn@tjaldur.nl, tglx@linutronix.de, yuehaibing@huawei.com, malat@debian.org, ezequiel@collabora.com, paul@crapouillou.net
List-Id: linux-mmc@vger.kernel.org

Add the MMC bindings for the X1000 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
---
 Documentation/devicetree/bindings/mmc/jz4740.txt | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/jz4740.txt b/Documentation/devicetree/bindings/mmc/jz4740.txt
index 13796fe..453d3b9 100644
--- a/Documentation/devicetree/bindings/mmc/jz4740.txt
+++ b/Documentation/devicetree/bindings/mmc/jz4740.txt
@@ -1,8 +1,8 @@
-* Ingenic JZ47xx MMC controllers
+* Ingenic XBurst MMC controllers
 
 This file documents the device tree properties used for the MMC controller in
-Ingenic JZ4740/JZ4780 SoCs. These are in addition to the core MMC properties
-described in mmc.txt.
+Ingenic JZ4740/JZ4760/JZ4780/X1000 SoCs. These are in addition to the core MMC
+properties described in mmc.txt.
 
 Required properties:
 - compatible: Should be one of the following:
@@ -10,6 +10,7 @@ Required properties:
   - "ingenic,jz4725b-mmc" for the JZ4725B
   - "ingenic,jz4760-mmc" for the JZ4760
   - "ingenic,jz4780-mmc" for the JZ4780
+  - "ingenic,x1000-mmc" for the X1000
 - reg: Should contain the MMC controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the MMC controller.
 - clocks: Clock for the MMC controller.
-- 
2.7.4
