Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4883295516;
	Fri, 15 Aug 2025 01:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222748; cv=none; b=iFEpzTqja0Xm84HiO4/2BLEA3YKDwGsalZsoyp697CuPUHTqMoVVYF0ThoqFJWYn07qeCCVoVI9Tcr6ekf1/AFLq3LJgXolBrz19zrMaTkKqOoFh5XlH1Y3voIDFLQs4YQTzOnxjy0x5AVft1akf1eXLLp4Aki8bvtnxkNaES9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222748; c=relaxed/simple;
	bh=4sxfAvqj4cNcTFAG8eOyEmLc1goXUm05coglsT+wLRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bQTIvy3lnQrLSGcGnwPRX8hAR0lO4R5ognM7M6pA8G37iqA5EMh9zEUH1xlxA0NZpJklLQbd2f1uqynqbVg1N9mYQF2BRbA+SqXV2s5mEkZNjTzXhR/5ActttqEHCz7iaeR0qa2Q8uvQf0dCisosKRxxI4NZhxqFZYREoU2DBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHIOCE+q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHIOCE+q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 663EEC4CEF1;
	Fri, 15 Aug 2025 01:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222748;
	bh=4sxfAvqj4cNcTFAG8eOyEmLc1goXUm05coglsT+wLRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mHIOCE+qM9QODXAdFTgwu9zEZ1YLlNbM6c7GXih3Rfm+YABbaNO6OgHhkY7vjKSMb
	 2MTMEFE+Q/+nrg5Xb0pdIReB2f7E029ylWaelUEjE78ErOwT59th9Cu5spLXPH1/CP
	 hWrnQ0f0WSc82Xwmuisgz0gXiRH8wdrdTn/ZbeoL3gjqA5eDl8GQpt79UVzurkMPyx
	 ogXT2PB4wGOh8IXuTkZcHE6tTCheIYS8YmxZylWh3EGCBABghcjXmJVwIMTo2MTLSX
	 TpA0t8Q+NdUB3YmmiF81LpBzMOE7u+hkJYqQEqFWBrab7BaHjBlbmy+XHt+Du1waTR
	 2BSOlkEEs0PBA==
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
Subject: [PATCH 08/38] mmc: au1xmmc: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:43 +0800
Message-ID: <20250815013413.28641-9-jszhang@kernel.org>
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

At the same time, replace the platform_driver's .suspend and .resume
usage with modern device_driver's .pm usage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/au1xmmc.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index 85470773650d..cc6e05f9b96f 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -1150,10 +1150,9 @@ static void au1xmmc_remove(struct platform_device *pdev)
 	}
 }
 
-#ifdef CONFIG_PM
-static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
+static int au1xmmc_suspend(struct device *dev)
 {
-	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct au1xmmc_host *host = dev_get_drvdata(dev);
 
 	__raw_writel(0, HOST_CONFIG2(host));
 	__raw_writel(0, HOST_CONFIG(host));
@@ -1164,27 +1163,24 @@ static int au1xmmc_suspend(struct platform_device *pdev, pm_message_t state)
 	return 0;
 }
 
-static int au1xmmc_resume(struct platform_device *pdev)
+static int au1xmmc_resume(struct device *dev)
 {
-	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct au1xmmc_host *host = dev_get_drvdata(dev);
 
 	au1xmmc_reset_controller(host);
 
 	return 0;
 }
-#else
-#define au1xmmc_suspend NULL
-#define au1xmmc_resume NULL
-#endif
+
+static DEFINE_SIMPLE_DEV_PM_OPS(au1xmmc_pmops, au1xmmc_suspend, au1xmmc_resume);
 
 static struct platform_driver au1xmmc_driver = {
 	.probe         = au1xmmc_probe,
 	.remove        = au1xmmc_remove,
-	.suspend       = au1xmmc_suspend,
-	.resume        = au1xmmc_resume,
 	.driver        = {
 		.name  = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		.pm = pm_sleep_ptr(&au1xmmc_pmops),
 	},
 };
 
-- 
2.50.0

