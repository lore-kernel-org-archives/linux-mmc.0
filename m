From: Per Forlin <per.forlin@stericsson.com>
Subject: [PATCH] mmc: mmc_test: align max_seg_size
Date: Mon, 14 Nov 2011 12:04:24 +0100
Message-ID: <1321268664-22006-1-git-send-email-per.forlin@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133]:38847 "EHLO
	eu1sys200aog112.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754038Ab1KNLEr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Nov 2011 06:04:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, ulf.hansson@stericsson.com, Linus Walleij <linus.walleij@linaro.org>
Cc: Chris Ball <cjb@laptop.org>, Per Forlin <per.forlin@stericsson.com>

If max_seg_size is unaligned, mmc_test_map_sg() may create sg element
sizes that are not aligned with 512 byte. Fix, align max_seg_size at
mmc_test_area_init().

Signed-off-by: Per Forlin <per.forlin@stericsson.com>
---
 drivers/mmc/card/mmc_test.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index b038c4a..5848998 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -1581,6 +1581,7 @@ static int mmc_test_area_init(struct mmc_test_card *test, int erase, int fill)
 
 	t->max_segs = test->card->host->max_segs;
 	t->max_seg_sz = test->card->host->max_seg_size;
+	t->max_seg_sz -= t->max_seg_sz % 512;
 
 	t->max_tfr = t->max_sz;
 	if (t->max_tfr >> 9 > test->card->host->max_blk_count)
-- 
1.6.3.3

