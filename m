Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BB2298CB6;
	Fri, 15 Aug 2025 01:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222944; cv=none; b=FKcpIsO1v6penvgeGeSFo7/vkTb9jVWxOzkCvUzMDssQTiUm4PNI8/z3tpKx2HY23PzT3/jIny1y01aGaMMHVVnf0rnGJp+trO4ugXCO9+ZDxz9r7Ofy8uRTDlHShz7YF0ZMo6CddEg97VVtvWfjhSs33/x2qGrXeqVqhj7XRwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222944; c=relaxed/simple;
	bh=Z/FsofMY227WloXvAvWVR10i7/zLGg3QA6StyCVCXTQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TIpImdMsBnb8/d8kUg0Qz2vLLxqXmPB58nWr/BSjuX8jLO5zkvm+UmQUtCCZTjFqmOjAU4UZ7IH0Be9DtwegDoRpvAPuo4dUErdld3473uq6htT5zbYR1n1YwsiLtD1lGpQk4aW8qWfJXnLlarQeO+sJ73njQ8iGATYGmZ3Z04E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OW/j3RE4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OW/j3RE4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44606C4CEED;
	Fri, 15 Aug 2025 01:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222944;
	bh=Z/FsofMY227WloXvAvWVR10i7/zLGg3QA6StyCVCXTQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OW/j3RE4gSC9rK+tSuZ57U4rHnlmxISJot7EpnrpDrgOouzGgNFk0UOcaErlsTQ6d
	 uX0IVq4zSSDaG47TOF6/qi/j+8Z+uduZj8w3nD3F+8R/08UkGYAyFiCYGFkpEA6y9w
	 /awaCZrSKl6HBt4QNue6ZHhnMo43QJY4yEdHkntbeLCTwRSCJa9SJ6j3UhnkBhGBH4
	 7AS2D8V5V+LzAFWtn9E4vT1E6F+yKnL76IujTBTzcESQftqBo7OMsYVscPcE8Kl8SZ
	 TitK2vHcs58qXiuo0sQC67BuAU3YvFWNLF1xp479XGhhrXBK2zK1JscwcoRRT6yis3
	 Zw0xfYV55Uc0g==
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
Subject: [PATCH 34/38] mmc: via-sdmmc: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:09 +0800
Message-ID: <20250815013413.28641-35-jszhang@kernel.org>
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
 drivers/mmc/host/via-sdmmc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/via-sdmmc.c b/drivers/mmc/host/via-sdmmc.c
index 3bd49f64899d..c628b3bbfd7a 100644
--- a/drivers/mmc/host/via-sdmmc.c
+++ b/drivers/mmc/host/via-sdmmc.c
@@ -1218,7 +1218,7 @@ static void via_sd_remove(struct pci_dev *pcidev)
 		pci_name(pcidev), (int)pcidev->vendor, (int)pcidev->device);
 }
 
-static void __maybe_unused via_init_sdc_pm(struct via_crdr_mmc_host *host)
+static void via_init_sdc_pm(struct via_crdr_mmc_host *host)
 {
 	struct sdhcreg *pm_sdhcreg;
 	void __iomem *addrbase;
@@ -1252,7 +1252,7 @@ static void __maybe_unused via_init_sdc_pm(struct via_crdr_mmc_host *host)
 	via_print_sdchc(host);
 }
 
-static int __maybe_unused via_sd_suspend(struct device *dev)
+static int via_sd_suspend(struct device *dev)
 {
 	struct via_crdr_mmc_host *host;
 	unsigned long flags;
@@ -1269,7 +1269,7 @@ static int __maybe_unused via_sd_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused via_sd_resume(struct device *dev)
+static int via_sd_resume(struct device *dev)
 {
 	struct via_crdr_mmc_host *sdhost;
 	u8 gatt;
@@ -1295,14 +1295,14 @@ static int __maybe_unused via_sd_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(via_sd_pm_ops, via_sd_suspend, via_sd_resume);
+static DEFINE_SIMPLE_DEV_PM_OPS(via_sd_pm_ops, via_sd_suspend, via_sd_resume);
 
 static struct pci_driver via_sd_driver = {
 	.name = DRV_NAME,
 	.id_table = via_ids,
 	.probe = via_sd_probe,
 	.remove = via_sd_remove,
-	.driver.pm = &via_sd_pm_ops,
+	.driver.pm = pm_sleep_ptr(&via_sd_pm_ops),
 };
 
 module_pci_driver(via_sd_driver);
-- 
2.50.0

