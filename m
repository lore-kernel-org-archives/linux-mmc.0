Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06AD92A1CF
	for <linux-mmc@vger.kernel.org>; Mon, 28 Jul 2025 08:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690964; cv=none; b=tqPJO7xqqZhCJbu0mZCrb/vgJre+cFYDVO3+6ABg0gw1fQWm2ku5sPbK9rlHpyIahVK1wEtkwR6KXC00U9Yh22qJN9Kk/qpLO8fZa2xfOdhNcCy+Vgsn8XsHUIQt/lWLmP+kGLzmx9TUqqzkYkRIuXEsVZh/rgTWDgiIOQuZl4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690964; c=relaxed/simple;
	bh=yEX22pBP2mbh4ycttlN1XueksT37A5jxsFhlkCdPJtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZOcPQ3n+s7OTgEDsuACllwOPmNKvT2Uedl4vvSO4vanONl7SvCn0hmg+AfcaPH3vXw4DeagCDISDYiku9PUhnP4r1qvpgl/sobdOiMesiIEr++bAWYE8naDnpfHUcs/vmYtBDnAdZKX+cNzWoopKpHCPCNpxLUIUJU7/cKJ/X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva020.nxp.com (localhost [127.0.0.1])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 74F2D1A202C;
	Mon, 28 Jul 2025 10:22:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 38B011A15DF;
	Mon, 28 Jul 2025 10:22:40 +0200 (CEST)
Received: from local (lsvm11u0000469.swis.ap-northeast-2.aws.nxp.com [10.52.9.123])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5D05B1800094;
	Mon, 28 Jul 2025 16:22:38 +0800 (+08)
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
Subject: [PATCH v3 1/2] mmc: core: SPI mode remove cmd7
Date: Mon, 28 Jul 2025 17:22:29 +0900
Message-Id: <20250728082230.1037917-2-rex.chen_1@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250728082230.1037917-1-rex.chen_1@nxp.com>
References: <20250728082230.1037917-1-rex.chen_1@nxp.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP

SPI mode doesn't support cmd7, so remove it in mmc_sdio_alive() and
confirm if sdio is active by checking CCCR register value is available
or not.

Signed-off-by: Rex Chen <rex.chen_1@nxp.com>
---
 drivers/mmc/core/sdio.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 0f753367aec1..83085e76486a 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -945,7 +945,11 @@ static void mmc_sdio_remove(struct mmc_host *host)
  */
 static int mmc_sdio_alive(struct mmc_host *host)
 {
-	return mmc_select_card(host->card);
+	if (!mmc_host_is_spi(host))
+		return mmc_select_card(host->card);
+	else
+		return mmc_io_rw_direct(host->card, 0, 0, SDIO_CCCR_CCCR, 0,
+					NULL);
 }
 
 /*
-- 
2.25.1

