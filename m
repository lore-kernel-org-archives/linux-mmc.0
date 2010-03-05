From: akpm@linux-foundation.org
Subject: [patch 115/160] mmc: at91_mci: correct kunmap_atomic()
Date: Fri, 05 Mar 2010 13:43:45 -0800
Message-ID: <201003052143.o25Lhjil029861@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:36005 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755631Ab0CEVny (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 5 Mar 2010 16:43:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, nicolas.ferre@atmel.com, avictor.za@gmail.com, linux-mmc@vger.kernel.org, wolfgang.mues@auerswald.de

From: Nicolas Ferre <nicolas.ferre@atmel.com>

kunmap_atomic() accepts a pointer to any location in the page so we do not
need the subtraction and cast.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Wolfgang Muees <wolfgang.mues@auerswald.de>
Cc: Andrew Victor <avictor.za@gmail.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/mmc/host/at91_mci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff -puN drivers/mmc/host/at91_mci.c~mmc-at91_mci-correct-kunmap_atomic drivers/mmc/host/at91_mci.c
--- a/drivers/mmc/host/at91_mci.c~mmc-at91_mci-correct-kunmap_atomic
+++ a/drivers/mmc/host/at91_mci.c
@@ -248,7 +248,7 @@ static inline void at91_mci_sg_to_dma(st
 			dmabuf = (unsigned *)tmpv;
 		}
 
-		kunmap_atomic(((void *)sgbuffer) - sg->offset, KM_BIO_SRC_IRQ);
+		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
 
 		if (size == 0)
 			break;
@@ -313,7 +313,7 @@ static void at91_mci_post_dma_read(struc
 			dmabuf = (unsigned *)tmpv;
 		}
 
-		kunmap_atomic(((void *)sgbuffer)-sg->offset, KM_BIO_SRC_IRQ);
+		kunmap_atomic(sgbuffer, KM_BIO_SRC_IRQ);
 		dmac_flush_range((void *)sgbuffer, ((void *)sgbuffer) + amount);
 		data->bytes_xfered += amount;
 		if (size == 0)
_
