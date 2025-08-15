Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CA6E28750F;
	Fri, 15 Aug 2025 01:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222712; cv=none; b=KKew8064SsWE0HR8uQB9U7Rx6vFI1dZuyPmyGvXHKCrSx/9Adrnb7lIiOyJ8tcmcd9wri9zbNgncVprNPgKTLmIUtUr9C+jldu4iuz72jZeMNIx/7ff8W3Eoawgw+NmPTpb6i8Nhv+WLXlRZgdocIvVlP3SlAHonacMgi0FdZP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222712; c=relaxed/simple;
	bh=Dj5pUa6pYGCNddPS96diLSsPZ688CWM7lpn6XfJEyN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4QNtfkOMyXkCeNMefUEZcD1jIWNhIrmnjZW0GovtpEi7aOvVF7tzoKzBMFjz8NQ1z8fNQqceN+E0jhLbExiIQIwnUwHnmYCl6YymmeaPaUtmnxMsDE/HRkIQSELP5LtR1f7+1OUb7Pn+XjlrWIe30keexLYF1jYV6Q3L/IkSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUqdTHUJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUqdTHUJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63BEC4CEF6;
	Fri, 15 Aug 2025 01:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222711;
	bh=Dj5pUa6pYGCNddPS96diLSsPZ688CWM7lpn6XfJEyN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUqdTHUJP84cKaciSc+feda3XjCat/0sQjwYdBs9YejAxI6VCKODbud3cJj1KuwML
	 sBf9y11YnuiPs6NWgmH60SIO2gIBirpueH6bIJ2qIoIvfKjf25DPO6yVjO2dll9W7G
	 qje0NgLnbvNPyU1oWWj0dXDcOKUuScsd5pPbYYcKYJF806ygFqxA1KOh08myodIPru
	 q+tVch4xac3CswRUOoTfGlxxC5XK+Gm8zSGZa0+Ka/FZSKtOlMPlQzqG0pnCx0PQ8x
	 xDFMZ9AVgV64qqQI6hW9RMXUXsxFGf4Amx2wCpdazKX4nMep0T966wor3JGXAdpRIa
	 Z3AS/U7TtylUw==
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
Subject: [PATCH 03/38] mmc: sdhci-xenon: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:38 +0800
Message-ID: <20250815013413.28641-4-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-xenon.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
index b12bee8342bd..046e8100dd08 100644
--- a/drivers/mmc/host/sdhci-xenon.c
+++ b/drivers/mmc/host/sdhci-xenon.c
@@ -622,7 +622,6 @@ static void xenon_remove(struct platform_device *pdev)
 	clk_disable_unprepare(pltfm_host->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int xenon_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -635,9 +634,7 @@ static int xenon_suspend(struct device *dev)
 	priv->restore_needed = true;
 	return ret;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int xenon_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -685,14 +682,10 @@ static int xenon_runtime_resume(struct device *dev)
 	clk_disable_unprepare(pltfm_host->clk);
 	return ret;
 }
-#endif /* CONFIG_PM */
 
 static const struct dev_pm_ops sdhci_xenon_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(xenon_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(xenon_runtime_suspend,
-			   xenon_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(xenon_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(xenon_runtime_suspend, xenon_runtime_resume, NULL)
 };
 
 static const struct of_device_id sdhci_xenon_dt_ids[] = {
@@ -721,7 +714,7 @@ static struct platform_driver sdhci_xenon_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_xenon_dt_ids,
 		.acpi_match_table = ACPI_PTR(sdhci_xenon_acpi_ids),
-		.pm = &sdhci_xenon_dev_pm_ops,
+		.pm = pm_ptr(&sdhci_xenon_dev_pm_ops),
 	},
 	.probe	= xenon_probe,
 	.remove = xenon_remove,
-- 
2.50.0

