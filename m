Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B66E29344F;
	Fri, 15 Aug 2025 01:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222823; cv=none; b=Jx65N1ZnGgOOzCxF+YarpCcTSWH8O3cXB0La+MmK5WNhExVgWGHGPOnG6feW+NFYiP/pBUkb7Tyx9zGPwpB01+iY62AvmU3C/FUhJEWjhp3uOoTkc/HpsOBLtiVLawCQAnTrx1XbgVKz7csLPcR8C1ocSr3AuAd6581f4ZxHicE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222823; c=relaxed/simple;
	bh=GKhcDi4HWFWwr3pajLQPCJLuDx+zYQo5xPViOOs7nCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fEomxWNi3R5nDmx9iT/TBnplPCLL0RyEc+ebxpYZfmAGmToERQ+rr8q+ktL95b9nQrp6qCpj1uh7SSCBdecMUBQXAq7zEoJueQHylM+O9teEo0zx4Ah9hVdsEY5/k/yP1rIU40J4MgLe6yNFBNUEKV8JbseZni019x/osN9s8Yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWJWeBFq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWJWeBFq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A78AC4CEED;
	Fri, 15 Aug 2025 01:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222822;
	bh=GKhcDi4HWFWwr3pajLQPCJLuDx+zYQo5xPViOOs7nCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWJWeBFq7eKqnGcMu+sIhicxUZxbUaeM6ba6RccfbF/2dBSBC3rUY+Z7OAkD5OXpi
	 hdi/j2S5jjvEVAQY/d0VbBxi7TjMvCZhey0dtD3PgsgdpSHYbgrDyb55paio6w71kZ
	 nPB6HcSHLF0X/+HEQAURNW3Y1XDMm5wpkxtGaV8AHXog6sJO0q0Z9ynSCiw4lUb6fH
	 RobI31dstAdof/57F/Rc+pLnmieKT/zjBTMrbEYz008rtvMhV9gl+AT7wd5ucNhmrr
	 iT8nN3Pw45SPsHNfIZcU6UhrAGQQRka/wRfy/RUrWpIsJ2tgoUI1kax0SB5YKAyIKO
	 THkc2wda48foQ==
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
Subject: [PATCH 18/38] mmc: sdhci-esdhc-imx: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:53 +0800
Message-ID: <20250815013413.28641-19-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-esdhc-imx.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
index a040c0896a7b..a7a5df673b0f 100644
--- a/drivers/mmc/host/sdhci-esdhc-imx.c
+++ b/drivers/mmc/host/sdhci-esdhc-imx.c
@@ -1650,7 +1650,6 @@ static void sdhci_esdhc_imx_hwinit(struct sdhci_host *host)
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
 static void sdhc_esdhc_tuning_save(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1707,7 +1706,6 @@ static void sdhc_esdhc_tuning_restore(struct sdhci_host *host)
 		       host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
 	}
 }
-#endif
 
 static void esdhc_cqe_enable(struct mmc_host *mmc)
 {
@@ -2016,7 +2014,6 @@ static void sdhci_esdhc_imx_remove(struct platform_device *pdev)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_esdhc_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -2112,9 +2109,7 @@ static int sdhci_esdhc_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int sdhci_esdhc_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -2188,12 +2183,10 @@ static int sdhci_esdhc_runtime_resume(struct device *dev)
 		cpu_latency_qos_remove_request(&imx_data->pm_qos_req);
 	return err;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_esdhc_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
-	SET_RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend,
-				sdhci_esdhc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(sdhci_esdhc_suspend, sdhci_esdhc_resume)
+	RUNTIME_PM_OPS(sdhci_esdhc_runtime_suspend, sdhci_esdhc_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_esdhc_imx_driver = {
@@ -2201,7 +2194,7 @@ static struct platform_driver sdhci_esdhc_imx_driver = {
 		.name	= "sdhci-esdhc-imx",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = imx_esdhc_dt_ids,
-		.pm	= &sdhci_esdhc_pmops,
+		.pm	= pm_ptr(&sdhci_esdhc_pmops),
 	},
 	.probe		= sdhci_esdhc_imx_probe,
 	.remove		= sdhci_esdhc_imx_remove,
-- 
2.50.0

