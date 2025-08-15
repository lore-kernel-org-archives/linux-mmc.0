Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48829293B48;
	Fri, 15 Aug 2025 01:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222959; cv=none; b=dMFwzY+dvd6KGwkvHqdqg5A6pth/Ij6+e3TaFE5f0m/R/LddJEyAAfB6F3IMNfr7LfW22YD7d7cpMo/u+LxuMqvBaNcZRFW13ax5NV0j3IXhzNKtlkhoxti7eHdoykbSJ5WY/fPZqnDud3DjXqohGeSgAB9OtFfXguRNdaFlv1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222959; c=relaxed/simple;
	bh=SIss+Xq9xiCpCrynk679o+RdenprEBRwz+hH338Ojlg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys8J0p7kkGBgFrr5MiSfqgDaTkMojanDNOf9enIh8obvDxgBzedpHKx5TbEuaJPCZ5vNUu+64WkTbMn1iQCygPDOigEDnaqFJpwY7+XlqsOqwU/cWrWJ/8vvh/Hj8TPiJ1kYzLF0D5N+Oy8KJ7MbKwf3wdABDwO/MenySfr4IOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu3uUEPv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu3uUEPv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC483C4CEED;
	Fri, 15 Aug 2025 01:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222958;
	bh=SIss+Xq9xiCpCrynk679o+RdenprEBRwz+hH338Ojlg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nu3uUEPvDKZYNvpRCDPhmrJNU0YmBfMf+A53OGCsvdkcf6CS4W7ghMcUUPi9wJV23
	 /spz7TwWfq0frPoyrDrFLiIoLsVDfRgTaZcZAx2WFOL6JYmDMorB3EuM3VaZxetlLa
	 wF5wxJqjzLDoy5A2c8sWYQuCV1LChIinQi5t56mgR1qH0zimPAaaylca/Y0vLupkoA
	 icIovZOPsLDAfle5m8W8X5g3jo0X7OwCPHw6rB+EiiJSEraPITz/sziV1QoVwI/z0g
	 3SgGsE2m0JIhwSBbyd8MVwwch58Na46k7Jmqjr5KnrzFL4IV6Q74R048WlUkS4G8sb
	 gopLqcWnV0VVQ==
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
Subject: [PATCH 36/38] mmc: dw_mmc-k3: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:11 +0800
Message-ID: <20250815013413.28641-37-jszhang@kernel.org>
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
 drivers/mmc/host/dw_mmc-k3.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 0311a37dd4ab..ad6aa1aea549 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -461,11 +461,8 @@ static int dw_mci_k3_probe(struct platform_device *pdev)
 }
 
 static const struct dev_pm_ops dw_mci_k3_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
-			   dw_mci_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
 };
 
 static struct platform_driver dw_mci_k3_pltfm_driver = {
@@ -475,7 +472,7 @@ static struct platform_driver dw_mci_k3_pltfm_driver = {
 		.name		= "dwmmc_k3",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= dw_mci_k3_match,
-		.pm		= &dw_mci_k3_dev_pm_ops,
+		.pm		= pm_ptr(&dw_mci_k3_dev_pm_ops),
 	},
 };
 
-- 
2.50.0

