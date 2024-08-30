Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688A16DC29;
	Fri, 30 Aug 2024 08:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005720; cv=none; b=WOptTtjSRgbi/Pjl4rBuavntaxXMSLIlfMe/4HP+pppTLM1hF+wsobuZHWgEW+J/sCs6mcOD/Z+p76HCqCNT+5k5HrMw/dLR+rGLZBtbRdU6AodBwo9iAzLhTFDwqbKQbwuEv3QY2cFJ/JJN7gUyzxsawHTjLMxWG42Yy8D1rqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005720; c=relaxed/simple;
	bh=cXz8s+dhfH4eKyccckZok1ImPOM6qL8TnvX2vihUKbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CuE6CjmB02t5cFKwm474c1RlGsM1rf3YRu0jurkKigy98mIVWE/V67xcalYCZciKqrQC0ifpfkcertZP92SdjioCQBPIFusFeau+IL2w66dLbPWQECeok9bWt3jgYgFPfVeyEL1iWGQQ2Ne5J8PQsd1v1vaYqiHd44O9uvAs/e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I2yOe0UZ; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I2yOe0UZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725005718; x=1756541718;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cXz8s+dhfH4eKyccckZok1ImPOM6qL8TnvX2vihUKbo=;
  b=I2yOe0UZN7IRYdyXG/oKnh2SjgZLJZfNrzsg7XTVIuBF0GNE0/CeiIJ5
   kPBAdRpF4zXy/UZUXA1LglIOlqNhSwT/mPdmZurc77q7CIGSv8Oh6T5fu
   V06rpsGN8zKp/ECyMqvW4GKJU/utvHk/Or8sFDYsRkIOeDslW6dSRUXfT
   Vh6zMY8iryqBXKZiOcv4n2fI8NGy9TmbNH/OsdQo3uLzHRpBhs4sr4EhE
   okRsFaG4EDsuOmeU+gKaezvH2TxGWKVFx5vsCu2+Y5im9EeuwjN1oI7LS
   OvxwVfYs2fKYZuKoQgfxQ9avURYErlVussBXOVwzrsw3lEcVr4F7hzMct
   Q==;
X-CSE-ConnectionGUID: VAeSbLWdTTSEy+nkApU6cw==
X-CSE-MsgGUID: lM7pOji4TxyAmCkBKi6y0w==
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="34149872"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 01:15:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 01:15:15 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 01:15:10 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Fri, 30 Aug 2024 13:44:58 +0530
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-atmel: Convert to json schema
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240830-atmel-sdhci-v1-1-01e3ec8c9804@microchip.com>
References: <20240830-atmel-sdhci-v1-0-01e3ec8c9804@microchip.com>
In-Reply-To: <20240830-atmel-sdhci-v1-0-01e3ec8c9804@microchip.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725005704; l=3153;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=cXz8s+dhfH4eKyccckZok1ImPOM6qL8TnvX2vihUKbo=;
 b=f6M5yP9ZTCiHo2kVszlFZCJfwDDzmYmHS3XaTqQCXMZ6oAjEKQhZFGWrUIWGqykySy0wus//y
 buC2zHIuYUUDb6qdPTAO9d+MrDrX75nD4wUCkRSdQYQ5G9EtaU8hN96
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Convert sdhci-atmel documentation to yaml format. The new file will inherit
from sdhci-common.yaml.

Note: Add microchip,sama7g5-sdhci to compatible list as we already use it
in the DT.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 98 ++++++++++++++++++++++
 1 file changed, 98 insertions(+)

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

-- 
2.43.0

