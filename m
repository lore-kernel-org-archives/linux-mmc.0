Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EE429993B;
	Fri, 15 Aug 2025 01:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755222966; cv=none; b=UlYvrV2bWb4/cLh3qY4wsR2ubUcK0aQcrAOGZ29THb+7I3ESCIXzZIm/vHS8Uu2FXtRpbJRIRD04PRP7ostaWBBUJzM8HS5KUkqvDwdKZOPfUCfzbGeqFYjzjlaHqzR53CcF9gAzOtWRf09i6vg4UR7V4TD0ibz8rbZei7BBsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755222966; c=relaxed/simple;
	bh=Uv4u50M4AilsmnclSV3mx2m8PHaUQmh87HAbah/c+J8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pmcyp5TIMbjgLEeztHMeyv1qj+bp9ridBjBosPU2esd9CO5Dj9YkOR9YJv2hkAmlTplEsMknIgyvZH0wdfJnX+Mf5qzlbp/cpLYspap9Gb/cONTNpx+umdZ/TJA54uroK571iGKWM0m55RTjoIbgTUMPOOkjteNJjBmCrtis2xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jt8IjIFA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jt8IjIFA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341E6C4CEF1;
	Fri, 15 Aug 2025 01:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755222966;
	bh=Uv4u50M4AilsmnclSV3mx2m8PHaUQmh87HAbah/c+J8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jt8IjIFAeAOsvwdVIzDZKDiZatNL33niufHsAHPVmWrxuNHHMWMXjWW9o6M2BPgDi
	 HX65FJ5SQvjp7mVpByb4Oj4KdaxZhxVuQJ+PYti9/8OsBgAuGkqocS7w66pn6AyGLV
	 jUqftc7oiSV0Ef9ECtr6d9+g+S0t/D0ThZwRnLv5+w5vUunAegz/fycsbjaW6f9oSC
	 xQvy/K51Gn9KN2M2LOjfTsRErrmHg7rJHoDevqjB6G470p2nB5dwuedMr6xLQq7SxC
	 RbSYNc2jelAB8tICh0W+1Qh4YEebwUbJpjhtmHdVj6JRwsM2NXO2vyfclVElmORtX5
	 Yek5Ol9IUOYag==
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
Subject: [PATCH 37/38] mmc: dw_mmc-pci: use modern PM macros
Date: Fri, 15 Aug 2025 09:34:12 +0800
Message-ID: <20250815013413.28641-38-jszhang@kernel.org>
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
 drivers/mmc/host/dw_mmc-pci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
index e7ab699f488e..092cc99175af 100644
--- a/drivers/mmc/host/dw_mmc-pci.c
+++ b/drivers/mmc/host/dw_mmc-pci.c
@@ -75,11 +75,8 @@ static void dw_mci_pci_remove(struct pci_dev *pdev)
 }
 
 static const struct dev_pm_ops dw_mci_pci_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(dw_mci_runtime_suspend,
-			   dw_mci_runtime_resume,
-			   NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+	RUNTIME_PM_OPS(dw_mci_runtime_suspend, dw_mci_runtime_resume, NULL)
 };
 
 static const struct pci_device_id dw_mci_pci_id[] = {
@@ -94,7 +91,7 @@ static struct pci_driver dw_mci_pci_driver = {
 	.probe		= dw_mci_pci_probe,
 	.remove		= dw_mci_pci_remove,
 	.driver		=	{
-		.pm =   &dw_mci_pci_dev_pm_ops,
+		.pm =   pm_ptr(&dw_mci_pci_dev_pm_ops),
 	},
 };
 
-- 
2.50.0

