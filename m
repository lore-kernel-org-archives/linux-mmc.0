Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9278E2F3644
	for <linux-mmc@vger.kernel.org>; Fri,  4 Jul 2025 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751620367; cv=none; b=lxGLgejWmRH+ZA8MegEsng8tmMYdmctpoOIukww379dQUAmH+qZCVd/MYgZ3x+GrGKSPrCz3XoTZXadKCVdymB3NAicRT9Gka+mqPQQ8dxqu9059KS1iqYs2Q1/Sf2Ix+rPovCLi6hoSb1WNYD+f93NMKpCJ2I6txyGvcKoWl70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751620367; c=relaxed/simple;
	bh=UfuOxbGyD9UOJPqdKY3ruWiH/ENMmDnJbV/+IIwZWPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Cd6HpbbM/+WR3ZYTZ4pygRNJT+Mmw4jYhcBLwSP6Hb3Jd084MH9RDQqQpjFRfgLB1wEoegYDPnaMT1z1XbeHdEDi3TgCpAAJvRwFpJu76DyMIHxsoRQid3Xuq6NgfMT4htP6Ps9VCFhlFHmn3MyDAbcrA1rM7KRjfLaQE8QmB3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CBE351A013D;
	Fri,  4 Jul 2025 11:03:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 91F731A057D;
	Fri,  4 Jul 2025 11:03:45 +0200 (CEST)
Received: from local (lsvm11u0000469.swis.ap-northeast-2.aws.nxp.com [10.52.9.123])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id CA4771800096;
	Fri,  4 Jul 2025 17:03:43 +0800 (+08)
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
Subject: [PATCH v2 0/2]
Date: Fri,  4 Jul 2025 18:03:38 +0900
Message-Id: <20250704090340.2231041-1-rex.chen_1@nxp.com>
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
Update based on reviewer comments
[patch 2/2]
No change for patch 2

Rex Chen (2):
  mmc: core: SPI mode remove cmd7
  mmc: mmc_spi: multiple block read remove read crc ack

 drivers/mmc/core/sdio.c    | 6 +++++-
 drivers/mmc/host/mmc_spi.c | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

-- 
2.25.1

