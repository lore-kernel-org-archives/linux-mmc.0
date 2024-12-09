Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696CB14F126;
	Mon,  9 Dec 2024 04:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718789; cv=none; b=LkpU3vdOQwGMHMuKjI1kxEFghxIpHQrVxEWfhcifiwhAebh6nyB6Hk5EhxEt2XB9ZeCGIrz4e9c6Oc1DCh8vZ031bG5DkNQ26hZbrBZ91ZB/GSBA4TRepZkjAuM29EMDivC2CbcPRbNZ0PH23qUxrXQ9VgxDsswwQTR8De4xi/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718789; c=relaxed/simple;
	bh=LY3RsQ2MtH1nNBWndK3puTnO5aAq4/wJBReWAMNoQbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=TFSlMyRLs8xXyYneANjtB0FYm4WeT8fT+c+rbdjt6xQSl1WYfg1C2tZ/2N+Ika4Td5gKCHnXFPHGI+D0woo1TDf3R+/EgOUyG5NwDAwrpPErQUh0NTmXg2amx9uHMdet8ZK3VpyeX5tBu28S3PWpbAhcNrWEHQpLoLSQJFICqDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=qw1cQJyo; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="qw1cQJyo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1733718787; x=1765254787;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=LY3RsQ2MtH1nNBWndK3puTnO5aAq4/wJBReWAMNoQbQ=;
  b=qw1cQJyoXBKw+95R2p3TmCjFBwtofEGky32W79h70xOxWBWhhxPpMe/a
   Exu16o98/oHzqkX3buRFUnNkTMqeo4LqpD8z0+D/2X/oWy1MCgRq9g1PR
   DxuaWzMJZQWo2tYVyWEFGLE7McOQFlVc9F88ZicRpzUoOl+uctRdvk/UC
   20pXwWWged4JtAZ88CFRIiOB0L8ElIy3cnYByXqHJpHRU2eqUZ03l5RRX
   Z+CHUx+SCZaid6/i8lHkdlezUnpBTfbahvrwObPLf5Sdkhg9mP8DNTGmX
   0VBBkiCLpjkEM8dX6rVrpW9Pgur+nn/3kYZ8DV03AlkCWoL2rLzf4MVOm
   w==;
X-CSE-ConnectionGUID: 72IB33lgRjS11USK+WrWBA==
X-CSE-MsgGUID: mBb2+HZpQcCgbtECVkhTjQ==
X-IronPort-AV: E=Sophos;i="6.12,218,1728975600"; 
   d="scan'208";a="266487019"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 08 Dec 2024 21:32:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 8 Dec 2024 21:32:38 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 8 Dec 2024 21:32:34 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 9 Dec 2024 10:02:30 +0530
Subject: [PATCH v2] dt-bindings: mmc: atmel,hsmci: Convert to json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241209-hsmci-v2-1-b5a6d7c59b67@microchip.com>
X-B4-Tracking: v=1; b=H4sIAN1yVmcC/13MQQ7CIBCF4as0sxZTRpHoynuYLsgwlVlQGjBE0
 3B3sUuX/8vLt0HhLFzgNmyQuUqRtPTAwwAU3PJkJb434IhnjaNRoUQSZR2d2F21sdZC/66ZZ3n
 vzmPqHaS8Uv7sbNW/9V+oWmllHBq+IPqZ/T0K5URB1iOlCFNr7QvoOxkSngAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733718754; l=5160;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=LY3RsQ2MtH1nNBWndK3puTnO5aAq4/wJBReWAMNoQbQ=;
 b=wul3xm8moixq7EJMj3Cr78cgKF6RGexFxWRTaDK16ghCA6IYsyHDynh8McreBentzrQrXVIWF
 0NkUoX9qcPMAHu4NGQFOig6bdl/dT9XYfkkcU8p9opbEZr+d/vdPwbw
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Convert atmel,hsmci documentation to yaml format. The new file will inherit
from mmc-controller.yaml.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changes in v2:
- Drop the duplicate properties in the slot node.
- Link to v1: https://lore.kernel.org/r/20241205-hsmci-v1-1-5a25e622dfed@microchip.com
---
 .../devicetree/bindings/mmc/atmel,hsmci.yaml       | 110 +++++++++++++++++++++
 .../devicetree/bindings/mmc/atmel-hsmci.txt        |  73 --------------
 2 files changed, 110 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml b/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
new file mode 100644
index 000000000000..26686ada6288
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
@@ -0,0 +1,110 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/atmel,hsmci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel High-Speed MultiMedia Card Interface (HSMCI)
+
+description:
+  The Atmel HSMCI controller provides an interface for MMC, SD, and SDIO memory
+  cards.
+
+maintainers:
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+  - Aubin Constans <aubin.constans@microchip.com>
+
+allOf:
+  - $ref: mmc-controller.yaml
+
+properties:
+  compatible:
+    const: atmel,hsmci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  dmas:
+    maxItems: 1
+
+  dma-names:
+    const: rxtx
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mci_clk
+
+  "#address-cells":
+    const: 1
+    description: Used for slot IDs.
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^slot@[0-9]+$":
+    type: object
+    description: A slot node representing an MMC, SD, or SDIO slot.
+
+    allOf:
+      - $ref: mmc-controller.yaml
+
+    properties:
+      reg:
+        description: Slot ID.
+        minimum: 0
+
+    required:
+      - reg
+      - bus-width
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+
+anyOf:
+  - required:
+      - slot@0
+  - required:
+      - slot@1
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/at91.h>
+    mmc@f0008000 {
+      compatible = "atmel,hsmci";
+      reg = <0xf0008000 0x600>;
+      interrupts = <12 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&mci0_clk>;
+      clock-names = "mci_clk";
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      slot@0 {
+        reg = <0>;
+        bus-width = <4>;
+        cd-gpios = <&pioD 15 0>;
+        cd-inverted;
+      };
+
+      slot@1 {
+        reg = <1>;
+        bus-width = <4>;
+      };
+    };
+...
diff --git a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt b/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
deleted file mode 100644
index 07ad02075a93..000000000000
--- a/Documentation/devicetree/bindings/mmc/atmel-hsmci.txt
+++ /dev/null
@@ -1,73 +0,0 @@
-* Atmel High Speed MultiMedia Card Interface
-
-This controller on atmel products provides an interface for MMC, SD and SDIO
-types of memory cards.
-
-This file documents differences between the core properties described
-by mmc.txt and the properties used by the atmel-mci driver.
-
-1) MCI node
-
-Required properties:
-- compatible: should be "atmel,hsmci"
-- #address-cells: should be one. The cell is the slot id.
-- #size-cells: should be zero.
-- at least one slot node
-- clock-names: tuple listing input clock names.
-	Required elements: "mci_clk"
-- clocks: phandles to input clocks.
-
-The node contains child nodes for each slot that the platform uses
-
-Example MCI node:
-
-mmc0: mmc@f0008000 {
-	compatible = "atmel,hsmci";
-	reg = <0xf0008000 0x600>;
-	interrupts = <12 4>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	clock-names = "mci_clk";
-	clocks = <&mci0_clk>;
-
-	[ child node definitions...]
-};
-
-2) slot nodes
-
-Required properties:
-- reg: should contain the slot id.
-- bus-width: number of data lines connected to the controller
-
-Optional properties:
-- cd-gpios: specify GPIOs for card detection
-- cd-inverted: invert the value of external card detect gpio line
-- wp-gpios: specify GPIOs for write protection
-
-Example slot node:
-
-slot@0 {
-	reg = <0>;
-	bus-width = <4>;
-	cd-gpios = <&pioD 15 0>
-	cd-inverted;
-};
-
-Example full MCI node:
-mmc0: mmc@f0008000 {
-	compatible = "atmel,hsmci";
-	reg = <0xf0008000 0x600>;
-	interrupts = <12 4>;
-	#address-cells = <1>;
-	#size-cells = <0>;
-	slot@0 {
-		reg = <0>;
-		bus-width = <4>;
-		cd-gpios = <&pioD 15 0>
-		cd-inverted;
-	};
-	slot@1 {
-		reg = <1>;
-		bus-width = <4>;
-	};
-};

---
base-commit: feffde684ac29a3b7aec82d2df850fbdbdee55e4
change-id: 20241205-hsmci-7ac3ea915777

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

