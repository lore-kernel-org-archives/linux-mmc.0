Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F5B25394B;
	Tue, 24 Jun 2025 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766316; cv=none; b=hjRi+UdExDiMA5ShwywY8yFPkP+WAUY8F3dtfhQcqq9V2ua90NnYLMFzp+WBfC0PAoCy47EThVNbatF4kndTpd97Q6L/h+yDhcLmD06dI0hYLzsyib2pLQQXVO8qi2BsjQ9cszn0stVMtqSredgL66Il5gJYYuq9eNS6sqnRuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766316; c=relaxed/simple;
	bh=6yyNlj5vw6z0l2dJcNP/J8vslBLojEUWd2Uc3VcDO7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e6zlXyT7Yubufn3NmO9ulO7f6/8Cl+mUxY+L8FvZj+/qve6tegWWZbnDiO62AcHLvGKxZSZH+bPLnNMSNcS2+tMvU6XpR6LoCmyP2l88fE+61jCG5KNZRQzau52c6rk2eE1Q//ZYrnuyDiw6e5igwRxPGnJwoGD2Sad3VJEMZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8BxJHDoklpoSTocAQ--.22419S3;
	Tue, 24 Jun 2025 19:58:32 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMDxu8TcklpohsAoAQ--.53899S5;
	Tue, 24 Jun 2025 19:58:32 +0800 (CST)
From: Binbin Zhou <zhoubinbin@loongson.cn>
To: Binbin Zhou <zhoubb.aaron@gmail.com>,
	Huacai Chen <chenhuacai@loongson.cn>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Huacai Chen <chenhuacai@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	loongarch@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	wanghongliang@loongson.cn,
	Binbin Zhou <zhoubinbin@loongson.cn>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 3/4] dt-bindings: mmc: loongson,ls2k0500-mmc: Add compatible for Loongson-2K2000
Date: Tue, 24 Jun 2025 19:58:12 +0800
Message-ID: <2274fcccd27d7c03bc026fd2a43727bdf5af1ef5.1750765495.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1750765495.git.zhoubinbin@loongson.cn>
References: <cover.1750765495.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDxu8TcklpohsAoAQ--.53899S5
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoW7WryrZr15uF17Zw13CF45Jwc_yoW5Jr4rpa
	9xCwsrGr40qF13urZ8Ca48Cw15ZrykC3ZrJFsrJw1UGwsxW3yYq343KFyFqay3CrWIqFW7
	Zry8Cw45uasrCrcCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0epB3UUUUU==

Add the devicetree compatible for Loongson-2K2000 EMMC/SD/SDIO controller.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../bindings/mmc/loongson,ls2k0500-mmc.yaml   | 47 ++++++++++++++++++-
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml b/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
index f2f10b2c618c..c142421bc723 100644
--- a/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
+++ b/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
@@ -9,6 +9,9 @@ title: The SD/SDIO/eMMC host controller for Loongson-2K family SoCs
 description:
   The MMC host controller on the Loongson-2K0500/2K1000 (using an externally
   shared apbdma controller) provides the SD and SDIO device interfaces.
+  The two MMC host controllers on the Loongson-2K2000 are similar,
+  except that they use internal exclusive DMA. one controller provides
+  the eMMC interface and the other provides the SD/SDIO interface.
 
 maintainers:
   - Binbin Zhou <zhoubinbin@loongson.cn>
@@ -21,8 +24,10 @@ properties:
     enum:
       - loongson,ls2k0500-mmc
       - loongson,ls2k1000-mmc
+      - loongson,ls2k2000-mmc
 
   reg:
+    minItems: 1
     items:
       - description: Loongson-2K MMC controller registers.
       - description: APB DMA config register for Loongson-2K MMC controller.
@@ -44,11 +49,31 @@ required:
   - reg
   - interrupts
   - clocks
-  - dmas
-  - dma-names
 
 unevaluatedProperties: false
 
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - loongson,ls2k0500-mmc
+          - loongson,ls2k1000-mmc
+
+then:
+  properties:
+    reg:
+      minItems: 2
+
+  required:
+    - dmas
+    - dma-names
+
+else:
+  properties:
+    reg:
+      maxItems: 1
+
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
@@ -67,3 +92,21 @@ examples:
         bus-width = <4>;
         cd-gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
     };
+
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+
+    mmc@79990000 {
+        compatible = "loongson,ls2k2000-mmc";
+        reg = <0x79990000 0x1000>;
+        interrupt-parent = <&pic>;
+        interrupts = <51 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk LOONGSON2_EMMC_CLK>;
+        bus-width = <8>;
+        non-removable;
+        cap-mmc-highspeed;
+        mmc-hs200-1_8v;
+        no-sd;
+        no-sdio;
+    };
-- 
2.47.1

