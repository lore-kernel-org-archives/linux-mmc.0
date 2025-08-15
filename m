Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0ED2C0F8D;
	Fri, 15 Aug 2025 01:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222900; cv=none; b=Bs8ccMi3qI1MX0YDy3Ttszm7ZJr4NpXHLQ2WHPkwfn1ThCSrgLprTaMuCfmcK2n1dgZmhov9YbMZLTPgM7muQv8WqnOAyWED4QrINft4MadebZN+xMCUvkitJTkkZsXF/b3f27c1tIMpDgs9ft3XEvKveAU9L76X1G3Uq4Xo8mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222900; c=relaxed/simple;
	bh=5JPIejjZncvYXTZd3JyE/pN9siWmySeS5xw05Ye13EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S//d+sBqXY5l07Fb6RKYv0LtRQzvueOt+cALzAOFiwerpkHTMk/4X4qPyT5JETWVb4JrLntgvICzwI22F+5lSbbnQhfPKCdR7hT8v2DXlgPHorSI6YZV6gO47tG/wfzLRXAQ/RqCnUFGye7Zk5wGeiM2Cwexwwl879clzm+k0Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyp/pm0i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyp/pm0i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6909CC4CEED;
	Fri, 15 Aug 2025 01:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222900;
	bh=5JPIejjZncvYXTZd3JyE/pN9siWmySeS5xw05Ye13EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qyp/pm0i1e91RxQz3IWb0FSla6+Qmc1tpyi1xpm5Tt8da/ce0VgXcOenIBafi0MHg
	 G7z1+E/xc3lXK7fKt1hhzDdbwlGV8+ri6MVZ5qLFs/oOm7GUh0hxPjoOFangqeHLK9
	 HSS9pHQH/XA56Su7fvgWOf+LOaDA1TtKPGpuS/NyZiuigcqbXg8JI8ELyZhbdFRXuL
	 PktXe5etsIp0cQoVN4JZGDfWw+t5GWHxGHQ4fg1Dgko3AGa5c+hD3mqi+J/RU6X4Ij
	 FVVS6IqRh+TosZ8MAReTwZgvV3TvBOceh63zVTMa3rCRLURw4Ugu9Y6BWgAkl8Ity4
	 RFGzZt08itvgA==
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
Subject: [PATCH 28/38] mmc: sdhci-tegra: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:03 +0800
Message-ID: <20250815013413.28641-29-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-tegra.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-tegra.c b/drivers/mmc/host/sdhci-tegra.c
index c811297185d8..820ce4dae58b 100644
--- a/drivers/mmc/host/sdhci-tegra.c
+++ b/drivers/mmc/host/sdhci-tegra.c
@@ -1831,7 +1831,7 @@ static void sdhci_tegra_remove(struct platform_device *pdev)
 	clk_disable_unprepare(tegra_host->tmclk);
 }
 
-static int __maybe_unused sdhci_tegra_runtime_suspend(struct device *dev)
+static int sdhci_tegra_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1841,7 +1841,7 @@ static int __maybe_unused sdhci_tegra_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused sdhci_tegra_runtime_resume(struct device *dev)
+static int sdhci_tegra_runtime_resume(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
@@ -1849,7 +1849,6 @@ static int __maybe_unused sdhci_tegra_runtime_resume(struct device *dev)
 	return clk_prepare_enable(pltfm_host->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_tegra_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -1910,12 +1909,10 @@ static int sdhci_tegra_resume(struct device *dev)
 	pm_runtime_force_suspend(dev);
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_tegra_dev_pm_ops = {
-	SET_RUNTIME_PM_OPS(sdhci_tegra_runtime_suspend, sdhci_tegra_runtime_resume,
-			   NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_tegra_suspend, sdhci_tegra_resume)
+	RUNTIME_PM_OPS(sdhci_tegra_runtime_suspend, sdhci_tegra_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(sdhci_tegra_suspend, sdhci_tegra_resume)
 };
 
 static struct platform_driver sdhci_tegra_driver = {
@@ -1923,7 +1920,7 @@ static struct platform_driver sdhci_tegra_driver = {
 		.name	= "sdhci-tegra",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_tegra_dt_match,
-		.pm	= &sdhci_tegra_dev_pm_ops,
+		.pm	= pm_ptr(&sdhci_tegra_dev_pm_ops),
 	},
 	.probe		= sdhci_tegra_probe,
 	.remove		= sdhci_tegra_remove,
-- 
2.50.0

