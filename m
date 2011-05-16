From: Chris Ball <cjb@laptop.org>
Subject: [PATCH 5/6] mmc: vub300: MODULE_* cleanup
Date: Sun, 15 May 2011 20:21:47 -0400
Message-ID: <1305505308-8767-5-git-send-email-cjb@laptop.org>
References: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pullcord.laptop.org ([18.85.46.20]:37132 "EHLO
	pullcord.laptop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751603Ab1EPATz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 May 2011 20:19:55 -0400
In-Reply-To: <1305505308-8767-1-git-send-email-cjb@laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Tony Olech <tony.olech@elandigitalsystems.com>
Cc: Chris Ball <cjb@laptop.org>

Move the MODULE_* fields down to their usual space at the bottom of the
source file, and remove a duplicated MODULE_LICENSE().

Signed-off-by: Chris Ball <cjb@laptop.org>
---
 drivers/mmc/host/vub300.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/vub300.c b/drivers/mmc/host/vub300.c
index 0463921..656d528 100644
--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -220,10 +220,6 @@ enum SD_RESPONSE_TYPE {
 #define SD_ERROR_OVERRUN			0x1B
 #define SD_ERROR_PIO_TIMEOUT			0x1C
 
-MODULE_AUTHOR("Tony Olech <tony.olech@elandigitalsystems.com>");
-MODULE_DESCRIPTION("VUB300 USB to SD/MMC/SDIO adapter driver");
-MODULE_LICENSE("GPL");
-
 #define FUN(c) (0x000007 & (c->arg>>28))
 #define REG(c) (0x01FFFF & (c->arg>>9))
 
@@ -2514,4 +2510,7 @@ static void __exit vub300_exit(void)
 
 module_init(vub300_init);
 module_exit(vub300_exit);
+
+MODULE_AUTHOR("Tony Olech <tony.olech@elandigitalsystems.com>");
+MODULE_DESCRIPTION("VUB300 USB to SD/MMC/SDIO adapter driver");
 MODULE_LICENSE("GPL");
-- 
1.7.0.1

