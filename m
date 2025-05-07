Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A4CE21E08D;
	Wed,  7 May 2025 07:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746602921; cv=none; b=dre7yGQhkhMgFZ6amKWXDE4oA0f2oh2hCqWBpCRvHX5uO9vdh7a0AF9K7tf7EBzQ5dcHQBrsx0UpIJd84oMizkOD+30s5GSgnAUFRRYXJ3FIveETNtCx6XCGHvOK+D+NUMkaP17vTEwPU65VUliqdHtqX6W/hphOStpZckPVXa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746602921; c=relaxed/simple;
	bh=ZYcHEvsZ4alD4Na2eMIoagFBXy6exmLOQcnHJ6cmnyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BBanWt/IZsNGvhhMydJnYpFf5HJzmE/V9tfsTqfpQ4XnIdatvXMPznDloeYJSAOa2GFuhlwPutjlkARdmqQX8elVr/HFCrzCswiH6rKrvB6UIH9UvieV9+PNkiOWAYxkRciZJxee8R71wWupa+SG7EZns9yqBaeWNLqcBeLQBYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.186])
	by gateway (Coremail) with SMTP id _____8AxWXGcCxtoE+HXAA--.26708S3;
	Wed, 07 May 2025 15:28:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.186])
	by front1 (Coremail) with SMTP id qMiowMBxn8WVCxtoGna5AA--.12969S3;
	Wed, 07 May 2025 15:28:26 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v2 1/4] dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC controller binding
Date: Wed,  7 May 2025 15:28:05 +0800
Message-ID: <9b5a416143d5d5da7084f3a868cf01e6827cd653.1746581751.git.zhoubinbin@loongson.cn>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1746581751.git.zhoubinbin@loongson.cn>
References: <cover.1746581751.git.zhoubinbin@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMBxn8WVCxtoGna5AA--.12969S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGFWkCr1xGF4DKr1kAr1UJwc_yoW5Ww4Dpa
	nrCrn7Gr40vF13Zws3Ka48Cw1rZ3s7CFsrXFsrJw17GasxW3WYqw1akF95Zay3CrWjqFW7
	ZF9akr4UCa47ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYI
	kI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
	8JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j
	6r4UMxCIbckI1I0E14v26r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8EoGPUUUUU==

Add the Loongson-2K SoC's SD/SDIO/eMMC controller binding with DT schema
format using json-schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../bindings/mmc/loongson,ls2k-mmc.yaml       | 69 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml b/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
new file mode 100644
index 000000000000..97a0853399f1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/loongson,ls2k-mmc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: The SD/SDIO/eMMC host controller for Loongson-2K family SoCs
+
+description:
+  The MMC host controller on the Loongson-2K0500/2K1000 (using an externally
+  shared apbdma controller) provides the SD and SDIO device interfaces.
+
+maintainers:
+  - Binbin Zhou <zhoubinbin@loongson.cn>
+
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - loongson,ls2k0500-mmc
+      - loongson,ls2k1000-mmc
+
+  reg:
+    items:
+      - description: Loongson-2K MMC controller registers.
+      - description: APB DMA config register for Loongson-2K MMC controller.
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
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
+  - clocks
+  - dmas
+  - dma-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/loongson,ls2k-clk.h>
+
+    mmc@1fe2c000 {
+        compatible = "loongson,ls2k1000-mmc";
+        reg = <0x1fe2c000 0x68>,
+              <0x1fe00438 0x8>;
+        interrupt-parent = <&liointc0>;
+        interrupts = <31 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk LOONGSON2_APB_CLK>;
+        dmas = <&apbdma1 0>;
+        dma-names = "rx-tx";
+        bus-width = <4>;
+        cd-gpios = <&gpio0 22 GPIO_ACTIVE_LOW>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 96b827049501..5bf74aa63299 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13935,6 +13935,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
 F:	drivers/soc/loongson/loongson2_guts.c
 
+LOONGSON-2 SOC SERIES MMC/SD/SDIO CONTROLLER DRIVER
+M:	Binbin Zhou <zhoubinbin@loongson.cn>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/loongson,ls2k-mmc.yaml
+
 LOONGSON-2 SOC SERIES PM DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-pm@vger.kernel.org
-- 
2.47.1

