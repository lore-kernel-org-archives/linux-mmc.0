Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25E522BE047;
	Fri, 15 Aug 2025 01:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222893; cv=none; b=gwSHzha+R/vpEzVgYjV+gx1i2f3mUUtJpnSYU5xnvhkQb1LNownyNCJBHQ8UrlRNNGdo7Mjp3F0jM2B06AaUWvdXD90pdjvXbwc3FSXNvhCUUKt5CeZn+NhYose1Fj2LNDN8N1C4XIm7sCREoG1c1NNDKMmmYk+vsUScpQtAhOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222893; c=relaxed/simple;
	bh=ybFzf6YV6svFwnuGTcj91dczGvntOop2Tzq6/4KfK+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZPsKI+pA5UvjOdYe649rihTbEuDFpcBP/+CSw0/piqVGD5tzOnnF/DVB5yDqOvfLiDjQkgvy7jblnDjEt8u8EYkqQF8AbfYUhrQKEpzO5yqdLxmfDICSu/ffKvNXSzXdsl2xfhJckx+5ys8vtd1bxoAxgzDZATQxMFd9dX0bAP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RvEI/6Gg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RvEI/6Gg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D5A2C4CEF5;
	Fri, 15 Aug 2025 01:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222893;
	bh=ybFzf6YV6svFwnuGTcj91dczGvntOop2Tzq6/4KfK+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RvEI/6GgRvmsQcb9b0H7HMRf/phZSG1vldJJQYf1bqIvVKtCr+8b+SXm6V7iRd56b
	 5ePTAF8BjhgkDJwy1zjJ7dZIst9ZBFMUk/p7iKA1MNif4njkf3Cuau0zEyTjyfjMTp
	 setvtAU4+88l4aIg9uDpTJS304r/LwC6UcLhGhwn30dpURfxxGFuRcgW4YGcjeXEFj
	 MaqEWjzeGwRn/1yHM/o/UwnzqQynTDiQypSrjIzWpTrMiqOnm5aPMVn5+GLjqQ74Ww
	 HYxXS1kX2AgD5C2NGwQ83Qq9ICH6bsHmOYnPtdLI8ksY03hFbTHhHwx9ycslWHNVVQ
	 uqYMs2xdWE3Pg==
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
Subject: [PATCH 27/38] mmc: sdhci-st: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:02 +0800
Message-ID: <20250815013413.28641-28-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-st.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index 9157342ff7a4..bf6685805137 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -445,7 +445,6 @@ static void sdhci_st_remove(struct platform_device *pdev)
 	reset_control_assert(rstc);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_st_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -492,9 +491,8 @@ static int sdhci_st_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(sdhci_st_pmops, sdhci_st_suspend, sdhci_st_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_st_pmops, sdhci_st_suspend, sdhci_st_resume);
 
 static const struct of_device_id st_sdhci_match[] = {
 	{ .compatible = "st,sdhci" },
@@ -509,7 +507,7 @@ static struct platform_driver sdhci_st_driver = {
 	.driver = {
 		   .name = "sdhci-st",
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		   .pm = &sdhci_st_pmops,
+		   .pm = pm_sleep_ptr(&sdhci_st_pmops),
 		   .of_match_table = st_sdhci_match,
 		  },
 };
-- 
2.50.0

