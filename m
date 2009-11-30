From: don.mullis@gmail.com
Subject: [PATCH 2.6.32-rc8 2/3] mmc: Clean up mmc_decode_scr() implementation
Date: Sun, 29 Nov 2009 19:38:36 -0800
Message-ID: <87zl64r8ar.fsf@gmail.com>
Reply-To: <873a3wsncj.fsf@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pw0-f42.google.com ([209.85.160.42]:36603 "EHLO
	mail-pw0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752687AbZK3Did (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 29 Nov 2009 22:38:33 -0500
Received: by pwi3 with SMTP id 3so1917040pwi.21
        for <linux-mmc@vger.kernel.org>; Sun, 29 Nov 2009 19:38:39 -0800 (PST)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: don.mullis@gmail.com

In mmc_decode_scr(), back out coercion of 128-bit-oriented
UNSTUFF_BITS() macro to work on 64-bit raw_scr field; invoke
UNSTUFF_BITS_ARRAY() instead.

Tested by verifying that /sys output for scr register is unchanged.

Signed-off-by: don.mullis@gmail.com
---
 drivers/mmc/core/sd.c |   10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/mmc/core/sd.c
===================================================================
--- linux-2.6.orig/drivers/mmc/core/sd.c	2009-09-29 12:50:36.000000000 -0700
+++ linux-2.6/drivers/mmc/core/sd.c	2009-11-01 22:30:37.000000000 -0800
@@ -163,20 +163,16 @@ static int mmc_decode_scr(struct mmc_car
 {
 	struct sd_scr *scr = &card->scr;
 	unsigned int scr_struct;
-	u32 resp[4];
 
-	resp[3] = card->raw_scr[1];
-	resp[2] = card->raw_scr[0];
-
-	scr_struct = UNSTUFF_BITS(resp, 60, 4);
+	scr_struct = UNSTUFF_BITS_ARRAY(card->raw_scr, 60, 4);
 	if (scr_struct != 0) {
 		printk(KERN_ERR "%s: unrecognised SCR structure version %d\n",
 			mmc_hostname(card->host), scr_struct);
 		return -EINVAL;
 	}
 
-	scr->sda_vsn = UNSTUFF_BITS(resp, 56, 4);
-	scr->bus_widths = UNSTUFF_BITS(resp, 48, 4);
+	scr->sda_vsn =    UNSTUFF_BITS_ARRAY(card->raw_scr, 56, 4);
+	scr->bus_widths = UNSTUFF_BITS_ARRAY(card->raw_scr, 48, 4);
 
 	return 0;
 }
