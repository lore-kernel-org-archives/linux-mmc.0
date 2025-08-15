Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA84293B75;
	Fri, 15 Aug 2025 01:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222799; cv=none; b=aziUfpt5IqwVzr+g/hp0n4TDVnDXZ4TPCV+aaQ7BooGhRjO/mJ9cMkeoCdKwCEEehzicFZqt2keMgfS0T4Nb+3QkKc0FJN6VZJ4Zkyb+t0Af17SLnwun91bFEUMdgA1hUkTrFgIbSSGbw5/U7vwWtD7sJZBj/ikzCwrY2MVmmmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222799; c=relaxed/simple;
	bh=gLvBbuGkoQJzWj+visP84phl5aqwxR7XVsLyoawyYjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lq3oDq0yqGxGIyxV9GcEHJ4tKYo+lTQ50xSbjTxe4mRnbnRpyAgqsyRZD5OLSvylZy3JW744ftEoenNc54Fwc8tH+0dTw4a6IrS31Gi0SLnDLdvh2+vwMMc212O3Vys/IhwyHokHbIlbXl1UcaRG83jd80WmoT/IWCbEifEVW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyR1dJGT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyR1dJGT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97253C4CEED;
	Fri, 15 Aug 2025 01:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222799;
	bh=gLvBbuGkoQJzWj+visP84phl5aqwxR7XVsLyoawyYjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyR1dJGTzB/CFKgXUDQACrEkhLdIZAIVGYgVR1x2iPuqmcgvF4l5uJsZvO1IOXWLy
	 OHL/LYMtLop4LfHOQBeP24OWTts2l6o5SNwb4ak1Z4loxHzWYDmQLbx++g7c6/+Sbe
	 SSDzOwo/SjxgpDdKpQ9/w2dW/2Ykoxma92AZMH9BevLfAr65etEtGlpiNeZTpmZ+hJ
	 fTlhodYwajMRdoalXCWd/nVj14uACt7rpj9XBB5iuHAGROYPMPuthtcA/wfTFTqoFQ
	 W+xSdoJdfQjLqToIG3XkkOdNDqL+lGrpT3RZkdK3jhs6tdfPKNhFO8g+Co2CRhan4u
	 36hpkYd60NWKw==
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
Subject: [PATCH 15/38] mmc: sdhci-acpi: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:50 +0800
Message-ID: <20250815013413.28641-16-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-acpi.c | 18 ++++--------------
 1 file changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/sdhci-acpi.c b/drivers/mmc/host/sdhci-acpi.c
index 2d46d4854fa1..84c7054607fc 100644
--- a/drivers/mmc/host/sdhci-acpi.c
+++ b/drivers/mmc/host/sdhci-acpi.c
@@ -973,8 +973,7 @@ static void sdhci_acpi_remove(struct platform_device *pdev)
 		c->slot->free_slot(pdev);
 }
 
-static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
-	struct device *dev)
+static void sdhci_acpi_reset_signal_voltage_if_needed(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
 	struct sdhci_host *host = c->host;
@@ -989,8 +988,6 @@ static void __maybe_unused sdhci_acpi_reset_signal_voltage_if_needed(
 	}
 }
 
-#ifdef CONFIG_PM_SLEEP
-
 static int sdhci_acpi_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
@@ -1017,10 +1014,6 @@ static int sdhci_acpi_resume(struct device *dev)
 	return sdhci_resume_host(c->host);
 }
 
-#endif
-
-#ifdef CONFIG_PM
-
 static int sdhci_acpi_runtime_suspend(struct device *dev)
 {
 	struct sdhci_acpi_host *c = dev_get_drvdata(dev);
@@ -1045,12 +1038,9 @@ static int sdhci_acpi_runtime_resume(struct device *dev)
 	return 0;
 }
 
-#endif
-
 static const struct dev_pm_ops sdhci_acpi_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
-	SET_RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend,
-			sdhci_acpi_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(sdhci_acpi_suspend, sdhci_acpi_resume)
+	RUNTIME_PM_OPS(sdhci_acpi_runtime_suspend, sdhci_acpi_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_acpi_driver = {
@@ -1058,7 +1048,7 @@ static struct platform_driver sdhci_acpi_driver = {
 		.name			= "sdhci-acpi",
 		.probe_type		= PROBE_PREFER_ASYNCHRONOUS,
 		.acpi_match_table	= sdhci_acpi_ids,
-		.pm			= &sdhci_acpi_pm_ops,
+		.pm			= pm_ptr(&sdhci_acpi_pm_ops),
 	},
 	.probe	= sdhci_acpi_probe,
 	.remove = sdhci_acpi_remove,
-- 
2.50.0

