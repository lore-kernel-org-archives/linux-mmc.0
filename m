From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH 2/3] mmc_test: change simple_strtol() to strict_strtol()
Date: Wed,  1 Sep 2010 09:26:46 +0300
Message-ID: <e144c2087fbdfd718b5caeac4eb7d0a7ce4896e0.1283276161.git.ext-andriy.shevchenko@nokia.com>
References: <cover.1283276161.git.ext-andriy.shevchenko@nokia.com>
 <756943b35144532a3c8de22c6dcfb179e5a7f69f.1283276161.git.ext-andriy.shevchenko@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ey0-f174.google.com ([209.85.215.174]:59492 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752051Ab0IAG00 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Sep 2010 02:26:26 -0400
In-Reply-To: <756943b35144532a3c8de22c6dcfb179e5a7f69f.1283276161.git.ext-andriy.shevchenko@nokia.com>
In-Reply-To: <cover.1283276161.git.ext-andriy.shevchenko@nokia.com>
References: <cover.1283276161.git.ext-andriy.shevchenko@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Adrian Hunter <adrian.hunter@nokia.com>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
---
 drivers/mmc/card/mmc_test.c |   12 +++++++-----
 1 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 359fae9..5423ac9 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -1836,9 +1836,10 @@ static const struct mmc_test_case mmc_test_cases[] = {
 
 static DEFINE_MUTEX(mmc_test_lock);
 
-static void mmc_test_run(struct mmc_test_card *test, int testcase)
+static void mmc_test_run(struct mmc_test_card *test, long testcase)
 {
-	int i, ret;
+	long i;
+	int ret;
 
 	printk(KERN_INFO "%s: Starting tests of card %s...\n",
 		mmc_hostname(test->card->host), mmc_card_id(test->card));
@@ -1849,7 +1850,7 @@ static void mmc_test_run(struct mmc_test_card *test, int testcase)
 		if (testcase && ((i + 1) != testcase))
 			continue;
 
-		printk(KERN_INFO "%s: Test case %d. %s...\n",
+		printk(KERN_INFO "%s: Test case %ld. %s...\n",
 			mmc_hostname(test->card->host), i + 1,
 			mmc_test_cases[i].name);
 
@@ -1920,9 +1921,10 @@ static ssize_t mmc_test_store(struct device *dev,
 {
 	struct mmc_card *card = mmc_dev_to_card(dev);
 	struct mmc_test_card *test;
-	int testcase;
+	long testcase;
 
-	testcase = simple_strtol(buf, NULL, 10);
+	if (strict_strtol(buf, 10, &testcase))
+		return -EINVAL;
 
 	test = kzalloc(sizeof(struct mmc_test_card), GFP_KERNEL);
 	if (!test)
-- 
1.6.3.3

