Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEEE292B52;
	Fri, 15 Aug 2025 01:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222916; cv=none; b=QnA7YyTugzM1RHr0Rc2XrOJu+iW+245PJ4W9ZJx/6jIlGnHThGOP6H3KoxfQDTw8SI2uw5cgEr9lEgRG1MbjPjprTw3zZyfuYjZOrZVgHaKZiZCx3OkulSPPJTlM1ViS8QABx/Di9UjXLYKjnbAu57M02vkXG9IrlGTf0Nox6qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222916; c=relaxed/simple;
	bh=OmkHH+BV0FO3aQkqJcAtiZOudBZE3tLbZpIaJkccmEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxXQEJaAOD4lxxhYobcrEvkaz5CmcGdVa13vgpePv7FtWsk7jekkf3PiX4Mo2VX32N6IkAgELoFJ74dxh8no6UNdSEJyAREHzivkat7y7LgDbAFN8/6kc+dwwShYL2wPwszm6OwaEzi1lqTqAE+8/2TTjA7n2fzZPzNLlO0QN6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d1ZeR1dQ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1ZeR1dQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C520C4CEF1;
	Fri, 15 Aug 2025 01:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222914;
	bh=OmkHH+BV0FO3aQkqJcAtiZOudBZE3tLbZpIaJkccmEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d1ZeR1dQ4X/pYWoMSzzAZK7SAhdjKYhNYU8WyOESyVUQ5r6YZPv5CbzHsGkVnLUi2
	 6eHkGD6ioUlPUGuKUDcC4yId/C3asaEkmanEV7wt1XHgp8ocyFHBsPdTHj1Pj+OXRG
	 u9VvHxjEnhHmk7d3BFBYJZomK6w4u2tz/TS9wOyYj7cnC8Xg+GroQyGgCmFvOsywCs
	 WQqskVLkkuSd6ezrpFO4QTjlfbEsIBekeYcsfIx38NsPoJLZj+66bQvIpIpxWKP+J8
	 NmsbwB/4U55+BQLj37wbsApVmKmhc2AFzkd86dpCiLRQr59dx8vWLBHkgV+e0LTBvy
	 NjWyfSfvSLsEA==
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
Subject: [PATCH 30/38] mmc: toshsd: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:05 +0800
Message-ID: <20250815013413.28641-31-jszhang@kernel.org>
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
 drivers/mmc/host/toshsd.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/toshsd.c b/drivers/mmc/host/toshsd.c
index e5f7f8abafc0..aa5d2511a62b 100644
--- a/drivers/mmc/host/toshsd.c
+++ b/drivers/mmc/host/toshsd.c
@@ -567,7 +567,6 @@ static void toshsd_powerdown(struct toshsd_host *host)
 	pci_write_config_byte(host->pdev, SD_PCICFG_CLKSTOP, 0);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int toshsd_pm_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -599,7 +598,6 @@ static int toshsd_pm_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static int toshsd_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 {
@@ -688,16 +686,14 @@ static void toshsd_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
-static const struct dev_pm_ops toshsd_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(toshsd_pm_suspend, toshsd_pm_resume)
-};
+static DEFINE_SIMPLE_DEV_PM_OPS(toshsd_pm_ops, toshsd_pm_suspend, toshsd_pm_resume);
 
 static struct pci_driver toshsd_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pci_ids,
 	.probe = toshsd_probe,
 	.remove = toshsd_remove,
-	.driver.pm = &toshsd_pm_ops,
+	.driver.pm = pm_sleep_ptr(&toshsd_pm_ops),
 };
 
 module_pci_driver(toshsd_driver);
-- 
2.50.0

