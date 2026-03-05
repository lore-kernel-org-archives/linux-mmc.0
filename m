Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472A86352;
	Thu,  5 Mar 2026 09:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701709; cv=none; b=PjZjQC2RJzf8U9i/t/3o92kS8ZWMja3zsPOmzGnbmZqlqoP+iobAtVGaO5jhL3Q7vLHc0y+mBDJsj2H1YFPtEOnHylFRBv2z/QwzKCCMCO1SUygQFpaOz6UGLZfqzQXA3esBzIfoWNt/amT4leFWkCXhNCSHej0bNw2uHgPA9I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701709; c=relaxed/simple;
	bh=pSUkOoJ4/ALTuvO3W1IcZcBwHHAMJ8QP4EcXEfW2+5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Fihgyx0d2VwheVXOBnI3Lb37g9Hod+TbXt1w+ZKNrXE++B/VY6EbHpZJuNKacL1n6Rbei1tcjRpqumrMkkBeszNLksNIzxXSG/pqMZUYEstYaZxjXI/Cc14PrTwrl5Ls5dUJa9V5j7//9TN5pGTlEjLzkDhSrXcicm8mG4r15qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE620C116C6;
	Thu,  5 Mar 2026 09:08:27 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] mmc: renesas_sdhi_sys_dmac: Convert to DEFINE_RUNTIME_DEV_PM_OPS()
Date: Thu,  5 Mar 2026 10:08:24 +0100
Message-ID: <a72e532c7364cd64b5cb4fc63c94b2af6b22ad8b.1772701528.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-mmc@vger.kernel.org
List-Id: <linux-mmc.vger.kernel.org>
List-Subscribe: <mailto:linux-mmc+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-mmc+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the Renesas SDHI SD/SDIO controller driver using SYS-DMAC from
an open-coded dev_pm_ops structure to DEFINE_RUNTIME_DEV_PM_OPS() and
pm_ptr().  This simplifies the code, and reduces kernel size in case
CONFIG_PM is disabled.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/renesas_sdhi_sys_dmac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/renesas_sdhi_sys_dmac.c b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
index 543ad1d0ed1cff95..9215600f03a2340e 100644
--- a/drivers/mmc/host/renesas_sdhi_sys_dmac.c
+++ b/drivers/mmc/host/renesas_sdhi_sys_dmac.c
@@ -456,19 +456,15 @@ static int renesas_sdhi_sys_dmac_probe(struct platform_device *pdev)
 				  of_device_get_match_data(&pdev->dev), NULL);
 }
 
-static const struct dev_pm_ops renesas_sdhi_sys_dmac_dev_pm_ops = {
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-	SET_RUNTIME_PM_OPS(tmio_mmc_host_runtime_suspend,
-			   tmio_mmc_host_runtime_resume,
-			   NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(renesas_sdhi_sys_dmac_dev_pm_ops,
+				 tmio_mmc_host_runtime_suspend,
+				 tmio_mmc_host_runtime_resume, NULL);
 
 static struct platform_driver renesas_sys_dmac_sdhi_driver = {
 	.driver		= {
 		.name	= "sh_mobile_sdhi",
 		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
-		.pm	= &renesas_sdhi_sys_dmac_dev_pm_ops,
+		.pm	= pm_ptr(&renesas_sdhi_sys_dmac_dev_pm_ops),
 		.of_match_table = renesas_sdhi_sys_dmac_of_match,
 	},
 	.probe		= renesas_sdhi_sys_dmac_probe,
-- 
2.43.0

