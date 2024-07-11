Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8167714F9EA;
	Thu, 11 Jul 2024 08:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720685932; cv=none; b=fP9j7GCW8QwPN4zV9E9heYqFTAWn1P1Dp/RddMV46TaUcO4/JNY/EEAf/QN6t/7RYQwCoyAqUhqkI5skxJa9CsVoEPIP5A9BKbUJeLqCutTIwPaYmqJDSoPevAoTxfQbmVtCFLz9uMCHDMmrdGvfH2hFkYGmz1eN05gAomzPCFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720685932; c=relaxed/simple;
	bh=CwDci9vRjYo9CAjJdyXJrVoCQNKghc/BQ7rniuB/qaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRpfQmwscCtMmPzXAXOKboCldROuOkU8zee+7bbUiYz6esphMR9johlllkQBuTWdU6Rep+zckpXOnjGnJaKc65IvhXvdiLuM6O1iSfnC7iRcWq9WNlYevxTYl48VPIaiqkef4aKDqkfgvsaoebcG6JGn+4a1p+NTaLEMgV/D72M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DqyP4sZN; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DqyP4sZN"
Received: by mail.gandi.net (Postfix) with ESMTPA id 2703C4000F;
	Thu, 11 Jul 2024 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1720685923;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=40fIdy34lgcI2e31bZTL+O/QYbIYmqzcDPmH5hhaCkQ=;
	b=DqyP4sZNOUv6eIBbdwi3KnrS6C+0OSmH2iVrxWVmXp3YBHD86ZDtEomoVp7GBD/dB1uwW9
	AeT+VRJg6V6eAER8s3K626rqHAuWdduTjzK24Ly5IC5R1wAXR/pE90epYlEeNpnYTrqXV9
	BzcT0M3aRxc0Y6Fa+jcoD8DiwCPbBdSJvUmPeILi5o8KTlGX+DxOFmo+8mmZwJCZQImD5T
	BNbmtmoUB0DeWyE+V1fDkh+wBG2+ppep1Zs5A3RfmZiH1Yr3KeZ+XzSNo+QOdPQJ3VbxcE
	ySuITjVKLuyjopgmKWXn57LAOkuyWIX95ukISQDLXWoO1x+Ljz7yf2qW0B++sg==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Christopher Cordahi <christophercordahi@nanometrics.ca>,
	Bastien Curutchet <bastien.curutchet@bootlin.com>
Subject: [PATCH 2/2] mmc: davinci_mmc: report all possible bus widths
Date: Thu, 11 Jul 2024 10:18:38 +0200
Message-ID: <20240711081838.47256-3-bastien.curutchet@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240711081838.47256-1-bastien.curutchet@bootlin.com>
References: <20240711081838.47256-1-bastien.curutchet@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: bastien.curutchet@bootlin.com

A dev_info() at probe's end() report the supported bus width. It never
reports 8-bits width while the driver can handle it.

Update the info message at then end of the probe to report the use of
8-bits data when needed.

Signed-off-by: Bastien Curutchet <bastien.curutchet@bootlin.com>
---
 drivers/mmc/host/davinci_mmc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index c302eb380e42..9cbde800685d 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1187,7 +1187,7 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 	struct mmc_davinci_host *host = NULL;
 	struct mmc_host *mmc = NULL;
 	struct resource *r, *mem = NULL;
-	int ret, irq;
+	int ret, irq, bus_width;
 	size_t mem_size;
 	const struct platform_device_id *id_entry;
 
@@ -1317,9 +1317,14 @@ static int davinci_mmcsd_probe(struct platform_device *pdev)
 
 	rename_region(mem, mmc_hostname(mmc));
 
+	if (mmc->caps & MMC_CAP_8_BIT_DATA)
+		bus_width = 8;
+	else if (mmc->caps & MMC_CAP_4_BIT_DATA)
+		bus_width = 4;
+	else
+		bus_width = 1;
 	dev_info(mmc_dev(host->mmc), "Using %s, %d-bit mode\n",
-		host->use_dma ? "DMA" : "PIO",
-		(mmc->caps & MMC_CAP_4_BIT_DATA) ? 4 : 1);
+		 host->use_dma ? "DMA" : "PIO", bus_width);
 
 	return 0;
 
-- 
2.45.0

