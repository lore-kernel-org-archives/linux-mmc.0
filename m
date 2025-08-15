Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11B22292906;
	Fri, 15 Aug 2025 01:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222763; cv=none; b=gOAt+3V8K+RexmifOZdj8KHqpbEdJf7ZKw9/JiLs9NYBgZtNEzsIUm8QUvwXqivuT/K8+jA7Ft5aK7PZbDg3DYItZQyczDPOwi46F+bSM7ZEgJMMTnxZ4e4jkTzz6Htaw8EAUjz3o2IUXBD8sQLg5dD1cc3p7AVLmg9jxCPKWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222763; c=relaxed/simple;
	bh=9RmwzGROqS9ck1Ji2XOxbWPQpMewErkgs9sCdvkpL+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CPfMDdwSoZD6AzXkTDoxyesiW29uDq4FLOM+kmn+X2smn+Q5JJ2SxADGqDyLQMBa2Djd0Y84TXZOHwZ/ynl9QsgNJ+VrN4S7pMpRngJ1z5v06+WYMPk+lj1TLdXDRcADV1f4ZsdDu1XpdtRAwc3ugHRdOe50YBiJkENdEvGy60k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQFe3H9b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQFe3H9b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A075C4CEF5;
	Fri, 15 Aug 2025 01:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222762;
	bh=9RmwzGROqS9ck1Ji2XOxbWPQpMewErkgs9sCdvkpL+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OQFe3H9bTycS7/s20LwV6tDDKPMfREMWN6QhYX4vqLHzaWUumZETvOoTzvKKDaUqO
	 M1R6ftX7vzOA8mGFV8s9WSLSMrPBVS6ItqipZN/zs8I4WYMfbz94cC7Y5ms8VeQDke
	 tCf0QPCmtubxEblu3zO8YZw5PpSLnj70xON+76530uw7c5iNWX57Eym3yF0B4Q2qJc
	 UvUpXzZKCBZohU/2l9rCm2iK3kHk5WBJMsrLbz1YZZUtNnpwNfMmZgVxwqHrjem29G
	 o5WVgxx+xTA107BvqPfCpCK++XwhtUjzqpkE779qHEbwKWESQ9PbXa3Y0CPH1WrRWn
	 Bpvn6MFF/FJXQ==
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
Subject: [PATCH 10/38] mmc: davinci_mmc: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:45 +0800
Message-ID: <20250815013413.28641-11-jszhang@kernel.org>
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
 drivers/mmc/host/davinci_mmc.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
index c691f1b60395..75fd00fc51ed 100644
--- a/drivers/mmc/host/davinci_mmc.c
+++ b/drivers/mmc/host/davinci_mmc.c
@@ -1347,7 +1347,6 @@ static void davinci_mmcsd_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->clk);
 }
 
-#ifdef CONFIG_PM
 static int davinci_mmcsd_suspend(struct device *dev)
 {
 	struct mmc_davinci_host *host = dev_get_drvdata(dev);
@@ -1373,21 +1372,14 @@ static int davinci_mmcsd_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops davinci_mmcsd_pm = {
-	.suspend        = davinci_mmcsd_suspend,
-	.resume         = davinci_mmcsd_resume,
-};
-
-#define davinci_mmcsd_pm_ops (&davinci_mmcsd_pm)
-#else
-#define davinci_mmcsd_pm_ops NULL
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(davinci_mmcsd_pm_ops,
+				davinci_mmcsd_suspend, davinci_mmcsd_resume);
 
 static struct platform_driver davinci_mmcsd_driver = {
 	.driver		= {
 		.name	= "davinci_mmc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= davinci_mmcsd_pm_ops,
+		.pm	= pm_sleep_ptr(&davinci_mmcsd_pm_ops),
 		.of_match_table = davinci_mmc_dt_ids,
 	},
 	.probe		= davinci_mmcsd_probe,
-- 
2.50.0

