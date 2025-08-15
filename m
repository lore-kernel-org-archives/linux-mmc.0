Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127D029344F;
	Fri, 15 Aug 2025 01:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222756; cv=none; b=VdL3U0iz9wCqd/kgSPAoru7E+sB2b1uNjIMygqPOMTHMbI9TPwrfhH67YW4cwmAMOe8Anrm/s/Hrd0aLvuLG4ZkYciD5KDAyCCd+rkCUBzrXsXkF00oGkE8ksr0B30ESbep0pd3Mp0YcfBiXEOHLrstqpUTX0wnwSTFAC+78PQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222756; c=relaxed/simple;
	bh=msCcAvgmi8cjejj/bvx4fWv7p7OoguqU+iU6TDTArRk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CZOMZGmqqKiVIWhFsmHof2T42tivoZLRliargCVL4W1bdJE3vFVC6kYooKTllyknzUl6blqWgzOkQHpJLWW1p0jbkmpNZhl7usUfTIsuyhcqn34zw+0llEI3nJY4UUNKezSmO9OvNHBP+t4f7jzZkGZOnaMFzNQViyWLuYdJYAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYxY7vtX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYxY7vtX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B00A4C4CEF6;
	Fri, 15 Aug 2025 01:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222755;
	bh=msCcAvgmi8cjejj/bvx4fWv7p7OoguqU+iU6TDTArRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eYxY7vtXqaX7YJcy1zJf9xAbJ4YA8B/F9s+Jp/+ua09WP7sEEyT4gPGoQityJgjO1
	 5xl4NBpSYzvNWJqxWajYQuhj7Loh+pJ/t9w3vB2AeD0XTjU4z0EOg76TAkHGxeZOpX
	 8Lhge4A3seUB0oBTgGkg+voVTZmSKUiTeLOk+9KuQIyd4BzMqeeo3LELi68pUpqDFe
	 bArbj5zBXda5yCGXaCVLCyXIRzeCeDJlgF56dc8m3ES63b6gO4gbP8LTxvPCABgiyt
	 zr7o3scbcxG2BwonXW9w2Mq1oD31nTtgnG7hXKGEXOgpuBsb3npikS2ZWwWNkQ7LyV
	 URp6OO0DhF6Lg==
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
Subject: [PATCH 09/38] mmc: cb710-mmc: use modern PM macros
Date: Fri, 15 Aug 2025 09:33:44 +0800
Message-ID: <20250815013413.28641-10-jszhang@kernel.org>
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

At the same time, replace the platform_driver's .suspend and .resume
usage with modern device_driver's .pm usage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/mmc/host/cb710-mmc.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/host/cb710-mmc.c b/drivers/mmc/host/cb710-mmc.c
index 448d2f9159ea..31daec787495 100644
--- a/drivers/mmc/host/cb710-mmc.c
+++ b/drivers/mmc/host/cb710-mmc.c
@@ -664,25 +664,25 @@ static const struct mmc_host_ops cb710_mmc_host = {
 	.get_cd = cb710_mmc_get_cd,
 };
 
-#ifdef CONFIG_PM
-
-static int cb710_mmc_suspend(struct platform_device *pdev, pm_message_t state)
+static int cb710_mmc_suspend(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
 
 	cb710_mmc_enable_irq(slot, 0, ~0);
 	return 0;
 }
 
-static int cb710_mmc_resume(struct platform_device *pdev)
+static int cb710_mmc_resume(struct device *dev)
 {
+	struct platform_device *pdev = to_platform_device(dev);
 	struct cb710_slot *slot = cb710_pdev_to_slot(pdev);
 
 	cb710_mmc_enable_irq(slot, 0, ~0);
 	return 0;
 }
 
-#endif /* CONFIG_PM */
+static DEFINE_SIMPLE_DEV_PM_OPS(cb710_mmc_pmops, cb710_mmc_suspend, cb710_mmc_resume);
 
 static int cb710_mmc_init(struct platform_device *pdev)
 {
@@ -767,13 +767,12 @@ static void cb710_mmc_exit(struct platform_device *pdev)
 }
 
 static struct platform_driver cb710_mmc_driver = {
-	.driver.name = "cb710-mmc",
+	.driver = {
+		.name = "cb710-mmc",
+		.pm = pm_sleep_ptr(&cb710_mmc_pmops),
+	},
 	.probe = cb710_mmc_init,
 	.remove = cb710_mmc_exit,
-#ifdef CONFIG_PM
-	.suspend = cb710_mmc_suspend,
-	.resume = cb710_mmc_resume,
-#endif
 };
 
 module_platform_driver(cb710_mmc_driver);
-- 
2.50.0

