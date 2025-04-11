Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8C6293460;
	Fri, 11 Apr 2025 08:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744361978; cv=none; b=AONMfSkvLLXuyk6/gAgpLvXbNiaENlQ9WukYxCZJGRWwKuPNUC8Aaks9gZNXGPDoddeUJ2M5cAFVbvZ5uDsQK53Tn9RCrz2J56xF0fENcowitYPKm+Fyo7IJweTFp7ieVNUhRSOC0AycMPYqvmQMzgg8vZNzyztc+v1HEA/DWsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744361978; c=relaxed/simple;
	bh=cd0NVpO1gJZi41yHFbMFBbhS+knn/ExfpHkC+hrSSiU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hfh2Nr3dNQ+IsFuICQ4ETi8aWRpYXCpbNqLJZig5TPeVPT+sKMg0tMdnM5w/zdVsjTPfnU1s/T3Fi2XX7UGlAYTa5eqibPATad6elMHH6PzSQzBmh1o3SD4x61Oqqq11NnNskevwOYTdhbWk8zXFgSjHJp2/nXHwM5wejkqAYvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gG/2GKGy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gG/2GKGy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B51E7C4CEE2;
	Fri, 11 Apr 2025 08:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744361977;
	bh=cd0NVpO1gJZi41yHFbMFBbhS+knn/ExfpHkC+hrSSiU=;
	h=From:To:Cc:Subject:Date:From;
	b=gG/2GKGyLnlMkAHUOSNiVc922ou4J+xfkBsa1vjwXh22TNaw4Y+Oi2dDEC4SGJwpO
	 5hzUWcMpyXqoRdFGTcqIQ/fCCrrNgBvf0YgWeTSEorxsOXLBuWu8lyqXIPLH2i+QNh
	 DEctEZs06tCvb4bQdSQryLDDRSKRb3gvwIHOIcRDMiuyc3u9WQ8pH5pulppxro5O69
	 HBhfbKHYQOwrJOfYXo2Pvkib5bdQgfRaGwB4KtENOShTdXifJ78dbddIqeRwinVapV
	 zdGEOphgI1Lt835bnO/nWdkVLbG4JEG2U8Xlt1/zBnJ7XL/hFVIjx8DCS6TgIRu9HB
	 C6DKD9vtdVrRg==
From: Arnd Bergmann <arnd@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Luke Wang <ziniu.wang_1@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Josua Mayer <josua@solid-run.com>,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] mmc: esdhc-imx: convert to modern PM_OPS
Date: Fri, 11 Apr 2025 10:59:04 +0200
Message-Id: <20250411085932.1902662-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

Two newly added functions are unused in configurations without
power management support:

drivers/mmc/host/sdhci-esdhc-imx.c:1586:13: error: unused function 'sdhc_esdhc_tuning_save' [-Werror,-Wunused-function]
 1586 | static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~
drivers/mmc/host/sdhci-esdhc-imx.c:1608:13: error: unused function 'sdhc_esdhc_tuning_restore' [-Werror,-Wunused-function]
 1608 | static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
      |             ^~~~~~~~~~~~~~~~~~~~~~~~~

Remove the #ifdef checks and instead use the better macros that
silently drop the unused functions when PM is disabled. This also
requires using pm_ptr() to eliminate both the runtime and pm_sleep
operations.

Fixes: 3d1eea493894 ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: add pm_ptr()
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7e8addaed697..3c2e50d0260d 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1942,7 +1942,6 @@ static void sdhci_esdhc_imx_remove(struct platform_device *pdev)
 	sdhci_pltfm_free(pdev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_esdhc_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -2021,9 +2020,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -2103,11 +2100,10 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 	return err;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_esdhc_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
-	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
+	SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
+	RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
 				sdhci_esdhc_runtime_resume, NULL)
 };
 
@@ -2116,7 +2112,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 		.name	= "sdhci-esdhc-imx",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = imx_esdhc_dt_ids,
-		.pm	= &sdhci_esdhc_pmops,
+		.pm	= pm_ptr(&sdhci_esdhc_pmops),
 	},
 	.probe		= sdhci_esdhc_imx_probe,
 	.remove		= sdhci_esdhc_imx_remove,
-- 
2.39.5

