Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D6292B52;
	Fri, 15 Aug 2025 01:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222922; cv=none; b=h89KxMdBpScaybKpRzsD/2jTioeOFl/ZXKrasYlD/apiDn9s/YDEV7EDIsqNTKCyOzbxP5I9+s1ANTklNmAaK9aO7gd+ky7dEVgssmw7XfOH5QFTUIdaUqGPbifez8GjQdvPCWleZlJo7RbpKBlbdfYEFQD6EAIeIvQPF9jKIV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222922; c=relaxed/simple;
	bh=H86uzBznaNKFfJ4yr0rczcFQsJTMFWry5uBkc9sc1Qg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICnqdFNSvfy2YqvjYUmFWYWOn2ac1xBjAL7gy5QJcuFIXszl8Q7JwBwP0UMaEVi5aBJ6QpOaSd7vgsjvFyUg+XPK2bKM0FlWcaNafl90SBV5Y1FqwXT+p6ClZgm4TPAs/HCo6FsX067fVT+/NG4LBZi2pAPHkllae3m6/qKAfwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K7NH0pUM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K7NH0pUM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59A5CC4CEED;
	Fri, 15 Aug 2025 01:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222922;
	bh=H86uzBznaNKFfJ4yr0rczcFQsJTMFWry5uBkc9sc1Qg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K7NH0pUM/gCBNvW/szYr5IrExsM/KITpOJ8YBopovC78fKnWm0nJuUUBUa7tXvYue
	 e9TImbYQ9W+aG6+sGiSkQUxqewOzAQu5kk94MTxT2mbE5mzlfkh+Yl6PfKFDTUW0o0
	 UbTPWfSqoiidFPO+4zeiiu4aEgXeqf8FXjYiDd3+qDMbwZh5Fy3vF61piK9fKspUcX
	 9002jawClFU7lZDvoH1oIsF2oPhpQYQQ/BCL6ZBV5wwC/8O/EWVgLrxrkZM+kmktBU
	 BpW2eUjTUtZtQhEAtfj9aiCfMuShZEBlInq/96vbpps4r4iTVGzrU2JcWabaG3rd4F
	 3eCN+TZR2aGGQ==
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
Subject: [PATCH 31/38] mmc: wmt-sdmmc: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:06 +0800
Message-ID: <20250815013413.28641-32-jszhang@kernel.org>
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
 drivers/mmc/host/wmt-sdmmc.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
index 0d2929cfe397..1b1d691e19fc 100644
--- a/drivers/mmc/host/wmt-sdmmc.c
+++ b/drivers/mmc/host/wmt-sdmmc.c
@@ -911,7 +911,6 @@ static void wmt_mci_remove(struct platform_device *pdev)
 	dev_info(&pdev->dev, "WMT MCI device removed\n");
 }
 
-#ifdef CONFIG_PM
 static int wmt_mci_suspend(struct device *dev)
 {
 	u32 reg_tmp;
@@ -963,18 +962,7 @@ static int wmt_mci_resume(struct device *dev)
 	return 0;
 }
 
-static const struct dev_pm_ops wmt_mci_pm = {
-	.suspend        = wmt_mci_suspend,
-	.resume         = wmt_mci_resume,
-};
-
-#define wmt_mci_pm_ops (&wmt_mci_pm)
-
-#else	/* !CONFIG_PM */
-
-#define wmt_mci_pm_ops NULL
-
-#endif
+static DEFINE_SIMPLE_DEV_PM_OPS(wmt_mci_pm_ops, wmt_mci_suspend, wmt_mci_resume);
 
 static struct platform_driver wmt_mci_driver = {
 	.probe = wmt_mci_probe,
@@ -982,7 +970,7 @@ static struct platform_driver wmt_mci_driver = {
 	.driver = {
 		.name = DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm = wmt_mci_pm_ops,
+		.pm = pm_sleep_ptr(&wmt_mci_pm_ops),
 		.of_match_table = wmt_mci_dt_ids,
 	},
 };
-- 
2.50.0

