Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0513D16C85D;
	Fri, 30 Aug 2024 08:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006025; cv=none; b=uIkGTe5y+lk1Hsgq9PCHD5R6DtLVWGAuuSvDJtnFvoLzbtPj0m8ZHq9VBoNOPMGgkDxEAAj9INCpeH+ey9zKy8uCZKa/lHWK9xPcT1ruxswGC5PRhhPwBg9e+O+gMUi0n0EQGN5ZV3SsatvG6wwUSWjJE9ZfkqzMNlH/wOhl5yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006025; c=relaxed/simple;
	bh=UzbISEjJbeJYIzdRh5vu4UtMWF3hngm+ARmtvyIeqms=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NsOYrS1B9aGNoURk+urm9+jTWHFLisF1QwLMV7cmM3IrTPVoeQSS1oDTyd5oOcZNVk1gwTHXZ3ZbPJtRWV09tgNz+YKTfR7nK3Drd4klBU/iJr9VEBfEyg2sK3W3PhJXRafaTre1PJ1OKWb8MY6odWpXoVQ3NyhUebbs4oeK5zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=CY/Bv5ID; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="CY/Bv5ID"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725006024; x=1756542024;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=UzbISEjJbeJYIzdRh5vu4UtMWF3hngm+ARmtvyIeqms=;
  b=CY/Bv5IDZ4YohKRI7KkUjWJ2pkaQ19Ve01aKocP5MO4o7/S4WdYIjTh0
   ogw9Eq0QJAz+sBySBJnX89b45T6D2WkUfUs+q2q8juykfWv945m+i18/4
   U+RLJ/uidZcW6Ljuwt4W6z88B7XDWGJdLd15AubRQc9m7UL8SEgNIdd6h
   JVxvOeHKAZxjA8S8/EuJwwZWfIY/McBx22+bTyEH3vWrBSjKJqyx5izB/
   YCDlJs8+x1aasBRNqp7YwYwcLXrPU83yv7wl+kW4Xsp5B/5ZYtYN1BLRh
   qCLs7UghVwhRpCYBwQawtvFkK2tntZpKKoDOVukPmHPuJ+jo21hkBDgUK
   g==;
X-CSE-ConnectionGUID: Ea7i2hfpR3mZRIVK2YOgEg==
X-CSE-MsgGUID: zqTxmHW8Szeuc7+Ss1tooA==
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="262037840"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 01:20:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 01:19:59 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 01:19:55 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Fri, 30 Aug 2024 13:49:42 +0530
Subject: [PATCH v2 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json
 schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240830-atmel-sdhci-v2-1-b7f58973f3fc@microchip.com>
References: <20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com>
In-Reply-To: <20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725005989; l=4972;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=UzbISEjJbeJYIzdRh5vu4UtMWF3hngm+ARmtvyIeqms=;
 b=f4Gg2dkfLysB4IWisSN8yeAX4xXLjipH9Pu9Z0IDs5H3V8e+6+utcfh+8hYaQHzLKpNS3+oHj
 F093w/S88BqCijqrgkSb6a/VrmS256kojJMtUk1y3Cw1FFNL1dyaOdT
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Convert sdhci-atmel documentation to yaml format. The new file will inherit
from sdhci-common.yaml.

Note: Add microchip,sama7g5-sdhci to compatible list as we already use it
in the DT.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 98 ++++++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-atmel.txt        | 35 --------
 2 files changed, 98 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
new file mode 100644
index 000000000000..91d18b2545e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/mmc/atmel,sama5d2-sdhci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Atmel SDHCI controller
+
+maintainers:
+  - Aubin Constans <aubin.constans@microchip.com>
+  - Nicolas Ferre <nicolas.ferre@microchip.com>
+
+description:
+  Bindings for the SDHCI controller found in Atmel/Microchip SoCs.
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - atmel,sama5d2-sdhci
+          - atmel,sama5d3-sdhci
+          - atmel,sama5d4-sdhci
+          - microchip,sam9x60-sdhci
+      - items:
+          - enum:
+              - microchip,sama7g5-sdhci
+          - const: microchip,sam9x60-sdhci
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+    maxItems: 3
+    description: |
+      The sama5d2 family includes three clocks: `hclock`, `multclk`, and `baseclk`.
+      For other families, including sam9x60 and sam9x7, only `hclock` and `multclk` are used.
+
+  clock-names:
+    minItems: 2
+    maxItems: 3
+
+  microchip,sdcal-inverted:
+    type: boolean
+    description:
+      When present, polarity on the SDCAL SoC pin is inverted.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+allOf:
+  - $ref: sdhci-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - atmel,sama5d2-sdhci
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: hclock
+            - const: multclk
+            - const: baseclk
+    else:
+      properties:
+        clocks:
+          maxItems: 2
+        clock-names:
+          items:
+            - const: hclock
+            - const: multclk
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/clock/at91.h>
+    mmc@a0000000 {
+        compatible = "atmel,sama5d2-sdhci";
+        reg = <0xa0000000 0x300>;
+        interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
+        clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
+        clock-names = "hclock", "multclk", "baseclk";
+        assigned-clocks = <&sdmmc0_gclk>;
+        assigned-clock-rates = <480000000>;
+    };
diff --git a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt b/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
deleted file mode 100644
index a9fb0a91245f..000000000000
--- a/Documentation/devicetree/bindings/mmc/sdhci-atmel.txt
+++ /dev/null
@@ -1,35 +0,0 @@
-* Atmel SDHCI controller
-
-This file documents the differences between the core properties in
-Documentation/devicetree/bindings/mmc/mmc.txt and the properties used by the
-sdhci-of-at91 driver.
-
-Required properties:
-- compatible:		Must be "atmel,sama5d2-sdhci" or "microchip,sam9x60-sdhci"
-			or "microchip,sam9x7-sdhci", "microchip,sam9x60-sdhci".
-- clocks:		Phandlers to the clocks.
-- clock-names:		Must be "hclock", "multclk", "baseclk" for
-			"atmel,sama5d2-sdhci".
-			Must be "hclock", "multclk" for "microchip,sam9x60-sdhci".
-			Must be "hclock", "multclk" for "microchip,sam9x7-sdhci".
-
-Optional properties:
-- assigned-clocks:	The same with "multclk".
-- assigned-clock-rates	The rate of "multclk" in order to not rely on the
-			gck configuration set by previous components.
-- microchip,sdcal-inverted: when present, polarity on the SDCAL SoC pin is
-  inverted. The default polarity for this signal is described in the datasheet.
-  For instance on SAMA5D2, the pin is usually tied to the GND with a resistor
-  and a capacitor (see "SDMMC I/O Calibration" chapter).
-
-Example:
-
-mmc0: sdio-host@a0000000 {
-	compatible = "atmel,sama5d2-sdhci";
-	reg = <0xa0000000 0x300>;
-	interrupts = <31 IRQ_TYPE_LEVEL_HIGH 0>;
-	clocks = <&sdmmc0_hclk>, <&sdmmc0_gclk>, <&main>;
-	clock-names = "hclock", "multclk", "baseclk";
-	assigned-clocks = <&sdmmc0_gclk>;
-	assigned-clock-rates = <480000000>;
-};

-- 
2.43.0

