Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D88F235057
	for <linux-mmc@vger.kernel.org>; Fri, 30 May 2025 16:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748624223; cv=none; b=Z3K2z6XktqD3Pb1vz+5CT/N1o8TJWXGU5aqkg/xStADax1AIDwMPFoa26RKMYJwIBFbhSA3USy/wJGxFVwGnwuejvRekCvLDURTOEJ7xKB44QngsyuTS0d8zALZf37EEGUDVkCWKJTlm0YPrC7825YXVuaJ2HDFTg2e2Jf4Yx9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748624223; c=relaxed/simple;
	bh=ZzkMu2eswU0XrtqbnA3EJLuo4ciC5dil8kpg4aNzLB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kDuOB280TxAiBHuzJ3PRjf7Ro4D2JkvCeelCkAB4MbG+evg9O3R48zUge+frYwHKV28hj9AU5sq5W6KVwEeGkZwUuDMC+GY+DDd1IL4MhwJch+TmZgbRRtbG0yENK7b93f6ioqcHdcry4mK4nuK3j6M9Xjj5uV6JyZZrj8BrRF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BUXXO/O0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BUXXO/O0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748624222; x=1780160222;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZzkMu2eswU0XrtqbnA3EJLuo4ciC5dil8kpg4aNzLB4=;
  b=BUXXO/O06Kf5pIW4mh6KoSnjXuzej/ylu53hc9Ipd3ucNzS0VqvUb0/3
   CA/0xQvtvuVD+TIh5dJRWsbMe8v6XLwNDm8MSRMcWDcQw+pmSo8uQFlHg
   2QKLt7l7SJlMUqVR6pi3as6hxzU4DT6xAkw46yCiC+1Uq7d7oTpWmjHl9
   e6d0VbZ1CY0wqYm+lOv3D4tUfR4mlq8g9vTF933r6C1uHfQyX9dTA+UOU
   bo7f3aTDTNK3AstNqxdy8Npge7BJjBipHmZqIxeMnuM0RyZj+i7TyTuRU
   SEiOr/1Mphast0fNhGsQ7oN2z2h/2EUl69aRJzFa9G8mYsfHypHeYZC26
   Q==;
X-CSE-ConnectionGUID: nKH1kJ1LQNeLk5s2VG13Pw==
X-CSE-MsgGUID: szTH/9PZQ72YJqVpbXEqCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="61392244"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="61392244"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 09:57:01 -0700
X-CSE-ConnectionGUID: 5Z3YRrHgRs+SBwa0vm4qxQ==
X-CSE-MsgGUID: KYxMK9MhSRiTFOyBG83Idg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="143892391"
Received: from oandoniu-mobl3.ger.corp.intel.com (HELO localhost.localdomain) ([10.245.244.173])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 09:56:56 -0700
From: Adrian Hunter <adrian.hunter@intel.com>
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Haibo Chen <haibo.chen@nxp.com>,
	Aubin Constans <aubin.constans@microchip.com>,
	Eugen Hristev <eugen.hristev@collabora.com>,
	Karel Balej <balejk@matfyz.cz>,
	Ben Dooks <ben-linux@fluff.org>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Hu Ziji <huziji@marvell.com>,
	Judith Mendez <jm@ti.com>,
	Andrew Davis <afd@ti.com>,
	linux-mmc@vger.kernel.org
Subject: [PATCH V2] mmc: sdhci: Return void from sdhci_runtime_suspend_host() and sdhci_runtime_resume_host()
Date: Fri, 30 May 2025 19:56:43 +0300
Message-ID: <20250530165643.141295-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit

It does not seem like these functions will ever need the return value,
which is presently always zero.

Simplify the usage by making the return type 'void' instead.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Fix warning reported by kernel test robot:
		drivers/mmc/host/sdhci-esdhc-imx.c:2103:6:
		warning: variable 'ret' is used uninitialized
		whenever 'if' condition is false
		[-Wsometimes-uninitialized]


 drivers/mmc/host/sdhci-acpi.c      |  8 +++-----
 drivers/mmc/host/sdhci-esdhc-imx.c | 12 +++---------
 drivers/mmc/host/sdhci-of-at91.c   |  8 ++++----
 drivers/mmc/host/sdhci-pci-core.c  | 19 ++++---------------
 drivers/mmc/host/sdhci-pxav3.c     |  8 +++-----
 drivers/mmc/host/sdhci-s3c.c       | 10 ++++------
 drivers/mmc/host/sdhci-xenon.c     |  9 ++-------
 drivers/mmc/host/sdhci.c           |  8 ++------
 drivers/mmc/host/sdhci.h           |  4 ++--
 drivers/mmc/host/sdhci_am654.c     |  8 ++------
 10 files changed, 29 insertions(+), 65 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index e6c5c82f64fa..d04c633f2b59 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -1028,14 +1028,11 @@ static int sdhci_acpi_runtime_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
 	struct sdhci_host *host = c->host;
-	int ret;
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
 
-	ret = sdhci_runtime_suspend_host(host);
-	if (ret)
-		return ret;
+	sdhci_runtime_suspend_host(host);
 
 	sdhci_acpi_reset_signal_voltage_if_needed(dev);
 	return 0;
@@ -1047,7 +1044,8 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
 
 	sdhci_acpi_byt_setting(&c->pdev->dev);
 
-	return sdhci_runtime_resume_host(c->host, 0);
+	sdhci_runtime_resume_host(c->host, 0);
+	return 0;
 }
 
 #endif
diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index ac187a8798b7..089ed0ccd9c4 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -2106,9 +2106,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 			return ret;
 	}
 
-	ret = sdhci_runtime_suspend_host(host);
-	if (ret)
-		return ret;
+	sdhci_runtime_suspend_host(host);
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
@@ -2122,7 +2120,7 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
 	if (imx_data->socdata->flags & ESDHC_FLAG_PMQOS)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_esdhc_runtime_resume(struct device *dev)
@@ -2152,17 +2150,13 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 
 	esdhc_pltfm_set_clock(host, imx_data->actual_clock);
 
-	err = sdhci_runtime_resume_host(host, 0);
-	if (err)
-		goto disable_ipg_clk;
+	sdhci_runtime_resume_host(host, 0);
 
 	if (host->mmc->caps2 & MMC_CAP2_CQE)
 		err = cqhci_resume(host->mmc);
 
 	return err;
 
-disable_ipg_clk:
-	clk_disable_unprepare(imx_data->clk_ipg);
 disable_per_clk:
 	clk_disable_unprepare(imx_data->clk_per);
 disable_ahb_clk:
diff --git a/drivers/mmc/host/sdhci-of-at91.c b/drivers/mmc/host/sdhci-of-at91.c
index 97988ed37467..8f12ba6a4f90 100644
--- a/drivers/mmc/host/sdhci-of-at91.c
+++ b/drivers/mmc/host/sdhci-of-at91.c
@@ -251,9 +251,8 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_at91_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	int ret;
 
-	ret = sdhci_runtime_suspend_host(host);
+	sdhci_runtime_suspend_host(host);
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
@@ -262,7 +261,7 @@ static int sdhci_at91_runtime_suspend(struct device *dev)
 	clk_disable_unprepare(priv->hclock);
 	clk_disable_unprepare(priv->mainck);
 
-	return ret;
+	return 0;
 }
 
 static int sdhci_at91_runtime_resume(struct device *dev)
@@ -300,7 +299,8 @@ static int sdhci_at91_runtime_resume(struct device *dev)
 	}
 
 out:
-	return sdhci_runtime_resume_host(host, 0);
+	sdhci_runtime_resume_host(host, 0);
+	return 0;
 }
 #endif /* CONFIG_PM */
 
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 13a84b9309e0..7f66d426c3c2 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -152,18 +152,15 @@ static int sdhci_pci_runtime_suspend_host(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot;
 	struct sdhci_host *host;
-	int i, ret;
 
-	for (i = 0; i < chip->num_slots; i++) {
+	for (int i = 0; i < chip->num_slots; i++) {
 		slot = chip->slots[i];
 		if (!slot)
 			continue;
 
 		host = slot->host;
 
-		ret = sdhci_runtime_suspend_host(host);
-		if (ret)
-			goto err_pci_runtime_suspend;
+		sdhci_runtime_suspend_host(host);
 
 		if (chip->rpm_retune &&
 		    host->tuning_mode != SDHCI_TUNING_MODE_3)
@@ -171,26 +168,18 @@ static int sdhci_pci_runtime_suspend_host(struct sdhci_pci_chip *chip)
 	}
 
 	return 0;
-
-err_pci_runtime_suspend:
-	while (--i >= 0)
-		sdhci_runtime_resume_host(chip->slots[i]->host, 0);
-	return ret;
 }
 
 static int sdhci_pci_runtime_resume_host(struct sdhci_pci_chip *chip)
 {
 	struct sdhci_pci_slot *slot;
-	int i, ret;
 
-	for (i = 0; i < chip->num_slots; i++) {
+	for (int i = 0; i < chip->num_slots; i++) {
 		slot = chip->slots[i];
 		if (!slot)
 			continue;
 
-		ret = sdhci_runtime_resume_host(slot->host, 0);
-		if (ret)
-			return ret;
+		sdhci_runtime_resume_host(slot->host, 0);
 	}
 
 	return 0;
diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 3fb56face3d8..450d2d0e0c39 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -525,11 +525,8 @@ static int sdhci_pxav3_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct sdhci_pxa *pxa = sdhci_pltfm_priv(pltfm_host);
-	int ret;
 
-	ret = sdhci_runtime_suspend_host(host);
-	if (ret)
-		return ret;
+	sdhci_runtime_suspend_host(host);
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
@@ -551,7 +548,8 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 	if (!IS_ERR(pxa->clk_core))
 		clk_prepare_enable(pxa->clk_core);
 
-	return sdhci_runtime_resume_host(host, 0);
+	sdhci_runtime_resume_host(host, 0);
+	return 0;
 }
 #endif
 
diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index bdf4dc0d6b77..dedc4e3a217e 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -714,9 +714,8 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_s3c *ourhost = to_s3c(host);
 	struct clk *busclk = ourhost->clk_io;
-	int ret;
 
-	ret = sdhci_runtime_suspend_host(host);
+	sdhci_runtime_suspend_host(host);
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
@@ -724,7 +723,7 @@ static int sdhci_s3c_runtime_suspend(struct device *dev)
 	if (ourhost->cur_clk >= 0)
 		clk_disable_unprepare(ourhost->clk_bus[ourhost->cur_clk]);
 	clk_disable_unprepare(busclk);
-	return ret;
+	return 0;
 }
 
 static int sdhci_s3c_runtime_resume(struct device *dev)
@@ -732,13 +731,12 @@ static int sdhci_s3c_runtime_resume(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_s3c *ourhost = to_s3c(host);
 	struct clk *busclk = ourhost->clk_io;
-	int ret;
 
 	clk_prepare_enable(busclk);
 	if (ourhost->cur_clk >= 0)
 		clk_prepare_enable(ourhost->clk_bus[ourhost->cur_clk]);
-	ret = sdhci_runtime_resume_host(host, 0);
-	return ret;
+	sdhci_runtime_resume_host(host, 0);
+	return 0;
 }
 #endif
 
diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index 098f0ea45cbe..15a76f8accea 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -648,11 +648,8 @@ static int xenon_runtime_suspend(struct device *dev)
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
 	struct xenon_priv *priv = sdhci_pltfm_priv(pltfm_host);
-	int ret;
 
-	ret = sdhci_runtime_suspend_host(host);
-	if (ret)
-		return ret;
+	sdhci_runtime_suspend_host(host);
 
 	if (host->tuning_mode != SDHCI_TUNING_MODE_3)
 		mmc_retune_needed(host->mmc);
@@ -687,9 +684,7 @@ static int xenon_runtime_resume(struct device *dev)
 		priv->restore_needed = false;
 	}
 
-	ret = sdhci_runtime_resume_host(host, 0);
-	if (ret)
-		goto out;
+	sdhci_runtime_resume_host(host, 0);
 	return 0;
 out:
 	clk_disable_unprepare(pltfm_host->clk);
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 32fa0b2bb912..9e0941f5023a 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -3863,7 +3863,7 @@ int sdhci_resume_host(struct sdhci_host *host)
 
 EXPORT_SYMBOL_GPL(sdhci_resume_host);
 
-int sdhci_runtime_suspend_host(struct sdhci_host *host)
+void sdhci_runtime_suspend_host(struct sdhci_host *host)
 {
 	unsigned long flags;
 
@@ -3880,12 +3880,10 @@ int sdhci_runtime_suspend_host(struct sdhci_host *host)
 	spin_lock_irqsave(&host->lock, flags);
 	host->runtime_suspended = true;
 	spin_unlock_irqrestore(&host->lock, flags);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(sdhci_runtime_suspend_host);
 
-int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
+void sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
 {
 	struct mmc_host *mmc = host->mmc;
 	unsigned long flags;
@@ -3931,8 +3929,6 @@ int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset)
 	sdhci_enable_card_detection(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
-
-	return 0;
 }
 EXPORT_SYMBOL_GPL(sdhci_runtime_resume_host);
 
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index f9d65dd0f2b2..6ccb21e50ee4 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -879,8 +879,8 @@ bool sdhci_enable_irq_wakeups(struct sdhci_host *host);
 void sdhci_disable_irq_wakeups(struct sdhci_host *host);
 int sdhci_suspend_host(struct sdhci_host *host);
 int sdhci_resume_host(struct sdhci_host *host);
-int sdhci_runtime_suspend_host(struct sdhci_host *host);
-int sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
+void sdhci_runtime_suspend_host(struct sdhci_host *host);
+void sdhci_runtime_resume_host(struct sdhci_host *host, int soft_reset);
 #endif
 
 void sdhci_cqe_enable(struct mmc_host *mmc);
diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index 73385ff4c0f3..e4d9faa05e11 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -1082,9 +1082,7 @@ static int sdhci_am654_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_runtime_suspend_host(host);
-	if (ret)
-		return ret;
+	sdhci_runtime_suspend_host(host);
 
 	/* disable the clock */
 	clk_disable_unprepare(pltfm_host->clk);
@@ -1106,9 +1104,7 @@ static int sdhci_am654_runtime_resume(struct device *dev)
 	if (ret)
 		return ret;
 
-	ret = sdhci_runtime_resume_host(host, 0);
-	if (ret)
-		return ret;
+	sdhci_runtime_resume_host(host, 0);
 
 	ret = cqhci_resume(host->mmc);
 	if (ret)
-- 
2.48.1

