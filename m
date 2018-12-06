From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] mmc: sdhci-of-esdhc: fix spelling mistake "upsupported" -> "unsupported"
Date: Thu,  6 Dec 2018 09:24:11 +0000
Message-ID: <20181206092411.12152-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a pr_warn message, fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/mmc/host/sdhci-of-esdhc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-of-esdhc.c b/drivers/mmc/host/sdhci-of-esdhc.c
index 856e809f38b7..e21e90f81bbd 100644
--- a/drivers/mmc/host/sdhci-of-esdhc.c
+++ b/drivers/mmc/host/sdhci-of-esdhc.c
@@ -597,7 +597,7 @@ static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int clock)
 			pre_div = 4;
 			div = 3;
 		} else {
-			pr_warn("%s: using upsupported clock division.\n",
+			pr_warn("%s: using unsupported clock division.\n",
 				mmc_hostname(host->mmc));
 		}
 	}
-- 
2.19.1
