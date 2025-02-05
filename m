Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7F1EB3E;
	Wed,  5 Feb 2025 03:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738727367; cv=none; b=n4O/j5pucvl2UOqGFVSnB7+6/pb6Z8YcIZr7Cr+mNuLQMMek5L/WPeHEOKUsc+VIKjt+nFiciPuuHEhu6SnXDJclW9Qfo5gzcYhsy8k/x6Gb20NMY7MUNA1w/8CYapgofzdJ4TizJvHidEuKsQgSxmZ8dnucKvtHmp7GI3rhtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738727367; c=relaxed/simple;
	bh=Y2M37YpkkM+Vyr8bB/bqMI0pllLoH5F4qCf3uTmRpkY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=gvvEM/0VOtGcv5mlIMa6axcWjstt8zSP1qHs9T91a2ehagYZ4Ty2w6mj5t3GN5X2j5kxUf6bGhFPjYqxJzB6oF3TaGBQNZS6Oi3VkXhdgiJhfTz53OUvs+uFdEQQNKqG7G8ds5+Q56r8x/oyL8A1CI3kbGgrtyPYZ85aQB0IjXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rrM03o8O; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rrM03o8O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1738727366; x=1770263366;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Y2M37YpkkM+Vyr8bB/bqMI0pllLoH5F4qCf3uTmRpkY=;
  b=rrM03o8OaI1B5MplxU+q2aqauOhOdR+7pwpGQn2ZNtoS2PIO3Ye/tPku
   C89Vts7d7eUvoE6CGp6mRi18evcl1m1EbGkpSA+j+BSwHyB6RcYw2rqmf
   dDqsYOTuzXCrxVDJF17JceSWv0kd6Xh9Su3RyAu2CDJxnhW0cLobI2PZI
   RsYn3SziBtjm+v3eRdSwxEQ1FXvO+rs9ePGB+v22sugRxAyDHAzpCMLKK
   Mv2Z+NG1alNtbecrS541Vh0L1u9oM+rTtA0xJgKLqhzk2hsBL47YezzNP
   B/LJT+9UzVsUZLpTU0O7eQXJn1m4XMDUH8rOSRHVFBN1ZjHfT9Uqzvfo2
   w==;
X-CSE-ConnectionGUID: 9q6sxc6oQ7qZQgsLIprwFg==
X-CSE-MsgGUID: 3DLtMxkgRhOvagShr5YrNw==
X-IronPort-AV: E=Sophos;i="6.13,260,1732604400"; 
   d="scan'208";a="268617910"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 04 Feb 2025 20:49:19 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 4 Feb 2025 20:48:48 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 4 Feb 2025 20:48:43 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Date: Wed, 5 Feb 2025 09:18:40 +0530
Subject: [PATCH RFC v2] dt-bindings: mmc: mmc-slot: make compatible
 property optional
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20250205-mmc-slot-v2-1-da3c5f30e2d9@microchip.com>
X-B4-Tracking: v=1; b=H4sIAJjfomcC/2WMywrCMBQFf6XctZEmjaR1JQh+gFvpIuZhLpimJ
 CUoJf9uyNblnDPMDslENAnO3Q7RZEwYlgrs0IFycnkZgroysJ5xyuhEvFckvcNG+pPg4zhpaeQ
 AVV+jsfhpqQfcb1eY6+gwbSF+Wz7Tdv2XMiWUaKsEF3LQg31ePKoYlMP1qIKHuZTyA3S5ypWpA
 AAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1738727322; l=1069;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=Y2M37YpkkM+Vyr8bB/bqMI0pllLoH5F4qCf3uTmRpkY=;
 b=euyPCQtPylPzBTnrVIPruEpcg2aZlyXORKa4vu1AoL4yj1xw9fMuXDNmnsUO4EOkAEw6vL48b
 HjHTGYLef3/C7DXH+LL04r3Bbck58HswIL+R+2FCxbZpd2p6GQYLrsk
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

Remove the compatible property from the list of required properties and
mark it as optional.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changes in v2:
- Instead of moving the compatible string to the other binding, just make it
  optional (remove from required list).
- Link to v1: https://lore.kernel.org/r/20241219-mmc-slot-v1-1-dfc747a3d3fb@microchip.com
---
 Documentation/devicetree/bindings/mmc/mmc-slot.yaml | 1 -
 1 file changed, 1 deletion(-)

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

---
base-commit: 40b8e93e17bff4a4e0cc129e04f9fdf5daa5397e
change-id: 20241219-mmc-slot-0574889daea3

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

