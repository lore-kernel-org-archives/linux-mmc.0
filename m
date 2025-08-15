Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECF1B28CF7C;
	Fri, 15 Aug 2025 01:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222863; cv=none; b=Dzfpm58FnO3TXDvd5KyrZu3OyI9Q+CDUbPRY4YqqDt+Bh5hh3TX3vqrog/7AbXgjTyG4miT1Zw6/AA0Bf9Akr6QpguUQnnFwOp9LgiyjLFS+ohqRl16c6UwMbdgygPfC8WUq8cd3/t12i8sZlo4wpLtp+oLuxdW8b5s9YoZrqeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222863; c=relaxed/simple;
	bh=zsWEaRqQM6tmd2c+fncO7p4Tpm64+i/AVDndX8KLebc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/eiJtLQj22EUkpp5ZQZ4+1YsZVSjr43ueOde4nTtXCNyXna+4UpdDatejUdnTD/BxV6IkDo/mK2q+N/efpkUhrZUlk09EcXxncv4JYljL906Km+HNt0hiJJL5+lKB+WIYxTmT9cYcauUpUN5S1VB9KZY8NcoGndmQ5mELEXX1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SFynERfK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SFynERfK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417C9C4CEED;
	Fri, 15 Aug 2025 01:54:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222862;
	bh=zsWEaRqQM6tmd2c+fncO7p4Tpm64+i/AVDndX8KLebc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SFynERfKhCtrM9XVoOAquRH4uvw1WEV7WBtGWb6KDxpifTA2gmx6lTFKoZNyHLsJp
	 Vkk4v63+jU/gW556gLVD8FBsNDPTiRF3LYUgEkd8MpkFUdtCEO3duKoIw6aaFmye2O
	 CqqAOQgKWqSHrD87KqyaVbM8Ql4/uzm72MFl4sSUZtLb/bTznep2KugeVWhxRzkCUY
	 QeELq6yqkxoE62tQdDQvDHxuMG4AoDRxuc+n0uqTsYOaQ+U5mmBg4fo4rDhSuFCJzK
	 uTOANE+RswWK5SrRtBwPfDbhN/ZuiClZhqCy1qzSP78eqFBY9OLRGPBPtFqo+/BpBL
	 7J05wvzmwAzdg==
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
Subject: [PATCH 23/38] mmc: sdhci-cadence: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:58 +0800
Message-ID: <20250815013413.28641-24-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-cadence.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index 2d823e158c59..60a297628b06 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -551,7 +551,6 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	return sdhci_add_host(host);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_cdns_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -578,11 +577,8 @@ static int sdhci_cdns_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops sdhci_cdns_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_pltfm_suspend, sdhci_cdns_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_cdns_pm_ops, sdhci_pltfm_suspend, sdhci_cdns_resume);
 
 static const struct of_device_id sdhci_cdns_match[] = {
 	{
@@ -606,7 +602,7 @@ static struct platform_driver sdhci_cdns_driver = {
 	.driver = {
 		.name = "sdhci-cdns",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm = &sdhci_cdns_pm_ops,
+		.pm = pm_sleep_ptr(&sdhci_cdns_pm_ops),
 		.of_match_table = sdhci_cdns_match,
 	},
 	.probe = sdhci_cdns_probe,
-- 
2.50.0

