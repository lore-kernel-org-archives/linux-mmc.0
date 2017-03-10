From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH 2/3] mmc: sdhci-pxav2: remove unnecessary platform_set_drvdata() call
Date: Fri, 10 Mar 2017 11:17:32 +0800
Message-ID: <20170310031733.812-3-jszhang@marvell.com>
References: <20170310031733.812-1-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170310031733.812-1-jszhang@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org, patrice.chotard@st.com
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kernel@stlinux.com, Jisheng Zhang <jszhang@marvell.com>
List-Id: linux-mmc@vger.kernel.org

sdhci_pltfm_init() has already set the platform drvdata for us, remove
the unnecessary platform_set_drvdata() call.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/mmc/host/sdhci-pxav2.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav2.c b/drivers/mmc/host/sdhci-pxav2.c
index 347eae2d7b6a..74e21ad699e0 100644
--- a/drivers/mmc/host/sdhci-pxav2.c
+++ b/drivers/mmc/host/sdhci-pxav2.c
@@ -222,8 +222,6 @@ static int sdhci_pxav2_probe(struct platform_device *pdev)
 		goto err_add_host;
 	}
 
-	platform_set_drvdata(pdev, host);
-
 	return 0;
 
 err_add_host:
-- 
2.11.0
