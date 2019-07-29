From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: sdhci-s3c: Mark expected switch fall-through
Date: Sun, 28 Jul 2019 19:02:59 -0500
Message-ID: <20190729000259.GA24022@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ben Dooks <ben-linux@fluff.org>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Kees Cook <keescook@chromium.org>
List-Id: linux-mmc@vger.kernel.org

Mark switch cases where we are expecting to fall through.

This patch fixes the following warnings:

drivers/mmc/host/sdhci-s3c.c: In function 'sdhci_s3c_probe':
drivers/mmc/host/sdhci-s3c.c:613:19: warning: this statement may fall through [-Wimplicit-fallthrough=]
   host->mmc->caps |= MMC_CAP_8_BIT_DATA;
drivers/mmc/host/sdhci-s3c.c:614:2: note: here
  case 4:
  ^~~~

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-s3c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
index 8e4a8ba33f05..cefa0fb8cfde 100644
--- a/drivers/mmc/host/sdhci-s3c.c
+++ b/drivers/mmc/host/sdhci-s3c.c
@@ -611,6 +611,7 @@ static int sdhci_s3c_probe(struct platform_device *pdev)
 	switch (pdata->max_width) {
 	case 8:
 		host->mmc->caps |= MMC_CAP_8_BIT_DATA;
+		/* Fall through */
 	case 4:
 		host->mmc->caps |= MMC_CAP_4_BIT_DATA;
 		break;
-- 
2.22.0
