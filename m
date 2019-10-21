From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 6/7] mmc: dw_mmc: Fix debugfs on 64-bit platforms
Date: Mon, 21 Oct 2019 16:37:41 +0200
Message-ID: <20191021143742.14487-7-geert+renesas@glider.be>
References: <20191021143742.14487-1-geert+renesas@glider.be>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20191021143742.14487-1-geert+renesas@glider.be>
Sender: netdev-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

"dw_mci.pending_events" and "dw_mci.completed_events" are "unsigned
long", i.e. 32-bit or 64-bit, depending on the platform.  Hence casting
their addresses to "u32 *", and calling debugfs_create_x32() breaks
operation on 64-bit platforms.

Fix this by using the new debugfs_create_xul() helper instead.

Fixes: f95f3850f7a9e1d4 ("mmc: dw_mmc: Add Synopsys DesignWare mmc host driver.")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/dw_mmc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index bf0048ebbda356a7..b4c4a9cd6365f122 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -177,10 +177,10 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 	debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
 	debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
 	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
-	debugfs_create_x32("pending_events", S_IRUSR, root,
-			   (u32 *)&host->pending_events);
-	debugfs_create_x32("completed_events", S_IRUSR, root,
-			   (u32 *)&host->completed_events);
+	debugfs_create_xul("pending_events", S_IRUSR, root,
+			   &host->pending_events);
+	debugfs_create_xul("completed_events", S_IRUSR, root,
+			   &host->completed_events);
 }
 #endif /* defined(CONFIG_DEBUG_FS) */
 
-- 
2.17.1
