From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH] mmc: core: Typo fix
Date: Thu, 14 Nov 2013 12:31:47 +0400
Message-ID: <1384417907-5911-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fallback5.mail.ru ([94.100.176.59]:50197 "EHLO
	fallback5.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752734Ab3KNIdW (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 14 Nov 2013 03:33:22 -0500
Received: from smtp11.mail.ru (smtp11.mail.ru [94.100.176.85])
	by fallback5.mail.ru (mPOP.Fallback_MX) with ESMTP id B90C01007E90A
	for <linux-mmc@vger.kernel.org>; Thu, 14 Nov 2013 12:32:18 +0400 (MSK)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Alexander Shiyan <shc_work@mail.ru>


Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 drivers/mmc/core/host.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index 49bc403..114f6bd 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -337,7 +337,7 @@ int mmc_of_parse(struct mmc_host *host)
 		break;
 	default:
 		dev_err(host->parent,
-			"Invalid \"bus-width\" value %ud!\n", bus_width);
+			"Invalid \"bus-width\" value %u!\n", bus_width);
 		return -EINVAL;
 	}
 
-- 
1.8.1.5

