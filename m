Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D515444E
	for <linux-mmc@vger.kernel.org>; Fri,  4 Oct 2024 09:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728034900; cv=none; b=eZL2QzPoyHTSIwC4km4S8hNRELPpyDV3o0pjypidEYV+qbpSNhffj9CUB+RzkiLiJOd6mW1G9esY+rwM+Qvb0d1liLzwyMawCJl+zRzmLPa801eXmjPYKais03uYq9a2OR3belALn8FswEysLGQpgpJG/MBF8MrcMZIr07dBTRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728034900; c=relaxed/simple;
	bh=M+2t92zXALlQvHm2hg+hEOmn8pOQBJ6MCX8dGeKhmKg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N+XgCKNyZOz0/pcvLpJE1oSXCRybQeeSQfDDeMNjBJBbJecpsIEUCKtvc64t4X8cYELFJ2uppQMqK7G8dnELJTn6cFvoQltJp8QeruKV+Nwo1GK11qmKSEYVPM0laoNSMQuFFT9/tXwNw31jf0V7xBbSITRFM1gy2z/ArjZcxpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AysSrzMw; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AysSrzMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728034899; x=1759570899;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=M+2t92zXALlQvHm2hg+hEOmn8pOQBJ6MCX8dGeKhmKg=;
  b=AysSrzMwvGDepVskpjLNJ5hU0sjYR/eYtt+8wTFSPOWyzymQNueIr1H2
   qs0hy6y62YuZ1iH6BTFMwtIQ1OXIUBQedn1NDAJOU+3tS7+482kNmFH5n
   j2F1J18GmaNx/AeCK2VaO44FrCv2LqNKhjTFXIQHJv53Vyzn3BHSkQ/H/
   KZkt3T9suqhl8359+Rf+F+htX9eB0og7RtpS2s8cPlc+ohtD5O/a8rR1y
   74+3foIh3XY7X8PabHtojqIG8hHpmqGGcwkSZGWNu8oNr6fq+woG72zwy
   tZV5vEtS+6GNcilO52V6IJW+/Qf9IihkV+Hj9IT6YO6U0YiuvHbtRoADS
   w==;
X-CSE-ConnectionGUID: vzJF9GbNRlWt2NuP7xc7wA==
X-CSE-MsgGUID: e946PQlRSyevwUmYlv0n6A==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="52656241"
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="52656241"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:37 -0700
X-CSE-ConnectionGUID: uiJLe4L+QXiZ5XXHklFUZQ==
X-CSE-MsgGUID: fiuGDLmGTnOppj8zsIIoxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,177,1725346800"; 
   d="scan'208";a="74975084"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 02:41:36 -0700
Received: from punajuuri.localdomain (punajuuri.localdomain [192.168.240.130])
	by kekkonen.fi.intel.com (Postfix) with ESMTP id C8B5811FA2C;
	Fri,  4 Oct 2024 12:41:33 +0300 (EEST)
Received: from sailus by punajuuri.localdomain with local (Exim 4.96)
	(envelope-from <sakari.ailus@linux.intel.com>)
	id 1sweoX-000Tc9-2Z;
	Fri, 04 Oct 2024 12:41:33 +0300
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
From: Sakari Ailus <sakari.ailus@linux.intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
Subject: [PATCH 28/51] mmc: Switch to __pm_runtime_put_autosuspend()
Date: Fri,  4 Oct 2024 12:41:33 +0300
Message-Id: <20241004094133.113827-1-sakari.ailus@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
References: <20241004094101.113349-1-sakari.ailus@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pm_runtime_put_autosuspend() will soon be changed to include a call to
pm_runtime_mark_last_busy(). This patch switches the current users to
__pm_runtime_put_autosuspend() which will continue to have the
functionality of old pm_runtime_put_autosuspend().

Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
---
 drivers/mmc/core/core.c            | 4 ++--
 drivers/mmc/host/atmel-mci.c       | 4 ++--
 drivers/mmc/host/dw_mmc-rockchip.c | 2 +-
 drivers/mmc/host/dw_mmc.c          | 2 +-
 drivers/mmc/host/mmci.c            | 2 +-
 drivers/mmc/host/omap_hsmmc.c      | 6 +++---
 drivers/mmc/host/sdhci-msm.c       | 2 +-
 drivers/mmc/host/sdhci-of-at91.c   | 2 +-
 drivers/mmc/host/sdhci-omap.c      | 4 ++--
 drivers/mmc/host/sdhci-pci-core.c  | 2 +-
 drivers/mmc/host/sdhci-pxav3.c     | 6 +++---
 drivers/mmc/host/sdhci-sprd.c      | 2 +-
 drivers/mmc/host/sdhci-xenon.c     | 2 +-
 drivers/mmc/host/sdhci_am654.c     | 2 +-
 drivers/mmc/host/tmio_mmc_core.c   | 2 +-
 15 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index d6c819dd68ed..edfa700ef06c 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -849,7 +849,7 @@ void mmc_release_host(struct mmc_host *host)
 		if (host->caps & MMC_CAP_SYNC_RUNTIME_PM)
 			pm_runtime_put_sync_suspend(mmc_dev(host));
 		else
-			pm_runtime_put_autosuspend(mmc_dev(host));
+			__pm_runtime_put_autosuspend(mmc_dev(host));
 	}
 }
 EXPORT_SYMBOL(mmc_release_host);
@@ -877,7 +877,7 @@ void mmc_put_card(struct mmc_card *card, struct mmc_ctx *ctx)
 
 	mmc_release_host(host);
 	pm_runtime_mark_last_busy(&card->dev);
-	pm_runtime_put_autosuspend(&card->dev);
+	__pm_runtime_put_autosuspend(&card->dev);
 }
 EXPORT_SYMBOL(mmc_put_card);
 
diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 204055b3c042..0ce3e1d62fbd 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -542,7 +542,7 @@ static int atmci_regs_show(struct seq_file *s, void *v)
 	spin_unlock_bh(&host->lock);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	seq_printf(s, "MR:\t0x%08x%s%s ",
 			buf[ATMCI_MR / 4],
@@ -2568,7 +2568,7 @@ static int atmci_probe(struct platform_device *pdev)
 		 host->mapbase, irq, nr_slots);
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index baa23b517731..888f1f36808d 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -553,7 +553,7 @@ static int dw_mci_rockchip_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 }
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 41e451235f63..3832eb66f60f 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -159,7 +159,7 @@ static int dw_mci_regs_show(struct seq_file *s, void *v)
 	seq_printf(s, "INTMASK:\t0x%08x\n", mci_readl(host, INTMASK));
 	seq_printf(s, "CLKENA:\t0x%08x\n", mci_readl(host, CLKENA));
 
-	pm_runtime_put_autosuspend(host->dev);
+	__pm_runtime_put_autosuspend(host->dev);
 
 	return 0;
 }
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b790c3c3c8f9..f842ee951965 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2083,7 +2083,7 @@ static void mmci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 	if (!enable) {
 		pm_runtime_mark_last_busy(mmc_dev(mmc));
-		pm_runtime_put_autosuspend(mmc_dev(mmc));
+		__pm_runtime_put_autosuspend(mmc_dev(mmc));
 	}
 }
 
diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 59e36e0ebbbf..ca4400aa61ea 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1664,7 +1664,7 @@ static int mmc_regs_show(struct seq_file *s, void *data)
 			OMAP_HSMMC_READ(host->base, CAPA));
 
 	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
+	__pm_runtime_put_autosuspend(host->dev);
 
 	return 0;
 }
@@ -1957,7 +1957,7 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_debugfs(mmc);
 	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
+	__pm_runtime_put_autosuspend(host->dev);
 
 	return 0;
 
@@ -2039,7 +2039,7 @@ static int omap_hsmmc_resume(struct device *dev)
 		omap_hsmmc_conf_bus_power(host);
 
 	pm_runtime_mark_last_busy(host->dev);
-	pm_runtime_put_autosuspend(host->dev);
+	__pm_runtime_put_autosuspend(host->dev);
 	return 0;
 }
 #endif
diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 8dd180a42f72..28b25689a44f 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2649,7 +2649,7 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 		goto pm_runtime_disable;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 97988ed37467..b8079d3f9316 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -426,7 +426,7 @@ static int sdhci_at91_probe(struct platform_device *pdev)
 	    || mmc_gpio_get_cd(host->mmc) >= 0)
 		sdhci_at91_set_force_card_detect(host);
 
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index 54d795205fb4..f97165e66e20 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1374,7 +1374,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 	}
 
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
@@ -1383,7 +1383,7 @@ static int sdhci_omap_probe(struct platform_device *pdev)
 
 err_rpm_put:
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 err_rpm_disable:
 	pm_runtime_dont_use_autosuspend(dev);
 	pm_runtime_disable(dev);
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index ed45ed0bdafd..3f8cd788fcb7 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -794,7 +794,7 @@ static void intel_ltr_set(struct device *dev, s32 val)
 	/* Cache the values into lpss structure */
 	intel_cache_ltr(slot);
 out:
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 }
 
 static bool intel_use_ltr(struct sdhci_pci_chip *chip)
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 990723a008ae..e8e30c10f244 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -454,7 +454,7 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
 	if (host->mmc->pm_caps & MMC_PM_WAKE_SDIO_IRQ)
 		device_init_wakeup(&pdev->dev, 1);
 
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
@@ -499,7 +499,7 @@ static int sdhci_pxav3_suspend(struct device *dev)
 		mmc_retune_needed(host->mmc);
 	ret = sdhci_suspend_host(host);
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
@@ -512,7 +512,7 @@ static int sdhci_pxav3_resume(struct device *dev)
 	pm_runtime_get_sync(dev);
 	ret = sdhci_resume_host(host);
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 
 	return ret;
 }
diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index db5e253b0f79..0e6f7acbaf96 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -872,7 +872,7 @@ static int sdhci_sprd_probe(struct platform_device *pdev)
 		goto err_cleanup_host;
 
 	pm_runtime_mark_last_busy(&pdev->dev);
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 
 	return 0;
 
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 098f0ea45cbe..a647fac22bdd 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -581,7 +581,7 @@ static int xenon_probe(struct platform_device *pdev)
 	if (err)
 		goto remove_sdhc;
 
-	pm_runtime_put_autosuspend(&pdev->dev);
+	__pm_runtime_put_autosuspend(&pdev->dev);
 	/*
 	 * If we previously detected AC5 with over 2GB of memory,
 	 * then we disable ADMA and 64-bit DMA.
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index b73f673db92b..4f6fbb632d90 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -989,7 +989,7 @@ static int sdhci_am654_probe(struct platform_device *pdev)
 	pm_runtime_set_autosuspend_delay(dev, SDHCI_AM654_AUTOSUSPEND_DELAY);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
+	__pm_runtime_put_autosuspend(dev);
 	return 0;
 
 clk_disable:
diff --git a/drivers/mmc/host/tmio_mmc_core.c b/drivers/mmc/host/tmio_mmc_core.c
index 45a474ccab1c..06f1a7fba104 100644
--- a/drivers/mmc/host/tmio_mmc_core.c
+++ b/drivers/mmc/host/tmio_mmc_core.c
@@ -161,7 +161,7 @@ static void tmio_mmc_enable_sdio_irq(struct mmc_host *mmc, int enable)
 
 		host->sdio_irq_enabled = false;
 		pm_runtime_mark_last_busy(mmc_dev(mmc));
-		pm_runtime_put_autosuspend(mmc_dev(mmc));
+		__pm_runtime_put_autosuspend(mmc_dev(mmc));
 	}
 }
 
-- 
2.39.5

