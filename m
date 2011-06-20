From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: [PATCH] mmc: dw_mmc: set the card_width bit per card.
Date: Mon, 20 Jun 2011 17:23:53 +0900
Message-ID: <1308558233-20545-1-git-send-email-tgih.jun@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: akpm@linux-foundation.org, cjb@laptop.org, kgene.kim@samsung.com, Seungwon Jeon <tgih.jun@samsung.com>
List-Id: linux-mmc@vger.kernel.org

This patch sets the card_width bit of CTYPE for the corresponding card.

CTYPE[31] and CTYPE[16] correspond respectively to card[15] and card[0]
for 8-bit mode. And CTYPE[15] and CTYPE[0] correspond respectively to
card[15] and CTYPE[0] for 1-bit or 4-bit mode.

Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
---
 drivers/mmc/host/dw_mmc.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 66dcddb..1ca830c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -574,7 +574,7 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot)
 	}
 
 	/* Set the current slot bus width */
-	mci_writel(host, CTYPE, slot->ctype);
+	mci_writel(host, CTYPE, (slot->ctype << slot->id));
 }
 
 static void dw_mci_start_request(struct dw_mci *host,
-- 
1.7.1
