Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27646126BF1;
	Fri, 15 Aug 2025 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222735; cv=none; b=j44DxRTpFfqL4LAeO84N4y/V8rv9+qx5B+9MfR+aN+xMnV6UHR8ifqPtggCjgoGgxXmqaL654w5O6hOmfFODa1XIlbZz0ZGpBGt+2T3ENyh/9cfFT3ur+QJ/9gjzz0YLPlMtNkOGSbzRI5V8Rt8VCi0kkgvG33ToBGPuc+zs7LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222735; c=relaxed/simple;
	bh=uZES36OWOSTbBmVBY5IvFFyIvgQpeCcxTZIxV8x7MY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jVpQLB+yw8gJw4C7+rOoci+hH8L43MIH3aPSGX3oshKxAm51aRf1oj9eheMlUIEoL/OE7AcYu4qssdNHwicj3OpV1PRShSsTcYrIjAQzoXxDu+ICulAUhNBpnFscUtCrt61hZncq7UVcS5UY8atE6wKNQbGmIgv86YaOz6Wq3mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8/KEHKH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8/KEHKH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4AF9C4CEED;
	Fri, 15 Aug 2025 01:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222733;
	bh=uZES36OWOSTbBmVBY5IvFFyIvgQpeCcxTZIxV8x7MY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P8/KEHKHOHp7taVdgWlB+Nc7+OFP3UQCssF41Qa86sL3PDQmehvB04bBJW83nVcGF
	 EpscYyRroa2rmRckpsd8x7WBe73edFctEkd+sZ8twG42jXuJye31ItAoJhCUhON9f8
	 2rSphfbSopT78Xr0qMZPRleg12CxeBfRqRVAlQLmPSOI/NJC15878v9lzAx1Homh7w
	 qcfCRBYcQ7H7SpUKuJd5YgFhhFLLo+BmeX1o2B4QxfcmhHasoapc8Zhbsz8pYx8Wcz
	 GSrVJg4MC1xmeuWwLgmF1nK/WId4O4LJWBdxFjF+3Fi3d2pLvYngpKH6YdE499yVlq
	 Sb6xBDKrxB3LQ==
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
Subject: [PATCH 06/38] mmc: alcor: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:41 +0800
Message-ID: <20250815013413.28641-7-jszhang@kernel.org>
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
 drivers/mmc/host/alcor.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/alcor.c b/drivers/mmc/host/alcor.c
index 288c3a91a0af..721db54739c1 100644
--- a/drivers/mmc/host/alcor.c
+++ b/drivers/mmc/host/alcor.c
@@ -1129,7 +1129,6 @@ static void alcor_pci_sdmmc_drv_remove(struct platform_device *pdev)
 	mmc_remove_host(mmc);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int alcor_pci_sdmmc_suspend(struct device *dev)
 {
 	struct alcor_sdmmc_host *host = dev_get_drvdata(dev);
@@ -1150,10 +1149,9 @@ static int alcor_pci_sdmmc_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
-static SIMPLE_DEV_PM_OPS(alcor_mmc_pm_ops, alcor_pci_sdmmc_suspend,
-			 alcor_pci_sdmmc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(alcor_mmc_pm_ops, alcor_pci_sdmmc_suspend,
+				alcor_pci_sdmmc_resume);
 
 static const struct platform_device_id alcor_pci_sdmmc_ids[] = {
 	{
@@ -1171,7 +1169,7 @@ static struct platform_driver alcor_pci_sdmmc_driver = {
 	.driver		= {
 		.name	= DRV_NAME_ALCOR_PCI_SDMMC,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &alcor_mmc_pm_ops
+		.pm	= pm_sleep_ptr(&alcor_mmc_pm_ops),
 	},
 };
 module_platform_driver(alcor_pci_sdmmc_driver);
-- 
2.50.0

