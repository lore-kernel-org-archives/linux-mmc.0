Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1261293B4C;
	Fri, 15 Aug 2025 01:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222726; cv=none; b=X2pB5Tuv/G5h01slQ50yJ/u/I18GhSDCnA87XBhqgQKHxQaEn7BgJHe///aM4ymtQWQ3V+qIt69mDGmKGojKHQPrGIp2Dd1uIQ9T/xBSJ1rBm3EFuJ3GQePQWQZf5DF92XclY0zZ9dtKkscfTW9+SJl/3TimNXE5IoYpU7Pzsvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222726; c=relaxed/simple;
	bh=pR5SwC3YqQIvXXY6dZ+NTJY284WdtppxcrZ3YVoccdE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A7l9UbK+saIBOxG8Sz4aXH1T15fMvbcMRDLXJL/iIwRs1JeqaI8zDX35WYZ58OwmyA83ibpQQOQzNZYRzrjcE++E5tWmKJx13IWWiffobPeuyYjiffYAFDvgKzA5mkYP3voYN7ppkKj8+Rf3ykw9pl05rWnyc0jPaEmwRrM9N4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pu4ELYqX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pu4ELYqX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 771CEC4CEF7;
	Fri, 15 Aug 2025 01:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222726;
	bh=pR5SwC3YqQIvXXY6dZ+NTJY284WdtppxcrZ3YVoccdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pu4ELYqXeLtckNlivIlNoh7OfZvmgIovYIbDUYyTNI6PxUeFTqMANm16xB5RXrURL
	 EIlCrwtOm8QcmnoJ+1MrgQ7XN/MZpwuBPP3JB5DZfFUyIa6z1dZdaYuwz3KsCCVwCo
	 X3MSGWG7SfsjPjvwu5IZjUePu37rhOB5ryrWMFyqBjTRHIIK3j0y0Qh+PvIAt+hWfi
	 fDWlEvEEJPw/WQgUdH7lAYj9/kyOI4g4woiCJhzDBzx6iGYQewaiF8UA1VLGy80E18
	 FZ9naUqHrHdEoGoNnrwjIZOvQOshHTpSzgHNTi5cBkwaS0+Y/XdCisIWY5k2yq/tMy
	 HZi3vjmNo+49Q==
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
Subject: [PATCH 05/38] mmc: sunxi: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:40 +0800
Message-ID: <20250815013413.28641-6-jszhang@kernel.org>
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
 drivers/mmc/host/sunxi-mmc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index ee4a65b0a22d..8dbcff53a631 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -1495,7 +1495,6 @@ static void sunxi_mmc_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, PAGE_SIZE, host->sg_cpu, host->sg_dma);
 }
 
-#ifdef CONFIG_PM
 static int sunxi_mmc_runtime_resume(struct device *dev)
 {
 	struct mmc_host	*mmc = dev_get_drvdata(dev);
@@ -1530,14 +1529,10 @@ static int sunxi_mmc_runtime_suspend(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sunxi_mmc_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend,
-			   sunxi_mmc_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(sunxi_mmc_runtime_suspend, sunxi_mmc_runtime_resume, NULL)
 };
 
 static struct platform_driver sunxi_mmc_driver = {
@@ -1545,7 +1540,7 @@ static struct platform_driver sunxi_mmc_driver = {
 		.name	= "sunxi-mmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sunxi_mmc_of_match,
-		.pm = &sunxi_mmc_pm_ops,
+		.pm = pm_ptr(&sunxi_mmc_pm_ops),
 	},
 	.probe		= sunxi_mmc_probe,
 	.remove		= sunxi_mmc_remove,
-- 
2.50.0

