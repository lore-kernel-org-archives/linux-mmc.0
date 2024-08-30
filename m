Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EC1B3B1C;
	Fri, 30 Aug 2024 14:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029556; cv=none; b=Qukc2K+0RgdjpYNQPj2xtpDh7Kwo4PUeBDg7oA+QJ3VjNZORJayKeHkz2+IduuJ9kEMfwcFw4nh4Yfndswd6WvcMA6Wf8itUX+YEDw7MJR13Ydr1XxDs9+QhMqZObvUsP0SZgOLgDYZRH/AgxIsXeQIg1RF6NBH9ukgRutMw+38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029556; c=relaxed/simple;
	bh=QESBbG94UsyFuv4RBgVGwBy6zCS6X5ImhMgiGrxYpEg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=YgQhM+liMlCjVP/29hYOZPC1tahK66KLokcVwwWStHi821AJq7v13VEOkBEm0EJzRtIBKmU3HU6TB/kD/v1b10C9dXijKTCVqTRFrsm/YTl0e5PhABBw+DklP42GJayWMMjwiIJslS2q+1DCX1wp8MiIxIuSzgw4WL+H1xpL5y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MBNnpelH; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MBNnpelH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725029554; x=1756565554;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=QESBbG94UsyFuv4RBgVGwBy6zCS6X5ImhMgiGrxYpEg=;
  b=MBNnpelHmOPddP7bKNCBTiDsWJhkajZ2268/hTF5GBM/u5x81M1XyZjb
   SQxCxrG1WHF8kz3JDXJWbcguZgKmeITVhQ0gMJYcfUmbiuKzcB0GDaqUO
   VC9bV12AAXNrZ7m4Swwf5lCozOGWf1iIno5gq6x1WoGsJwrlEBNsKKD+r
   kO8569uWboQm4QMMtPldD5AeMb3TJTV2ucvhLNoB27qdBrQ/uKmf98+oK
   MxmxIzXtYexauhPYOh/9k8KV1GVcf1v3XZW+AEyDnxCUcO2z1ReLNXm8/
   PuUcR9+QflaHq5bsIJ7SQhymKpsvtQNEhGO9Q4pTn/3qfGC727ZKc/tmf
   A==;
X-CSE-ConnectionGUID: 2zZRB9uxQuqDg306Gmx2hg==
X-CSE-MsgGUID: TqL8IWjUTAajSmhggNAgcQ==
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="31104534"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 07:52:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 07:52:02 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 07:51:54 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Fri, 30 Aug 2024 20:21:21 +0530
Subject: [PATCH v3 2/2] dt-bindings: mmc: atmel,sama5d2-sdhci: Add sama7d65
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240830-atmel-sdhci-v3-2-7c97a0872af4@microchip.com>
References: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
In-Reply-To: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725029490; l=903;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=QESBbG94UsyFuv4RBgVGwBy6zCS6X5ImhMgiGrxYpEg=;
 b=7xmvoRjcIUf0MEuwspw/R63zBo9m+2HqLLQVftqsX+CoGWpMgyqAywrwiVVfLEV9z5QJQVK8W
 9Q0uOy3yaOuBT+Ps8mCg2o44iGhSy7JYpjvLXVdNlG3jcdMrUYRwsI3
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Add mmc binding documentation for sama7d65.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml b/Documentation/devicetree/bindings/mmc/atmel,sama5d2-sdhci.yaml
index ba4786328833..a7c0ce201a5c 100644
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

