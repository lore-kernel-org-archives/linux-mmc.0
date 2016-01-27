From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [RFC PATCH 02/21] mmc: sdhci-iproc: consolidate parsing path
Date: Wed, 27 Jan 2016 13:06:25 +0800
Message-ID: <1453871185-3371-1-git-send-email-shawn.lin@rock-chips.com>
References: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1453871155-3283-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: bcm-kernel-feedback-list@broadcom.com, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>, Scott Branden <sbranden@broadcom.com>
List-Id: linux-mmc@vger.kernel.org

This patch remove mmc_of_parse and check return value
of sdhci_get_of_property.

Cc: Scott Branden <sbranden@broadcom.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 drivers/mmc/host/sdhci-iproc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
index 3b423b0..18cfe2c 100644
--- a/drivers/mmc/host/sdhci-iproc.c
+++ b/drivers/mmc/host/sdhci-iproc.c
@@ -196,8 +196,9 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
 
 	iproc_host->data = iproc_data;
 
-	mmc_of_parse(host->mmc);
-	sdhci_get_of_property(pdev);
+	ret = sdhci_get_of_property(pdev);
+	if (ret)
+		return ret;
 
 	/* Enable EMMC 1/8V DDR capable */
 	host->mmc->caps |= MMC_CAP_1_8V_DDR;
-- 
2.3.7
