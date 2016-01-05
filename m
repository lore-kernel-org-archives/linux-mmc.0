From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 03/11] mmc: sdhci-msm: use sdhci_pltfm_init for private allocation
Date: Tue, 5 Jan 2016 18:51:31 +0800
Message-ID: <1451991099-4946-4-git-send-email-jszhang@marvell.com>
References: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:4525 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751603AbcAEK4C (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Jan 2016 05:56:02 -0500
In-Reply-To: <1451991099-4946-1-git-send-email-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: ulf.hansson@linaro.org, swarren@wwwdotorg.org, lee@kernel.org, eric@anholt.net, michal.simek@xilinx.com, soren.brinkmann@xilinx.com, ludovic.desroches@atmel.com, srinivas.kandagatla@gmail.com, maxime.coquelin@st.com, patrice.chotard@st.com, thierry.reding@gmail.com, sebastian.hesselbarth@gmail.com
Cc: linux-mmc@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, kernel@stlinux.com, linux-tegra@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

Commit 0e748234293f ("mmc: sdhci: Add size for caller in init+register")
allows users of sdhci_pltfm to allocate private space in calls to
sdhci_pltfm_init+sdhci_pltfm_register. This patch migrates sdhci-msm
to this allocation.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-msm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index 4695bee..0109446 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -437,17 +437,14 @@ static int sdhci_msm_probe(struct platform_device *pdev)
 	u32 core_version, caps;
 	u8 core_major;
 
-	msm_host = devm_kzalloc(&pdev->dev, sizeof(*msm_host), GFP_KERNEL);
-	if (!msm_host)
-		return -ENOMEM;
-
-	msm_host->sdhci_msm_pdata.ops = &sdhci_msm_ops;
-	host = sdhci_pltfm_init(pdev, &msm_host->sdhci_msm_pdata, 0);
+	host = sdhci_pltfm_init(pdev, &msm_host->sdhci_msm_pdata,
+				sizeof(*msm_host));
 	if (IS_ERR(host))
 		return PTR_ERR(host);
 
 	pltfm_host = sdhci_priv(host);
-	pltfm_host->priv = msm_host;
+	msm_host = sdhci_pltfm_priv(pltfm_host);
+	msm_host->sdhci_msm_pdata.ops = &sdhci_msm_ops;
 	msm_host->mmc = host->mmc;
 	msm_host->pdev = pdev;
 
@@ -570,7 +567,7 @@ static int sdhci_msm_remove(struct platform_device *pdev)
 {
 	struct sdhci_host *host = platform_get_drvdata(pdev);
 	struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
-	struct sdhci_msm_host *msm_host = pltfm_host->priv;
+	struct sdhci_msm_host *msm_host = sdhci_pltfm_priv(pltfm_host);
 	int dead = (readl_relaxed(host->ioaddr + SDHCI_INT_STATUS) ==
 		    0xffffffff);
 
-- 
2.6.4

