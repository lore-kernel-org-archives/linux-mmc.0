Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A3917B425;
	Fri, 15 Aug 2025 01:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222857; cv=none; b=NrFBJ95A+5zflnEhaSS5xhn6+ZoNqZAuDuZTpq3HGsq3z1z4j6a5v0jiZXsSEvVobXIezUr9vLJQdLxH89iBVzc8qYxxcBxucLdm2yycluUmIx/+mbtJZzlhGI9DELAkMkhU83f6+9YxGEZyTmim8qVvPz7f/Zuii+iJir1rQ5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222857; c=relaxed/simple;
	bh=7GhD3DnX4djD7Vr1Ea8aB9eSRTm/evft74otUw4IJg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uTbPzdrVOOyIQj+/UhTSwaMLmDF3IeWBZTYTQp9/EMkrPJccTLLb+Y5cwq558XT31MhKYiV0NlQ+fDafoR2QX7Ci4EVxOGQEkvuPY6EgNfrmsuiPZy+IIxOf2/L2WIj43F8xlcAc9EIeZwpnSYhAiy83MP8D4/+ejTXmpNMSPDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iz2zQGeN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz2zQGeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4099FC4CEF1;
	Fri, 15 Aug 2025 01:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222854;
	bh=7GhD3DnX4djD7Vr1Ea8aB9eSRTm/evft74otUw4IJg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iz2zQGeNI0OSbBAbZqn5iCJYn0Bu4VRlGo2oeUsTfGB8Z1Jpv1x/QCNkdxmeBm3GC
	 n7V19MxLnRa9R9tRr5wFufARLNsLrHKXFerQRgb5P+WKRts3saKpWezEjdOlmuYlah
	 lgoWmgastZh28HeukMFH6ktgZpFoABff51vJE7w8YRdFuanOjiO4QBl2HZoSyZxV6D
	 Wzpmc8eQrjqcwauWS7DnoFB2nHL1jEPpG9s1GmTs+Z7cqLqJX++TlAWAaNrdK/PR9l
	 Cgk8nbuAYt6Ur5DuqKIFS4i1WPsx6qihbyKr3HS6eglZWx9cHbSnWHON2d+waXXsqo
	 /5n+FibBKy05A==
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
Subject: [PATCH 22/38] mmc: sdhci-omap: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:57 +0800
Message-ID: <20250815013413.28641-23-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-omap.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci-omap.c b/drivers/mmc/host/sdhci-omap.c
index cdb09605e009..b5d7c1a80a92 100644
--- a/drivers/mmc/host/sdhci-omap.c
+++ b/drivers/mmc/host/sdhci-omap.c
@@ -1400,8 +1400,7 @@ static void sdhci_omap_remove(struct platform_device *pdev)
 	pm_runtime_force_suspend(dev);
 }
 
-#ifdef CONFIG_PM
-static void __maybe_unused sdhci_omap_context_save(struct sdhci_omap_host *omap_host)
+static void sdhci_omap_context_save(struct sdhci_omap_host *omap_host)
 {
 	omap_host->con = sdhci_omap_readl(omap_host, SDHCI_OMAP_CON);
 	omap_host->hctl = sdhci_omap_readl(omap_host, SDHCI_OMAP_HCTL);
@@ -1412,7 +1411,7 @@ static void __maybe_unused sdhci_omap_context_save(struct sdhci_omap_host *omap_
 }
 
 /* Order matters here, HCTL must be restored in two phases */
-static void __maybe_unused sdhci_omap_context_restore(struct sdhci_omap_host *omap_host)
+static void sdhci_omap_context_restore(struct sdhci_omap_host *omap_host)
 {
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_HCTL, omap_host->hctl);
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_CAPA, omap_host->capa);
@@ -1424,7 +1423,7 @@ static void __maybe_unused sdhci_omap_context_restore(struct sdhci_omap_host *om
 	sdhci_omap_writel(omap_host, SDHCI_OMAP_ISE, omap_host->ise);
 }
 
-static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
+static int sdhci_omap_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1443,7 +1442,7 @@ static int __maybe_unused sdhci_omap_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused sdhci_omap_runtime_resume(struct device *dev)
+static int sdhci_omap_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1458,13 +1457,10 @@ static int __maybe_unused sdhci_omap_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_omap_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(sdhci_omap_runtime_suspend,
-			   sdhci_omap_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	RUNTIME_PM_OPS(sdhci_omap_runtime_suspend, sdhci_omap_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver sdhci_omap_driver = {
@@ -1473,7 +1469,7 @@ static struct platform_driver sdhci_omap_driver = {
 	.driver = {
 		   .name = "sdhci-omap",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		   .pm = &sdhci_omap_dev_pm_ops,
+		   .pm = pm_ptr(&sdhci_omap_dev_pm_ops),
 		   .of_match_table = omap_sdhci_match,
 		  },
 };
-- 
2.50.0

