From: <gregkh@suse.de>
Subject: patch s3cmci-s3cmci_card_present-use-no_detect-to-decide-whether-there-is-a-card-detect-pin.patch added to 2.6.33-stable tree
Date: Thu, 11 Mar 2010 16:45:29 -0800
Message-ID: <12683547291671@site>
Mime-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:50750 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753002Ab0CLCtr (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 11 Mar 2010 21:49:47 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: lars@metafoo.de, akpm@linux-foundation.org, ben-linux@fluff.org, gregkh@suse.de, linux-mmc@vger.kernel.org, torvalds@linux-foundation.org
Cc: stable@kernel.org, stable-commits@vger.kernel.org


This is a note to let you know that we have just queued up the patch titled

    Subject: s3cmci: s3cmci_card_present: Use no_detect to decide whether there is a card detect pin

to the 2.6.33-stable tree.  Its filename is

    s3cmci-s3cmci_card_present-use-no_detect-to-decide-whether-there-is-a-card-detect-pin.patch

A git repo of this tree can be found at 
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary


>From dc2ed552804f3a2ae41c0ffe4bc09879ec8f7396 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Fri, 5 Mar 2010 13:43:37 -0800
Subject: s3cmci: s3cmci_card_present: Use no_detect to decide whether there is a card detect pin

From: Lars-Peter Clausen <lars@metafoo.de>

commit dc2ed552804f3a2ae41c0ffe4bc09879ec8f7396 upstream.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: <linux-mmc@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/mmc/host/s3cmci.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/mmc/host/s3cmci.c
+++ b/drivers/mmc/host/s3cmci.c
@@ -1179,7 +1179,7 @@ static int s3cmci_card_present(struct mm
 	struct s3c24xx_mci_pdata *pdata = host->pdata;
 	int ret;
 
-	if (pdata->gpio_detect == 0)
+	if (pdata->no_detect)
 		return -ENOSYS;
 
 	ret = gpio_get_value(pdata->gpio_detect) ? 0 : 1;


Patches currently in stable-queue which might be from lars@metafoo.de are

