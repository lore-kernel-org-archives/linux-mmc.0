From: Alexander Shiyan <shc_work@mail.ru>
Subject: [PATCH RESEND] mmc: core: trivial: Typo fix
Date: Sat, 15 Feb 2014 15:40:58 +0400
Message-ID: <1392464458-5701-1-git-send-email-shc_work@mail.ru>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from fallback2.mail.ru ([94.100.176.87]:35234 "EHLO
	fallback2.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbaBOLl3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 15 Feb 2014 06:41:29 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Chris Ball <chris@printf.net>, Jiri Kosina <trivial@kernel.org>, Alexander Shiyan <shc_work@mail.ru>

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
1.8.3.2

