Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AA5212542;
	Mon, 23 Mar 2026 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774231641; cv=none; b=lIRH+kQcxro/2KpVtcPkUhdNBZSPE4jTSPkZgV62pjXrnBE0sA94+5fRilO/gpq0C1aXGm8ijSthxpJ8Z3Lghs+o4CCh5OiPtTqMRz5mYpnbxgRIQxOu0R8LoWMoP4ADCmTVI491b8eRvIGjaossBq+xwFDS09x27V2oqnpYHmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774231641; c=relaxed/simple;
	bh=jdzbRuodmDOa4Rz8PKWhhJ6GdFCSrpEzLrR1LcRWhN8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=tHV1KS+FTqV0RSS79ByjTnC/GE5Wfi+jXo8ZM8lMXqR4xC9+O5zjDbH467MBFG7sjbjgpsYd+Qd2dNnBYwRJhCU44WaV/kDbWngp2DGhCftbcGUQs++AAizjx8Y2o8WbQwqJZCMAoelf0uMSF3r6u9dlgWT+bFA3wCVeiqx/iOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Mon, 23 Mar
 2026 10:07:07 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Mon, 23 Mar 2026 10:07:07 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Mon, 23 Mar 2026 10:07:07 +0800
Subject: [PATCH v3 1/2] dt-bindings: mmc: sdhci-of-aspeed: Add AST2700
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260323-sdhci-v3-1-93555b8f6411@aspeedtech.com>
References: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
In-Reply-To: <20260323-sdhci-v3-0-93555b8f6411@aspeedtech.com>
To: Andrew Jeffery <andrew@codeconstruct.com.au>, Ulf Hansson
	<ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Joel Stanley
	<joel@jms.id.au>, Ryan Chen <ryanchen.aspeed@gmail.com>, Adrian Hunter
	<adrian.hunter@intel.com>, Philipp Zabel <p.zabel@pengutronix.de>
CC: Andrew Jeffery <andrew@aj.id.au>, <linux-aspeed@lists.ozlabs.org>,
	<openbmc@lists.ozlabs.org>, <linux-mmc@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Ryan Chen <ryan_chen@aspeedtech.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774231627; l=2522;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=jdzbRuodmDOa4Rz8PKWhhJ6GdFCSrpEzLrR1LcRWhN8=;
 b=4EdN1Pbm/olA1ehS/4Wg9tcediCzCAre0wopiJ6/Evw3ha8JJDuq5b3h4PViy9ycjeuR6a3Vz
 GsYzhSmUJOODuCKoj/UEitmcX4oEa5jTgoMztAoRXA5HFR6FJnNk5zz
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

AST2700 SDHCI controller is fully compatible with AST2600.

However, it is necessary to take the AST2700 SD controller out of
reset, so require the 'resets' property.

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

