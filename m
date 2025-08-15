Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF590295537;
	Fri, 15 Aug 2025 01:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222871; cv=none; b=mhRIyGmVR8Y3obZPCPpo9P3qEJxVngOmTxVsVJoXLvllODtAq4coiIPh7ILz9MHz4/a8hU6muLQXpafpuwrChQezxOmB/HZaKMnNSxqMcKqh9VWj97N1PCCQZAyv8tHvEdNA5Z5hE8H2mkzX7xyqJXZuEZQE7h1SYr2yYZS6X+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222871; c=relaxed/simple;
	bh=Xtt0Gh+8rnJkc7bnfTKTYzJ6uGY9+nZj9Zh0PXtUiSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l9Wa5Gs7KloVPKtZzcdPgVynPVO4hmGKnsY9DXLpias2zOBlZI2d5wRd8bWj1+xrU8QUeQRSTlGjoqDMtH4tOD1egLy4EnfXXvVu9MluQgS2auDbAI+/NTa586/U6nHj+z7weNaqn52ZEfDGHQwQAha4P0b+Cda7kztvruRclmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nzoMw8Os; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nzoMw8Os"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47747C4CEF1;
	Fri, 15 Aug 2025 01:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222870;
	bh=Xtt0Gh+8rnJkc7bnfTKTYzJ6uGY9+nZj9Zh0PXtUiSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nzoMw8Ostluj9UsuWcFcet5p6QRTPN+V16+FKix81XRZpr74c+MJlJEousO98mu8w
	 7cuehjiVN7kfSl/3AcnSiqnTEthVmeMYOHwD73Tp76sAEQxqefSmfnL28kIuxRVcXu
	 Spj73JcIfaFJi2b0Lv/3krO7BeOQ/BQOgHAgcioetmkrkT16ZW9md05mOzmoABQji8
	 0KJS0GttkOoyIcXum9x2I2u/iwzJH2wLq9Q8glVLXzkwyAdQB7AIumhYRy/aYdwDSK
	 QOWXWgYuI1lCeJDzfzJ/6DBUnnkSbl4umjZkSIYYF0gVK0/uiQYN5IT8gx3c+whqVJ
	 fdhgv5rVgJWSg==
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
Subject: [PATCH 24/38] mmc: sdhci-s3c: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:59 +0800
Message-ID: <20250815013413.28641-25-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-s3c.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 40857fc2e21b..6bf66aaa86a6 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -681,7 +681,6 @@ static void sdhci_s3c_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sc->clk_io);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_s3c_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -698,9 +697,7 @@ static int sdhci_s3c_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
-#endif
 
-#ifdef CONFIG_PM
 static int sdhci_s3c_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -730,12 +727,10 @@ static int sdhci_s3c_runtime_resume(struct device *dev)
 	sdhci_runtime_resume_host(host, 0);
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_s3c_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_s3c_suspend, sdhci_s3c_resume)
-	SET_RUNTIME_PM_OPS(sdhci_s3c_runtime_suspend, sdhci_s3c_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(sdhci_s3c_suspend, sdhci_s3c_resume)
+	RUNTIME_PM_OPS(sdhci_s3c_runtime_suspend, sdhci_s3c_runtime_resume, NULL)
 };
 
 static const struct platform_device_id sdhci_s3c_driver_ids[] = {
@@ -770,7 +765,7 @@ static struct platform_driver sdhci_s3c_driver = {
 		.name	= "s3c-sdhci",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = of_match_ptr(sdhci_s3c_dt_match),
-		.pm	= &sdhci_s3c_pmops,
+		.pm	= pm_ptr(&sdhci_s3c_pmops),
 	},
 };
 
-- 
2.50.0

