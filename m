From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: [PATCH] mmc: core: set regulator not found message as debug
Date: Mon, 9 Nov 2015 15:03:59 +0100
Message-ID: <1447077839-446-1-git-send-email-ludovic.desroches@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, nicolas.ferre@atmel.com, Ludovic Desroches <ludovic.desroches@atmel.com>
List-Id: linux-mmc@vger.kernel.org

Turn the informative message about no vmmc/vqmmc regulator found in
debug one. There is no need to indicate that something optional is
missing. Moreover, it can bring confusion, people who doesn't know
it is optional may consider these messages as warnings or errors.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 drivers/mmc/core/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 5ae89e4..5b294dd 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1485,7 +1485,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	if (IS_ERR(mmc->supply.vmmc)) {
 		if (PTR_ERR(mmc->supply.vmmc) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		dev_info(dev, "No vmmc regulator found\n");
+		dev_dbg(dev, "No vmmc regulator found\n");
 	} else {
 		ret = mmc_regulator_get_ocrmask(mmc->supply.vmmc);
 		if (ret > 0)
@@ -1497,7 +1497,7 @@ int mmc_regulator_get_supply(struct mmc_host *mmc)
 	if (IS_ERR(mmc->supply.vqmmc)) {
 		if (PTR_ERR(mmc->supply.vqmmc) == -EPROBE_DEFER)
 			return -EPROBE_DEFER;
-		dev_info(dev, "No vqmmc regulator found\n");
+		dev_dbg(dev, "No vqmmc regulator found\n");
 	}
 
 	return 0;
-- 
2.5.0
