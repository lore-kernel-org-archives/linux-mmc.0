From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 7/7] mmc: dw_mmc: Remove superfluous cast in debugfs_create_u32() call
Date: Mon, 21 Oct 2019 16:37:42 +0200
Message-ID: <20191021143742.14487-8-geert+renesas@glider.be>
References: <20191021143742.14487-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021143742.14487-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

"dw_mci.state" is an enum, which is compatible with u32, so there is no
need to cast its address, preventing further compiler checks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/dw_mmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index b4c4a9cd6365f122..fc9d4d000f97e434 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -176,7 +176,7 @@ static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
 
 	debugfs_create_file("regs", S_IRUSR, root, host, &dw_mci_regs_fops);
 	debugfs_create_file("req", S_IRUSR, root, slot, &dw_mci_req_fops);
-	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
+	debugfs_create_u32("state", S_IRUSR, root, &host->state);
 	debugfs_create_xul("pending_events", S_IRUSR, root,
 			   &host->pending_events);
 	debugfs_create_xul("completed_events", S_IRUSR, root,
-- 
2.17.1
