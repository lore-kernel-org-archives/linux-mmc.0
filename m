From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 2/2] mmc_test: fix display of .5 KiB
Date: Thu, 23 Sep 2010 14:51:36 +0300
Message-ID: <20100923115136.18000.69228.sendpatchset@ahunter-work.research.nokia.com>
References: <20100923115122.18000.46750.sendpatchset@ahunter-work.research.nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:46532 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754652Ab0IWLvu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Sep 2010 07:51:50 -0400
In-Reply-To: <20100923115122.18000.46750.sendpatchset@ahunter-work.research.nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc Mailing List <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@nokia.com>

>From 676448f4d2623103cc5a4d246afe9ce32b7f339d Mon Sep 17 00:00:00 2001
From: Adrian Hunter <adrian.hunter@nokia.com>
Date: Thu, 23 Sep 2010 13:08:21 +0300
Subject: [PATCH 2/2] mmc_test: fix display of .5 KiB

Append .5 to KiB display when there are an odd number of
sectors.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/card/mmc_test.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 5874040..c38a3a8 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -539,7 +539,7 @@ static void mmc_test_print_rate(struct mmc_test_card *test, uint64_t bytes,
 	printk(KERN_INFO "%s: Transfer of %u sectors (%u%s KiB) took %lu.%09lu "
 			 "seconds (%u kB/s, %u KiB/s)\n",
 			 mmc_hostname(test->card->host), sectors, sectors >> 1,
-			 (sectors == 1 ? ".5" : ""), (unsigned long)ts.tv_sec,
+			 (sectors & 1 ? ".5" : ""), (unsigned long)ts.tv_sec,
 			 (unsigned long)ts.tv_nsec, rate / 1000, rate / 1024);
 
 	mmc_test_save_transfer_result(test, 1, sectors, ts, rate);
@@ -563,7 +563,7 @@ static void mmc_test_print_avg_rate(struct mmc_test_card *test, uint64_t bytes,
 	printk(KERN_INFO "%s: Transfer of %u x %u sectors (%u x %u%s KiB) took "
 			 "%lu.%09lu seconds (%u kB/s, %u KiB/s)\n",
 			 mmc_hostname(test->card->host), count, sectors, count,
-			 sectors >> 1, (sectors == 1 ? ".5" : ""),
+			 sectors >> 1, (sectors & 1 ? ".5" : ""),
 			 (unsigned long)ts.tv_sec, (unsigned long)ts.tv_nsec,
 			 rate / 1000, rate / 1024);
 
-- 
1.7.0.4

