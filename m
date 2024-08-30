Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB57516D4C2;
	Fri, 30 Aug 2024 08:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006023; cv=none; b=MmBBricEHTH3EkT6rp0yIYfKcaatBkJCYAIpXabwyT5/UbURLNIdm3mZ8Kjdc/PCUSZCetzeAIq4alqFgrtI48u6yamarwvhh8cSDcHjEUjuwHhFh7Eu00BITP5LCmJiVeoo6y8stLfplLr0mYVw48GNgyAcG882xQH+ThZULgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006023; c=relaxed/simple;
	bh=zcDaQYsKqxlDjCEArmeEbW9uCc+0/XUnK3g3iK7DY7U=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=BCyZ/3AHvzCpD50OWfryLs/bHZJIYWtbZPvqhYOv1urwyPoP3rDlSn/YqbtOpqxjSUlS9iCIertbeZTQxkM4K2/eBpPWxDUEEq7YZvss6nyXdwclZoj/WMrLdbGkrGFIQq4lLlNH6HPJX3FCzG1pD4T44hIpcESUgNcAVEm+D8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=fCGmlhIf; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="fCGmlhIf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725006022; x=1756542022;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=zcDaQYsKqxlDjCEArmeEbW9uCc+0/XUnK3g3iK7DY7U=;
  b=fCGmlhIfbRD6w5k4UMsuy9XoeTU9UJYx92kuL0kwCPTSYeE6KtukH1g4
   IvgWAlpVDxOwPvRKUAwtcZtkWBPOheuzIxAshNnRiJpNnM3QIfHhTf/fn
   vXhvmrE2X9H2SlhwImVzUG1kzAFr0LB6375G/vsHTEUROIs0J5JPjxUTl
   AWtPNSk/SpwINymOd2oLtlvwiQ1/DCr++k3RDY3W9ALeLjqEVpj4A06i6
   4brDuZRHjwpdexoJAo5eWBbvda3Qz2NRUZ2ppd2Pn66gEXzBs6VHEe/aV
   VqtZcV3MSPW07ZVyHd6KVR6edsSj8+aSRUJo1xerV+bdol/o1X2aA2o4n
   g==;
X-CSE-ConnectionGUID: Ea7i2hfpR3mZRIVK2YOgEg==
X-CSE-MsgGUID: qihJpKHzQdmQo7OiSVUscA==
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="262037837"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 01:20:21 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 01:19:54 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 01:19:50 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH v2 0/2] Update sdhci-atmel dt-binding documentation
Date: Fri, 30 Aug 2024 13:49:41 +0530
Message-ID: <20240830-atmel-sdhci-v2-0-b7f58973f3fc@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ2A0WYC/23MQQrCMBCF4auUWRuZpEETV95DuojT0QzYpiSlK
 KV3N3bt8n/wvhUKZ+ECl2aFzIsUSWMNc2iAYhifrKSvDQaNRdeiCvPAL1X6SKLIB2/uZ40nY6E
 +pswPee/arasdpcwpf3Z80b/1v7NohQo1t0yOvEN7HYRyoijTkdIA3bZtX9qSv+uqAAAA
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725005989; l=951;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=zcDaQYsKqxlDjCEArmeEbW9uCc+0/XUnK3g3iK7DY7U=;
 b=n0k7q+AZo3h4KmBpuC28AGMrUoqMMKvIdbmisIO1NzAlIDNzQQQMX6VmGww+LBYTjsT1l7A3h
 Q4lbItekQu4DVYqEGCxAOw0b4kCChJG4dWlhQQ6tKgigry419CBTPwI
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series converts the sdhci-atmel dt-binding to yaml format and adds
the sama7d65,sama7g5 compatibles to the list.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Changes in v2:
- Add missing deleted file to the patch 
"Documentation/devicetree/bindings/mmc/sdhci-atmel.txt"
- Link to v1: https://lore.kernel.org/r/20240830-atmel-sdhci-v1-0-01e3ec8c9804@microchip.com

---
Dharma Balasubiramani (2):
      dt-bindings: mmc: sdhci-atmel: Convert to json schema
      dt-bindings: mmc: atmel,sama5d2-sdhci: Add sama7d65 compatible

 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 103 +++++++++++++++++++++
 .../devicetree/bindings/mmc/sdhci-atmel.txt        |  35 -------
 2 files changed, 103 insertions(+), 35 deletions(-)
---
base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
change-id: 20240830-atmel-sdhci-c9a92b710624

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

