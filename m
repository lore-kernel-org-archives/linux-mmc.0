Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6430B126BF1;
	Fri, 15 Aug 2025 01:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222741; cv=none; b=PVxFGlyFWZbELpimx89HbQ753TSODGYePtzezgDg2ijHGaXGfnQf1VkhgMVeG+NpOomOoDMZilQ0edC22HEX/dROE18F6QipwtB/Wsi+XqItrAcXYR1XDG2EMcRvXzAY6Cpu28830m4e5vK3fwVLdMa5xp4CQJf/23aHdGQB5t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222741; c=relaxed/simple;
	bh=iX7IOVbBU0iKfkEMkyGcPNaVsUqvqC0gaZQA5pKhNR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uQg3FL/G9ysAcaMSHtgV3zsHfqI7hyhyPAZvKWN49QpAOJd+f+BwS/gyMFlIc7IvvFGvQ/JGCD4WyDR2iXC0lvwf/iftfabx7fI8fTpSZYaasRS9jRiTVAdk+zPr1sIiSMKjzVllJknjki9VD5fe68wmuEwCubFSrimzYuRUTZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AhAHFOi/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AhAHFOi/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C205C4CEF5;
	Fri, 15 Aug 2025 01:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222741;
	bh=iX7IOVbBU0iKfkEMkyGcPNaVsUqvqC0gaZQA5pKhNR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AhAHFOi/JlN87VrzcWaGUozNfWkDJ/evavNiYQNbE1+UqRLAQC4ERMcyZNHsaPrhF
	 yA8NnN7BKDDIhAjJ5BJATZQViwfu0wWgUO6Y0p1tWVCaIybdYTJgxz4RT5ns5YHIZg
	 3Ncy76LbVq+yVkmKj3bRlM5ih5HxE8GfWYUHDMj6lL7F3Lawno/YiqQ6vQGbs5qefH
	 xUD+fKizHRSz2sSsX+tsv23T/ByY1g/eBbRRprkWevHZxKnhazMrdiUrPIGgC0llzv
	 n8iJZfEyvrxIdbPBsAcAKCFNfZ3O8e5JAkZbzqm6XNRdslQpACgET0eyg4Mw/DqtSW
	 xAFYTdEN5rH+w==
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
Subject: [PATCH 07/38] mmc: atmel: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:42 +0800
Message-ID: <20250815013413.28641-8-jszhang@kernel.org>
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
 drivers/mmc/host/atmel-mci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 777342fb7657..d1fbc6811563 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2622,7 +2622,6 @@ static void atmci_remove(struct platform_device *pdev)
 	pm_runtime_put_noidle(dev);
 }
 
-#ifdef CONFIG_PM
 static int atmci_runtime_suspend(struct device *dev)
 {
 	struct atmel_mci *host = dev_get_drvdata(dev);
@@ -2642,12 +2641,10 @@ static int atmci_runtime_resume(struct device *dev)
 
 	return clk_prepare_enable(host->mck);
 }
-#endif
 
 static const struct dev_pm_ops atmci_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(atmci_runtime_suspend, atmci_runtime_resume, NULL)
 };
 
 static struct platform_driver atmci_driver = {
@@ -2657,7 +2654,7 @@ static struct platform_driver atmci_driver = {
 		.name		= "atmel_mci",
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table	= atmci_dt_ids,
-		.pm		= &atmci_dev_pm_ops,
+		.pm		= pm_ptr(&atmci_dev_pm_ops),
 	},
 };
 module_platform_driver(atmci_driver);
-- 
2.50.0

