Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7E928A404;
	Thu, 10 Apr 2025 14:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294173; cv=none; b=Qwa1F00bAXdy33dYZ/EbuGTZhUvXVweZQO9vyL+kQZPHiQaQDvpkcFXsYrqABgseYNgmUCNlvbTfw555ULjJ77eYOCKUgno3tuRM8YKclc39RpCyOP1ja/rZWzy1EoP/v/6x3LBeBFLLn+2hGX8mF7Pi07qpHBtaBOGG99RJTow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294173; c=relaxed/simple;
	bh=DpSjE5BAz8kF66zp70q0y2bFTSB7iHjZZeJN5OuVsKY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WhPrRW5rh0YJtGKPy91VQdhR4Iv9C9i1XpZP97mkyFj4QVxMJg0Ro6me57GKCrzNTwMM3WYnWCggevOfZ+TIF5L10kh1GgysKwsGjWTiArS5jDFxRr8XvL4kF2ZPly6VXxrBnKCRpKNZhNct33EO4o2Dd5Epnh7W+KHJV/ZjAgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VqaubKMc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VqaubKMc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CC0C4CEDD;
	Thu, 10 Apr 2025 14:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744294173;
	bh=DpSjE5BAz8kF66zp70q0y2bFTSB7iHjZZeJN5OuVsKY=;
	h=From:To:Cc:Subject:Date:From;
	b=VqaubKMc5kARpMjjWo1wDPI9VjxMOBQUAhNCaQP+CR8mp9GLF2PS4yclHoikGneRT
	 2G4WdRdQ1Gm9r5L5GMrphcctR0FMWJJ0OPdRFnfNdlkd9UNArITduEj0Db7IMGUtCF
	 DZn7AqK0DOL+swc54mWskPcRsL0qPJGBmrgju98dE8605WTShXo7SojVtKLY5GIeSj
	 7diWgGieg53v7f1t+HNZ5WyeNLNfNmZ0EMp4Af64BF0YaHlOSEsEfKGGYNrnvwPfOn
	 98s0BlPQZ22AtNtKwh6tCcA/YBVESjWjFkrgJ3QZN5pmeCoaADhuRe+tQ1qc9arZJ2
	 J713FGcAf4llg==
From: Arnd Bergmann <arnd@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>,
	Haibo Chen <haibo.chen@nxp.com>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Luke Wang <ziniu.wang_1@nxp.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Ciprian Marian Costea <ciprianmarian.costea@oss.nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	imx@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	s32@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: esdhc-imx: convert to modern PM_OPS
Date: Thu, 10 Apr 2025 16:09:07 +0200
Message-Id: <20250410140921.849213-1-arnd@kernel.org>
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
silently drop the unused functions when PM is disabled.

Fixes: 3d1eea493894 ("mmc: sdhci-esdhc-imx: Save tuning value when card stays powered in suspend")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mmc/host/sdhci-esdhc-imx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index 7e8addaed697..8742622da55a 100644
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
 
-- 
2.39.5

