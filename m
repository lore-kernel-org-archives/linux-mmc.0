Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E0317B425;
	Fri, 15 Aug 2025 01:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222847; cv=none; b=bOscgD4WezWi5uxBOyFDWPzKcTZIXGO772RSckHSZ+jhk6V+V6JTSsG14X3anIsJ5Y3wVbVYR5tPmt+LGv/WXD4+3DDnzap8rF6x4abmCAW1bMrHFijtfy/DCeWBFHxJndE1mJTVUR9YepuYKWqBcfPJXxDtw62JwHniXXofisM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222847; c=relaxed/simple;
	bh=J6J27b6ZY/lIVsGzB/5kKFuMsLpEdftsz7uY/8ELpPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHoVOJmnDHvuD8UX0gwx/3HFVZ8L9zfr1xfuvtD1Ip/UnB/Opkc/Bx2LgL4oFDo3x6n1RI4SFvAfgKo55+4QsTudD1xo4+SndXFdjWRgDGgJ/auud1nYt5n8tdMySW1kLNAPSR6B6TDiP+Lg4kQnSuaSe7L6Bhny9Q6rM1Jazg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RYmaDxvq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RYmaDxvq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40DEDC4CEED;
	Fri, 15 Aug 2025 01:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222846;
	bh=J6J27b6ZY/lIVsGzB/5kKFuMsLpEdftsz7uY/8ELpPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RYmaDxvqZWhdCT+s1rUnuT70Ro4RzSmRn480BP7LnWpXvoeicxUW8ECz23t9WWn8F
	 ClIrVPk0ifVqWkPbsbzo39Mz/WvH2RrHE2ND+jOrQA1eQfzadp9+rKWoBqLvXsi0CH
	 +Gn3wmo06niX05EaJcmSnrPaR4NSjMFnNG4AQrTjbtYwu4MuHjc/wLQtIBe2u+4gYH
	 sxba6cy8QMexNzq6Dem0VG5/59Me9zW7DrDLkCl1sSGqc+14VS9aXio8RS7BWlV+UD
	 xtgvwRkoQx2P0YnPu1m/yX2cmokbE72eDoNaQlmLslFH9PHfqiXRIQO054ywdnPN2o
	 2dIVOUfUO1QZg==
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
Subject: [PATCH 21/38] mmc: sdhci-of-esdhc: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:56 +0800
Message-ID: <20250815013413.28641-22-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-of-esdhc.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index c6ee0099ead0..8345e2c5a034 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -1234,7 +1234,6 @@ static u32 esdhc_irq(struct sdhci_host *host, u32 intmask)
 	return intmask;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static u32 esdhc_proctl;
 static int esdhc_of_suspend(struct device *dev)
 {
@@ -1260,11 +1259,8 @@ static int esdhc_of_resume(struct device *dev)
 	}
 	return ret;
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(esdhc_of_dev_pm_ops,
-			esdhc_of_suspend,
-			esdhc_of_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(esdhc_of_dev_pm_ops, esdhc_of_suspend, esdhc_of_resume);
 
 static const struct sdhci_ops sdhci_esdhc_be_ops = {
 	.read_l = esdhc_be_readl,
@@ -1511,7 +1507,7 @@ static struct platform_driver sdhci_esdhc_driver = {
 		.name = "sdhci-esdhc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_esdhc_of_match,
-		.pm = &esdhc_of_dev_pm_ops,
+		.pm = pm_sleep_ptr(&esdhc_of_dev_pm_ops),
 	},
 	.probe = sdhci_esdhc_probe,
 	.remove = sdhci_pltfm_remove,
-- 
2.50.0

