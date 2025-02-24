Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817211624EB;
	Mon, 24 Feb 2025 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365586; cv=none; b=QvyIuBajwJtkgnpblUnm2CQUpU8eHxOiXgQ+gDVcA6Hhy0qIqoazpP6Sa9inoYVEWeWkconkwzf21jkEKzsukCPoZbaGne30CKsvN8z274vbz1wz9oFIlECkHkJMiIf9zXEYiXATgMgJbGxSL12HIm0TlO4yiHQJ5/tk08ScHso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365586; c=relaxed/simple;
	bh=J9123hZZrTlIOXBBpLmo8l+k5NrzmEjd/ByKPLqak5s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lSqcb/3BWosdKd+y/v/h5fg14DDIQzJi0NyXdL+uiZLXsWDxE1mnQHEfBetg0HIGMGvtD8oefc/E3UNTnLzfF67skpf+1WQytfIWad1JQXVVgG58Ntln5NSNs0UfT0CV9Ft5yRKoAC3qIvzkvcRoxhIt/hmpPdhrVTHKGP113go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=QxCB1Aom; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="QxCB1Aom"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740365584; x=1771901584;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=J9123hZZrTlIOXBBpLmo8l+k5NrzmEjd/ByKPLqak5s=;
  b=QxCB1AomDNs50AMf6RSTYLFfStSw3FiGwy6GsIq0xctVTp9cvmE1gxTI
   6l7NkxooqP0iOWH1hZCzgSTW/tQ+LplZLrohu4f7oiaqcBW6d2HTeCZru
   VoHuPNPXfBNUaEv2eJcd8S+3li9sRzDZsAWiHKWTmcCyrXNi5dz3ERDmc
   MKsQ9DETy7DkU2Ks7G0TVtTJ9kwJ80ImIuOYZnQJuy8vcimTlR3c/AEc3
   nP2btxMPdRsClnq5oidQubhHqNWTTGEbtghoMhGArfw8VjpPgcJU6MWlR
   yd5Ozoe/Y/cU5ILrDL2yRkHoGjzVWjZcRH9g9L2Qu6PUGI33vA08hmriv
   g==;
X-CSE-ConnectionGUID: 6rVg96LVQkmrqYQWG6Firw==
X-CSE-MsgGUID: 1zih4FZmSx+QgG3aHGhnsA==
X-IronPort-AV: E=Sophos;i="6.13,309,1732604400"; 
   d="scan'208";a="42149827"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2025 19:52:57 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 23 Feb 2025 19:52:40 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 23 Feb 2025 19:52:35 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Mon, 24 Feb 2025 08:22:27 +0530
Subject: [PATCH v4 1/2] dt-bindings: mmc: mmc-slot: Make compatible
 property optional
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250224-mmc-slot-v4-1-231620a31e88@microchip.com>
References: <20250224-mmc-slot-v4-0-231620a31e88@microchip.com>
In-Reply-To: <20250224-mmc-slot-v4-0-231620a31e88@microchip.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740365548; l=1669;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=J9123hZZrTlIOXBBpLmo8l+k5NrzmEjd/ByKPLqak5s=;
 b=iDQoQc5oZ8QR9avJPK5QkY2uuNY3zyCIOqDnd0geowgfmnyOkIzbvtD2WwO1bpiOqrNyHdy6+
 FGdvWNIhq7LB1aK78lpkwa21FvcUe+3Z/3M9DeOVdjaWKx4mtFRlxWz
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

The compatible property is required for some vendor-specific device trees,
such as Amlogic's meson-mx-sdio, but is unnecessary for others, like
Microchip's DTS. To resolve unintended warnings for configurations that do
not require it, remove compatible from the required properties in
mmc-slot.yaml.

Since meson-mx-sdio still requires compatible, explicitly add it to its
required list in amlogic,meson-mx-sdio.yaml.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

