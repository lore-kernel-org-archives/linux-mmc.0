Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B147314C5A4;
	Fri, 30 Aug 2024 08:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005749; cv=none; b=ZpARivrfyzsZLprXh8IMtj33y/7kxFphTWyLb/g+pU3CuGmUWEeuIGjO5X0R6v1E1WimwmIprJstdEfOrtiC8QXdwrN0gz3n0QPVDrlG1pnADuuhaVOOcrcgDnI6QZdnSsI3svgqsJLi42RLI/cH9E62dh3ekuILZMgxRm919rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005749; c=relaxed/simple;
	bh=zeiNe3RDjxa0ANwXXvSkRZhe0L3aObfW49MAHahbOCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ZNAdxWhWBlHkBk+XxsY7tvzx/gcs80YqR1F6x4Ls0J942BrzznPoFb++/eSgtFHjfR+/NW2wkVb+rJz8ZxwpzgkCfjC6S0D4aFohsc2/bjtpmxOXjkDmM9E0/oXnyrDtjCM3Cd7t1AzJtTuyBnA9OYWjdYK/CH5NE6Av9tV8dYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ZF7OS77D; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ZF7OS77D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725005747; x=1756541747;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zeiNe3RDjxa0ANwXXvSkRZhe0L3aObfW49MAHahbOCs=;
  b=ZF7OS77DLXCpSHbXfXiaDlq+0tnDV1W644QNsHtiZUKX+QKp0jUlE+mo
   f0NKwSyykPFhjcUiYTCc+dgxbxZ8kDN3TDDiBTjWAjJU61tr0kQubqJDf
   UHGlzRH0iIdKTdOGQsYWSHuUlECoj3Wuk/ScDqYEjLvUgAotjfgkunt52
   wjhPVilPiN27Ktx5gh+L+iT7+D0jfKsDICdxmJDGNzSdcPGW6LYLVi8Re
   mQqV1KCx9tRkXoQNGtnyYqUG0WLAbZRPh6lr31HqQIFegR5bohmfrnc3Z
   EkmHHCyn0F4JkqhnbuMQBeJtVonKyLSgt0a3j/x0yx3ozyYWGa0CWbM0C
   Q==;
X-CSE-ConnectionGUID: Foej+J7cSxe5AcBBVpoV/A==
X-CSE-MsgGUID: zEDWijkdSXChZwKVKZtMzQ==
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="31025518"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 01:15:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 01:15:20 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 01:15:15 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Fri, 30 Aug 2024 13:44:59 +0530
Subject: [PATCH 2/2] dt-bindings: mmc: atmel,sama5d2-sdhci: Add sama7d65
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240830-atmel-sdhci-v1-2-01e3ec8c9804@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725005704; l=903;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=zeiNe3RDjxa0ANwXXvSkRZhe0L3aObfW49MAHahbOCs=;
 b=6CfAxaOWcDzV0c4qjJvHh+w9Qyasy4tMQCiQd8jrfW42/2rQxid5XAjNDedfVajB07aEzqzbv
 5PvuIPXGK1aAbZ8Cmh90uQajzzTz+lp7zmqa21ccnge0bIikc3kE+Pq
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Add mmc binding documentation for sama7d65.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
index 91d18b2545e1..31b3c719b3e2 100644
--- a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
+++ b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
@@ -25,6 +25,11 @@ properties:
           - enum:
               - microchip,sama7g5-sdhci
           - const: microchip,sam9x60-sdhci
+      - items:
+          - enum:
+              - microchip,sama7d65-sdhci
+          - const: microchip,sama7g5-sdhci
+          - const: microchip,sam9x60-sdhci
 
   reg:
     maxItems: 1

-- 
2.43.0

