From: Alexander Holler <holler@ahsoftware.de>
Subject: [PATCH] mmc: print message if a card supports secure erase/trim
Date: Tue, 27 Jan 2015 12:48:24 +0100
Message-ID: <1422359304-30321-1-git-send-email-holler@ahsoftware.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Holler <holler@ahsoftware.de>
List-Id: linux-mmc@vger.kernel.org

It's an interesting detail, so inform the user about it.

Signed-off-by: Alexander Holler <holler@ahsoftware.de>
---
 drivers/mmc/core/bus.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
index 8a1f124..4a60028 100644
--- a/drivers/mmc/core/bus.c
+++ b/drivers/mmc/core/bus.c
@@ -347,6 +347,10 @@ int mmc_add_card(struct mmc_card *card)
 			uhs_bus_speed_mode, type, card->rca);
 	}
 
+	if (mmc_can_secure_erase_trim(card))
+		pr_info("%s: card supports secure erase/trim\n",
+			mmc_hostname(card->host));
+
 #ifdef CONFIG_DEBUG_FS
 	mmc_add_card_debugfs(card);
 #endif
-- 
2.1.0
