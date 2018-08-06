From: Michal Simek <michal.simek@xilinx.com>
Subject: [PATCH] mmc: sdhci-of-arasan: Do now show error message in case of deffered probe
Date: Mon,  6 Aug 2018 10:43:10 +0200
Message-ID: <c9688c600633ce9f4d7b6319366116e6e7c4b97d.1533544988.git.michal.simek@xilinx.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, monstr@monstr.eu
Cc: Adrian Hunter <adrian.hunter@intel.com>, linux-mmc@vger.kernel.org, Jaehoon Chung <jh80.chung@samsung.com>, u-boot@lists.denx.de, linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

When mmc-pwrseq property is passed mmc_pwrseq_alloc() can return
-EPROBE_DEFER because driver for power sequence provider is not probed
yet. Do not show error message when this situation happens.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
index e3332a522a5d..e65f3bce3643 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -772,7 +772,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
 
 	ret = mmc_of_parse(host->mmc);
 	if (ret) {
-		dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev, "parsing dt failed (%d)\n", ret);
 		goto unreg_clk;
 	}
 
-- 
1.9.1
