Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8940C2951B3;
	Fri, 15 Aug 2025 01:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222973; cv=none; b=nNgxVUXt/X5NK8dms7r/6yqzXfJCk/LVWyzwPBUI1QS1Ib7irw3sgBgNiItOlPIN9Aqw2qSpF7S1Tp5+/YkGwKluq1It1T26rU+d4U8nn/EB1pXeb+XeLB9f0Ep1ftR/mCyGTSjuAYxOM0SYoU29DniKbYE4+vgt+hP+bDMbXIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222973; c=relaxed/simple;
	bh=r/j8FaIOvHUYrSEe5Yr0T8P9WzL2BKrKUkvkK+hcizQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=La4ypF1gTexseIl+z/z12xbPtVYLMnn1hAQSoNDyGzvOnvoEL4PN66x//7v8WlHI+/pfXisppbEzG8gzk2mvYs0Va7KPCV8itKvMAslyByVap/IeuaHqJ5yNG3er2q+6ZyojN1+B76bPTzHmd63HVARrNeLG6c6cUgd/4gAW6k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nG+EwLlE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nG+EwLlE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 811A0C4CEF5;
	Fri, 15 Aug 2025 01:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222973;
	bh=r/j8FaIOvHUYrSEe5Yr0T8P9WzL2BKrKUkvkK+hcizQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nG+EwLlEJOhkwuCwR6X5CqG6huU2//edIzsEpPaK5k27aHrGoBksw17Y4x53bOrOQ
	 Ex/wVnzSdM55Lu49HULItlCvlvdkc8S63fdLwIO4UFNHJDxnl2pFKaDaigC61tV8km
	 9Ogophhy4DWeXTr/804dsoMvXp2clmI44j52XUUepDa6ud7Ty50aT0pHOo9k1nicoP
	 r4HAb3RzaK71qbLu9GRxQeN3LtV3DVp2GuHaqy4Yf6iDKyp8SdPWa0h7Q8S38YvwbJ
	 v2/2QX92Aox72R1uFo19SfbUnph3UD8V8MGb+I5ouwNU1TGQMHkveZxGneDAdqRx2S
	 Y9HAjH4avYWaQ==
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
Subject: [PATCH 38/38] mmc: dw_mmc-rockchip: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:13 +0800
Message-ID: <20250815013413.28641-39-jszhang@kernel.org>
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
 drivers/mmc/host/dw_mmc-rockchip.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index baa23b517731..d2aec6cf9773 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -568,11 +568,8 @@ static void dw_mci_rockchip_remove(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dw_mci_rockchip_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
-			   dw_mci_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
 };
 
 static struct platform_driver dw_mci_rockchip_pltfm_driver = {
@@ -582,7 +579,7 @@ static struct platform_driver dw_mci_rockchip_pltfm_driver = {
 		.name		= "dwmmc_rockchip",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_rockchip_match,
-		.pm		= &dw_mci_rockchip_dev_pm_ops,
+		.pm		= pm_ptr(&dw_mci_rockchip_dev_pm_ops),
 	},
 };
 
-- 
2.50.0

