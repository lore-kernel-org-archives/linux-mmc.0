Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1088F292B4B;
	Fri, 15 Aug 2025 01:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222785; cv=none; b=DVnuZcyZ2OLw5ifclt4JeQ7dKzMfuJWtjVC/ttlPGZvvg5mOLBWyZut+yIDue0kkBKe68BWbB1GmLNgV1lwNtyce7q+zRgiD4aKDKwmVMdX8Dg7Iq59s8cFDpQQZaMeaX302y8znBSMos7OoBPHIjiF99q0Gz/NvbskJceu8jkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222785; c=relaxed/simple;
	bh=HiZ4XD/u4pJ1wA4ohoDlBJ2++rgCeSH25iXqkb/Id5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlFtg8Lx0czivGZiCT4mpF3DigQoZ7sOPl1dbpHjG0JtrADYrvGemAfARfrBZvdRzLF9eA53firawtX0mPfNCehoC1fQTwZX4XawPd3eQTmvPEQ4MTVuQqZ74NwjwXM0JOjsk8Oa5sgxsGDZto5NbUC9YuvIp/6t3Kb/fycD6wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mA/JLl3j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mA/JLl3j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE42BC4CEED;
	Fri, 15 Aug 2025 01:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222784;
	bh=HiZ4XD/u4pJ1wA4ohoDlBJ2++rgCeSH25iXqkb/Id5A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mA/JLl3jVe71FvL6nc4NXj8fauG7h72JzOotjKYUik6oH6R05zibT0D1auS9aM0k7
	 aMxLQg5z2OKC1iVwDuFL/yjN9sbVkxgRsRB6EnQp0j/tkTftdpPXwPG5sKMdTwgbbA
	 Dbh7q8yuTH4XNvkdQymNRJkcfowgbpe+jp1N2qQs8LILnk17shBwUWk5N2y3Mwbfa6
	 002yKhUdZsnoJ1e4Zu7uxJ1UCPIQja+pMtBbfqJ+Yj4AEWPE4ec0NZq95IEhTVLlqO
	 IBdJGF8F8iLXKcqszht9xp+yme6KWTxerAMlH+vTeMDZkuX/nmc+8YIx3KBGzTioS9
	 TnAZxMAot3ggA==
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
Subject: [PATCH 13/38] mmc: omap_hsmmc: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:48 +0800
Message-ID: <20250815013413.28641-14-jszhang@kernel.org>
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
 drivers/mmc/host/omap_hsmmc.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index adc0d0b6ae37..09e4354d1f1d 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -620,8 +620,6 @@ static void omap_hsmmc_set_bus_mode(struct omap_hsmmc_host *host)
 		OMAP_HSMMC_WRITE(host->base, CON, con & ~OD);
 }
 
-#ifdef CONFIG_PM
-
 /*
  * Restore the MMC host context, if it was lost as result of a
  * power state change.
@@ -689,6 +687,7 @@ static int omap_hsmmc_context_restore(struct omap_hsmmc_host *host)
 	return 0;
 }
 
+#ifdef CONFIG_PM
 /*
  * Save the MMC host context (store the number of power state changes so far).
  */
@@ -1990,7 +1989,6 @@ static void omap_hsmmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(host->dbclk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int omap_hsmmc_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host = dev_get_drvdata(dev);
@@ -2032,9 +2030,7 @@ static int omap_hsmmc_resume(struct device *dev)
 	pm_runtime_put_autosuspend(host->dev);
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int omap_hsmmc_runtime_suspend(struct device *dev)
 {
 	struct omap_hsmmc_host *host;
@@ -2102,11 +2098,10 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 	spin_unlock_irqrestore(&host->irq_lock, flags);
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops omap_hsmmc_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
-	SET_RUNTIME_PM_OPS(omap_hsmmc_runtime_suspend, omap_hsmmc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(omap_hsmmc_suspend, omap_hsmmc_resume)
+	RUNTIME_PM_OPS(omap_hsmmc_runtime_suspend, omap_hsmmc_runtime_resume, NULL)
 };
 
 static struct platform_driver omap_hsmmc_driver = {
@@ -2115,7 +2110,7 @@ static struct platform_driver omap_hsmmc_driver = {
 	.driver		= {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm = &omap_hsmmc_dev_pm_ops,
+		.pm = pm_ptr(&omap_hsmmc_dev_pm_ops),
 		.of_match_table = of_match_ptr(omap_mmc_of_match),
 	},
 };
-- 
2.50.0

