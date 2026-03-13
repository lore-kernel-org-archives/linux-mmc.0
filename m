Received: from TWMBX01.aspeed.com (mail.aspeedtech.com [211.20.114.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4120D30FC0F;
	Fri, 13 Mar 2026 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.20.114.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773379689; cv=none; b=g1wHg1n6nrKcGd+TcaaumOB15GkwQAV0cMPIzxj59FHikTC9Y8H6dO/p1xVGwkdkxjND5CCKgEUQTg1OntruZ22gGdMcOPGMdg5+g5UzJrNdEi2gRC72bJUq5LxGUUaiCQMBzPOp68yvs/7bXd9Ru6KCGTsAiOfKLDH0+gSSJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773379689; c=relaxed/simple;
	bh=q02tFnoGppa7W4iZi/yxC4p7ULpWPHKGK+xBBuI6DQI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=JnEcdcEBbndAgkWZIS8oCzWkgF9qb9FS/gU/ijEQbfO9SoSWVYp5YEJGsojz+sNNDE5pS5vTWA5/PVSrmccJIlaMawXNtH3BoJ8ocGswcb0PV28dEIY3UOQNzDdbEaT9zUHiybYhnnR3Vn6/WxAqLdUiii03ZHkAukzJR9jBNok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; arc=none smtp.client-ip=211.20.114.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
Received: from TWMBX01.aspeed.com (192.168.0.62) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10; Fri, 13 Mar
 2026 13:27:57 +0800
Received: from [127.0.1.1] (192.168.10.13) by TWMBX01.aspeed.com
 (192.168.0.62) with Microsoft SMTP Server id 15.2.1748.10 via Frontend
 Transport; Fri, 13 Mar 2026 13:27:57 +0800
From: Ryan Chen <ryan_chen@aspeedtech.com>
Date: Fri, 13 Mar 2026 13:27:56 +0800
Subject: [PATCH 1/2] dt-bindings: mmc: sdhci-of-aspeed : Add ast2700
 support
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260313-sdhci-v1-1-91cea19c8a67@aspeedtech.com>
References: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
In-Reply-To: <20260313-sdhci-v1-0-91cea19c8a67@aspeedtech.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773379677; l=1588;
 i=ryan_chen@aspeedtech.com; s=20251126; h=from:subject:message-id;
 bh=q02tFnoGppa7W4iZi/yxC4p7ULpWPHKGK+xBBuI6DQI=;
 b=tPuwiH/wlFeRK57OmtmPuPTeGLy5Gna1WX3SgFWWsijMl4zAe9YFqsG3IVSTnVJRi+UVewyzg
 4JPKEb8JmZPDM1xfahIUGMKwoFtm/bp1Ces22FDee1T4qdrpwWVR3Iz
X-Developer-Key: i=ryan_chen@aspeedtech.com; a=ed25519;
 pk=Xe73xY6tcnkuRjjbVAB/oU30KdB3FvG4nuJuILj7ZVc=

Add the "aspeed,ast2700-sd-controller" compatible. The ast2700 sdhci
controller requires an reset, so make the "resets" property mandatory
for this compatible to reflect the hardware requirement.

Signed-off-by: Ryan Chen <ryan_chen@aspeedtech.com>
---
 Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
index d24950ccea95..a2ff9a94db13 100644
--- a/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/aspeed,sdhci.yaml
@@ -26,6 +26,7 @@ properties:
       - aspeed,ast2400-sd-controller
       - aspeed,ast2500-sd-controller
       - aspeed,ast2600-sd-controller
+      - aspeed,ast2700-sd-controller
   reg:
     maxItems: 1
     description: Common configuration registers
@@ -37,6 +38,20 @@ properties:
   clocks:
     maxItems: 1
     description: The SD/SDIO controller clock gate
+  resets:
+    maxItems: 1
+if:
+  properties:
+    compatible:
+      contains:
+        const: aspeed,ast2700-sd-controller
+then:
+  required:
+    - resets
+
+else:
+  properties:
+    resets: false
 
 patternProperties:
   "^sdhci@[0-9a-f]+$":
@@ -50,6 +65,7 @@ patternProperties:
           - aspeed,ast2400-sdhci
           - aspeed,ast2500-sdhci
           - aspeed,ast2600-sdhci
+          - aspeed,ast2700-sdhci
       reg:
         maxItems: 1
         description: The SDHCI registers

-- 
2.34.1

