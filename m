From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Subject: [PATCHv5 1/3] mmc_test: use API to check card type
Date: Mon,  6 Sep 2010 11:12:17 +0300
Message-ID: <3fa57fe7152b608279ec56dcfe969a42b672a197.1283760476.git.ext-andriy.shevchenko@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.1.47]:49873 "EHLO mgw-sa01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752737Ab0IFIwW (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 6 Sep 2010 04:52:22 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Hunter Adrian <adrian.hunter@nokia.com>, Chris Ball <cjb@laptop.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

There are methods to check card type. Let's use them instead of direct checking
type bits.

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/mmc/card/mmc_test.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index b992725..cd8edf4 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -1977,7 +1977,7 @@ static int mmc_test_probe(struct mmc_card *card)
 {
 	int ret;
 
-	if ((card->type != MMC_TYPE_MMC) && (card->type != MMC_TYPE_SD))
+	if (!mmc_card_mmc(card) && !mmc_card_sd(card))
 		return -ENODEV;
 
 	ret = device_create_file(&card->dev, &dev_attr_test);
-- 
1.6.3.3

