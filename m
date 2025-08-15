Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A873C292B52;
	Fri, 15 Aug 2025 01:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222929; cv=none; b=uU3uZNVTuHb1VvmnmYeZmQTMsUY4X/Ys5Ymj8tyR7acFeoJ0Q4I/tC664D1Y+uGsUfntIhquRRbARjG33AKVQkZmHTZS4nhhipgNhaXqwFcxDlDWxJkGShgobKE7GZdqraqlDnBOKUP+pgh26fAMmi2KdY4bzJ3XBVsJZaqjSNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222929; c=relaxed/simple;
	bh=Yz6S1aReViAb+oa9fo4YKprCoSFsQvvu8L/EMETvz4o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N6YJAcAG5u1W1aI3/w8Mwho/qpQEdGEjJsVZxO97LCk0DRUcZb1hEcCvf54VI1P8T1bMWVAH29WENNl7zkv4fktDPbIH1+vki3X3b0L1cl3YRz46t/eZm/UefI+OLFERQUS4YF6AJi97qnibJCMpVBh0FjP/+QT8l0Ot9QITVi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oo7KKsOn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oo7KKsOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3631C4CEF7;
	Fri, 15 Aug 2025 01:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222929;
	bh=Yz6S1aReViAb+oa9fo4YKprCoSFsQvvu8L/EMETvz4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oo7KKsOnqOrOeW8JFEspGz8d0cYNYYwDRC1lGRMvlkfLtQtoclXl4dSYJ0imBPThN
	 3U2yVWv1N+vNGsvwsVDpnd4Onf7L133aDlsW5y46acLC1uLdr4wM7mCvITB9jv1gf9
	 QT+jyZkNvC5Bldm9CItsRuOgxAkDPRR2cjO1Vmi+t6MFPZOoTAp9QYSjyKLqvArfkV
	 pllZ4qd34NmBzPuhjZ6PKFU8zegltGajQ1N1+laWgSM4pik5U+Xa31rPiqm89pQqLk
	 ZUTPXatTESyJkFbWra6RttFDtMAWgNHece4mcieh1paG/dtd1pC6De5sbUQgM6mPJq
	 aUieWj0A6LygA==
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
Subject: [PATCH 32/38] mmc: mtk-sd: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:07 +0800
Message-ID: <20250815013413.28641-33-jszhang@kernel.org>
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
CONFIG_PM_SLEEP are disabled, without having to use __maybe_unused.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/mtk-sd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index d7020e06dd55..79074291e9d2 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -3278,7 +3278,7 @@ static void msdc_restore_reg(struct msdc_host *host)
 		__msdc_enable_sdio_irq(host, 1);
 }
 
-static int __maybe_unused msdc_runtime_suspend(struct device *dev)
+static int msdc_runtime_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
@@ -3300,7 +3300,7 @@ static int __maybe_unused msdc_runtime_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused msdc_runtime_resume(struct device *dev)
+static int msdc_runtime_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
@@ -3323,7 +3323,7 @@ static int __maybe_unused msdc_runtime_resume(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused msdc_suspend(struct device *dev)
+static int msdc_suspend(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
@@ -3348,7 +3348,7 @@ static int __maybe_unused msdc_suspend(struct device *dev)
 	return pm_runtime_force_suspend(dev);
 }
 
-static int __maybe_unused msdc_resume(struct device *dev)
+static int msdc_resume(struct device *dev)
 {
 	struct mmc_host *mmc = dev_get_drvdata(dev);
 	struct msdc_host *host = mmc_priv(mmc);
@@ -3360,8 +3360,8 @@ static int __maybe_unused msdc_resume(struct device *dev)
 }
 
 static const struct dev_pm_ops msdc_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
-	SET_RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(msdc_suspend, msdc_resume)
+	RUNTIME_PM_OPS(msdc_runtime_suspend, msdc_runtime_resume, NULL)
 };
 
 static struct platform_driver mt_msdc_driver = {
@@ -3371,7 +3371,7 @@ static struct platform_driver mt_msdc_driver = {
 		.name = "mtk-msdc",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = msdc_of_ids,
-		.pm = &msdc_dev_pm_ops,
+		.pm = pm_ptr(&msdc_dev_pm_ops),
 	},
 };
 
-- 
2.50.0

