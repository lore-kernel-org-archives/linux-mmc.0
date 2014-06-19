From: Chris Ball <chris@printf.net>
Subject: [PATCH] mmc: test: Fix potential __free_pages(NULL) in mmc_test
Date: Thu, 19 Jun 2014 19:55:08 +0100
Message-ID: <86d2e4n303.fsf@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:38525 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754891AbaFSSzL (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Jun 2014 14:55:11 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, rucsoftsec@gmail.com

alloc_pages() can return NULL, in which case we'll pass NULL to
__free_pages().

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=78391
Reported-by: RUC_SoftSec <rucsoftsec@gmail.com>
Cc: rucsoftsec@gmail.com
Signed-off-by: Chris Ball <chris@printf.net>
---
 drivers/mmc/card/mmc_test.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/card/mmc_test.c b/drivers/mmc/card/mmc_test.c
index 0c0fc52..c86da32 100644
--- a/drivers/mmc/card/mmc_test.c
+++ b/drivers/mmc/card/mmc_test.c
@@ -2884,7 +2884,8 @@ static ssize_t mtf_test_write(struct file *file, const char __user *buf,
 	}
 
 #ifdef CONFIG_HIGHMEM
-	__free_pages(test->highmem, BUFFER_ORDER);
+	if (test->highmem)
+            __free_pages(test->highmem, BUFFER_ORDER);
 #endif
 	kfree(test->buffer);
 	kfree(test);
-- 
Chris Ball   <http://printf.net/>
