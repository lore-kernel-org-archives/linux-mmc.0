Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BA78F55;
	Thu, 19 Dec 2024 04:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581500; cv=none; b=nD04st6ZAwqyKVNPtimZy3S3CyLY96ENQk1iL3G1/gI1fkXcca0iVYqwfgp3biYCmq9pXL/6Fs4spcXE6XwiMQ4D6JvuRKW12UEh9szHD//1gV2Z3tETOEk1AVoSFvdsD/nLHe7AvpyeNK4FLwq/5ooiL5Zh1RWNcOFs4fpTaqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581500; c=relaxed/simple;
	bh=R2Wn9SYot7N14emTkPFRNkyiryUGhE+kyUJk2LjZOi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=YDAQvQWXn/seUnxAJ1Zx4FcH8Y8d+17sFZOl648hCYmgi4iDY5mBIMTnGS4VKyV0+JEGY7/34R/NVwmVDj0z0H4kHX/PCVf6Of5frWY2GTzpmxrtQuyCLtaTuZR5Q/p+fofV4H6PnhZGkwC5ssz4Dlb4xaeL9UeLLqZ4EuVdI4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=I0MxLnTc; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="I0MxLnTc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1734581498; x=1766117498;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=R2Wn9SYot7N14emTkPFRNkyiryUGhE+kyUJk2LjZOi0=;
  b=I0MxLnTc4lprvYyUiDpf4g1J5pxtGxVUAmzlOg3hez7GI122u2KnI9Ka
   Ov6q/UKcckooweskwXzV1Ohw5UAuUvceuaV89xnoq4E5N6X08gsN5MFie
   /LiJd0TOr34sy4eH1WlQWteVpYXaInxrNS8mWD6iEvdrqPhoBeFAC+fKW
   4fzTklOtwVdPVECagLuehJDjbAL25ktvw9NS7r5YOo8XElZS5isNu1cdb
   Jzj/gxZ8mIGFWJT61bt9FZRc6uV3jHWwdZyfURPXIDDofMYLGrxRWzc8b
   vJazFS+pxyuwnizS6OmMGh/RZjHa4Lq5Gh23R/Q/zD+kzNEfNaHJI6hoR
   g==;
X-CSE-ConnectionGUID: Bu64aKVFRiuMCGIiLDlv2g==
X-CSE-MsgGUID: rY+Ot2OJREaaV8hnCrck1A==
X-IronPort-AV: E=Sophos;i="6.12,246,1728975600"; 
   d="scan'208";a="203189664"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 18 Dec 2024 21:11:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 18 Dec 2024 21:10:51 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 18 Dec 2024 21:10:46 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Thu, 19 Dec 2024 09:40:41 +0530
Subject: [PATCH] dt-bindings: mmc: move compatible property to its specific
 binding
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com>
X-B4-Tracking: v=1; b=H4sIAMCcY2cC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxNDI0NL3dzcZN3inPwSXQNTcxMLC8uUxNREYyWg8oKi1LTMCrBR0bG1tQA
 n+/BZWgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1734581446; l=1926;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=R2Wn9SYot7N14emTkPFRNkyiryUGhE+kyUJk2LjZOi0=;
 b=E+4ohOGm0CaZHEhi41ta2R+gPmJ7QEzV7VjPBewgBaV6JA/zWVQkda++p+wMyWejCmzWZGXVu
 wG8dVRWrIxcCsm7OfEMT6IptgaUCI0vnKZNd5+qBf+W2cNXEuM2Zpz5
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Move the `compatible` property into its specific binding to make the MMC
slot more generic and modular.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
 Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml | 4 ++++
 Documentation/devicetree/bindings/mmc/mmc-slot.yaml              | 7 +------
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
index 022682a977c6..7600a4988eca 100644
--- a/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
+++ b/Documentation/devicetree/bindings/mmc/amlogic,meson-mx-sdio.yaml
@@ -54,6 +54,10 @@ patternProperties:
       A node for each slot provided by the MMC controller
 
     properties:
+      compatible:
+        items:
+          - const: mmc-slot
+
       reg:
         enum: [0, 1, 2]
 
diff --git a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
index 1f0667828063..84c4605658e0 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
+++ b/Documentation/devicetree/bindings/mmc/mmc-slot.yaml
@@ -20,19 +20,15 @@ properties:
   $nodename:
     pattern: "^slot(@.*)?$"
 
-  compatible:
-    const: mmc-slot
-
   reg:
     description:
       the slot (or "port") ID
     maxItems: 1
 
 required:
-  - compatible
   - reg
 
-unevaluatedProperties: false
+additionalProperties: true
 
 examples:
   - |
@@ -40,7 +36,6 @@ examples:
       #address-cells = <1>;
       #size-cells = <0>;
       slot@0 {
-        compatible = "mmc-slot";
         reg = <0>;
         bus-width = <4>;
       };

---
base-commit: 7fa366f1b6e376c38966faa42da7f0f2e013fdab
change-id: 20241219-mmc-slot-0574889daea3

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

