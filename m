Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11807199E89;
	Mon, 24 Feb 2025 02:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740365654; cv=none; b=efsTtLoClwxOr1UBAblnzJJgAvQwIfaQZMDTeQfe+LmtdZRilAYtLWW0UQr4KgDs9xBrkuJFRGVyaFRyPYAyNZFPuM5IOPJsFrEqsPGFcAZ/7cglzN29rN7AhRXX0LuW44U8h0RJUzPNPmZQKhCyxuopimNBPvDEBFqzFPmFrM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740365654; c=relaxed/simple;
	bh=eyemEMNGosa3n/OdORh+QR5/lkWa2v+ZSdITVPlwPk0=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=akwahEJ3rJZJSqyz9pJ2O3JwnGgi3ihSfQV3y3zHSSRjMyGaqejvZ5HDK8Zh0YBZdBkOLjvD01TmOpGH/bnDnc3wWNipoqtcZMSI4WZJgmBYeL2kiqqPOVboFkAOCpOSfrl2YVXTHxcb7hz3N3FdQasG1B2O+zeV8qQ46FYE2UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=0K/aLdkS; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="0K/aLdkS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1740365653; x=1771901653;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=eyemEMNGosa3n/OdORh+QR5/lkWa2v+ZSdITVPlwPk0=;
  b=0K/aLdkSCs2gkdPXebs1dkViAQ1+r5Sf0VVl25EZv8D3dvHOisKAHMBA
   wqB+0jwLK/2n2z6mymD69LkOv1VbfqN27yRUVrU1I2FTImGjE3Lbv+qHf
   DJKYyFsn3Kg/DPHUzPHdVfrf8YzntqdjdajfvpwmddOzLNs0vSYzjDjRk
   rSa5mhk4WRJ6mFwLIKHiXIet1nYCZIdgFOQnzZHslIsBxHIVTZ26Av/uD
   BNVS2IwkkuTe/pH8tkFAMrG0TW2CterkjAM+aPYCa42ZaO+ngfy/s4HG6
   7jCCGgqfpHJksnrvGSPxFrSp7IFJYm5/JM0cal09h1uQ/uyBt4tGRCcQC
   A==;
X-CSE-ConnectionGUID: PEkXTKBESfqUq+t0U30eiQ==
X-CSE-MsgGUID: 9NPXPyaESMmg2sWeIQg41A==
X-IronPort-AV: E=Sophos;i="6.13,309,1732604400"; 
   d="scan'208";a="37623869"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2025 19:53:03 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 23 Feb 2025 19:52:34 -0700
Received: from [127.0.0.1] (10.10.85.11) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Sun, 23 Feb 2025 19:52:30 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v4 0/2] dt-bindings: mmc: Fix the mmc-slot and Convert
 atmel,hsmci to json schema
Date: Mon, 24 Feb 2025 08:22:26 +0530
Message-ID: <20250224-mmc-slot-v4-0-231620a31e88@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOreu2cC/23MTQqDMBCG4atI1k2ZTBKMXfUepYuYnxpoGklEW
 sS7V4WCFJffMM87keJycIVcqolkN4YS0msZ4lQR0+nXw9Fgl00QUDBkDY3R0PJMAwVZC6Uaq53
 mZHnvs/PhvaVu92V3oQwpf7byyNbrQWRklFHrTS1qzS337TUGk5PpQn82KZI1NOIPS0CQO4wr1
 txIz8GhbY4w32GGO8wpUGw9KoVQg4B/PM/zFyRl03geAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740365548; l=1684;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=eyemEMNGosa3n/OdORh+QR5/lkWa2v+ZSdITVPlwPk0=;
 b=s5k2Y8EORIHPvltG/Ih2kxVcEz9Cv6lHPofX+nfuc0ktRhQu4EsQNp90vxo9mlS4ZaVtgsCWm
 qCIrJ+jwNReDZsOSt+mQjvruxeCAQC3DiLunjhq4vmkE8AyyuWAZgzp
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series modifies the property status of "compatible"
(required/optional).

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changes in v4:
- Rewrapped the commit message with textwidth=75
- Allow slot pattern property to match only 0 to 2 as per reg.
- Add Reviewed-by tags from Rob.
- Link to v3: https://lore.kernel.org/r/20250212-mmc-slot-v3-0-2bf288207040@microchip.com

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
base-commit: d4b0fd87ff0d4338b259dc79b2b3c6f7e70e8afa
change-id: 20241219-mmc-slot-0574889daea3

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

