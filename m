From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 3/3] mmc: card.h: Use NULL instead of zero
Date: Fri,  4 Oct 2013 22:59:25 -0300
Message-ID: <1380938365-7769-3-git-send-email-festevam@gmail.com>
References: <1380938365-7769-1-git-send-email-festevam@gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yh0-f48.google.com ([209.85.213.48]:38559 "EHLO
	mail-yh0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751196Ab3JECGQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Oct 2013 22:06:16 -0400
Received: by mail-yh0-f48.google.com with SMTP id f11so1183962yha.21
        for <linux-mmc@vger.kernel.org>; Fri, 04 Oct 2013 19:06:15 -0700 (PDT)
In-Reply-To: <1380938365-7769-1-git-send-email-festevam@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: cjb@laptop.org
Cc: linux-mmc@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

Fix the following sparse warnings:

drivers/mmc/card/block.c:2371:9: warning: Using plain integer as NULL pointer
drivers/mmc/core/quirks.c:61:9: warning: Using plain integer as NULL pointer

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 include/linux/mmc/card.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index f42cdbd..5a30d23 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -350,7 +350,7 @@ struct mmc_fixup {
 #define CID_OEMID_ANY ((unsigned short) -1)
 #define CID_NAME_ANY (NULL)
 
-#define END_FIXUP { 0 }
+#define END_FIXUP { NULL }
 
 #define _FIXUP_EXT(_name, _manfid, _oemid, _rev_start, _rev_end,	\
 		   _cis_vendor, _cis_device,				\
-- 
1.8.1.2

