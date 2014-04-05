From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] mmc: card.h: Use NULL instead of 0 for END_FIXUP
Date: Fri,  4 Apr 2014 22:42:48 -0300
Message-ID: <1396662168-6501-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:42708 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753615AbaDEBnr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Apr 2014 21:43:47 -0400
Received: by mail-yh0-f47.google.com with SMTP id 29so3850379yhl.6
        for <linux-mmc@vger.kernel.org>; Fri, 04 Apr 2014 18:43:46 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: chris@printf.net
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following sparse warnings:

drivers/mmc/card/block.c:2421:9: warning: Using plain integer as NULL pointer

drivers/mmc/core/quirks.c:69:9: warning: Using plain integer as NULL pointer

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 include/linux/mmc/card.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index b730272..aa7e57f 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -353,7 +353,7 @@ struct mmc_fixup {
 #define CID_OEMID_ANY ((unsigned short) -1)
 #define CID_NAME_ANY (NULL)
 
-#define END_FIXUP { 0 }
+#define END_FIXUP { NULL }
 
 #define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	\
 		   _cis_vendor, _cis_device,				\
-- 
1.8.3.2

