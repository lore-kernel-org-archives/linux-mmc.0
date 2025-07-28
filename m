Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB82A1CF
	for <linux-mmc@vger.kernel.org>; Mon, 28 Jul 2025 08:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690960; cv=none; b=pNkRQpClAVhISYV2zBkflGQ4rUSuQDZ6tUeOyIyfo9mS10p20rDSYbAFo03mnWPCwQBMPIH5AIL3Ah1QVaU7veZUxjuVoAEvxZKytHGW9aWWudT1LnLsGCnH3YN46zS3A6ekkv5VAPlYqdCrhWL7L/eOquF1WFO3YRGrJjxTRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690960; c=relaxed/simple;
	bh=krt0jkb7/nzqysTT4SXldEPuDhZbmN7Z5hfViJ0jUzI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tof/tukmQWwvA1XKC7p+L3iygsOBCAC3i8okyoBsIf0cxZJqOG5zDdgoJu40cc4ELoC7ldflNJH05IOg6YS1MuiV/N3Zp5uta/WMHRfWrDBtNq0dWfPMWBmnW+Iw5hgiiDlYS3s4RnreZoWaNvuwow75cP4zzObi/sC1+7dOe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 158C01A15FE;
	Mon, 28 Jul 2025 10:22:37 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CCFE81A2040;
	Mon, 28 Jul 2025 10:22:36 +0200 (CEST)
Received: from local (lsvm11u0000469.swis.ap-northeast-2.aws.nxp.com [10.52.9.123])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 671111800093;
	Mon, 28 Jul 2025 16:22:35 +0800 (+08)
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
Subject: [PATCH v3 0/2]
Date: Mon, 28 Jul 2025 17:22:28 +0900
Message-Id: <20250728082230.1037917-1-rex.chen_1@nxp.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

[patch 1/2]
No change for patch 1
[patch 2/2]
Add more details in commit message

Rex Chen (2):
  mmc: core: SPI mode remove cmd7
  mmc: mmc_spi: multiple block read remove read crc ack

 drivers/mmc/core/sdio.c    | 6 +++++-
 drivers/mmc/host/mmc_spi.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1

