From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v3 4/6] mmc: sdhci-s3c: derive transfer width host capability
 from max_width in platform data
Date: Tue, 31 Jan 2012 23:26:14 +0530
Message-ID: <1328032576-9269-5-git-send-email-thomas.abraham@linaro.org>
References: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1328032576-9269-1-git-send-email-thomas.abraham@linaro.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: linux-arm-kernel@lists.infradead.org, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, ben-linux@fluff.org, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

max_width member in platform data can be used to derive the mmc bus transfer
width that can be supported by the controller.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
 drivers/mmc/host/sdhci-s3c.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index e1b685d..a57d7a0 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -562,6 +562,14 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;
 
+	switch (pdata->max_width) {
+	case 8:
+		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+	case 4:
+		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
+		break;
+	}
+
 	if (pdata->host_caps)
 		host->mmc->caps |= pdata->host_caps;
 
-- 
1.6.6.rc2
