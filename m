From: Mike Looijmans <mike.looijmans@topic.nl>
Subject: [PATCH 1/2] mmc/host/sdhci-of-arasan.c: Use signed formatting in error messages
Date: Thu, 23 Oct 2014 13:31:00 +0200
Message-ID: <1414063861-5491-1-git-send-email-mike.looijmans@topic.nl>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: michal.simek@xilinx.com, chris@printf.net, ulf.hansson@linaro.org, Mike Looijmans <mike.looijmans@topic.nl>
List-Id: linux-mmc@vger.kernel.org

"ret" is a signed int, so use "%d" in format strings instead of "%u".
This prevents cryptic codes in error messages like this:
sdhci-arasan e0101000.sdhci: platform register failed (4294966779)

Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
Reviewed-by: Michal Simek <michal.simek@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index 8cf81c3..7ac6718 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -161,7 +161,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
 	if (IS_ERR(host)) {
 		ret = PTR_ERR(host);
-		dev_err(&pdev->dev, "platform init failed (%u)\n", ret);
+		dev_err(&pdev->dev, "platform init failed (%d)\n", ret);
 		goto clk_disable_all;
 	}
 
@@ -172,7 +172,7 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	ret = sdhci_add_host(host);
 	if (ret) {
-		dev_err(&pdev->dev, "platform register failed (%u)\n", ret);
+		dev_err(&pdev->dev, "platform register failed (%d)\n", ret);
 		goto err_pltfm_free;
 	}
 
-- 
1.7.9.5
