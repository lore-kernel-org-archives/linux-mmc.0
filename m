Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D431292B38;
	Fri, 15 Aug 2025 01:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222719; cv=none; b=mlJVfnLiqxhJj8ZQGvr8dvCgPIlvPcYwuxew7U6WQPmzKlrlrIuScMQCASsAhjvV5M+I+vBu/qBADe7yBTTz/8eALIrfH2mU7FO7KQoYPWhx2h2lrzzUgTn5Ba4IRaFN2KsoWJX6TZP8tTYgS3SVNpOyLL8lk42xct2NzEUcPNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222719; c=relaxed/simple;
	bh=D3DkjDD6dvOBo/VwPs1BDV3f/nKM+KgJX7LDIFABO4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a5+xTMJnu2JoNG9vo3GvSPyANn5RdLQ+o96AltZHkm2+8cGmWeBLZhpwtsIl6VlNpWFtE5Qv8+/Z5S0306J6+saEkRwr0dwh9aGp6I1aO0dB+AbuFFAEf6ac/EIo6MmEjfgDsxP69ZxVEr5ahj9Npm1DlAesFwkdVsxmeqkCBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H0IJbXyO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H0IJbXyO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D5BFC4CEED;
	Fri, 15 Aug 2025 01:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222719;
	bh=D3DkjDD6dvOBo/VwPs1BDV3f/nKM+KgJX7LDIFABO4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H0IJbXyOUjTEunP36V87uEwlEriSNZgIFWpQ38566b5M7TBfmYgq2IKpc8z9DJ/9Z
	 om1ZV94tV/fHlhD3MYLJ92BN6EhMcXOz43/4CcNOBLC5pnN7YzqyHFj4b8WQSI8A3D
	 W77QRecVcTUgID1jHNoFMvrAAfRWm1h/V19Ia5FKnqF4wzCfWByfHkZVwB4i3j00q8
	 O/SpQt9zG3NQU+a14WYl6/Ag5/P6c7cG+eYFRckFC52W4IrWsKc2xrycTJLVQk4nIj
	 GCIges9auPegfpkbOwwKVBy5d2b122oB7ME+vnP/P7rGFrL/0h8nPuSKn4cby2kjND
	 8Sky8rIQwn0Gw==
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
Subject: [PATCH 04/38] mmc: sdhci-pxav3: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:39 +0800
Message-ID: <20250815013413.28641-5-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-pxav3.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index 1371960e34eb..6fb461cdd904 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -484,7 +484,6 @@ static void sdhci_pxav3_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pxa->clk_core);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_pxav3_suspend(struct device *dev)
 {
 	int ret;
@@ -510,9 +509,7 @@ static int sdhci_pxav3_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int sdhci_pxav3_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -544,12 +541,10 @@ static int sdhci_pxav3_runtime_resume(struct device *dev)
 	sdhci_runtime_resume_host(host, 0);
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_pxav3_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pxav3_suspend, sdhci_pxav3_resume)
-	SET_RUNTIME_PM_OPS(sdhci_pxav3_runtime_suspend,
-		sdhci_pxav3_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(sdhci_pxav3_suspend, sdhci_pxav3_resume)
+	RUNTIME_PM_OPS(sdhci_pxav3_runtime_suspend, sdhci_pxav3_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_pxav3_driver = {
@@ -557,7 +552,7 @@ static struct platform_driver sdhci_pxav3_driver = {
 		.name	= "sdhci-pxav3",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(sdhci_pxav3_of_match),
-		.pm	= &sdhci_pxav3_pmops,
+		.pm	= pm_ptr(&sdhci_pxav3_pmops),
 	},
 	.probe		= sdhci_pxav3_probe,
 	.remove		= sdhci_pxav3_remove,
-- 
2.50.0

