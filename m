Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6E6145FE5;
	Fri, 30 Aug 2024 08:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725005718; cv=none; b=Nam2HWrZZTt8lu+q0zPdC/t6PiHzD/p+Swp3ozZP9nSnFBi7Pu8a4TbiAjQdtPnTLD/0TlUWeoYmLrUOoWvWJ7OxKXhwW01jRvR8EnXcVCD6evhoH5xdXf6UGo8fz5QTtFO/8BHS6bf6fx61ZkpV68IVUod9sZozgrBVbncSHrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725005718; c=relaxed/simple;
	bh=PfHArUCNsji7Qaj8ax6hw5+hylGxkzu9WNEGxCTgLaw=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gNcDwA58SUEutPnREY86qxoy731VEjKWCzi7jiFbG8NDvuso4oXlqIdx6UpCz4+rja225kWNbQlJlb1MZ/L0bm5sunSHXd3VEEcO+Ji2X1g6cPVvJ55i/ilblaBxLOp1iR2TaenQNTPGXPik1OwvIkuYX9YUbq08DGQZ/dwJno4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OV4pZMn5; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OV4pZMn5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725005716; x=1756541716;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=PfHArUCNsji7Qaj8ax6hw5+hylGxkzu9WNEGxCTgLaw=;
  b=OV4pZMn5bUciz7hcFlbcpJCWWUBLzJ7gmXSwadnUNWrhJXY2ECxijzi4
   eYEHcN+dAxZQxax4fmydOC3+bqojyhrQHSPVt8QiwDeN8Z7hj0/o9jc/A
   ueG+rhj5hwcRgPRZpZIxa5HXL8IA2APEGAdAnK14RQwQFY+dmpogKVHud
   MpnRL+3WRenGxaq5vopHGIjRMxzOI15d9nsPn92xlAz2o5j0pxPmnug26
   zHS6HI1OAmwg/FoAGDsH59VxEHJcmpe7FhPjRqvPypKm2NmhuicbN8OYn
   KZgs+iLmHhzC1YejaIdZEzwt7E/ewj3UgjfE9YIFS6Kx1NtQCosm9GUbR
   A==;
X-CSE-ConnectionGUID: VAeSbLWdTTSEy+nkApU6cw==
X-CSE-MsgGUID: 6kyWpNZIQDmjs3DNedyvWA==
X-IronPort-AV: E=Sophos;i="6.10,188,1719903600"; 
   d="scan'208";a="34149871"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Aug 2024 01:15:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 30 Aug 2024 01:15:10 -0700
Received: from che-lt-i70843lx.mchp-main.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Fri, 30 Aug 2024 01:15:05 -0700
From: Dharma Balasubiramani <dharma.b@microchip.com>
Subject: [PATCH 0/2] Update sdhci-atmel dt-binding documentation
Date: Fri, 30 Aug 2024 13:44:57 +0530
Message-ID: <20240830-atmel-sdhci-v1-0-01e3ec8c9804@microchip.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIF/0WYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDC2MD3cSS3NQc3eKUjORM3WTLREujJHNDAzMjEyWgjoKi1LTMCrBp0bG
 1tQAtHdlBXQAAAA==
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni
	<alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Aubin Constans <aubin.constans@microchip.com>
CC: <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Dharma Balasubiramani <dharma.b@microchip.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725005704; l=650;
 i=dharma.b@microchip.com; s=20240209; h=from:subject:message-id;
 bh=PfHArUCNsji7Qaj8ax6hw5+hylGxkzu9WNEGxCTgLaw=;
 b=xuunt1qKYh/CxFxG1Otc8rzrVLQAdVWaQ88Zq0afbCUpdOrpwXBa8pE59KojYsDokKlrHINVV
 6hoqS4fxOadDuQtxGH7DFM8rHjUYJ22dIu+X99wI9tlPRoZWUXhvfrp
X-Developer-Key: i=dharma.b@microchip.com; a=ed25519;
 pk=kCq31LcpLAe9HDfIz9ZJ1U7T+osjOi7OZSbe0gqtyQ4=

This patch series converts the sdhci-atmel dt-binding to yaml format and adds
the sama7d65,sama7g5 compatibles to the list.

Signed-off-by: Dharma Balasubiramani <dharma.b@microchip.com>
---
Dharma Balasubiramani (2):
      dt-bindings: mmc: sdhci-atmel: Convert to json schema
      dt-bindings: mmc: atmel,sama5d2-sdhci: Add sama7d65 compatible

 .../bindings/mmc/atmel,sama5d2-sdhci.yaml          | 103 +++++++++++++++++++++
 1 file changed, 103 insertions(+)
---
base-commit: 985bf40edf4343dcb04c33f58b40b4a85c1776d4
change-id: 20240830-atmel-sdhci-c9a92b710624

Best regards,
-- 
Dharma Balasubiramani <dharma.b@microchip.com>

