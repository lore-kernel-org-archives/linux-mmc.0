Received: from mail-m49236.qiye.163.com (mail-m49236.qiye.163.com [45.254.49.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E806F7494;
	Tue, 12 Aug 2025 12:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.254.49.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755002206; cv=none; b=Ki0Fn+nhVvbSR/BLPp/yflgMmUmse1El3KQ0TXTy6Nk7ii7HmY9rH1R1NUyMjcgG1NOjlONMrV7bJryhItwY8NcHgvEKQciTjiteYyA+I0jxJB1cBvMW50cnRgeg+7MvZvMOvE6llcz/Q/3Ec0Yt8IK3KV+RR3KkO4VMxpNu2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755002206; c=relaxed/simple;
	bh=W0xpLXS4t7sIy92AyJg6Tcaom5x2x8cM3Z63JmAuOi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=czsUcFT9ZH5GX7LN2C3ihflB2PCn8wt2jtISR8OcfNHP5sjdsUi+PIcomgQYLNunu69FFkHd30qz5lnG4zOqe/12dObVyoSPG2MPwv63AfF/rErdSEE4qadhu3asQZ3MEr21AGpF5O3XHf8lm4SGo+F/XipY/3y2jOY7HRHOhKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=ipb3Z4ar; arc=none smtp.client-ip=45.254.49.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="ipb3Z4ar"
Received: from albert-OptiPlex-7080.. (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1f211b6d1;
	Tue, 12 Aug 2025 20:31:30 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: krzk@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulf.hansson@linaro.org,
	catalin.marinas@arm.com,
	will@kernel.org,
	arnd@arndb.de,
	adrian.hunter@intel.com,
	robin.murphy@arm.com,
	ding.wang@bst.ai,
	gordon.ge@bst.ai
Cc: bst-upstream@bstai.top,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v3 4/8] dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
Date: Tue, 12 Aug 2025 20:31:06 +0800
Message-ID: <20250812123110.2090460-5-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
References: <20250812123110.2090460-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a989e43a55a09cckunm52c5de62844361
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZGEgeVk5OSR4ZSEIZSUpKHVYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0hVSk
	tLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=ipb3Z4arhnKQUWgsF0SV/Ku9sNBABtr9l7gIr5DIQvM30KBARP5eZo9LkmQQixWbV63qMbl/KmEM6TSmxE4UcJNUUjohqnatIW3gnCFo+NzBYMYyeYZ0TcYXS5ycZ06Ng95gmad6+ZisOLyAjK0EwVwL8vAK4iDRsWyNVyt+U/I=; s=default; c=relaxed/relaxed; d=thundersoft.com; v=1;
	bh=0Ri6zMj/+h5ih+JWU6WL0UfhfS5rxCY0NiL6EaniZCg=;
	h=date:mime-version:subject:message-id:from;

Add device tree binding documentation for the Black Sesame Technologies
(BST) DWCMSHC SDHCI controller.

This binding describes the required and optional properties for the
bst,c1200-dwcmshc-sdhci compatible controller, including register layout,
interrupts, bus width, clock configuration, and other controller-specific
features.

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
Changes for v3:
- Switch reg schema from maxItems to explicit items with per-entry
descriptions
- Improve example: add irq.h include and wrap under a bus node with
address/size cells
- Drop status = "disabled" from example; keep example concise
- Add Signed-off-by: Ge Gordon

Changes for v2:
- Simplified description, removed redundant paragraphs
- Updated $schema to reference mmc-specific scheme
- Corrected compatible to add soc name
(bst,c1200-dwcmshc-sdhci)
- Removed all redundant property descriptions
- Dropped invalid mmc_crm_base/size properties, use reg for all address
ranges
- Cleaned up required properties to only essential entries
- Standardized example DTS format, fixed reg syntax and property
ordering
- Removed additionalProperties: true
---
 .../bindings/mmc/bst,dwcmshc-sdhci.yaml       | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
new file mode 100644
index 000000000000..aa72ce60259f
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
@@ -0,0 +1,70 @@
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
+allOf:
+  - $ref: mmc-controller.yaml#
+
+properties:
+  compatible:
+    const: bst,c1200-dwcmshc-sdhci
+
+  reg:
+    items:
+      - description: Core SDHCI registers
+      - description: CRM registers
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: core
+
+  memory-region:
+    maxItems: 1
+
+  dma-coherent: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        mmc@22200000 {
+            compatible = "bst,c1200-dwcmshc-sdhci";
+            reg = <0x0 0x22200000 0x0 0x1000>,
+                  <0x0 0x23006000 0x0 0x1000>;
+            interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&clk_mmc>;
+            clock-names = "core";
+            memory-region = <&mmc0_reserved>;
+            max-frequency = <200000000>;
+            bus-width = <8>;
+            non-removable;
+            dma-coherent;
+        };
+    };
-- 
2.43.0

