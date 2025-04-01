Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC87C1EFFAE
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501540; cv=none; b=ZMTyShKps5M0jQ+t4wlkGxaSSPb96q3/g1yVocdVvmQXded06mMYiWpElE2+uUSwUAN5NRlj/RfFcd/sxrKdNHeH+rKbDk8LJhKZ/DVxMkDh6TPx/KHbf6YvvKKfaj1fIgOwHmXPIN+s8oVFBI8YwPc0cX3SBPolf+9H0ICtEIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501540; c=relaxed/simple;
	bh=0udXzi5kRaCVtu2MSYN76N7YszYT1xQ1mAxssYbGmBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ClraKGaDuKgAWtd99Ia7OEJrDZY300y8K+M1v9PWEn6Qxn+Iyz0ijTGDVqpauxY1ex1smJx0GY/HGTLwngi9j8vzQ7FRpJYokpQQE8RmIKZqeutrlLi4L2ILvddvXd3m80cbaSGcX+fLjfs5jX9nc072JBRuYCryPwUgRbKOvfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=iP/sPI+Y; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="iP/sPI+Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=4qRMpSzQPBAJjla67O8HOW3Ea2/Maln21vohn6Kf9p8=; b=iP/sPI
	+YiZ50n8xNJ/KpS2V9XJDjbVI6N+k0r06OwMrQB0qNQHYkRVza6vA4+P6rwMirUE
	4aFXgQIKmcigeTUgP+5EQjREDT0JHEwT4sxzPdngTRSLJiV9pf/m6vguTynqc3IO
	SFTcT0xvMEoOmpJwgxGuJrPSaQN5p7cIX8zv3ZwmSZ04Uu/1qvnVniI57tzrjUbK
	96fb8uyILBHMEvjPyKZgtljRWnU7dwvwKDxTk9Ucaq9HQRRLaCOpxpDi+ah0p9k1
	oj571cFOV0+ZvYD28poGCRDsthJTxeRizYfM0ELRoxR/faldIvjM8yLYsTPVI4xB
	g9PQqCiovZlGhnyg==
Received: (qmail 1558864 invoked from network); 1 Apr 2025 11:58:56 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:56 +0200
X-UD-Smtp-Session: l3s3148p1@DCLClbQxZoIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 11/11] mmc: rename mmc_can_gpio_ro() to mmc_host_can_gpio_ro()
Date: Tue,  1 Apr 2025 11:58:47 +0200
Message-ID: <20250401095847.29271-12-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
References: <20250401095847.29271-1-wsa+renesas@sang-engineering.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mmc_can_* functions sometimes relate to the card and sometimes to the host.
Make it obvious by renaming this function to include 'host'.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/mmc/core/slot-gpio.c         | 4 ++--
 drivers/mmc/host/renesas_sdhi_core.c | 2 +-
 drivers/mmc/host/sdhci-omap.c        | 2 +-
 drivers/mmc/host/sdhci.c             | 2 +-
 drivers/mmc/host/tmio_mmc_core.c     | 2 +-
 include/linux/mmc/slot-gpio.h        | 2 +-
 6 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 82a933d86889..c5bc6268803e 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -275,10 +275,10 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 }
 EXPORT_SYMBOL(mmc_gpiod_request_ro);
 
-bool mmc_can_gpio_ro(struct mmc_host *host)
+bool mmc_host_can_gpio_ro(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
 	return ctx->ro_gpio ? true : false;
 }
-EXPORT_SYMBOL(mmc_can_gpio_ro);
+EXPORT_SYMBOL(mmc_host_can_gpio_ro);
diff --git a/drivers/mmc/host/renesas_sdhi_core.c b/drivers/mmc/host/renesas_sdhi_core.c
index 4642fdb8bf65..c66dd85d33c5 100644
--- a/drivers/mmc/host/renesas_sdhi_core.c
+++ b/drivers/mmc/host/renesas_sdhi_core.c
@@ -1112,7 +1112,7 @@ int renesas_sdhi_probe(struct platform_device *pdev,
 		host->mmc->caps2 &= ~(MMC_CAP2_HS400 | MMC_CAP2_HS400_ES);
 
 	/* For some SoC, we disable internal WP. GPIO may override this */
-	if (mmc_can_gpio_ro(host->mmc))
+	if (mmc_host_can_gpio_ro(host->mmc))
 		mmc_data->capabilities2 &= ~MMC_CAP2_NO_WRITE_PROTECT;
 
 	/* SDR speeds are only available on Gen2+ */
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 26a9a8b5682a..8897839ab2aa 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1270,7 +1270,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 			mmc->f_max = 48000000;
 	}
 
-	if (!mmc_can_gpio_ro(mmc))
+	if (!mmc_host_can_gpio_ro(mmc))
 		mmc->caps2 |= MMC_CAP2_NO_WRITE_PROTECT;
 
 	pltfm_host->clk = devm_clk_get(dev, "fck");
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 4bffec30c508..821cc916ad98 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -2571,7 +2571,7 @@ int sdhci_get_ro(struct mmc_host *mmc)
 		is_readonly = 0;
 	} else if (host->ops->get_ro) {
 		is_readonly = host->ops->get_ro(host);
-	} else if (mmc_can_gpio_ro(mmc)) {
+	} else if (mmc_host_can_gpio_ro(mmc)) {
 		is_readonly = mmc_gpio_get_ro(mmc);
 		/* Do not invert twice */
 		allow_invert = !(mmc->caps2 & MMC_CAP2_RO_ACTIVE_HIGH);
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 569b66d3d47a..b71241f55df5 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1176,7 +1176,7 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 				  dma_max_mapping_size(&pdev->dev));
 	mmc->max_seg_size = mmc->max_req_size;
 
-	if (mmc_can_gpio_ro(mmc))
+	if (mmc_host_can_gpio_ro(mmc))
 		_host->ops.get_ro = mmc_gpio_get_ro;
 
 	if (mmc_host_can_gpio_cd(mmc))
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 4f6a46c636ec..23ac5696fa38 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -25,6 +25,6 @@ int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config);
 int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
 bool mmc_host_can_gpio_cd(struct mmc_host *host);
-bool mmc_can_gpio_ro(struct mmc_host *host);
+bool mmc_host_can_gpio_ro(struct mmc_host *host);
 
 #endif
-- 
2.47.2

