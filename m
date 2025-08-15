Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13DC29344F;
	Fri, 15 Aug 2025 01:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222815; cv=none; b=MOYQdkKL21uy93q22wa1DeE6AkTQ3T7/iNEv3K6SBddjeh8pOOhaxIfcy83x0gs6/MD8+Q1so62jOXmXr2VLI0JLzKYubuMqykycnE6A59dzaItAQPwzQL2ZplWYAuw0NtoTxhNT7hRSZTQM4wa2+zqd8fCsMAznYRkQ19wZRqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222815; c=relaxed/simple;
	bh=iJdqm6fChWwedp2Qg212RxFmubV9KbL+zQFWdcThFmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V7KzbZgd0i510EGo74rJNUpYatJ4Fi3Wa2NWLxKHiRQGTYvcErjDTKmZB9+1S19bIktJ1PpoKiuM6phACIcY2zgZTvYI6FGFyhO/AyqPbknr6bj5wfKK3vvmiARBs3x7jBbafG7UrNVL/H3j1gz9HE4BZVaRW0yiBBJreaCwFiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLZuYmwt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLZuYmwt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B2EDC4CEF1;
	Fri, 15 Aug 2025 01:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222814;
	bh=iJdqm6fChWwedp2Qg212RxFmubV9KbL+zQFWdcThFmU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XLZuYmwtHOgawZHbrs8le8MEYR/bhrslLCuXmTzmlh9ePiBAwNmn8qWKi2OT3qvt1
	 DIduGIQOWIVFcR8lxBqFd1fCQqMrRV7aURdAEqTmofgMh6OSJ/6TBBUmZdbKfWKYK9
	 L6MGwudUvFaN+mwX/1j8hbar75j07GD1qlz29unB+KABOegvBADlds6VHSkKv1wjg9
	 GvssvpcQ545H62GkC+1qy4LAdEc9CnyuoknqFM+0+TfDfxbOkQypiMVMrLbbGxfkGe
	 1Nu2vgjF/7e4r007hcFP7499UWdnBvwx21LhqHTHKO0lwo3eY5BqZRDKSByJRa7yYi
	 a/+Iufw2UGzBg==
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
Subject: [PATCH 17/38] mmc: sdhci-brcmstb: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:52 +0800
Message-ID: <20250815013413.28641-18-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-brcmstb.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci-brcmstb.c b/drivers/mmc/host/sdhci-brcmstb.c
index efc2f3bdc631..15705e85417f 100644
--- a/drivers/mmc/host/sdhci-brcmstb.c
+++ b/drivers/mmc/host/sdhci-brcmstb.c
@@ -496,7 +496,6 @@ static void sdhci_brcmstb_shutdown(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, sdhci_brcm_of_match);
 
-#ifdef CONFIG_PM_SLEEP
 static int sdhci_brcmstb_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -540,17 +539,14 @@ static int sdhci_brcmstb_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops sdhci_brcmstb_pmops = {
-	SET_SYSTEM_SLEEP_PM_OPS(sdhci_brcmstb_suspend, sdhci_brcmstb_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(sdhci_brcmstb_pmops, sdhci_brcmstb_suspend, sdhci_brcmstb_resume);
 
 static struct platform_driver sdhci_brcmstb_driver = {
 	.driver		= {
 		.name	= "sdhci-brcmstb",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &sdhci_brcmstb_pmops,
+		.pm	= pm_sleep_ptr(&sdhci_brcmstb_pmops),
 		.of_match_table = of_match_ptr(sdhci_brcm_of_match),
 	},
 	.probe		= sdhci_brcmstb_probe,
-- 
2.50.0

