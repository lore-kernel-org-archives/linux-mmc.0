Received: from mail-m21470.qiye.163.com (mail-m21470.qiye.163.com [117.135.214.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BA265CD0;
	Wed, 28 May 2025 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748422499; cv=none; b=nS8JWQ+dOjV8lGdZIsybhkuoA+aKO6PGQgMPCowusISBLDZyWK6ZkcPilXMPmXV2foSly+T68nKJXpTKd+0fR1Mt8kTr1XF/AXi+2aqH7FqNFEcg3C9RE236q/XcyjGNgON3bBp7eyVYLGn1Px7OQJhsjD9CcP6HgZSeJPr3gfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748422499; c=relaxed/simple;
	bh=6OrfkisRggUmUjJtD20gSVGc6+cKde6EW/sKfoA/v2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jG2KIKqlg0CT0L8eF3FvAefOD3ScUU6V1HYN8FhosipqAreLDVxcn8LMPO40UkDLiYiu9LxxLPtptN265ECIQfX7I3vCFX2PrKm0bIqB0ZMl5DYjfUtMlAwWqivXDAlMn/xK5RnIyuUqKhAjIPYiLxjH3IFW2VrKzi4/xRI9fBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=bAE0mei3; arc=none smtp.client-ip=117.135.214.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="bAE0mei3"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 16b15a60d;
	Wed, 28 May 2025 16:54:52 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ge Gordon <gordon.ge@bst.ai>
Cc: BST Linux Kernel Upstream Group <bst-upstream@bstai.top>,
	linux-arm-kernel@lists.infradead.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v1 4/9] dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
Date: Wed, 28 May 2025 16:54:51 +0800
Message-Id: <20250528085451.481267-1-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTB0ZVksdSUNITR1DTxgeGVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a97161a016709cckunm4606c7f3397dab
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Mxw6LCo6PjE#PkgKLg5COTIR
	LEkKCUJVSlVKTE9DT0lJT0JITUJKVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQU9MSUk3Bg++
DKIM-Signature:a=rsa-sha256;
	b=bAE0mei3mJMwcZJl4gdhGUEj8pKxMfbikNhy9hrQxxV+RXQM3X6pjhUaT4rl1GO7WzNyaAXsEWIteJjFR37b6ZNSu+XH1aiXTsJlNfuGgHMrtkSALTXadz7fKJfSCk1BtkKd8LiveB4cailNM1bioJtJRmLqqgez7ULqVmeKLqg=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=Vb4BX0UJyLUvKF4fET6nq/FFfA6w/RMSx8v+7CHMEsA=;
	h=date:mime-version:subject:message-id:from;

Add device tree binding documentation for the Black Sesame Technologies
(BST) DWCMSHC SDHCI controller.

This binding describes the required and optional properties for the
bst,dwcmshc-sdhci compatible controller, including register layout,
interrupts, bus width, clock configuration, and other controller-specific
features.

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
 .../bindings/mmc/bst,dwcmshc-sdhci.yaml       | 115 ++++++++++++++++++
 1 file changed, 115 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
new file mode 100644
index 000000000000..429e7f50cdec
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
@@ -0,0 +1,115 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/bst,dwcmshc-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Black Sesame Technologies DWCMSHC SDHCI Controller
+
+maintainers:
+  - Ge Gordon <gordon.ge@bst.ai>
+
+description: |
+  The BST DWCMSHC SDHCI controller is a Synopsys DesignWare Mobile Storage Host
+  Controller IP integrated in BST SoCs.
+
+  This documents the differences between the core properties in mmc.yaml and the
+  properties used by the sdhci-bst driver.
+
+properties:
+  compatible:
+    const: bst,dwcmshc-sdhci
+
+  reg-names:
+    const: base
+    description: Specify the register name
+
+  reg:
+    maxItems: 1
+    description: Host controller base address
+
+  interrupts:
+    maxItems: 1
+    description: One MMC interrupt should be described here
+
+  interrupt-names:
+    items:
+      - const: IRQDWMMC0
+
+  non-removable:
+    type: boolean
+    description: Non-removable slot (like eMMC)
+
+  bus-width:
+    description: Number of data lines
+    enum: [1, 4, 8]
+
+  clock-frequency:
+    description: Base clock frequency in Hz
+
+  max-frequency:
+    description: Maximum clock frequency in Hz
+
+  fifo-depth:
+    description: |
+      FIFO depth in bytes. If this property is not specified, the default value
+      of the fifo size is determined from the controller registers.
+
+  mmc_crm_base:
+    description: Base address of MMC CRM registers
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  mmc_crm_size:
+    description: Size of MMC CRM registers
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  memory-region:
+    maxItems: 1
+    description: Specify the MMC DMA buffer range
+
+  sdhci,auto-cmd12:
+    type: boolean
+    description: Enable auto CMD12 support
+
+  dma-coherent:
+    type: boolean
+    description: Enable coherent DMA operations
+
+required:
+  - compatible
+  - reg-names
+  - reg
+  - interrupts
+  - interrupt-names
+  - non-removable
+  - bus-width
+  - clock-frequency
+  - max-frequency
+  - fifo-depth
+  - mmc_crm_base
+  - mmc_crm_size
+
+examples:
+  - |
+    dwmmc0@22200000 {
+        status = "okay";
+        compatible = "bst,dwcmshc-sdhci";
+        reg-names = "base";
+        reg = <0x0 0x22200000 0x0 0x1000>;
+        interrupts = <0x0 0x90 0x4>;
+        interrupt-names = "IRQDWMMC0";
+        #address-cells = <0x2>;
+        #size-cells = <0x0>;
+        clock-frequency = <200000000>;
+        max-frequency = <200000000>;
+        mmc_crm_base = <0x23006000>;
+        mmc_crm_size = <0x1000>;
+        fifo-depth = <0x400>;
+        bus-width = <8>;
+        non-removable;
+        sdhci,auto-cmd12;
+        dma-coherent;
+        memory-region = <&mmc_dma_buf>;
+    };
+
+additionalProperties: true
\ No newline at end of file
-- 
2.25.1

