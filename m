Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA41029B8CE;
	Fri, 15 Aug 2025 01:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222951; cv=none; b=N7/qF1MzQy298ephewI10hJsGGNpF/LoegX1vQEu6tYKyp8op2Xpo8Xyu2EnBee60Q8aTi5ExcsodWPCJJbKM9sGDROvapw3z8EX3gaOqnmsSM87q9bL6IPWKbmrk0Sqo3BhRbEB/Hl1UmgoQm5THb4DYtnLYI3fH3jr6wwrUkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222951; c=relaxed/simple;
	bh=fCpU2z9tS/VV7L6nfg3/4EK4ZZ3KWPbuidPRnhC6sbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CSHF9zZ0VyD3AF2uPIVgtsUPl6G0yM/DEBleS103ZRxMh0iYvZWpSqKnDJDuXKWYAS9CxYS7cxE2Lsj1YVJ/TyjzKG8ta3nKlnMLnIkIzM1FRGAg72cTekmxvBeP4iyYxWX9NzfNkYNuKtddSPhaHI+6PkqcR6h5DXVEv5BVXuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ofl++gEF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ofl++gEF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F74AC4CEF1;
	Fri, 15 Aug 2025 01:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222951;
	bh=fCpU2z9tS/VV7L6nfg3/4EK4ZZ3KWPbuidPRnhC6sbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ofl++gEF8hDD1BiUk0L5kOrL3tmhCQRcx7V73vE/h/nvVo/61aJ5OTvX1YpHhWvbC
	 o/keqG0LYNNdk4ryh7WJ8rPWlIUSJIZm99vL+wo7NhM+MYHhYQi2OgHsBxCpg6ite7
	 KU23jZIXTt0IuKaRXeOMK20TNAJgMpNvrCcXwwmo4XhfC/ErDCZaVoQqITO+ks6/rH
	 wF5z9CUJMsmJRbBl6hConr4BTq67ZDKm8iyfyS4GcS53Ijoe7p5+QTiN30lZyX8CWG
	 hrhZKfODN/o8inMGwinl/8hAwAk5wil9OLfUn5IaEwwVuBSvFE/nUwWNLkErF3NrBf
	 C+J2Ob8jeRo9g==
From: Jisheng Zhang <jszhang@kernel.org>
To: Ulf Hansson <ulf.hansson@linaro.org>,
	Aubin Constans <aubin.constans@microchip.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	=?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
	Jaehoon Chung <jh80.chung@samsung.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Russell King <linux@armlinux.org.uk>,
	Chaotian Jing <chaotian.jing@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kamal Dasu <kamal.dasu@broadcom.com>,
	Al Cooper <alcooperx@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Michal Simek <michal.simek@amd.com>,
	Eugen Hristev <eugen.hristev@linaro.org>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Ben Dooks <ben-linux@fluff.org>,
	Viresh Kumar <vireshk@kernel.org>,
	Orson Zhai <orsonzhai@gmail.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Chunyan Zhang <zhang.lyra@gmail.com>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Alexey Charkov <alchark@gmail.com>
Cc: linux-mmc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 35/38] mmc: dw_mmc: exynos: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:10 +0800
Message-ID: <20250815013413.28641-36-jszhang@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250815013413.28641-1-jszhang@kernel.org>
References: <20250815013413.28641-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the modern PM macros for the suspend and resume functions to be
automatically dropped by the compiler when CONFIG_PM or
CONFIG_PM_SLEEP are disabled, without having to use #ifdef guards.

This has the advantage of always compiling these functions in,
independently of any Kconfig option. Thanks to that, bugs and other
regressions are subsequently easier to catch.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/dw_mmc-exynos.c | 13 +++----------
 drivers/mmc/host/dw_mmc.h        |  3 +++
 2 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index e3548408ca39..384609671a9a 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -189,7 +189,6 @@ static void dw_mci_exynos_set_clksel_timing(struct dw_mci *host, u32 timing)
 		set_bit(DW_MMC_CARD_NO_USE_HOLD, &host->slot->flags);
 }
 
-#ifdef CONFIG_PM
 static int dw_mci_exynos_runtime_resume(struct device *dev)
 {
 	struct dw_mci *host = dev_get_drvdata(dev);
@@ -203,9 +202,7 @@ static int dw_mci_exynos_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif /* CONFIG_PM */
 
-#ifdef CONFIG_PM_SLEEP
 /**
  * dw_mci_exynos_suspend_noirq - Exynos-specific suspend code
  * @dev: Device to suspend (this device)
@@ -265,7 +262,6 @@ static int dw_mci_exynos_resume_noirq(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static void dw_mci_exynos_config_hs400(struct dw_mci *host, u32 timing)
 {
@@ -712,11 +708,8 @@ static void dw_mci_exynos_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dw_mci_exynos_pmops = {
-	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend_noirq,
-				      dw_mci_exynos_resume_noirq)
-	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
-			   dw_mci_exynos_runtime_resume,
-			   NULL)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(dw_mci_exynos_suspend_noirq, dw_mci_exynos_resume_noirq)
+	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_exynos_runtime_resume, NULL)
 };
 
 static struct platform_driver dw_mci_exynos_pltfm_driver = {
@@ -726,7 +719,7 @@ static struct platform_driver dw_mci_exynos_pltfm_driver = {
 		.name		= "dwmmc_exynos",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_exynos_match,
-		.pm		= &dw_mci_exynos_pmops,
+		.pm		= pm_ptr(&dw_mci_exynos_pmops),
 	},
 };
 
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 5463392dc811..588027932412 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -541,6 +541,9 @@ extern void dw_mci_remove(struct dw_mci *host);
 #ifdef CONFIG_PM
 extern int dw_mci_runtime_suspend(struct device *device);
 extern int dw_mci_runtime_resume(struct device *device);
+#else
+static inline int dw_mci_runtime_suspend(struct device *device) { return -EOPNOTSUPP; }
+static inline int dw_mci_runtime_resume(struct device *device) { return -EOPNOTSUPP; }
 #endif
 
 /**
-- 
2.50.0

