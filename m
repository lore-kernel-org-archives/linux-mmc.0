From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mmc: sdhci-cadence: fix logically and structurally dead code
Date: Thu, 19 Apr 2018 08:53:16 -0500
Message-ID: <20180419135316.GA14790@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: linux-mmc@vger.kernel.org

Currently, the code block inside the for loop will never execute
more than once, because the function returns inmediately after
the first iteration, hence the execution of the code at the second
iteration is structurally dead and, code at line 281: return 0; is
never reached.

Based on the code comments, it seems that the actual intention is
to execute the code inside the for loop twice instead of once.

So, fix this issue by removing the return statement inside the for
loop and replace the "return 0" with "return ret".

Addresses-Coverity-ID: 1468009 ("Logically dead code")
Addresses-Coverity-ID: 1468002 ("Structurally dead code")
Fixes: 213fae74318b ("mmc: sdhci-cadence: send tune request twice to
work around errata")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mmc/host/sdhci-cadence.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/mmc/host/sdhci-cadence.c b/drivers/mmc/host/sdhci-cadence.c
index bc30d16..facbad8 100644
--- a/drivers/mmc/host/sdhci-cadence.c
+++ b/drivers/mmc/host/sdhci-cadence.c
@@ -275,10 +275,9 @@ static int sdhci_cdns_set_tune_val(struct sdhci_host *host, unsigned int val)
 					 !(tmp & SDHCI_CDNS_HRS06_TUNE_UP),
 					 0, 1);
 
-		return ret;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int sdhci_cdns_execute_tuning(struct mmc_host *mmc, u32 opcode)
-- 
2.7.4
