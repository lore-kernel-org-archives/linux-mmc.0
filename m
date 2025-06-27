Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5AD219E8
	for <linux-mmc@vger.kernel.org>; Fri, 27 Jun 2025 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.121.34.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750992652; cv=none; b=OP+bknS76coUNjKhMwSQGQKHvNlV+E8BqMq1+3XB2QVdsVkKl0zOWE0s/acRfm87fw5B4G5+mZm7itzQUbIDG5+gEBUNl92uz3sFIbof/8BkkVEYhXIbNPo1bUxRWSwHKn4FroqNpPTZIG70rLtLgxl6Nd77L19kI3zgA/ZJYzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750992652; c=relaxed/simple;
	bh=sqc/NB2bVD9Hj5p3h7Gdt6Q5U5DFD9Za3XsYrX6SRFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XdqtPne5qnIQrFl/VNRLa9tS1PZH8F7bzkkznJKdmNGp8D2FDiJ0CWMWNFn9jR+E6taRtYpMLGthPQxoJqNInblHnE+fg57CLMYdkzWyHwD8uGHrkoqV8JtiJzZsyOKeg595LHGsoq7Sslgt1XWfWwYxyGZ4Kfu7OxEAmnlC6Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; arc=none smtp.client-ip=92.121.34.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Received: from inva021.nxp.com (localhost [127.0.0.1])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D81D620244E;
	Fri, 27 Jun 2025 04:50:48 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
	by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9DFE4202449;
	Fri, 27 Jun 2025 04:50:48 +0200 (CEST)
Received: from local (lsvm11u0000469.swis.ap-northeast-2.aws.nxp.com [10.52.9.123])
	by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id D26821800078;
	Fri, 27 Jun 2025 10:50:46 +0800 (+08)
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
Subject: [PATCH 1/2] mmc: core: SPI mode remove cmd7
Date: Fri, 27 Jun 2025 11:50:31 +0900
Message-Id: <20250627025032.1192873-2-rex.chen_1@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250627025032.1192873-1-rex.chen_1@nxp.com>
References: <20250627025032.1192873-1-rex.chen_1@nxp.com>
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
 drivers/mmc/core/sdio.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
index 0f753367aec1..a5679a0add16 100644
--- a/drivers/mmc/core/sdio.c
+++ b/drivers/mmc/core/sdio.c
@@ -945,7 +945,13 @@ static void mmc_sdio_remove(struct mmc_host *host)
  */
 static int mmc_sdio_alive(struct mmc_host *host)
 {
-	return mmc_select_card(host->card);
+	u8 data;
+
+	if (!mmc_host_is_spi(host))
+		return mmc_select_card(host->card);
+	else
+		return mmc_io_rw_direct(host->card, 0, 0, SDIO_CCCR_CCCR, 0,
+					&data);
 }
 
 /*
-- 
2.25.1

