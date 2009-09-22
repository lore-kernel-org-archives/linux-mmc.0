From: akpm@linux-foundation.org
Subject: [patch 077/232] sdio: fix read buffer overflow
Date: Tue, 22 Sep 2009 16:45:09 -0700
Message-ID: <200909222345.n8MNj9kq013725@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37141 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753480AbZIVXpm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Sep 2009 19:45:42 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, roel.kluin@gmail.com, david.vrabel@csr.com, linux-mmc@vger.kernel.org

From: Roel Kluin <roel.kluin@gmail.com>

Avoid buffer underrun when parsing an invalid CISTPL_VERS_1.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
Cc: David Vrabel <david.vrabel@csr.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/core/sdio_cis.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/mmc/core/sdio_cis.c~sdio-fix-read-buffer-overflow drivers/mmc/core/sdio_cis.c
--- a/drivers/mmc/core/sdio_cis.c~sdio-fix-read-buffer-overflow
+++ a/drivers/mmc/core/sdio_cis.c
@@ -40,7 +40,7 @@ static int cistpl_vers_1(struct mmc_card
 			nr_strings++;
 	}
 
-	if (buf[i-1] != '\0') {
+	if (nr_strings < 4) {
 		printk(KERN_WARNING "SDIO: ignoring broken CISTPL_VERS_1\n");
 		return 0;
 	}
_
