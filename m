Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3936D13D53E;
	Fri, 30 Aug 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006008; cv=none; b=Glj++0ywd6FiMUxWKl6l3eEj9X10RW7/WvZkBgE5f/0E5TJCVGmSyK5dVLZO+Dh6F7YYGd5IRQ/co4InX+18euz9PS5gJj0WITxMH86OGXFBySFItjyBFKiYwYgOZITVNj2wap3EGkEHckRA6n5YGFDBpvTA44W2Mig/slzwzjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006008; c=relaxed/simple;
	bh=zeiNe3RDjxa0ANwXXvSkRZhe0L3aObfW49MAHahbOCs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=amBOu2/t8fAmbzzf9kdl2WDlatcaRmSf12qQabTMDcX9+JdiElvHmvnjHna5cZxD584sb44GvIyHax/TKQlTXCUe3RojDHQT5UaCdeNqoeh3F6+4AC/lxQ0IPf7yWF6bcOXcr8UNnytZH5qfyXzBLhPimIc/TiL1feTp1B8TAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=MXIUC3hB; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="MXIUC3hB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725006007; x=1756542007;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=zeiNe3RDjxa0ANwXXvSkRZhe0L3aObfW49MAHahbOCs=;
  b=MXIUC3hBG7mahGsQxslqTuMCMPUsCMOGJDRHdbf5m6MN94ujFzti6FOW
   vcpBf1dxxQYJPy4rgb64yb5lfNlMoz7AgzP6gNUXAE+eQfCJOmGRGG8hf
   h8RdKr2x3Ys9IxoorIH8FUdD1m0pMx+CAINhn4ewVoYDuO3oV6PRqTtOl
   6ZVKn5ku9FVq4x4UGOp7JmSi1UvCLne0GkDjc83fFCDH94jisLnncknE4
   61lKGWCzp3N+cucE5c0wVWhFQuZ3tjdRBUpXxxScm6Qk/Yfs3oU6KKdE3
   r3VTK1Win+nI5jPqVQaRB4W89soys3dYHEE+bykJ4e+mrBtsWQmzbzK3d
   g==;
X-CSE-ConnectionGUID: UTJOvnZHRjSQL+I5bPdPIQ==
X-CSE-MsgGUID: dvHOL8cNQt+/McnANW+RSw==
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="34150018"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 01:20:05 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 01:20:04 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 01:20:00 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Fri, 30 Aug 2024 13:49:43 +0530
Subject: [PATCH v2 2/2] dt-bindings: mmc: atmel,sama5d2-sdhci: Add sama7d65
 compatible
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240830-atmel-sdhci-v2-2-b7f58973f3fc@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725005989; l=903;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=zeiNe3RDjxa0ANwXXvSkRZhe0L3aObfW49MAHahbOCs=;
 b=I7+5YXaFh01UaSu1Dkd8REhCZqUEK0Sj4J8i/YlblfbJvMRXQT5HpUI/5lqWOmYAKUxTIoDqP
 0pTJint7khzAcuRnBhYOeB82dawSgFDW5czhl3X5Cer9TScCg3rKG5s
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

