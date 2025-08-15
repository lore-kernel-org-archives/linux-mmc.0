Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E645C1459F7;
	Fri, 15 Aug 2025 01:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222831; cv=none; b=JCgaUdf11Hoz3hmMYgpj6pEtyrwwEvIpQrdfItFGDUYr2d7pWpqzRlNvjEp1wf1frXS5PESjYBtnWWE+Lw8GWYhWGpCTTWCVCD20HUR3ipDEikyeKRh3d9e2AgCYbdG0uVfbX5eeDPEdm8BVrNtO0HBeqyfKhHJT2c+EelLDZ00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222831; c=relaxed/simple;
	bh=Ux36/+4yl2iQkvaT8m/hv4l9xmuFgZ2Qi1WQEgYGMhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IsVDq346zXNJa7xZ+QuieqcgjAKcUuXzGxK8lP1en5l/zkA/j0Xrv0t4nV2aMmEgWwvh1ZYTdjgb6xYs/Ob0/jVzPGQDIAw4K+/xGQkhP23aal5Km46+7DBzcVzKS43SOCKHAEaw/bf9L/D7EYG6XjN77D+nDBfNlMsk8TO19EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mTG83LuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mTG83LuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D238C4CEF1;
	Fri, 15 Aug 2025 01:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222830;
	bh=Ux36/+4yl2iQkvaT8m/hv4l9xmuFgZ2Qi1WQEgYGMhE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mTG83LuVzFIvF0a3sV26/ciH2Ly6BSbsJxlCxeysvh8N9eRFiDaTHCz/AxI3tM7t/
	 kdiLu6NuhWS1JIDTPhP67GeHW/BHsYRIpcT4U99xG+TXN4kg3iU7VRj1qqrMUjB1px
	 NdC/AHo0FE7iT95bkn1Qq3LePDksMPB03nUwCMgpLMwQKKYqVaJnefcsfnJqnaQ2Uw
	 NgJaHhVxbJylkqb8MVr0j1GgkS6p55pA6y4UoW2KxQ/1G+0FWflK6j5hVu9+mHdFBs
	 Sz1NV1bTZGfuIP0Cqcr77ujy0Ylvonj1M6pFe4hql10f82B3pff+vsM/6BQaLWsRwC
	 QiVjMAlc2KY1A==
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
Subject: [PATCH 19/38] mmc: sdhci-of-arasan: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:54 +0800
Message-ID: <20250815013413.28641-20-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-of-arasan.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 42878474e56e..d0939b5bc1a6 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -581,7 +581,6 @@ static const struct sdhci_pltfm_data sdhci_arasan_cqe_pdata = {
 			SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
 };
 
-#ifdef CONFIG_PM_SLEEP
 /**
  * sdhci_arasan_suspend - Suspend method for the driver
  * @dev:	Address of the device structure
@@ -675,10 +674,9 @@ static int sdhci_arasan_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* ! CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
-			 sdhci_arasan_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_arasan_dev_pm_ops, sdhci_arasan_suspend,
+				sdhci_arasan_resume);
 
 /**
  * sdhci_arasan_sdcardclk_recalc_rate - Return the card clock rate
@@ -2051,7 +2049,7 @@ static struct platform_driver sdhci_arasan_driver = {
 		.name = "sdhci-arasan",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_arasan_of_match,
-		.pm = &sdhci_arasan_dev_pm_ops,
+		.pm = pm_sleep_ptr(&sdhci_arasan_dev_pm_ops),
 	},
 	.probe = sdhci_arasan_probe,
 	.remove = sdhci_arasan_remove,
-- 
2.50.0

