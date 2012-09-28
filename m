From: yongd <yongd@marvell.com>
Subject: [PATCH 2/3] mmc: sdhci-s3c: enable polling to detect card by itself
Date: Fri, 28 Sep 2012 18:28:32 +0800
Message-ID: <1348828113-19668-3-git-send-email-yongd@marvell.com>
References: <1348828113-19668-1-git-send-email-yongd@marvell.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1348828113-19668-1-git-send-email-yongd@marvell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>, Anton Vorontsov <anton.vorontsov@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>, Shawn Guo <shawn.guo@linaro.org>, Wolfram Sang <w.sang@pengutronix.de>, Daniel Drake <dsd@laptop.org>, Sascha Hauer <s.hauer@pengutronix.de>, Wilson Callan <wilson.callan@savantsystems.com>, Ben Dooks <ben-linux@fluff.org>
Cc: zhangfei.gao@marvell.com, kevin.liu@marvell.com, jlfu@marvell.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, yongd <yongd@marvell.com>
List-Id: linux-mmc@vger.kernel.org

In the current code logic, sdhci_add_host() will enable the polling
method (set MMC_CAP_NEEDS_POLL) for a removable card (MMC_CAP_
NONREMOVABLE is not set) whose host's internal card detection method
is disabled for some reason (SDHCI_QUIRK_BROKEN_CARD_DETECTION is set).

However, this is improper since we can have some other card detection
methods besides host internal card detection and polling method. As a
result, sdhci_add_host() will redundantly enable polling for a card
which actually uses other methods, eg external GPIO.

So, we plan to remove such improper setting in sdhci_add_host(). But
before this, this patch is a MUST, which enables polling in host driver
itself when the detection type is S3C_SDHCI_CD_NONE.

Change-Id: I28bd6765e6c6a9dd6c288ff4ca6ecf7268a2d8ed
Signed-off-by: yongd <yongd@marvell.com>
---
 drivers/mmc/host/sdhci-s3c.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 2903949..0701f08 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -687,6 +687,9 @@ static int __devinit sdhci_s3c_probe(struct platform_device *pdev)
 	    pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->quirks |= SDHCI_QUIRK_BROKEN_CARD_DETECTION;
 
+	if (pdata->cd_type == S3C_SDHCI_CD_NONE)
+		host->mmc->caps = MMC_CAP_NEEDS_POLL;
+
 	if (pdata->cd_type == S3C_SDHCI_CD_PERMANENT)
 		host->mmc->caps = MMC_CAP_NONREMOVABLE;
 
-- 
1.7.9.5
