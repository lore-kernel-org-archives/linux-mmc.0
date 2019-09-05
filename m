From: Zhou Yanjie <zhouyanjie@zoho.com>
Subject: [PATCH 3/4] dt-bindings: MMC: Add JZ4760 bindings.
Date: Thu,  5 Sep 2019 15:38:08 +0800
Message-ID: <1567669089-88693-4-git-send-email-zhouyanjie@zoho.com>
References: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1567669089-88693-1-git-send-email-zhouyanjie@zoho.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mips@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, ulf.hansson@linaro.org, paul.burton@mips.com, linus.walleij@linaro.org, paul@crapouillou.net, malat@debian.org, yuehaibing@huawei.com, ezequiel@collabora.com, robh+dt@kernel.org, mark.rutland@arm.com, syq@debian.org, jiaxun.yang@flygoat.com
List-Id: linux-mmc@vger.kernel.org

Add the MMC bindings for the JZ4760 Soc from Ingenic.

Signed-off-by: Zhou Yanjie <zhouyanjie@zoho.com>
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
