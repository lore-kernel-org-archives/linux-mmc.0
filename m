Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF86292B4B;
	Fri, 15 Aug 2025 01:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222778; cv=none; b=uAC1lBxagIelztoKzgZiqJS35Q99rdTc9vXcpsSNC9vhOu5lgJMX4i1cexMt85diwgHdFXttbOtpyX7H92iCCajDa+CergjlLmTZAZMXV0Dm6DBh/KHoDjrqF4Qfdkkd4cRTFwSBZA0ijS0xsp8mgC2X79Ko3R9jUFRVHsxncAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222778; c=relaxed/simple;
	bh=INlG0kmvqymyn+H5Y2Jxgc3TKHlGOcIl3DMuV65cwzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f2+Aqsuh0jhtUJreI6+0tJw1/xnCTcARVo3o4fpC761yFgSsQeXcbmZvtvhs6+aEH59EmsnLsk5SY84u1Igtf7gHdiLyOR1MV9rBDt9COD4Bhn/CvJK4qykuRpiVUju0oj132ryfG3UpVzgdLhJ8fuqXJzR/YEnRGjgUMXADT/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A14Vblpk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A14Vblpk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C69C4CEF1;
	Fri, 15 Aug 2025 01:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222777;
	bh=INlG0kmvqymyn+H5Y2Jxgc3TKHlGOcIl3DMuV65cwzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A14Vblpk8k9Atpkx9WpA3Dde2demSaHB2yZO/0mQsaCMmun0f8LeslrhEiMq0/3F8
	 PqoajhBfFhrvJsBMBLF1P7ULHedL4y2MFD2f+DPCTxSoa5hc07kO6khaXdp1CrVEFO
	 b60JqOU32zhF5vFkpBtwXJtj53rzUpZnvG5Hm7cCMI+jllN6iUxeltHtwKaIOeL627
	 012abVMeD0JY5e62IUTg7CbGvw0NPaPPPZVY/3xgnZmwO2SwdxITZ0EgqcGy+cjujo
	 DtlzZWuPZnlClsRsftc3dIomXOlfG29IYgZ+WXU4H0trSxqPVY4cdY9Fa01gTN93L7
	 cNUTWhma3TXsw==
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
Subject: [PATCH 12/38] mmc: mxs-mmc: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:47 +0800
Message-ID: <20250815013413.28641-13-jszhang@kernel.org>
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
 drivers/mmc/host/mxs-mmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mxs-mmc.c b/drivers/mmc/host/mxs-mmc.c
index a6e44e406106..7c7c52d9e8e7 100644
--- a/drivers/mmc/host/mxs-mmc.c
+++ b/drivers/mmc/host/mxs-mmc.c
@@ -680,7 +680,6 @@ static void mxs_mmc_remove(struct platform_device *pdev)
 	clk_disable_unprepare(ssp->clk);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int mxs_mmc_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
@@ -699,9 +698,8 @@ static int mxs_mmc_resume(struct device *dev)
 
 	return clk_prepare_enable(ssp->clk);
 }
-#endif
 
-static SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_suspend, mxs_mmc_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(mxs_mmc_pm_ops, mxs_mmc_suspend, mxs_mmc_resume);
 
 static struct platform_driver mxs_mmc_driver = {
 	.probe		= mxs_mmc_probe,
@@ -709,7 +707,7 @@ static struct platform_driver mxs_mmc_driver = {
 	.driver		= {
 		.name	= DRIVER_NAME,
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &mxs_mmc_pm_ops,
+		.pm	= pm_sleep_ptr(&mxs_mmc_pm_ops),
 		.of_match_table = mxs_mmc_dt_ids,
 	},
 };
-- 
2.50.0

