Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA41D27E7E1;
	Fri, 15 Aug 2025 01:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222792; cv=none; b=qetY9CAO8gy0GKTF4fYpHjeP7RGuM9Cdu+i2c6XDHa1fMWSeIG+PPsuOyYL2hKXKGTF3SCnu/ufBmlBBkOrWBWFkUVlLNgEd+ZJBsFltMWuse5LU3JkFECcBjanuwpMtPxonT+b+ilcfT8a1WBzpQnmz7IUrOtyIlyvtwFZHl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222792; c=relaxed/simple;
	bh=wNn/Z9vUP6iHRWkf9R1OqTJtEgv9lNTdtSOoH2sgL8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pvbvnCUCEp6NE1A7euVJN2ofYfOYainZjFHzJC8ffpafRdGGSQAKiZyovv7XgknSszIg3DTtlOMsXm68ma1pfU9KPIZbwPsOLYm/QK/TjmxfzJQBK+Gdis0avIYPf7oyA9C3k8H8U1UQnum1JvQZcdVygqUGMz1xa6T04bpBz5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iH62QQsC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iH62QQsC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D1BAC4CEF1;
	Fri, 15 Aug 2025 01:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222792;
	bh=wNn/Z9vUP6iHRWkf9R1OqTJtEgv9lNTdtSOoH2sgL8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iH62QQsCvnwapvY6vzORU0hWUDL2BjqlSblFzc8s9C4BPyZIz16/oRvO0NmiJFpSq
	 DZqESJwSOhigggBHM7PiO+GF6nsD7pRe9hOEIP/PimOLxzG/L6l1IUJ6ZpCXDP80Oy
	 5wgdz3kytDQIoBmU5zUNcx+of5tGePAxqZoBrr9V5whthaOdN9WOo6H06+1SK38xUt
	 d0X2iivlQLh5zheCdjltAwa5siXqpo7/Ll/1Rr0pMHFPtqd3zlKxoDKwUisiAf1K2D
	 Zqn/g+K6REWcrhn9VZ7W2MzK3MiDLKzpitaC7RuGOvUag8udEvTsVb1qfXgNK2p9aI
	 OdgtaRwTlToEQ==
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
Subject: [PATCH 14/38] mmc: rtsx_usb_sdmmc: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:49 +0800
Message-ID: <20250815013413.28641-15-jszhang@kernel.org>
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
 drivers/mmc/host/rtsx_usb_sdmmc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/rtsx_usb_sdmmc.c b/drivers/mmc/host/rtsx_usb_sdmmc.c
index c5f6b9df066b..98184b140a41 100644
--- a/drivers/mmc/host/rtsx_usb_sdmmc.c
+++ b/drivers/mmc/host/rtsx_usb_sdmmc.c
@@ -1428,7 +1428,6 @@ static void rtsx_usb_sdmmc_drv_remove(struct platform_device *pdev)
 		": Realtek USB SD/MMC module has been removed\n");
 }
 
-#ifdef CONFIG_PM
 static int rtsx_usb_sdmmc_runtime_suspend(struct device *dev)
 {
 	struct rtsx_usb_sdmmc *host = dev_get_drvdata(dev);
@@ -1446,11 +1445,9 @@ static int rtsx_usb_sdmmc_runtime_resume(struct device *dev)
 		mmc_detect_change(host->mmc, 0);
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops rtsx_usb_sdmmc_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(rtsx_usb_sdmmc_runtime_suspend,
-			   rtsx_usb_sdmmc_runtime_resume, NULL)
+	RUNTIME_PM_OPS(rtsx_usb_sdmmc_runtime_suspend, rtsx_usb_sdmmc_runtime_resume, NULL)
 };
 
 static const struct platform_device_id rtsx_usb_sdmmc_ids[] = {
@@ -1469,7 +1466,7 @@ static struct platform_driver rtsx_usb_sdmmc_driver = {
 	.driver		= {
 		.name	= "rtsx_usb_sdmmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &rtsx_usb_sdmmc_dev_pm_ops,
+		.pm	= pm_ptr(&rtsx_usb_sdmmc_dev_pm_ops),
 	},
 };
 module_platform_driver(rtsx_usb_sdmmc_driver);
-- 
2.50.0

