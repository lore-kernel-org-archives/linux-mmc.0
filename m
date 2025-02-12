Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C246C207E18;
	Wed, 12 Feb 2025 09:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352193; cv=none; b=jaS0ZZuCT+OxmO7KIqKnvH62ugfDndKjCQXvR51o4X9Stuipdt8ow8I3mZykSbVQAch7CoWERSDjKLZBkIOCE4EABJ6F/Bm0j2drJzrUfGXgU4QfL4JANX/SDHzE/aQjRQh2IH2IQfNArc+yZ81lD+vmmwJWwplw/NSSYEAcID4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352193; c=relaxed/simple;
	bh=FtpQPQxXyCZvQj8wWOr7b4bemvo3SmchpItYo+CBY98=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SuvBHZ3MFa30y3uEMjwgek2U+PqUk5E3hLXagXDfThJ+YFyXhBVoR8EW8joh9dTnk4LMqv06K/Cl/yxYfC77/ZREcSPDzzCBzSHVMqJsUCEequgqYIQkLyvLWbFCZzOgNQqAl5Ov/A5cS9gGvd/jMKNriJvP/e38QMl8gwgEsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P0CHBoB1; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P0CHBoB1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739352191; x=1770888191;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FtpQPQxXyCZvQj8wWOr7b4bemvo3SmchpItYo+CBY98=;
  b=P0CHBoB17qhEoDSdRncx5n50/8andfm1tYMgH9q3zqJywAnfrAyrGLNP
   UflAd9QTvQGX3MgJUhrLfKJW5uBaly6FXALhyjSkYd9Mjx5sjlWAAaRMs
   oU+F3hJUFOWh6oUtV5Bn/rrW5zcUIxrlerqqxT9m4hroXD36/6ZeafSlO
   gK+qbY7reGtPG2fqUvPiw+aRq9VkLgj6ZqzDKNhV9u+omv6UH3EdQMF59
   4EKz0QxQSi+TzxvtB2S+wtzVZfcRNgm7zxjS5ewTqnlIGXY2Y52SwCChU
   gXChivsCzAK1jF+pEMoOKDjJ4aEGrkgsnBSUNgalKNZJHtVZdwsL2fbfo
   w==;
X-CSE-ConnectionGUID: Im7caqcMRgeiMBKdbNTopA==
X-CSE-MsgGUID: l+jiiei1QIuIv8w+HO/aMQ==
X-IronPort-AV: E=Sophos;i="6.13,279,1732604400"; 
   d="scan'208";a="37190267"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2025 02:23:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Feb 2025 02:22:28 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 12 Feb 2025 02:22:23 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Wed, 12 Feb 2025 14:52:10 +0530
Subject: [PATCH v3 1/2] dt-bindings: mmc: mmc-slot: Make compatible
 property optional
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250212-mmc-slot-v3-1-2bf288207040@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739352136; l=1618;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=FtpQPQxXyCZvQj8wWOr7b4bemvo3SmchpItYo+CBY98=;
 b=M64rEr7kRrwyX1QrNxdiw1/HiMyCZ3zWX9Itfkk3bZ0NS4jWaGzoU66nc3FzpEfGrrHAZHv8B
 dxEMCnnyyXUCJzRL9cUKBiizPwamPTbLVI9G7d47b+L/8rD5n0IpLEy
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

The compatible property is required for some vendor-specific device trees, such
as Amlogic's meson-mx-sdio, but is unnecessary for others, like Microchip's
DTS. To resolve unintended warnings for configurations that do not require it,
remove compatible from the required properties in mmc-slot.yaml.

Since meson-mx-sdio still requires compatible, explicitly add it to its
required list in amlogic,meson-mx-sdio.yaml.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml | 3 +++
 Documentation/devicetree/bindings/mmc/mmc-slot.yaml              | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
index 022682a977c6..0d4d9ca6a8d9 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
@@ -60,6 +60,9 @@ patternProperties:
       bus-width:
         enum: [1, 4]
 
+    required:
+      - compatible
+
     unevaluatedProperties: false
 
 required:
diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
index 1f0667828063..ca3d0114bfc6 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
@@ -29,7 +29,6 @@ properties:
     maxItems: 1
 
 required:
-  - compatible
   - reg
 
 unevaluatedProperties: false

-- 
2.43.0

