Received: from mail-m19731103.qiye.163.com (mail-m19731103.qiye.163.com [220.197.31.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC2B2309B0;
	Wed,  2 Jul 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.103
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449915; cv=none; b=fg7W/ZJmvDsYZIxoUtBMj+Hd1OLY9gu/xLTJoRps+6WOuboEuG5+R9yX4UY2s7CoTYYPFLbeqny4RYHFRN1ILBP5pMu2c6VvmEPqfsiTk2uG/gt0J1LW3vp38mviiq/UXK9IlNrOnajg1lpkB5t4XHzrWXFVpPm6ORCxQHArvZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449915; c=relaxed/simple;
	bh=1EDFj4goj5CsQ5wj3psPIN+ghrdp1Uo32Zl1NGBk7fg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MFiDgNVf0FbkzNu+2RdILHDvchKa+GKYuZyPAawKckNpDqudE1tDdQlnScokDpU7Y4JVfbFeMksh29MIaU75Dwm5GqUq+j0RFx2kYGEk1L6E2URwu8Q5+74fLlh3/gW7uZEXK/u8hlnHpIHdYWG90mL4YO5T4AvR8Z806r34I+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com; spf=pass smtp.mailfrom=thundersoft.com; dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b=joicoOyL; arc=none smtp.client-ip=220.197.31.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thundersoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thundersoft.com header.i=@thundersoft.com header.b="joicoOyL"
Received: from localhost.localdomain (unknown [117.184.129.134])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1aaa9ed49;
	Wed, 2 Jul 2025 17:46:35 +0800 (GMT+08:00)
From: Albert Yang <yangzh0906@thundersoft.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	krzk@kernel.org,
	conor+dt@kernel.org,
	gordon.ge@bst.ai,
	catalin.marinas@arm.com,
	geert.uytterhoeven@gmail.com,
	will@kernel.org,
	ulf.hansson@linaro.org,
	adrian.hunter@intel.com,
	arnd@arndb.de
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	soc@lists.linux.dev,
	bst-upstream@bstai.top,
	neil.armstrong@linaro.org,
	jonathan.cameron@huawei.com,
	bigfoot@classfun.cn,
	kever.yang@rock-chips.com,
	mani@kernel.org,
	geert+renesas@glider.be,
	andersson@kernel.org,
	nm@ti.com,
	nfraprado@collabora.com,
	quic_tdas@quicinc.com,
	ebiggers@google.com,
	victor.shih@genesyslogic.com.tw,
	shanchun1218@gmail.com,
	ben.chuang@genesyslogic.com.tw,
	Albert Yang <yangzh0906@thundersoft.com>
Subject: [PATCH v2 4/8] dt-bindings: mmc: add binding for BST DWCMSHC SDHCI controller
Date: Wed,  2 Jul 2025 17:44:40 +0800
Message-Id: <20250702094444.3523973-5-yangzh0906@thundersoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702094444.3523973-1-yangzh0906@thundersoft.com>
References: <20250528085403.481055-1-yangzh0906@thundersoft.com>
 <20250702094444.3523973-1-yangzh0906@thundersoft.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDGhhKVkgdS08YGExNTk5IQlYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkxVSkNPVUpJQlVKSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpOTE5VSk
	tLVUpCS0tZBg++
X-HM-Tid: 0a97ca87ec9609cckunmee1cabff3ebb45
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6MDo6Ejo6LDE3Ck8iHSE0HQIC
	NQwKCzNVSlVKTE5KT09CTkJMSk5CVTMWGhIXVQIaFRwBE0tCS007DxMOFR8eCQgUHQ9VGBQWRVlX
	WRILWUFZSkpMVUpDT1VKSUJVSkhPWVdZCAFZQU9ITkw3Bg++
DKIM-Signature:a=rsa-sha256;
	b=joicoOyLfPcI5Htb1jQL3vfoaIeY1lc6q9SmjGU0vYGNsKgX5FlzEe//fUMFt+F2Dt5msY0bIJHRnbNv2d+Ki7OV8xn3wNKMXXvBaG4Q66kys7HQLCJrgjS6tDstwINmLA7RWk/T5myjQBO8memOyK9cx2gDTqhwHD5Wld7+YVM=; c=relaxed/relaxed; s=default; d=thundersoft.com; v=1;
	bh=TfcFw4Er+lRQGjZg8dmF9mso3a6O4zW0NF5yIyCmuEU=;
	h=date:mime-version:subject:message-id:from;

Add device tree binding documentation for the Black Sesame Technologies
(BST) DWCMSHC SDHCI controller.

This binding describes the required and optional properties for the
bst,dwcmshc-sdhci compatible controller, including register layout,
interrupts, bus width, clock configuration, and other controller-specific
features.

---
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

Signed-off-by: Ge Gordon <gordon.ge@bst.ai>
Signed-off-by: Albert Yang <yangzh0906@thundersoft.com>
---
 .../bindings/mmc/bst,dwcmshc-sdhci.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml

diff --git a/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
new file mode 100644
index 000000000000..699dc404caac
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/bst,dwcmshc-sdhci.yaml
@@ -0,0 +1,67 @@
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
+    maxItems: 2
+    description: |
+      Register base addresses and sizes for the SDHCI controller.
+      First entry is the core SDHCI registers, second entry is the
+      CRM registers.
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
+
+    mmc@22200000 {
+        compatible = "bst,c1200-dwcmshc-sdhci";
+        reg = <0x0 0x22200000 0x0 0x1000>,
+              <0x0 0x23006000 0x0 0x1000>;
+        interrupts = <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&clk_mmc>;
+        clock-names = "core";
+        memory-region = <&mmc0_reserved>;
+        max-frequency = <200000000>;
+        bus-width = <8>;
+        non-removable;
+        dma-coherent;
+        status = "disabled";
+    };
-- 
2.25.1

