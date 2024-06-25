Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA35516F26B;
	Tue, 25 Jun 2024 12:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719318857; cv=none; b=hcBhAX5tNbkYDdpyUjH5eihCPQo+nwKamIvAXkrj4Ew5qrxrjnz7itTEE0VUMSNpAqMF/us7/nZcq1TWW1QUb6cssIgmnA1RVNnEUlP29O5pOD+Y30dtZzuo5BHjESmCRxl1JjduVq2DsGBS1zTF8GdfDc09r2+h9L/TgNFkV8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719318857; c=relaxed/simple;
	bh=h64D8fpBD1lKfgd7DANWqsP5wNcgHjfFMPaZVfLP9w4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UJ3gD1XM7tM631qugdCKeS1o3LBaPb5tQQJT8ubQVN4pi1Odm38EwGRno28LKPpdiOwC+O6NpbA9/3wxPGLG81iy7uW2peazytVJUvghx/a9jchRSkkdv0n2cxBl6YERgIkxmKoDPpvRMmS42HekcO20ZSZ+bB31IsKympcx4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=P0xrSaMp; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="P0xrSaMp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1719318856; x=1750854856;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h64D8fpBD1lKfgd7DANWqsP5wNcgHjfFMPaZVfLP9w4=;
  b=P0xrSaMpyxVJ4XREOE2mSHNXAWulGwlSbWGTte6YCONdvUiF0nlRWmtM
   qYr4hg2sUEII8g066Pgi9Pa3lazs7/kck6H8VqfroB75LbYGemnJB7piD
   6I4V3H171Y3MSFwy1SyYeieserxdKCmW0t4uBQ2QT48rbqtkrZ2ITEVeE
   NXn6BXasrhd6+EMrZj2DlgcGm4lftPELMAoQGw0ajguavINQTNg+lpUE/
   +sAo0nMpIOphCT3W1iAeNJeZq7Uz+bt2tYwO7wWvP5DGb+Ysup2UxXqWc
   kyMYrCUVc4WkftHc5tIO/A3rMPdMwnh/RCC9noMGulU6Ffcnlq5uwd7PT
   Q==;
X-CSE-ConnectionGUID: XriPB4ONTrq6zgOQXS01lw==
X-CSE-MsgGUID: iYJuNYuDTuy+amZy3+QVBA==
X-IronPort-AV: E=Sophos;i="6.08,264,1712646000"; 
   d="scan'208";a="28472536"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 25 Jun 2024 05:34:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 25 Jun 2024 05:33:44 -0700
Received: from wendy.microchip.com (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Tue, 25 Jun 2024 05:33:43 -0700
From: Conor Dooley <conor.dooley@microchip.com>
To: <linux-kernel@vger.kernel.org>
CC: <conor@kernel.org>, <conor.dooley@microchip.com>, Ulf Hansson
	<ulf.hansson@linaro.org>, Cyril Jean <cyril.jean@microchip.com>,
	<linux-mmc@vger.kernel.org>
Subject: [PATCH v2] mmc: mmc_spi: allow for spi controllers incapable of getting as low as 400k
Date: Tue, 25 Jun 2024 13:33:21 +0100
Message-ID: <20240625-gigantic-frown-1ef4afa3e6fa@wendy>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1574; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=h64D8fpBD1lKfgd7DANWqsP5wNcgHjfFMPaZVfLP9w4=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDGlVOwU3cm5oCFlWnv3X8f7s60VqYjd0fiqm6N08/F7y0Iev RdJ3OkpZGMQ4GGTFFFkSb/e1SK3/47LDuectzBxWJpAhDFycAjCRL2sYGabPdTw6W+x8cVRUuJ8Zyx aBcObLL/6+P8Z645jSpDcsaacYGT7cuF6dZCdikviw4Nea/nnM15TnflmuWnzMxuf8E5YsWW4A
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Some controllers may not be able to reach a bus clock as low as 400 KHz
due to a lack of sufficient divisors. In these cases, the SD card slot
becomes non-functional as Linux continuously attempts to set the bus
clock to 400 KHz. If the controller is incapable of getting that low,
set its minimum frequency instead. While this may eliminate some SD
cards, it allows those capable of operating at the controller's minimum
frequency to be used.

Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
---

Without the RFC tag, but otherwise unchanged.

rfc/v1: https://lore.kernel.org/all/20240612-dense-resample-563f07c30185@spud/

CC: Ulf Hansson <ulf.hansson@linaro.org>
CC: Cyril Jean <cyril.jean@microchip.com>
CC: linux-mmc@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/mmc/host/mmc_spi.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mmc_spi.c b/drivers/mmc/host/mmc_spi.c
index 09d7a6a0dc1aa..c9caa1ece7ef9 100644
--- a/drivers/mmc/host/mmc_spi.c
+++ b/drivers/mmc/host/mmc_spi.c
@@ -1208,7 +1208,10 @@ static int mmc_spi_probe(struct spi_device *spi)
 	 * that's the only reason not to use a few MHz for f_min (until
 	 * the upper layer reads the target frequency from the CSD).
 	 */
-	mmc->f_min = 400000;
+	if (spi->controller->min_speed_hz > 400000)
+		dev_warn(&spi->dev,"Controller unable to reduce bus clock to 400 KHz\n");
+
+	mmc->f_min = max(spi->controller->min_speed_hz, 400000);
 	mmc->f_max = spi->max_speed_hz;
 
 	host = mmc_priv(mmc);
-- 
2.43.2

