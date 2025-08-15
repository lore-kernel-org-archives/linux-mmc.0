Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71429CB3E;
	Fri, 15 Aug 2025 01:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222878; cv=none; b=gE0MRpU+vA+E+NRJoZuVR6Uif++U5H6G0OMzbkDujXs0lTiwEDfd/Q5jHMjmtzVEtHiHQCCzmLDFmBIFY3vUzq1bQ9uyAYM6QvYp9p/4st85w8h1YeZHPOWMqPJwAN99NpZz092vZSysGCX6f/hRHmEepDllVOuikiLB0fTC4Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222878; c=relaxed/simple;
	bh=L9nwWEBfXJuPHyqSS33q6AaeSPO5IJkCOi0sAgxs/00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HsIu0BrNHpu51bDMO2jPDp3hQGbRqLXWHry7s6UG3yPwRWI28LpmrjVCz9PucUyVKyX7GwvuHQ9BURi2eX3wE3xtSPhvZXjUtZDoSdJp8PUy3D7pLACvA6uBhX1PfbazCZHmTdZjsaoga/3dGw31oD4Xo9w6YwZBtA4b/Cy6U6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dCo1hZl3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dCo1hZl3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4997EC4CEF5;
	Fri, 15 Aug 2025 01:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222878;
	bh=L9nwWEBfXJuPHyqSS33q6AaeSPO5IJkCOi0sAgxs/00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dCo1hZl3h8+a0xrnd/3RE2wwmFWVthCvDvOPQaLG/501313/kl52bfN9HcfGEIRr4
	 RtC6gFwxLYZQkN7nFcz7vMxv4Ywpt2TdKeVwbPK6N0EiJdB4D6EDSakO0BXURmVgds
	 5uxItax4qqRtSefCXjrGJ7dMhnDA06jhWhmJVjE+QXYLFhPnBHiR/rpz0/KAehIDBo
	 x41/RtmXCVdwb0mjXzgaSJH6rloO5wffkFh3APYW5+SoZ3eL0GUHQrGe4d0WSeitgf
	 UrAeuH7EC0pa0onmM5ZF4sKtpxK9Yzlztp/LTCSImp8gNqL2FOlKvCtNDNfaIHQ7Cy
	 NllY/r+FqVLPw==
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
Subject: [PATCH 25/38] mmc: sdhci-spear: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:00 +0800
Message-ID: <20250815013413.28641-26-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-spear.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/sdhci-spear.c b/drivers/mmc/host/sdhci-spear.c
index fa0f8aeb7ee0..72d21dc0cb69 100644
--- a/drivers/mmc/host/sdhci-spear.c
+++ b/drivers/mmc/host/sdhci-spear.c
@@ -130,7 +130,6 @@ static void sdhci_remove(struct platform_device *pdev)
 	clk_disable_unprepare(sdhci->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -161,9 +160,8 @@ static int sdhci_resume(struct device *dev)
 
 	return sdhci_resume_host(host);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(sdhci_pm_ops, sdhci_suspend, sdhci_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_pm_ops, sdhci_suspend, sdhci_resume);
 
 static const struct of_device_id sdhci_spear_id_table[] = {
 	{ .compatible = "st,spear300-sdhci" },
@@ -175,7 +173,7 @@ static struct platform_driver sdhci_driver = {
 	.driver = {
 		.name	= "sdhci",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &sdhci_pm_ops,
+		.pm	= pm_sleep_ptr(&sdhci_pm_ops),
 		.of_match_table = sdhci_spear_id_table,
 	},
 	.probe		= sdhci_probe,
-- 
2.50.0

