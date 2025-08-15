Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2202D0611;
	Fri, 15 Aug 2025 01:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222908; cv=none; b=f/iS9Lhgd+emywdcv3jCB4cZiIxNuZHnHcc5Y7nRGY4j0XfN+BkwkRaYn3E1eNCnFrf/9voce4wV8q5lF/K3bDSVd1svIr2qHPzVjXDplA3z81k496wWIgo4YCtjG8whKk3DeaC3e0Ag4vqqo86TzTE6sS++UL/oUTNUkGlcmDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222908; c=relaxed/simple;
	bh=iqqY8zQk1p/28e+Z3PtSrocfEQskqgD1t/io2W6SGFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbGI5jSbnhyBFyMD2pyAC6f73z/xdAh6gtyfS1c+z6gQiLWpBME4164xuODGVJ07Y4EKJFIYEH28zUrETkF9seas+YeVCidzlNY/8Zx9eDi1gseZLgF5aVDDS9lO3G8kL5URhlZKsuZ8aY/7s+NNNxJBd8t3YqnaPF7mgZsLrkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r4Nc3Jt0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r4Nc3Jt0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B36C4C4CEED;
	Fri, 15 Aug 2025 01:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222907;
	bh=iqqY8zQk1p/28e+Z3PtSrocfEQskqgD1t/io2W6SGFc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4Nc3Jt0OKR/Fl/eAqfQk1IZP4MQtAVDBA5iArz6rS86z/DPWGP1X8kO0k8qeidSM
	 v/Nf0gKeNc6OsDj9TQcZToOynUIcfQGHqEkQ6eKDGSFBvR2gR2V1KTNn1JCurkKXX/
	 fjD0aWmWWFw4tJ4at9QEbb8k3QZtKmJ6mAPPar8IGGIMmCGPu11d4AA6Q8cumzZ6wo
	 40d3UTiv5kmU9XKrxn/3FF+Vzcbdo9N2wMCUX7TmZq+a75BY9kVtNfL9j5THaVuLJf
	 AxypypHct8zghEzKGOZme7gDQcXOMDNgMHHt80vblA4IfTgHxLZJ8hklQLtrgMy7VV
	 J+FZqpdAunQmw==
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
Subject: [PATCH 29/38] mmc: sh_mmicf: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:04 +0800
Message-ID: <20250815013413.28641-30-jszhang@kernel.org>
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
 drivers/mmc/host/sh_mmcif.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sh_mmcif.c b/drivers/mmc/host/sh_mmcif.c
index 19f84584ecfa..413c34585c90 100644
--- a/drivers/mmc/host/sh_mmcif.c
+++ b/drivers/mmc/host/sh_mmcif.c
@@ -1568,7 +1568,6 @@ static void sh_mmcif_remove(struct platform_device *pdev)
 	pm_runtime_disable(&pdev->dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sh_mmcif_suspend(struct device *dev)
 {
 	struct sh_mmcif_host *host = dev_get_drvdata(dev);
@@ -1584,11 +1583,8 @@ static int sh_mmcif_resume(struct device *dev)
 {
 	return 0;
 }
-#endif
 
-static const struct dev_pm_ops sh_mmcif_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sh_mmcif_suspend, sh_mmcif_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(sh_mmcif_dev_pm_ops, sh_mmcif_suspend, sh_mmcif_resume);
 
 static struct platform_driver sh_mmcif_driver = {
 	.probe		= sh_mmcif_probe,
@@ -1596,7 +1592,7 @@ static struct platform_driver sh_mmcif_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &sh_mmcif_dev_pm_ops,
+		.pm	= pm_sleep_ptr(&sh_mmcif_dev_pm_ops),
 		.of_match_table = sh_mmcif_of_match,
 	},
 };
-- 
2.50.0

