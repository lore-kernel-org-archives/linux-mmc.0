Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFE18FDA7;
	Fri, 30 Aug 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029523; cv=none; b=cd1qPWQN3QlqDkZq8tA2jGH98436UF+pLkmWAq1pdIHOdUHP37hhAX8NQK489/cuYAXsCu6kQ2bqfi6Zq0a9jdYQl24psqb3vkFTV3DnTi0ksFuy5BW83MiqM/SWUpP5ZDE802fGBII8zdOfUGKOrp2iEw+2t57mGGiPuKk5aa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029523; c=relaxed/simple;
	bh=JcTnkU7pr13R4zExJGsVutJ8y24F+DvuJFCKNDtoM44=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=jbGrTjjLPmmJO4woRto587M/bilAQMtB55B69DhHtA9mSIMNCl7Zyknf8KS1iawx/Jmyfl/OjwTt1UO8CtiV9o3L9bJYAot8NjG9jUpvEVFxWs3KcguLciJO35BGl2BLKIUyjfqj1Hiafo1I4a+cNT9l7sApyBbPXTthFMEdugs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=vo+INVHa; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="vo+INVHa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725029522; x=1756565522;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=JcTnkU7pr13R4zExJGsVutJ8y24F+DvuJFCKNDtoM44=;
  b=vo+INVHaach8ddcd1RlABbb8uwzTXpzI2qY5qC1ezbI7YW5EIF8Q1a4H
   utXapGTJ/IyX5wnZUqeg0J3cW3IcLiau7U1tgdydRYJhPZR7VoUZNMiZF
   RgpTOLJMi3MvO+dqpFchSm6abEVjAF+S2nV/WZrGkBFgBNoWiV4Uh8TvK
   Hnaz0D7ZKAjjuTXlY/9mtmugN1FZc1UE/z8rXZn6XJf2Gz7SXD+1p8czk
   e10AuLoYGvrvS+WWKZ37oNq3olyNX0f8Z0g4yYNHZZrC1xyF2FaIHMs/P
   iBXviXcX/Ngl7ermFxwlmJpJEDQaaNN14uBY6GTogtgQRtu+c7jIV7Hkm
   w==;
X-CSE-ConnectionGUID: 97HzC2AdRWaAlgmYy3Tgsw==
X-CSE-MsgGUID: AZ2hZn5oQHemjakCGe+N9w==
X-IronPort-AV: E=Sophos;i="6.10,189,1719903600"; 
   d="scan'208";a="262052123"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 07:52:01 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 07:51:41 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 07:51:31 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v3 0/2] Update sdhci-atmel dt-binding documentation
Date: Fri, 30 Aug 2024 20:21:19 +0530
Message-ID: <20240830-atmel-sdhci-v3-0-7c97a0872af4@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGfc0WYC/32MSwrCMBQAr1KyNpJPtYkr7yEu2tcX88A2JSlBK
 b27aZciLmdgZmEJI2Fil2phETMlCmMBfagY+HZ8IKe+MFNC1cJowdt5wCdPvQfiYFurukaKs6p
 ZKaaIjl777XYv7CnNIb73eZab/f3JkgsuJGoEA9aI+joQxACepiOEgW2vrP70qvRd407GNtppB
 9/9uq4ftU2Uz+oAAAA=
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725029490; l=1267;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=JcTnkU7pr13R4zExJGsVutJ8y24F+DvuJFCKNDtoM44=;
 b=45xE/P1RWOEMYhzADg9jmgCBTqfX67aRcs8EFsqAh5R/7e0VTwoqUKeVCBjIRtOPailSqdJBQ
 TyfZhrPFPk7DtWDtiWxd94gACy7PRgL2BpLAHlZ73MXBE8G2WSusVc3
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series converts the sdhci-atmel dt-binding to yaml format and adds
the sama7d65,sama7g5 compatibles to the list.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changes in v3:
- update the items in clocks instead of plain description.
- move the items list to clock-names.
- since baseclk is must, change maxitems to minitems: 3, and modify the
  conditional bits accordingly.
- Link to v2: https://lore.kernel.org/r/20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com

Changes in v2:
- Add missing deleted file to the patch 
"Documentation/devicetree/bindings/mmc/sdhci-atmel.txt"
- Link to v1: https://lore.kernel.org/r/20240830-atmel-sdhci-v1-0-01e3ec8c9804@microchip.com

---
Dharma Balasubiramani (2):
      dt-bindings: mmc: sdhci-atmel: Convert to json schema
      dt-bindings: mmc: atmel,sama5d2-sdhci: Add sama7d65 compatible

 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 95 ++++++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-atmel.txt        | 35 --------
 2 files changed, 95 insertions(+), 35 deletions(-)
---
base-commit: 4b7d983dd85a5cdf4938f4a0a93adedf697ac04d
change-id: 20240830-atmel-sdhci-c9a92b710624

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

