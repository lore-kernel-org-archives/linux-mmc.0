Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D055129ACE6;
	Fri, 15 Aug 2025 01:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222885; cv=none; b=sYva0zelM6RK+rPVZoM7o6zjy0brBZ1HLr0wVOpcltgqFxV0u6HEjbWBNWu2owqXXwFgQh6iyjq7Vj820GcLdXWZqEndFBqOn6oV+l30UZSrGlxHGfHk7ZbVjhEIh6Rb0oggeye8usz7yGaLCWSchQ3felQuXAlBE/uCO0qNteI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222885; c=relaxed/simple;
	bh=TtXJDmxezN+QVZxIQGLYSDHPqxnbwoOEA70hU7804NA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=knrMVo/jGNRIWHOiltXRLm5fsHSzyo7TlR7/GLhGWkgJZdEKN578bb4YNJSJE5kPOp8DAWK57dj8KkEF2MYRRx848VqE49N/90nClZFdLpLX+UcDIGDv8/JXtRWr2j/KWwhG55zuZoPYXXzrF0UrMdTRWhYjf7iSlIAV7AfXmCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SMWNEvJv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SMWNEvJv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8F7FC4CEF1;
	Fri, 15 Aug 2025 01:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222885;
	bh=TtXJDmxezN+QVZxIQGLYSDHPqxnbwoOEA70hU7804NA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SMWNEvJvzM0oLtdZFwynmU8NMdDuBZ/xydk9OkNcJBREHSbb5xYExOdmRjF6YzCuQ
	 ORMllVx1oDrfemI/MQC1zNCNlpyU/k/tr1eZtUSHM9z9BxuQchCOjJM3R+VYUYt/0s
	 BJCU0YP+RU8OaPgqt7bw/2L71UXedMEwLwTPskv71/ZgHh8wjRHN/W0Vp0E+9Kohy/
	 VVPS9jbXdngclLmKw8bv+4uPE42oVSRoArxupZ+AVWJms/sMUIpiHGt2L6fDFz0fPN
	 x9sx5Y9D4pe36aMNvFgd6HDqO2OJBP0ROzgV3qvAnaH5MqWXfapfc1NenY6OfEx/B+
	 OUf/s9U/2oDLA==
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
Subject: [PATCH 26/38] mmc: sdhci-sprd: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:01 +0800
Message-ID: <20250815013413.28641-27-jszhang@kernel.org>
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
 drivers/mmc/host/sdhci-sprd.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/mmc/host/sdhci-sprd.c b/drivers/mmc/host/sdhci-sprd.c
index fe2fe52b23b2..3584a2b314a9 100644
--- a/drivers/mmc/host/sdhci-sprd.c
+++ b/drivers/mmc/host/sdhci-sprd.c
@@ -903,7 +903,6 @@ static const struct of_device_id sdhci_sprd_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, sdhci_sprd_of_match);
 
-#ifdef CONFIG_PM
 static int sdhci_sprd_runtime_suspend(struct device *dev)
 {
 	struct sdhci_host *host = dev_get_drvdata(dev);
@@ -950,13 +949,10 @@ static int sdhci_sprd_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
 static const struct dev_pm_ops sdhci_sprd_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(sdhci_sprd_runtime_suspend,
-			   sdhci_sprd_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(sdhci_sprd_runtime_suspend, sdhci_sprd_runtime_resume, NULL)
 };
 
 static struct platform_driver sdhci_sprd_driver = {
@@ -966,7 +962,7 @@ static struct platform_driver sdhci_sprd_driver = {
 		.name = "sdhci_sprd_r11",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
 		.of_match_table = sdhci_sprd_of_match,
-		.pm = &sdhci_sprd_pm_ops,
+		.pm = pm_ptr(&sdhci_sprd_pm_ops),
 	},
 };
 module_platform_driver(sdhci_sprd_driver);
-- 
2.50.0

