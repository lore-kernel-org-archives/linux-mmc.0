From: Piotr Sroka <piotrs@cadence.com>
Subject: [v5 4/4] mmc: sdhci-cadence: refactor probe function
Date: Tue, 21 Mar 2017 14:33:26 +0000
Message-ID: <1490106806-3936-1-git-send-email-piotrs@cadence.com>
References: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1490106736-2242-1-git-send-email-piotrs@cadence.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, Piotr Sroka <piotrs@cadence.com>
List-Id: linux-mmc@vger.kernel.org

Use added dev variable for devm_clk_get.

Signed-off-by: Piotr Sroka <piotrs@cadence.com>
---
Changes for v5:
- patch created in v5
---
 drivers/mmc/host/sdhci-cadence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index c3c7090..5aa238d 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -305,7 +305,7 @@ static int sdhci_cdns_probe(struct platform_device *pdev)
 	int ret;
 	struct device *dev = &pdev->dev;
 
-	clk = devm_clk_get(&pdev->dev, NULL);
+	clk = devm_clk_get(dev, NULL);
 	if (IS_ERR(clk))
 		return PTR_ERR(clk);
 
-- 
2.2.2
