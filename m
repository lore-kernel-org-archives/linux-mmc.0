Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACF7296BDF;
	Fri, 15 Aug 2025 01:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222807; cv=none; b=TTnGVQz7ui6X4gWPK0NAXwORZfxB1BXgyxGrIJx6fc+nTx59bz803uqLUWcVmL6PblvDC1uOye4+AqOLCWAQuE5m9XVVJRmj1J1yqhP3AJW717diJNrhzGFlMLZrBdCpNQgmxVJCrz4CmwcVv7n9FALSZU3s8PHqaVFEOcXEe7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222807; c=relaxed/simple;
	bh=YHFUwlHlhBKsJ5yZ5yqkXs/Purgd1GS7WR1VUPMWAt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MXHIIUueVuI+QYsb19oXDk7x9uFkAqCKkL2Ha5EM2USCmM6ERlXypvtjcRZGUsDdZsd0+bzCBWj4sIjG0otGOY6GfGzfGHEIdOsmeuKQVybiJPxmoBkOPjzNDLt0hh/U5trAjwbwUVB+ej/aINr+Yt6eZDmNco9JjZKHtZ97/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QucpIfWu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QucpIfWu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2F74C4CEF6;
	Fri, 15 Aug 2025 01:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222806;
	bh=YHFUwlHlhBKsJ5yZ5yqkXs/Purgd1GS7WR1VUPMWAt0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QucpIfWuarf1LW5+Mn2mNMWk6v0LhEgN0WU/S47R5wJtyW35lILfLPVJcPTYoLG57
	 gGdSCKLkhVwhurW6Mtp2hfTlxQ6w/pfmHhK08fDWt99KsAejVUz4ZZzGOCGRdIcoz0
	 dKnYyHSgToGa/UJXnblKWfmzyAhBrl9s7S6Zo/B6jwkX5SuMnH4Hvw1/9Cb2GV6Wky
	 imdZJc8ISrVoXUZAnns5ZBRQ0CS9XH2ulVT1kYTRuKrOPOpau6tfruP1rGaGlJWQ0/
	 +xADkVGgiNzF3STcR7MM9dOJ/5Ox2FgY24eUjRVGoRfyGdH7Z1jcH7gaSMjba6b8y0
	 aVYZy37reN1Bw==
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
Subject: [PATCH 16/38] mmc: sdhci_am654: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:51 +0800
Message-ID: <20250815013413.28641-17-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci_am654.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci_am654.c b/drivers/mmc/host/sdhci_am654.c
index e4fc345be7e5..48bf5532e571 100644
--- a/drivers/mmc/host/sdhci_am654.c
+++ b/drivers/mmc/host/sdhci_am654.c
@@ -1018,7 +1018,6 @@ static void sdhci_am654_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 }
 
-#ifdef CONFIG_PM
 static int sdhci_am654_restore(struct sdhci_host *host)
 {
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1106,20 +1105,17 @@ static int sdhci_am654_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_am654_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(sdhci_am654_runtime_suspend,
-			   sdhci_am654_runtime_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
+	RUNTIME_PM_OPS(sdhci_am654_runtime_suspend, sdhci_am654_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
 };
 
 static struct platform_driver sdhci_am654_driver = {
 	.driver = {
 		.name = "sdhci-am654",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm = &sdhci_am654_dev_pm_ops,
+		.pm = pm_ptr(&sdhci_am654_dev_pm_ops),
 		.of_match_table = sdhci_am654_of_match,
 	},
 	.probe = sdhci_am654_probe,
-- 
2.50.0

