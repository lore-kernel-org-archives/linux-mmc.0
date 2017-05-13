From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] mmc: core: Delete an error message for a failed memory
 allocation in three functions
Date: Sat, 13 May 2017 14:54:10 +0200
Message-ID: <b0978766-199a-942e-43d8-58d2a8a17e1a@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Burton <paul.burton@imgtec.com>, Shawn Lin <shawn.lin@rock-chips.com>, Ulf Hansson <ulf.hansson@linaro.org>, Uri Yanai <uri.yanai@sandisk.com>, Tomas Winkler <tomas.winkler@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 13 May 2017 14:40:08 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/mmc/core/sd.c | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index d109634fbfce..1d7542daecbe 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -294,12 +294,8 @@ static int mmc_read_switch(struct mmc_card *card)
 	err = -EIO;
 
 	status = kmalloc(64, GFP_KERNEL);
-	if (!status) {
-		pr_err("%s: could not allocate a buffer for "
-			"switch capabilities.\n",
-			mmc_hostname(card->host));
+	if (!status)
 		return -ENOMEM;
-	}
 
 	/*
 	 * Find out the card's support bits with a mode 0 operation.
@@ -359,11 +355,8 @@ int mmc_sd_switch_hs(struct mmc_card *card)
 		return 0;
 
 	status = kmalloc(64, GFP_KERNEL);
-	if (!status) {
-		pr_err("%s: could not allocate a buffer for "
-			"switch capabilities.\n", mmc_hostname(card->host));
+	if (!status)
 		return -ENOMEM;
-	}
 
 	err = mmc_sd_switch(card, 1, 0, 1, status);
 	if (err)
@@ -596,11 +589,8 @@ static int mmc_sd_init_uhs_card(struct mmc_card *card)
 		return 0;
 
 	status = kmalloc(64, GFP_KERNEL);
-	if (!status) {
-		pr_err("%s: could not allocate a buffer for "
-			"switch capabilities.\n", mmc_hostname(card->host));
+	if (!status)
 		return -ENOMEM;
-	}
 
 	/* Set 4-bit bus width */
 	if ((card->host->caps & MMC_CAP_4_BIT_DATA) &&
-- 
2.12.3
