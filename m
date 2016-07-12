From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 2/2] mmc: dw_mmc: Print proper voltage on error
Date: Tue, 12 Jul 2016 16:08:22 +0200
Message-ID: <1468332502-28016-2-git-send-email-k.kozlowski@samsung.com>
References: <1468332502-28016-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1468332502-28016-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

The commit 97f659a2e972 ("mmc: dw_mmc: prevent to set the wrong
value") reordered the code so the 'uhs' variable used in
mmc_regulator_set_vqmmc() error message is always 0 at that time thus
always printing 3.3 voltage.  Instead use value obtained from ios in
printed error message.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mmc/host/dw_mmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c2a128628b31..7de561065003 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1416,8 +1416,8 @@ static int dw_mci_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	ret = mmc_regulator_set_vqmmc(mmc, ios);
 	if (ret) {
 		dev_err(&mmc->class_dev,
-				 "Regulator set error %d - %s V\n",
-				 ret, uhs & v18 ? "1.8" : "3.3");
+				 "Regulator set error %d - %s\n",
+				 ret, mmc_voltage_to_str(ios));
 		return ret;
 	}
 
-- 
1.9.1
