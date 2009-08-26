From: Ohad Ben-Cohen <ohad@bencohen.org>
Subject: [PATCH 1/2] mmc: add card quirks support
Date: Wed, 26 Aug 2009 04:09:41 +0300
Message-ID: <1251248981.31954.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ew0-f206.google.com ([209.85.219.206]:53743 "EHLO
	mail-ew0-f206.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932477AbZHZBDf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2009 21:03:35 -0400
Received: by ewy2 with SMTP id 2so980722ewy.17
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2009 18:03:36 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mmc@vger.kernel.org

From: Ohad Ben-Cohen <ohad@wizery.com>

A card quirks field is added to support non-standard
devices (e.g. embedded sdio devices).

Signed-off-by: Ohad Ben-Cohen <ohad@wizery.com>
---
 include/linux/mmc/card.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 403aa50..eac86fe 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -94,6 +94,7 @@ struct mmc_card {
 #define MMC_STATE_READONLY	(1<<1)		/* card is read-only */
 #define MMC_STATE_HIGHSPEED	(1<<2)		/* card is in high speed mode */
 #define MMC_STATE_BLOCKADDR	(1<<3)		/* card uses block-addressing */
+	unsigned int		quirks; 	/* card quirks */
 
 	u32			raw_cid[4];	/* raw card CID */
 	u32			raw_csd[4];	/* raw card CSD */
-- 
1.5.4.3



