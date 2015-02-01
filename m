From: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
Subject: [PATCH 1/5] drivers: mmc: card: Fix replaces simple_strtoul func call with kstrtoul
Date: Mon,  2 Feb 2015 01:36:58 +0530
Message-ID: <1422821222-24079-2-git-send-email-sheetal.tigadoli@gmail.com>
References: <1422821222-24079-1-git-send-email-sheetal.tigadoli@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wi0-f176.google.com ([209.85.212.176]:65371 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753892AbbBAUJd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 1 Feb 2015 15:09:33 -0500
In-Reply-To: <1422821222-24079-1-git-send-email-sheetal.tigadoli@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: joe@perches.com, linux-mmc@vger.kernel.org, ben@decadent.org.uk, kuninori.morimoto.gx@renesas.com, ulf.hansson@linaro.org, linux-kernel@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@gmail.com>

This patch fixes following coding style warning in file block.c

        drivers/mmc/card/block.c:279: WARNING: simple_strtoul is obsolete, use kstrtoul instead

Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@gmail.com>
---
 drivers/mmc/card/block.c |    9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/card/block.c b/drivers/mmc/card/block.c
index c69afb5..80f7b4b 100644
--- a/drivers/mmc/card/block.c
+++ b/drivers/mmc/card/block.c
@@ -274,13 +274,12 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 			      const char *buf, size_t count)
 {
 	int ret;
-	char *end;
 	struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
-	unsigned long set = simple_strtoul(buf, &end, 0);
-	if (end == buf) {
-		ret = -EINVAL;
+	unsigned long set;
+
+	ret = kstrtoul(buf, 0, &set);
+	if ((ret == -EINVAL) || (ret == -ERANGE))
 		goto out;
-	}
 
 	set_disk_ro(dev_to_disk(dev), set || md->read_only);
 	ret = count;
-- 
1.7.9.5

