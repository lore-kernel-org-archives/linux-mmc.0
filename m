Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AD72080D5;
	Wed, 12 Feb 2025 09:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352194; cv=none; b=W4/IIJzZOjr+vdbE2BUnO2sXDeAOQd8VpJOfSH9OyFZNsuXQmHHfhkuy0cTDNX7INpvH+I2g9OGhOHmqDsImimG+z+DjBi+PyFlExXtJy89+fYLK4+zBoIzlPij7RIFiObM2nW3LOdiSi+/tSmiHSOKMflLflSW7o8K/Rig8pgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352194; c=relaxed/simple;
	bh=A1lTgaCSCPH+LFYIcMVq6NgsuaXTkZ36T56r0CfFEyU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=AkVnrfo3ipLsp2nL+nL1fLLvi6f+NbxmDkfMKZp/60SaqhhUxPl8ai0nw47LKBxJlrIseEr4VKMrh/6qPksraOwL0+0swoSCUPEAfRoYahBY5YrTXionc/s9cWaxNlfsszPpk7knq1K8kYa4R3aNYA3HwoUBCSOsQtZHxQxrQ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=FgKCuSl0; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="FgKCuSl0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739352192; x=1770888192;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=A1lTgaCSCPH+LFYIcMVq6NgsuaXTkZ36T56r0CfFEyU=;
  b=FgKCuSl0mJhSoQ1wIGRf0gLBr4IQSLVtoXEaSB1a/FncVqG45VJPANed
   r3dj+MaUHEBqBr3GMq5b8ykX67JsPRoel3DxRMJDeJ+rzS4a9MDnzJclV
   xEiID50ZjBh6699qmSQoB4lDPl/bADqTUetEhhKlBK9p5OTQlhRZvEtKQ
   df3Q1wldG5fDklGd6IyT1CcaI1fkFut8/1rNvwn7UwtDG4qiDRlJW5p5q
   vXDVVczyd7SROrHyiGGNmh/he/h5e7Y2AQikeawYYNI+djlTw4G+v/phO
   iKTQSvZoucQnSclOFV22JvJ22xapxTp4na78zYf1RRnWBhxveAmx3gsdH
   w==;
X-CSE-ConnectionGUID: Im7caqcMRgeiMBKdbNTopA==
X-CSE-MsgGUID: Ydz9VnPsRnKzfMIBBjCRkg==
X-IronPort-AV: E=Sophos;i="6.13,279,1732604400"; 
   d="scan'208";a="37190268"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2025 02:23:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Feb 2025 02:22:33 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 12 Feb 2025 02:22:28 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Wed, 12 Feb 2025 14:52:11 +0530
Subject: [PATCH v3 2/2] dt-bindings: mmc: atmel,hsmci: Convert to json
 schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250212-mmc-slot-v3-2-2bf288207040@microchip.com>
References: <20250212-mmc-slot-v3-0-2bf288207040@microchip.com>
In-Reply-To: <20250212-mmc-slot-v3-0-2bf288207040@microchip.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, Kevin Hilman
	<khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>, "Martin
 Blumenstingl" <martin.blumenstingl@googlemail.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-amlogic@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Dharma Balasubiramani
	<dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739352136; l=4768;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=A1lTgaCSCPH+LFYIcMVq6NgsuaXTkZ36T56r0CfFEyU=;
 b=Lcp/a3O6yv2QXnNOK3V/BtiNINsPT6P7qaEjWrE56J8XikZUjIugwaqJ43z6SzQYhqTQKUE30
 oVJfL27sDDBClvHBJjSY45HEGAHzmAEoUQ7mDXNEORYqUgBDn0+Uiws
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Convert atmel,hsmci documentation to yaml format. The new file will inherit
from mmc-controller.yaml.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../devicetree/bindings/mmc/atmel,hsmci.yaml       | 106 +++++++++++++++++++++
 .../devicetree/bindings/mmc/atmel-hsmci.txt        |  73 --------------
 2 files changed, 106 insertions(+), 73 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml b/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
new file mode 100644
index 000000000000..feaa98e44955
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/atmel,hsmci.yaml
@@ -0,0 +1,106 @@
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
+    $ref: mmc-slot.yaml
+    description: A slot node representing an MMC, SD, or SDIO slot.
+
+    properties:
+      reg:
+        enum: [0, 1]
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

-- 
2.43.0

