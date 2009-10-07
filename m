From: akpm@linux-foundation.org
Subject: [patch 15/16] mmc: sdio: don't require CISTPL_VERS_1 to contain 4 strings
Date: Wed, 07 Oct 2009 16:32:33 -0700
Message-ID: <200910072332.n97NWYT7029982@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:46659 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755433AbZJGXnA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Oct 2009 19:43:00 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: torvalds@linux-foundation.org
Cc: akpm@linux-foundation.org, david.vrabel@csr.com, bzhao@marvell.com, jic23@cam.ac.uk, linux-mmc@vger.kernel.org, roel.kluin@gmail.com

From: David Vrabel <david.vrabel@csr.com>

The PC Card 8.0 specification (vol.  4, section 3.2.10) says the
TPLLV1_INFO field of the CISTPL_VERS_1 tuple must contain 4 strings.  Some
cards don't have all 4 so just parse as many as we can.

[akpm@linux-foundation.org: coding-style fixes]
Signed-off-by: David Vrabel <david.vrabel@csr.com>
Tested-by: Jonathan Cameron <jic23@cam.ac.uk>
Tested-by: Bing Zhao <bzhao@marvell.com>
Cc: Roel Kluin <roel.kluin@gmail.com>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---


diff -puN drivers/mmc/core/sdio_cis.c~mmc-sdio-dont-require-cistpl_vers_1-to-contain-4-strings drivers/mmc/core/sdio_cis.c
--- a/drivers/mmc/core/sdio_cis.c~mmc-sdio-dont-require-cistpl_vers_1-to-contain-4-strings
+++ a/drivers/mmc/core/sdio_cis.c
@@ -29,6 +29,8 @@ static int cistpl_vers_1(struct mmc_card
 	unsigned i, nr_strings;
 	char **buffer, *string;
 
+	/* Find all null-terminated (including zero length) strings in
+	   the TPLLV1_INFO field. Trailing garbage is ignored. */
 	buf += 2;
 	size -= 2;
 
@@ -39,11 +41,8 @@ static int cistpl_vers_1(struct mmc_card
 		if (buf[i] == 0)
 			nr_strings++;
 	}
-
-	if (nr_strings < 4) {
-		printk(KERN_WARNING "SDIO: ignoring broken CISTPL_VERS_1\n");
+	if (nr_strings == 0)
 		return 0;
-	}
 
 	size = i;
 
_
