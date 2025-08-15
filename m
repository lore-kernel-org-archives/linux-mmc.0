Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792D292906;
	Fri, 15 Aug 2025 01:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222770; cv=none; b=rlE234gWrys2HLo8idJsUz4ldfHvLgfAH+VkJKCphkSvM1fheozIxKnVAFdO31a5fiCNUPdhcU4CcjSPzC+RbiLEuYx+lo9IHe8Pn3B7x2A9bQI7OZEsXrOpLKLbhzBhrpKpwijrRZh/S7yeDUzvOfcVHdlMD92Iw8KCrc+/oco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222770; c=relaxed/simple;
	bh=IzZgrP+Thm8aY8QaBcmn+pxhfIUSwm9lvX5B3/yxCjw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKQpY1u0D+GKwZrWoPON97PgVmJRKq8XV6KgsCLv++v35p9lYLukTUpUzO0ESh+xXdU/v4PcV10cWZfJSDwMGKhd6O6blWfsNiBCKM4xw8xDqVUkaommVe0Z/qgHt8PAU0POOKMW7lf4l9M+bGyNJybFBS7oG3/Wk2G+LmBFA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kAY78ScT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kAY78ScT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56219C4CEED;
	Fri, 15 Aug 2025 01:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222770;
	bh=IzZgrP+Thm8aY8QaBcmn+pxhfIUSwm9lvX5B3/yxCjw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kAY78ScTm7Jba7wSMqJrIh+m8CrW6Xn3mPma7xXWtD8mzaKvMaZFxZ1Dl/BdUD414
	 bAmErURaLsJQtX2aHHlgVOwrSth8aQMDnNtcISUJ4t0kdP54Jb8Iu3xbPHpgWZCCvt
	 B9R+mTvxNgwNbcYuQ9NlZiOpm29jEqq4Z5XFDcqjhT/ur7sdd2Et99/y1IG4gVWIDD
	 cdt5kk1WWERYQF4/Buj0q4SNUQOgcYrtx2AkFNdm9mYxMHRt0noIzbecahW1XQcB88
	 NjDOc2eYroTQ2CJluGJC/rgJqHInz+t3BzWa/AbJTacJobQ+qtxxJhcqCbA4Vgj+6y
	 yZg/+SeNRwfKg==
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
Subject: [PATCH 11/38] mmc: mmci: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:46 +0800
Message-ID: <20250815013413.28641-12-jszhang@kernel.org>
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
 drivers/mmc/host/mmci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 8367283647a9..e500051bd572 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -2516,7 +2516,6 @@ static void mmci_remove(struct amba_device *dev)
 	}
 }
 
-#ifdef CONFIG_PM
 static void mmci_save(struct mmci_host *host)
 {
 	unsigned long flags;
@@ -2581,12 +2580,10 @@ static int mmci_runtime_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops mmci_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(mmci_runtime_suspend, mmci_runtime_resume, NULL)
 };
 
 static const struct amba_id mmci_ids[] = {
@@ -2675,7 +2672,7 @@ MODULE_DEVICE_TABLE(amba, mmci_ids);
 static struct amba_driver mmci_driver = {
 	.drv		= {
 		.name	= DRIVER_NAME,
-		.pm	= &mmci_dev_pm_ops,
+		.pm	= pm_ptr(&mmci_dev_pm_ops),
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 	},
 	.probe		= mmci_probe,
-- 
2.50.0

