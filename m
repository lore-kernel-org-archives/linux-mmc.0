Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5017537D119;
	Tue, 24 Mar 2026 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317536; cv=none; b=VdY2BBZunxEoyhgkd7UFk2P7LJ1pYH5kjJPZG1+l0YuPLTmg6BDB3/zWmQ/L25KKhXJ4tIy6wKOSxmuwBVVLXtS4J3y7vpf7TeCZxIM9NRtByC/nPQCI5SR827w3e3jmIw5vy1YCokgyLV20WakD39nUJ0gxtI8yittE5gkoZ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317536; c=relaxed/simple;
	bh=ZR+85VvCpC5m0e0QbMD/12gDOgXWD3wC6lCYYqmGJ+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Lq6/9N0P+4/pCZUcHH7W7X+KvitsIRu8xwQ+PsBULVMesd27Vqs+56Rx498lwX9UlUK5Nkz+/FT9mAs+H+tPUvbWxGIL/ZmlXL8fnQakVd+oIsxUBEAL1O0qTG2UojEnvdMuoxyodNa0z8Bppe8sbdvaqfaoSPUF6jyYgK1miE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Tue, 24 Mar
 2026 09:58:50 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Tue, 24 Mar 2026 09:58:50 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Tue, 24 Mar 2026 09:58:49 +0800
Subject: [PATCH v4 1/2] dt-bindings: mmc: sdhci-of-aspeed: Add AST2700
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260324-sdhci-v4-1-c8c2060ccb5c@aspeedtech.com>
References: <20260324-sdhci-v4-0-c8c2060ccb5c@aspeedtech.com>
In-Reply-To: <20260324-sdhci-v4-0-c8c2060ccb5c@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774317530; l=2595;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=ZR+85VvCpC5m0e0QbMD/12gDOgXWD3wC6lCYYqmGJ+Q=;
 b=BB04lkHYHRQ7uG/4q6WQYc1QkJ7KkNyD5olofxQaL3Bor+a7Mrq+gGGfyHaYOP7345MtBNP28
 aZ3f5YB6I9SDoMgQEr2MWMcRLtRNwm1+eEUjXjfYKPANz+0ZvdT62++
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

AST2700 SDHCI controller is fully compatible with AST2600.

However, it is necessary to take the AST2700 SD controller out of
reset, so require the 'resets' property.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
Changes in v3:
- Add items list const for ast2700 ast2600 compatible
- Move if/then/else block after required: (per example-schema)
Changes in v2:
- add missing blank line
- modify ast2700 compatible items const
---
 .../devicetree/bindings/mmc/aspeed,sdhci.yaml      | 41 +++++++++++++++++-----
 1 file changed, 33 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index d24950ccea95..e4a9c2810893 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -22,10 +22,15 @@ description: |+
 
 properties:
   compatible:
-    enum:
-      - aspeed,ast2400-sd-controller
-      - aspeed,ast2500-sd-controller
-      - aspeed,ast2600-sd-controller
+    oneOf:
+      - enum:
+          - aspeed,ast2400-sd-controller
+          - aspeed,ast2500-sd-controller
+          - aspeed,ast2600-sd-controller
+      - items:
+          - const: aspeed,ast2700-sd-controller
+          - const: aspeed,ast2600-sd-controller
+
   reg:
     maxItems: 1
     description: Common configuration registers
@@ -38,6 +43,9 @@ properties:
     maxItems: 1
     description: The SD/SDIO controller clock gate
 
+  resets:
+    maxItems: 1
+
 patternProperties:
   "^sdhci@[0-9a-f]+$":
     type: object
@@ -46,10 +54,15 @@ patternProperties:
 
     properties:
       compatible:
-        enum:
-          - aspeed,ast2400-sdhci
-          - aspeed,ast2500-sdhci
-          - aspeed,ast2600-sdhci
+        oneOf:
+          - enum:
+              - aspeed,ast2400-sdhci
+              - aspeed,ast2500-sdhci
+              - aspeed,ast2600-sdhci
+          - items:
+              - const: aspeed,ast2700-sdhci
+              - const: aspeed,ast2600-sdhci
+
       reg:
         maxItems: 1
         description: The SDHCI registers
@@ -78,6 +91,18 @@ required:
   - ranges
   - clocks
 
+if:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2700-sd-controller
+then:
+  required:
+    - resets
+else:
+  properties:
+    resets: false
+
 examples:
   - |
     #include <dt-bindings/clock/aspeed-clock.h>

-- 
2.34.1

