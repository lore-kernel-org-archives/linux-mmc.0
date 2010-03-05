From: akpm@linux-foundation.org
Subject: [patch 108/160] mmc: at91_mci: fix pointer errors
Date: Fri, 05 Mar 2010 13:43:38 -0800
Message-ID: <201003052143.o25LhcqI029816@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:41418 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754374Ab0CEVn6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:58 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, wolfgang.mues@auerswald.de, avictor.za@gmail.com, linux-mmc@vger.kernel.org, nicolas.ferre@atmel.com

From: Wolfgang Muees <wolfgang.mues@auerswald.de>

Fixes two pointer errors, one which leads to memory overwrites if used
with large chunks of data.

Signed-off-by: Wolfgang Muees <wolfgang.mues@auerswald.de>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Victor <avictor.za@gmail.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/at91_mci.c |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff -puN drivers/mmc/host/at91_mci.c~mmc-at91_mci-fix-pointer-errors drivers/mmc/host/at91_mci.c
--- a/drivers/mmc/host/at91_mci.c~mmc-at91_mci-fix-pointer-errors
+++ a/drivers/mmc/host/at91_mci.c
@@ -227,11 +227,13 @@ static inline void at91_mci_sg_to_dma(st
 			for (index = 0; index < (amount / 4); index++)
 				*dmabuf++ = swab32(sgbuffer[index]);
 		} else {
-			memcpy(dmabuf, sgbuffer, amount);
-			dmabuf += amount;
+			char *tmpv = (char *)dmabuf;
+			memcpy(tmpv, sgbuffer, amount);
+			tmpv += amount;
+			dmabuf = (unsigned *)tmpv;
 		}
 
-		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
+		kunmap_atomic(((void *)sgbuffer) - sg->offset, KM_BIO_SRC_IRQ);
 
 		if (size == 0)
 			break;
_
