From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH 2/6 v2] dt-bindings: MMC: Add JZ4760 bindings.
Date: Sat, 12 Oct 2019 13:13:16 +0800
Message-ID: <1570857203-49192-3-git-send-email-zhouyanjie@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
 <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1570857203-49192-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, paul.burton@mips.com, mark.rutland@arm.com, syq@debian.org, ulf.hansson@linaro.org, linus.walleij@linaro.org, armijn@tjaldur.nl, tglx@linutronix.de, yuehaibing@huawei.com, malat@debian.org, ezequiel@collabora.com, paul@crapouillou.net
List-Id: linux-mmc@vger.kernel.org

Add the MMC bindings for the JZ4760 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/mmc/jz4740.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/jz4740.txt b/Documentation/devicetree/bindings/mmc/jz4740.txt
index 8a6f87f..13796fe 100644
--- a/Documentation/devicetree/bindings/mmc/jz4740.txt
+++ b/Documentation/devicetree/bindings/mmc/jz4740.txt
@@ -8,6 +8,7 @@ Required properties:
 - compatible: Should be one of the following:
   - "ingenic,jz4740-mmc" for the JZ4740
   - "ingenic,jz4725b-mmc" for the JZ4725B
+  - "ingenic,jz4760-mmc" for the JZ4760
   - "ingenic,jz4780-mmc" for the JZ4780
 - reg: Should contain the MMC controller registers location and length.
 - interrupts: Should contain the interrupt specifier of the MMC controller.
-- 
2.7.4
