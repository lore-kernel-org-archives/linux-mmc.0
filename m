From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 3/3] mmc: sdhci-st: remove unnecessary platform_set_drvdata() call
Date: Fri, 10 Mar 2017 11:17:33 +0800
Message-ID: <20170310031733.812-4-jszhang@marvell.com>
References: <20170310031733.812-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:36547 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752935AbdCJDWo (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Mar 2017 22:22:44 -0500
In-Reply-To: <20170310031733.812-1-jszhang@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, patrice.chotard@st.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, Jisheng Zhang <jszhang@marvell.com>

sdhci_pltfm_init() has already set the platform drvdata for us, remove
the unnecessary platform_set_drvdata() call.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-st.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-st.c b/drivers/mmc/host/sdhci-st.c
index ed92ce729dde..7fff6490855c 100644
--- a/drivers/mmc/host/sdhci-st.c
+++ b/drivers/mmc/host/sdhci-st.c
@@ -418,8 +418,6 @@ static int sdhci_st_probe(struct platform_device *pdev)
 		goto err_out;
 	}
 
-	platform_set_drvdata(pdev, host);
-
 	host_version = readw_relaxed((host->ioaddr + SDHCI_HOST_VERSION));
 
 	dev_info(&pdev->dev, "SDHCI ST Initialised: Host Version: 0x%x Vendor Version 0x%x\n",
-- 
2.11.0

