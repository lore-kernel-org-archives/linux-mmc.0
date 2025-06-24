Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4F5279DCF;
	Tue, 24 Jun 2025 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750766315; cv=none; b=HZgD3BxIUUuBgy1WWi4MA2hZn87JZ+x4g+yc2L75bEhd8fpEta/BkO8VUIn5T6ZNxB3dPol26XXbY5JGT/OqVgR9Fw7lZV37P9xPotnv3oTljabC6Cay1ZNvOFGTDIct751vJ3+w1gzAFXp2/3ryFiZfVGbCuiQAJl3McholbT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750766315; c=relaxed/simple;
	bh=Ub+cz3yiy3gHtq6XGbvDj1ErurX1K2PN+ayXuh4U6I0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQTBCq1mb1aWUirb4P4PT3LvpYf/rWKJx95OCAEFc6wRtHhpy+l9+e8H7ACoVKFKduqD1YIogFCShnPCWAwlUkM/eIFJatEM/Ha+DBmqC/iCji9EhZNGeIkHp9YHGJAUfKL7h1rHkWtFcR7A4bjSuf2atsONo2aBeSNNm5lPMk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.149])
	by gateway (Coremail) with SMTP id _____8CxbWvmklpoOjocAQ--.63094S3;
	Tue, 24 Jun 2025 19:58:30 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.149])
	by front1 (Coremail) with SMTP id qMiowMDxu8TcklpohsAoAQ--.53899S3;
	Tue, 24 Jun 2025 19:58:28 +0800 (CST)
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
	Binbin Zhou <zhoubinbin@loongson.cn>
Subject: [PATCH v4 1/4] dt-bindings: mmc: Add Loongson-2K SD/SDIO/eMMC controller binding
Date: Tue, 24 Jun 2025 19:58:10 +0800
Message-ID: <949c55be120a806ea3d74b47fa2cc96ced2905fc.1750765495.git.zhoubinbin@loongson.cn>
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
X-CM-TRANSID:qMiowMDxu8TcklpohsAoAQ--.53899S3
X-CM-SenderInfo: p2kr3uplqex0o6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxGw1UAr13uF4DWFyfAw4kXwc_yoW5Ary3pa
	nrCr9rGr40qF13Zws3Ka48Cw1rX3s7CrnrXFsrJw17Gas8Wa4Yqw1akFyrZa43CrW2qFW7
	ZFyFkr45Ca47ArcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB0b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	GcCE3s1ln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2
	x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5
	McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_
	Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67
	AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8I
	cVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI
	8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v2
	6r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUxhiSDUUUU

Add the Loongson-2K SoC's SD/SDIO/eMMC controller binding with DT schema
format using json-schema.

Signed-off-by: Binbin Zhou <zhoubinbin@loongson.cn>
---
 .../bindings/mmc/loongson,ls2k0500-mmc.yaml   | 69 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 75 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml

diff --git a/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml b/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
new file mode 100644
index 000000000000..f2f10b2c618c
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/loongson,ls2k0500-mmc.yaml#
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
index a92290fffa16..2d1cdd2cfc2b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14175,6 +14175,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/hwinfo/loongson,ls2k-chipid.yaml
 F:	drivers/soc/loongson/loongson2_guts.c
 
+LOONGSON-2 SOC SERIES MMC/SD/SDIO CONTROLLER DRIVER
+M:	Binbin Zhou <zhoubinbin@loongson.cn>
+L:	linux-mmc@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mmc/loongson,ls2k0500-mmc.yaml
+
 LOONGSON-2 SOC SERIES PM DRIVER
 M:	Yinbo Zhu <zhuyinbo@loongson.cn>
 L:	linux-pm@vger.kernel.org
-- 
2.47.1

