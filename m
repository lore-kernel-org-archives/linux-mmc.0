Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907C3292B44;
	Fri, 15 Aug 2025 01:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222704; cv=none; b=bUegAg0lpVKEXGW+zwrVxwf1Tqk1P+LrA56fEhSMfjdV4zzUfCXSpX3kQGzc/jE6pu+SKu+Vx2qeZ0hWVcRJ7w3c45SRWo80oaD5DRETzdPgYA4f85EQaAAuikyCfkRsmhaoSbBJbYB67pMwESJT2jKGE5asdsZL6lQ382Ov0mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222704; c=relaxed/simple;
	bh=qzpM1XuJhY79b5vm7aQ2AzS3RoIhsSh8ykJUmXGcMPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CU0nOo52vOmQhJyeisM66DuvMDRdYVpH/Kz1EMMcN4rFHn70Hbp1hu4o6kNuoEmwd/UKyZOvhIL+1KVdfstA0hc2Iv9XwW88M3t+XtK5AKc3I4GQGVmtuWGR68p2glwHHuReslaKL1qosssgnSPOVQssSr3bYap4w0XUMWZzvq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Stakwimz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Stakwimz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A9D7C4CEF1;
	Fri, 15 Aug 2025 01:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222704;
	bh=qzpM1XuJhY79b5vm7aQ2AzS3RoIhsSh8ykJUmXGcMPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Stakwimz9E9Xy8tXWPKwm3hkGyVw5iyWxs4ffgTN9NRgzMUkT2ABqbGXXsDMW2yWk
	 3Da4EJaN2vjUKvaSKKsmUd3hol/fZrG9DtUjgXB15dSqLx4FhccUz+3Ga7GJwOHJ+m
	 PKJdTRAZ7E7z7c+vztl6XlAtImwlWsVd4qSEj7oct7P62geVoBevnxl4Wb4qXcdx+3
	 SSb+kASiI4vazjVuAiF2rYRrukH1yqmfjyLNY5Z+j1/+KsJbxc4zoEkc7mW9Q+57rg
	 2DN97HZ/IDMhhCCWkWlaCk64MiIIWZP1NOjvd+Vvr/wjJcxtdyVK1kBSFqczqGhor9
	 bUSvGRvwEMXCQ==
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
Subject: [PATCH 02/38] mmc: sdhci-of-dwcmshc: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:37 +0800
Message-ID: <20250815013413.28641-3-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-of-dwcmshc.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-dwcmshc.c b/drivers/mmc/host/sdhci-of-dwcmshc.c
index ee6b1096f709..eebd45389956 100644
--- a/drivers/mmc/host/sdhci-of-dwcmshc.c
+++ b/drivers/mmc/host/sdhci-of-dwcmshc.c
@@ -1499,7 +1499,6 @@ static void dwcmshc_remove(struct platform_device *pdev)
 	clk_bulk_disable_unprepare(priv->num_other_clks, priv->other_clks);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int dwcmshc_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -1570,9 +1569,6 @@ static int dwcmshc_resume(struct device *dev)
 	clk_disable_unprepare(pltfm_host->clk);
 	return ret;
 }
-#endif
-
-#ifdef CONFIG_PM
 
 static void dwcmshc_enable_card_clk(struct sdhci_host *host)
 {
@@ -1603,12 +1599,9 @@ static int dwcmshc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-#endif
-
 static const struct dev_pm_ops dwcmshc_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
-	SET_RUNTIME_PM_OPS(dwcmshc_runtime_suspend,
-			   dwcmshc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(dwcmshc_suspend, dwcmshc_resume)
+	RUNTIME_PM_OPS(dwcmshc_runtime_suspend, dwcmshc_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_dwcmshc_driver = {
@@ -1617,7 +1610,7 @@ static struct platform_driver sdhci_dwcmshc_driver = {
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_dwcmshc_dt_ids,
 		.acpi_match_table = ACPI_PTR(sdhci_dwcmshc_acpi_ids),
-		.pm = &dwcmshc_pmops,
+		.pm = pm_ptr(&dwcmshc_pmops),
 	},
 	.probe	= dwcmshc_probe,
 	.remove = dwcmshc_remove,
-- 
2.50.0

