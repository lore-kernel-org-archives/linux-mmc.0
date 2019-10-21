From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 5/7] mmc: atmel-mci: Remove superfluous cast in debugfs_create_u32() call
Date: Mon, 21 Oct 2019 16:37:40 +0200
Message-ID: <20191021143742.14487-6-geert+renesas@glider.be>
References: <20191021143742.14487-1-geert+renesas@glider.be>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191021143742.14487-1-geert+renesas@glider.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-mmc@vger.kernel.org

"atmel_mci.state" is an enum, which is compatible with u32, so there is
no need to cast its address, preventing further compiler checks.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/mmc/host/atmel-mci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index ef2eb9e7c75a32a1..34c992d875298932 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -583,7 +583,7 @@ static void atmci_init_debugfs(struct atmel_mci_slot *slot)
 
 	debugfs_create_file("regs", S_IRUSR, root, host, &atmci_regs_fops);
 	debugfs_create_file("req", S_IRUSR, root, slot, &atmci_req_fops);
-	debugfs_create_u32("state", S_IRUSR, root, (u32 *)&host->state);
+	debugfs_create_u32("state", S_IRUSR, root, &host->state);
 	debugfs_create_xul("pending_events", S_IRUSR, root,
 			   &host->pending_events);
 	debugfs_create_xul("completed_events", S_IRUSR, root,
-- 
2.17.1
