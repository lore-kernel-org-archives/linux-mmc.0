Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FD21EFFBF
	for <linux-mmc@vger.kernel.org>; Tue,  1 Apr 2025 09:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.117.254.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743501540; cv=none; b=KNZbphDtb11uE2nlr+Jys8GXzqMvVdwHPuFPJqPY/3WFhgSx4OZZz2VtuzBNkFfPM3UuIpcS6sfQTNiC8gY5JRPOuiB7sORYbRm4tFFU5JhWCXpJy5D13Un5v0/Dqv5qz0GJ/tTYtt0pGwJXrObBnb3iwEvgEg/79sZGkTy851A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743501540; c=relaxed/simple;
	bh=4MyBN7FIBxopeBKiwITGRdXVZW4wJ5oXni7JOtxJIy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qU7/7rtJ5E7m2uFqeNh7rrUcZkvjHiBJnXYNIN4CZCKoSUvmphqrWFERPgjmYdX/ur7FaTqdClz6hjVo6YWlG+T4c2AP5aacMKKiCjDTRhZxR0ZH4T07F312tvo5/NSkZ/cpNu+yLjvduiVl6cuiwWhY+QgMWn0CZYgNiOKrsPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com; spf=pass smtp.mailfrom=sang-engineering.com; dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b=jjRVlZlQ; arc=none smtp.client-ip=194.117.254.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sang-engineering.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="jjRVlZlQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sang-engineering.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:mime-version:content-transfer-encoding;
	 s=k1; bh=ChImba1yZvxWxDm9IGWpf6Bs0jfG5/oHLm9Gp6AUrMs=; b=jjRVlZ
	lQoN/WIDpGcQiE8nuGvlc6eQxvip0aosBXcEzprfUhVEx75PHd8KPpy8QgMqi3bU
	MCkD86TO58fSBEEI2RjXvHazBcep0rvYWPAhYZHnNVZWO52y+6m5sIfRDZLchP/F
	fxnE1bz69IQm4WAdmI61Jaf2+tFVbvFYAovlYcQhZRIpMuJUVST02+0YV/8vuBZm
	Q/N1OjQNZhXuWccJJy39mJCxqkrzwN7QMl+gUkA+d7VPP3/G/KfPhrMlGs8h6yfT
	hzsXFclQwTWrch+Cj59SrvEcMNwUEpm/OsfgBbtCK4bZpuA1lme6Y8yAB1lGO3T7
	Dy0PeGNfKQVdmFbA==
Received: (qmail 1558845 invoked from network); 1 Apr 2025 11:58:56 +0200
Received: by mail.zeus03.de with UTF8SMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 1 Apr 2025 11:58:56 +0200
X-UD-Smtp-Session: l3s3148p1@RFy6lbQxYoIgAwDPXwSgADIEZgbhJYA3
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-mmc@vger.kernel.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [RFC PATCH 10/11] mmc: rename mmc_can_gpio_cd() to mmc_host_can_gpio_cd()
Date: Tue,  1 Apr 2025 11:58:46 +0200
Message-ID: <20250401095847.29271-11-wsa+renesas@sang-engineering.com>
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
 drivers/mmc/core/slot-gpio.c     | 4 ++--
 drivers/mmc/host/dw_mmc.c        | 6 +++---
 drivers/mmc/host/mtk-sd.c        | 2 +-
 drivers/mmc/host/sdhci.c         | 4 ++--
 drivers/mmc/host/sunplus-mmc.c   | 2 +-
 drivers/mmc/host/tmio_mmc_core.c | 4 ++--
 include/linux/mmc/slot-gpio.h    | 2 +-
 7 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index 5fd455816393..82a933d86889 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -228,13 +228,13 @@ int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config)
 }
 EXPORT_SYMBOL(mmc_gpiod_set_cd_config);
 
-bool mmc_can_gpio_cd(struct mmc_host *host)
+bool mmc_host_can_gpio_cd(struct mmc_host *host)
 {
 	struct mmc_gpio *ctx = host->slot.handler_priv;
 
 	return ctx->cd_gpio ? true : false;
 }
-EXPORT_SYMBOL(mmc_can_gpio_cd);
+EXPORT_SYMBOL(mmc_host_can_gpio_cd);
 
 /**
  * mmc_gpiod_request_ro - request a gpio descriptor for write protection
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bb596d169420..8b4d1a3cd178 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -3622,7 +3622,7 @@ int dw_mci_runtime_suspend(struct device *dev)
 	clk_disable_unprepare(host->ciu_clk);
 
 	if (host->slot &&
-	    (mmc_can_gpio_cd(host->slot->mmc) ||
+	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
 	     !mmc_card_is_removable(host->slot->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
@@ -3636,7 +3636,7 @@ int dw_mci_runtime_resume(struct device *dev)
 	struct dw_mci *host = dev_get_drvdata(dev);
 
 	if (host->slot &&
-	    (mmc_can_gpio_cd(host->slot->mmc) ||
+	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
 	     !mmc_card_is_removable(host->slot->mmc))) {
 		ret = clk_prepare_enable(host->biu_clk);
 		if (ret)
@@ -3690,7 +3690,7 @@ int dw_mci_runtime_resume(struct device *dev)
 
 err:
 	if (host->slot &&
-	    (mmc_can_gpio_cd(host->slot->mmc) ||
+	    (mmc_host_can_gpio_cd(host->slot->mmc) ||
 	     !mmc_card_is_removable(host->slot->mmc)))
 		clk_disable_unprepare(host->biu_clk);
 
diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 345ea91629e0..66da4d7dc550 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -2977,7 +2977,7 @@ static int msdc_drv_probe(struct platform_device *pdev)
 		mmc->f_min = DIV_ROUND_UP(host->src_clk_freq, 4 * 4095);
 
 	if (!(mmc->caps & MMC_CAP_NONREMOVABLE) &&
-	    !mmc_can_gpio_cd(mmc) &&
+	    !mmc_host_can_gpio_cd(mmc) &&
 	    host->dev_comp->use_internal_cd) {
 		/*
 		 * Is removable but no GPIO declared, so
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 5f91b44891f9..4bffec30c508 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -158,7 +158,7 @@ static void sdhci_set_card_detection(struct sdhci_host *host, bool enable)
 	u32 present;
 
 	if ((host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) ||
-	    !mmc_card_is_removable(host->mmc) || mmc_can_gpio_cd(host->mmc))
+	    !mmc_card_is_removable(host->mmc) || mmc_host_can_gpio_cd(host->mmc))
 		return;
 
 	if (enable) {
@@ -3744,7 +3744,7 @@ static bool sdhci_cd_irq_can_wakeup(struct sdhci_host *host)
 {
 	return mmc_card_is_removable(host->mmc) &&
 	       !(host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION) &&
-	       !mmc_can_gpio_cd(host->mmc);
+	       !mmc_host_can_gpio_cd(host->mmc);
 }
 
 /*
diff --git a/drivers/mmc/host/sunplus-mmc.c b/drivers/mmc/host/sunplus-mmc.c
index 1cddea615a27..63279760239c 100644
--- a/drivers/mmc/host/sunplus-mmc.c
+++ b/drivers/mmc/host/sunplus-mmc.c
@@ -791,7 +791,7 @@ static int spmmc_get_cd(struct mmc_host *mmc)
 {
 	int ret = 0;
 
-	if (mmc_can_gpio_cd(mmc))
+	if (mmc_host_can_gpio_cd(mmc))
 		ret = mmc_gpio_get_cd(mmc);
 
 	if (ret < 0)
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 04c1c54df791..569b66d3d47a 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -1179,11 +1179,11 @@ int tmio_mmc_host_probe(struct tmio_mmc_host *_host)
 	if (mmc_can_gpio_ro(mmc))
 		_host->ops.get_ro = mmc_gpio_get_ro;
 
-	if (mmc_can_gpio_cd(mmc))
+	if (mmc_host_can_gpio_cd(mmc))
 		_host->ops.get_cd = mmc_gpio_get_cd;
 
 	/* must be set before tmio_mmc_reset() */
-	_host->native_hotplug = !(mmc_can_gpio_cd(mmc) ||
+	_host->native_hotplug = !(mmc_host_can_gpio_cd(mmc) ||
 				  mmc->caps & MMC_CAP_NEEDS_POLL ||
 				  !mmc_card_is_removable(mmc));
 
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 1ed7b0d1e4f9..4f6a46c636ec 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -24,7 +24,7 @@ int mmc_gpiod_request_ro(struct mmc_host *host, const char *con_id,
 int mmc_gpiod_set_cd_config(struct mmc_host *host, unsigned long config);
 int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
-bool mmc_can_gpio_cd(struct mmc_host *host);
+bool mmc_host_can_gpio_cd(struct mmc_host *host);
 bool mmc_can_gpio_ro(struct mmc_host *host);
 
 #endif
-- 
2.47.2

