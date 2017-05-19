From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH v2] mmc: core: Delete an error message for a failed memory
 allocation in four functions
Date: Fri, 19 May 2017 13:34:44 +0200
Message-ID: <0ce8f8ac-d340-3f15-a698-ddfa449508e1@users.sourceforge.net>
References: <b0978766-199a-942e-43d8-58d2a8a17e1a@users.sourceforge.net>
 <CAPDyKFqhNQdfr19195YfL7f4Jh0u6pGZ9QtSff0C6fe6R9wdjw@mail.gmail.com>
 <50f3c642-b866-27f3-1201-5490225116f4@users.sourceforge.net>
 <CAPDyKFraTYQWAqSNdZG_bRpbDiLFw4nigVzC1nkmrfnr2aw2og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.web.de ([212.227.15.4]:53737 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750793AbdESLfF (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 19 May 2017 07:35:05 -0400
In-Reply-To: <CAPDyKFraTYQWAqSNdZG_bRpbDiLFw4nigVzC1nkmrfnr2aw2og@mail.gmail.com>
Content-Language: en-GB
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Bojan Prtvar <prtvar.b@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Paul Burton <paul.burton@imgtec.com>, Shawn Lin <shawn.lin@rock-chips.com>, Tomas Winkler <tomas.winkler@intel.com>, Uri Yanai <uri.yanai@sandisk.com>, Wolfram Sang <wsa@the-dreams.de>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Fri, 19 May 2017 13:15:27 +0200

Omit an extra message for a memory allocation failure in these functions.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
This refactoring superseded the update suggestion "mmc: core: Delete
an error message for a failed memory allocation in three functions"
from 2017-05-13 because another adjustment was requested by Ulf Hansson.
https://patchwork.kernel.org/patch/9725233/
https://lkml.org/lkml/2017/5/19/308

 drivers/mmc/core/mmc_test.c |  2 --
 drivers/mmc/core/sd.c       | 16 +++-------------
 2 files changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/core/mmc_test.c b/drivers/mmc/core/mmc_test.c
index fd1b4b8510b9..7a304a6e5bf1 100644
--- a/drivers/mmc/core/mmc_test.c
+++ b/drivers/mmc/core/mmc_test.c
@@ -3220,8 +3220,6 @@ static int __mmc_test_register_dbgfs_file(struct mmc_card *card,
 	df = kmalloc(sizeof(*df), GFP_KERNEL);
 	if (!df) {
 		debugfs_remove(file);
-		dev_err(&card->dev,
-			"Can't allocate memory for internal usage.\n");
 		return -ENOMEM;
 	}
 
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
2.13.0

