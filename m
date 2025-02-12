Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97120207A2C;
	Wed, 12 Feb 2025 09:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739352191; cv=none; b=GPL+ya6fN4PjRXPsGSBWEylHb0srRAD0w1ycTY4pPgvshRLFUeocawFd2GPOvE8R1JeGwhK+kNr2i7hB0oKV05pLVgYJHtxzyluFcDN6TdickVYwqbmsgDaGtyMoGwrCs1mM/1YQY/ESh1JiNNBIiSXFxcatNOQMx3J+GlHxP0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739352191; c=relaxed/simple;
	bh=xUs1bH+W/iCogz1hXGPiTgCgI6O4GmwLfBC8KJfbnv0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=b6OrRKdBP5hDg4JmrQ5DvLTpZthwP9rYtyARP3iq1beYzgMTkhNMsHQvTHyhMONY7/ElQuQEE01OPXzsp8jI7mOViJxlS6UXaymQu76Roj+/H2NwyITUfiHulVe5FL+wOgd85nGgvwbwrf4GkOm6k9svLcn0Z5uFKeyZXAthkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=a8ND9QPI; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="a8ND9QPI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1739352189; x=1770888189;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=xUs1bH+W/iCogz1hXGPiTgCgI6O4GmwLfBC8KJfbnv0=;
  b=a8ND9QPIVe/lKCXlnagKgVvA4D35TfYw+eXRhiE5JkqKwEFsvusxmuX0
   sn0AvU9jpjwmWqsypeymtMvcbOEr7Zo1jTuhZCthRZxPtSByJwzIWBnGH
   8KLaK9SioUYpeaYrM+/kUhsyEiMVYE+pj3RDOXV+rLlXnnsitYtX7lmca
   XHWQ9Sd0B3r4/h5Z8f9j83MpK2Kh9qyWgkAxETR6+gRN6JM+BlpafjORV
   bDGhPMFY1rU+4HlVy1SZA2VFTCbOBhsk6GD/QVAwM8PGakGjyw0xSYl2n
   n5nRAPKUFlwmaUiMt2IAt8JPDnK3FvOtDbDz0pX1L1+7J5MXD26Klrut5
   A==;
X-CSE-ConnectionGUID: Im7caqcMRgeiMBKdbNTopA==
X-CSE-MsgGUID: 14u+0lMYQ4mioTEP1VJ3lQ==
X-IronPort-AV: E=Sophos;i="6.13,279,1732604400"; 
   d="scan'208";a="37190261"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Feb 2025 02:23:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 12 Feb 2025 02:22:22 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 12 Feb 2025 02:22:17 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v3 0/2] dt-bindings: mmc: Fix the mmc-slot and Convert
 atmel,hsmci to json schema
Date: Wed, 12 Feb 2025 14:52:09 +0530
Message-ID: <20250212-mmc-slot-v3-0-2bf288207040@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEForGcC/22MywrCMBQFf6VkbSS5SWjryv8QFzEPe8E0JSlBK
 f1304Ig4nIOZ2Yh2SV0mZyahSRXMGMcK4hDQ8ygx7ujaCsTYCA58J6GYGh+xJky1cqu6612WpB
 6n5Lz+NxTl2vlAfMc02svF76tfyKFU06tN61stbDC384BTYpmwOloYiBbqMBHVgyY+pJhk7Uwy
 gvmwPa/8rqub5w2t5LhAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739352136; l=1427;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=xUs1bH+W/iCogz1hXGPiTgCgI6O4GmwLfBC8KJfbnv0=;
 b=P8VjgomucORyCZ1TW0hO3s+2LkILloCeyETpd/3Lroit69beEjtEhR5Yj3qitz1mcZpRjMA24
 S4U58N+vpuIBWU9xe2QtSHVd/I3qYYVcLGZyZvevU3GkdS/zf2XEufi
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series modifies the property status of "compatible"
(required/optional).

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changes in v3:
- Add compatible as required property in meson binding.
- Include the dependent patch that converts txt to yaml for clarity in patch series.
- Refer the mmc-slot binding in the hsmci binding.
- Explain "why" the property is made optional in commit description.
- Link to v2: https://lore.kernel.org/r/20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com

Changes in v2:
- Instead of moving the compatible string to the other binding, just make it
  optional (remove from required list).
- Link to v1: https://lore.kernel.org/r/20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com

---
Dharma Balasubiramani (2):
      dt-bindings: mmc: mmc-slot: Make compatible property optional
      dt-bindings: mmc: atmel,hsmci: Convert to json schema

 .../bindings/mmc/amlogic,meson-mx-sdio.yaml        |   3 +
 .../devicetree/bindings/mmc/atmel,hsmci.yaml       | 106 +++++++++++++++++++++
 .../devicetree/bindings/mmc/atmel-hsmci.txt        |  73 --------------
 .../devicetree/bindings/mmc/mmc-slot.yaml          |   1 -
 4 files changed, 109 insertions(+), 74 deletions(-)
---
base-commit: c674aa7c289e51659e40dda0f954886ef7f80042
change-id: 20241219-mmc-slot-0574889daea3

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

