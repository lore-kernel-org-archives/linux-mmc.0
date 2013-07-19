From: Jingoo Han <jg1.han@samsung.com>
Subject: [PATCH] mmc: mmc_test: replace strict_strtol() with kstrtol_from_user()
Date: Fri, 19 Jul 2013 16:02:43 +0900
Message-ID: <000c01ce844d$f75ba650$e612f2f0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:29439 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759747Ab3GSHCp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 19 Jul 2013 03:02:45 -0400
Received: from epcpsbgr3.samsung.com
 (u143.gpu120.samsung.co.kr [203.254.230.143])
 by mailout1.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTP id <0MQ6002KG8UZV0U0@mailout1.samsung.com> for
 linux-mmc@vger.kernel.org; Fri, 19 Jul 2013 16:02:44 +0900 (KST)
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>

The usage of strict_strtol() is not preferred, because
strict_strtol() is obsolete. Thus, kstrtol() should be
used.

Also, both kstrtol() and copy_from_user() can be replaced
with kstrtol_from_user() to make the code simpler.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/mmc/card/mmc_test.c |   14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index a69df52..0c0fc52 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2849,18 +2849,12 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 	struct seq_file *sf = (struct seq_file *)file->private_data;
 	struct mmc_card *card = (struct mmc_card *)sf->private;
 	struct mmc_test_card *test;
-	char lbuf[12];
 	long testcase;
+	int ret;
 
-	if (count >= sizeof(lbuf))
-		return -EINVAL;
-
-	if (copy_from_user(lbuf, buf, count))
-		return -EFAULT;
-	lbuf[count] = '\0';
-
-	if (strict_strtol(lbuf, 10, &testcase))
-		return -EINVAL;
+	ret = kstrtol_from_user(buf, count, 10, &testcase);
+	if (ret)
+		return ret;
 
 	test = kzalloc(sizeof(struct mmc_test_card), GFP_KERNEL);
 	if (!test)
-- 
1.7.10.4


