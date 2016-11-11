From: Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] mmc: sd: Meet alignment requirements for raw_ssr DMA
Date: Fri, 11 Nov 2016 14:22:36 +0000
Message-ID: <20161111142236.8270-1-paul.burton@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailapp01.imgtec.com ([195.59.15.196]:40862 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751821AbcKKOW7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 11 Nov 2016 09:22:59 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Paul Burton <paul.burton@imgtec.com>, Ulf Hansson <ulf.hansson@linaro.org>

The mmc_read_ssr() function results in DMA to the raw_ssr member of
struct mmc_card, which is not guaranteed to be cache line aligned & thus
might not meet the requirements set out in Documentation/DMA-API.txt:

  Warnings:  Memory coherency operates at a granularity called the cache
  line width.  In order for memory mapped by this API to operate
  correctly, the mapped region must begin exactly on a cache line
  boundary and end exactly on one (to prevent two separately mapped
  regions from sharing a single cache line).  Since the cache line size
  may not be known at compile time, the API will not enforce this
  requirement.  Therefore, it is recommended that driver writers who
  don't take special care to determine the cache line size at run time
  only map virtual regions that begin and end on page boundaries (which
  are guaranteed also to be cache line boundaries).

On some systems where DMA is non-coherent this can lead to us losing
data that shares cache lines with the raw_ssr array.

Fix this by kmalloc'ing a temporary buffer to perform DMA into. kmalloc
will ensure the buffer is suitably aligned, allowing the DMA to be
performed without any loss of data.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org
---
 drivers/mmc/core/sd.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 73c762a..f6f40a1 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -223,6 +223,7 @@ static int mmc_decode_scr(struct mmc_card *card)
 static int mmc_read_ssr(struct mmc_card *card)
 {
 	unsigned int au, es, et, eo;
+	u32 *raw_ssr;
 	int i;
 
 	if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
@@ -231,14 +232,21 @@ static int mmc_read_ssr(struct mmc_card *card)
 		return 0;
 	}
 
-	if (mmc_app_sd_status(card, card->raw_ssr)) {
+	raw_ssr = kmalloc(sizeof(card->raw_ssr), GFP_KERNEL);
+	if (!raw_ssr)
+		return -ENOMEM;
+
+	if (mmc_app_sd_status(card, raw_ssr)) {
 		pr_warn("%s: problem reading SD Status register\n",
 			mmc_hostname(card->host));
+		kfree(raw_ssr);
 		return 0;
 	}
 
 	for (i = 0; i < 16; i++)
-		card->raw_ssr[i] = be32_to_cpu(card->raw_ssr[i]);
+		card->raw_ssr[i] = be32_to_cpu(raw_ssr[i]);
+
+	kfree(raw_ssr);
 
 	/*
 	 * UNSTUFF_BITS only works with four u32s so we have to offset the
-- 
2.10.2

