Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87C11D6DAE;
	Mon,  2 Sep 2024 10:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725274670; cv=none; b=XaLNMe0JSXiF9TBtjErRe0xKnpSR559r5MgLkdPG3nZRW/3c1xtiQckIcj9ZldLz4QCECYXuzp2vjt7DonHYbk2Vvi6K0OXYQ6n4wR35RnGORbaOnSi9QzV+1LrDF9MKEWsBX04YjN5zpdkgtDp952kfr4nbwc6Zm6pyg25NwlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725274670; c=relaxed/simple;
	bh=5BbWc1k6oA1tQz42t0Be4gA3NCk1QECpPKKme5UwU68=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=GUpmqlMdVO67v8GW1xpSATpwiviU3Y0TSQ9Sp7WbJC64CkWc6XWrL8bA7n1MXy1BZVh47CW1UmLP88mFivuT4Dslc9YUVck2yh9OVRK+NWSbRc7Ma0fCKYoeeUnRzJ+oyAw2gjk4gVZdGIlLmmV+dqKX3UzzY0Mh397Eksn/fCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Fl/3HtTx; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Fl/3HtTx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725274668; x=1756810668;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=5BbWc1k6oA1tQz42t0Be4gA3NCk1QECpPKKme5UwU68=;
  b=Fl/3HtTxhadhjoWVdvhu3vj0ZYJBI1RNlMy5rkRE/EWVeUqsK57BXm1v
   QUHGysbQqtXR5kFzPaRu0shURavcWKVRndnRo1Mi1mwyYjOb37W8zndv6
   VZnq69XU7mi8IVzGSCWEIJwfndKK14BUT5N7vlWOtDSxOeZMP+1S1WM+w
   x/c/+hTYGtxNPaaQcOu1LjqE9jknpFMpxXBnCaW5lz2MbooD8ShFbo4uz
   2OqkAIt78dKAHbZsRsTU7gdTYFDK26uJi5GWjbpDHioJLYmNHshN09n/9
   kHK3bansEBdi4X5jghg6osQtiBpdaMG0twstcuD/dOs1/8JU7LT9nKAeb
   g==;
X-CSE-ConnectionGUID: UGwwVVYkSCW8ZZOAd5HOeA==
X-CSE-MsgGUID: IBCickTLSQiDyGRm7UbQ6w==
X-IronPort-AV: E=Sophos;i="6.10,195,1719903600"; 
   d="scan'208";a="31845450"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 02 Sep 2024 03:57:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 2 Sep 2024 03:57:27 -0700
Received: from che-lt-i70843lx.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 2 Sep 2024 03:57:16 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 2 Sep 2024 16:27:09 +0530
Subject: [PATCH v4] dt-bindings: mmc: sdhci-atmel: Convert to json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240902-atmel-sdhci-v4-1-96912fab6b2d@microchip.com>
X-B4-Tracking: v=1; b=H4sIAASa1WYC/33NTQ6CMBCG4auQrq3pD9rWlfcwLsrQ2kmEkpYQD
 eHuFrYSlt8kzzszyS6hy+RWzSS5CTPGvoz6VBEItn85im3ZRDBRMy0ZtWPn3jS3AZCCsUY0irO
 rqEkRQ3IeP1vt8Sw7YB5j+m7xia/X/c7EKaOMO+lAg9GsvncIKULA4QyxI2trEgdeFN8of9FGS
 S897Hl54GXxCoyyTCth/d//ZVl+CTttgCoBAAA=
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725274635; l=6278;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=5BbWc1k6oA1tQz42t0Be4gA3NCk1QECpPKKme5UwU68=;
 b=wRvoDXOxjyA2kABOBSV5jStVdpWIVysKjfXncXOkFQDC3cgE3O5fvNUDu0qHsspga4Izl+ORe
 o4WEHHSaGRLBoqByLqikn4sFnGceo5d3schF7vlbIp79dXjsWqSTLpV
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Convert sdhci-atmel documentation to yaml format. The new file will inherit
from sdhci-common.yaml.

Note: Add microchip,sama7g5-sdhci to compatible list as we already use it
in the DT.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
This patch series converts the sdhci-atmel dt-binding to yaml format and adds
the sama7d65,sama7g5 compatibles to the list.
---
Changes in v4:
- remove the "atmel,sama5d3-sdhci" and "atmel,sama5d4-sdhci" compatibles and
  add back the "microchip,sam9x7-sdhci" compatible from old binding which was missed.
- drop the addition of sama7d65 in binding, will be sent along with the dts patch series.
- Add the entire description of "microchip,sdcal-inverted" from old txt binding.
- The microchip,sam9x7-sdhci is yet to be merged in DTS
https://lore.kernel.org/lkml/20240729070934.1991467-1-varshini.rajendran@microchip.com/
- Link to v3: https://lore.kernel.org/r/20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com

Changes in v3:
- update the items in clocks instead of plain description.
- move the items list to clock-names.
- since baseclk is must, change maxitems to minitems: 3, and modify the
  conditional bits accordingly.
- Link to v2: https://lore.kernel.org/r/20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com

Changes in v2:
- Add missing deleted file to the patch 
"Documentation/devicetree/bindings/mmc/sdhci-atmel.txt"
- Link to v1: https://lore.kernel.org/r/20240830-atmel-sdhci-v1-0-01e3ec8c9804@microchip.com
---
 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 92 ++++++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-atmel.txt        | 35 --------
 2 files changed, 92 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
new file mode 100644
index 000000000000..8c8ade88e8fe
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
@@ -0,0 +1,92 @@
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
+          - microchip,sam9x60-sdhci
+      - items:
+          - enum:
+              - microchip,sam9x7-sdhci
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
+    items:
+      - description: hclock
+      - description: multclk
+      - description: baseclk
+    minItems: 2
+
+  clock-names:
+    items:
+      - const: hclock
+      - const: multclk
+      - const: baseclk
+    minItems: 2
+
+  microchip,sdcal-inverted:
+    type: boolean
+    description:
+      When present, polarity on the SDCAL SoC pin is inverted. The default
+      polarity for this signal is described in the datasheet. For instance on
+      SAMA5D2, the pin is usually tied to the GND with a resistor and a
+      capacitor (see "SDMMC I/O Calibration" chapter).
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
+          minItems: 3
+        clock-names:
+          minItems: 3
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

---
base-commit: 4b7d983dd85a5cdf4938f4a0a93adedf697ac04d
change-id: 20240830-atmel-sdhci-c9a92b710624

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

