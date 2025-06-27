Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27051362
	for <linux-mmc@vger.kernel.org>; Fri, 27 Jun 2025 02:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750993149; cv=none; b=IT5vDa6xbyb7d1bCPNetMowraPc1Q9ZH1fTkrZfebo3Yc1RuCakmKohdbD4+uEmw7AIFZHVDqPxE0JnH73ykJSrUDL/Wb7HV7Ny1Atcx1P4szmOJ9f91zIR+J58WnbSDZ53wPZFI3q4b2L5qNnD9IqoEN0LCTrGSJF+4W4bGehM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750993149; c=relaxed/simple;
	bh=xhxVcpzUMelrcAwsTvnMzq3dpbFBBmm04hNnfEWbK94=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=li8aA8LpXdiUa0Lxf1++4YAm58zwjcvWJpexyyz26fQxT+VPGA23Hfzf+amsWTpj0xG3mJ2BoFF2LkQOEmVZ3IyVM+WlAbBJUEFn+ATpctpi+/Iy641vYJjf35tyDonxGs+aL1pcKG++aYw+Hg2jwQwoegPD1SgNba2T/MWVoVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31DCB20244B;
	Fri, 27 Jun 2025 04:50:38 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ECD90202449;
	Fri, 27 Jun 2025 04:50:37 +0200 (CEST)
Received: from local (lsvm11u0000469.swis.ap-northeast-2.aws.nxp.com [10.52.9.123])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 23D6F1800079;
	Fri, 27 Jun 2025 10:50:36 +0800 (+08)
From: Rex Chen <rex.chen_1@nxp.com>
To: ulf.hansson@linaro.org
Cc: conor.dooley@microchip.com,
	bartosz.golaszewski@linaro.org,
	viro@zeniv.linux.org.uk,
	linux-mmc@vger.kernel.org,
	avri.altman@wdc.com,
	shawn.lin@rock-chips.com,
	adrian.hunter@intel.com,
	wsa+renesas@sang-engineering.com,
	rex.chen_1@nxp.com
Subject: [PATCH 0/2]
Date: Fri, 27 Jun 2025 11:50:30 +0900
Message-Id: <20250627025032.1192873-1-rex.chen_1@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

[PATCH 1/2]
Function mmc_sdio_alive() check if sd device alive by cmd7, but SPI mode
cmd7 unavailable, so replaced by check if can read CCCR register success.
[PATCH 2/2]
SPI multiple read operation doesn't need to read crc ack, so remove it.

Rex Chen (2):
  mmc: core: SPI mode remove cmd7
  mmc: mmc_spi: multiple block read remove read crc ack

 drivers/mmc/core/sdio.c    | 8 +++++++-
 drivers/mmc/host/mmc_spi.c | 2 +-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.25.1

