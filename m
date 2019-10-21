From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 3/7] net: caif: Fix debugfs on 64-bit platforms
Date: Mon, 21 Oct 2019 16:37:38 +0200
Message-ID: <20191021143742.14487-4-geert+renesas@glider.be>
References: <20191021143742.14487-1-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20191021143742.14487-1-geert+renesas@glider.be>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ludovic Desroches <ludovic.desroches@microchip.com>, Ulf Hansson <ulf.hansson@linaro.org>, Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Jaehoon Chung <jh80.chung@samsung.com>, "David S . Miller" <davem@davemloft.net>, "Rafael J . Wysocki" <rafael@kernel.org>, Johannes Berg <johannes@sipsolutions.net>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

"ser_device.state" is "unsigned long", i.e. 32-bit or 64-bit, depending
on the platform.  Hence casting its address to "u32 *", and calling
debugfs_create_x32() breaks operation on 64-bit platforms.

Fix this by using the new debugfs_create_xul() helper instead.

Fixes: 9b27105b4a44c54b ("net-caif-driver: add CAIF serial driver (ldisc)")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/caif/caif_serial.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
index 40b079162804fb0c..bd40b114d6cd7214 100644
--- a/drivers/net/caif/caif_serial.c
+++ b/drivers/net/caif/caif_serial.c
@@ -102,8 +102,8 @@ static inline void debugfs_init(struct ser_device *ser, struct tty_struct *tty)
 	debugfs_create_blob("last_rx_msg", 0400, ser->debugfs_tty_dir,
 			    &ser->rx_blob);
 
-	debugfs_create_x32("ser_state", 0400, ser->debugfs_tty_dir,
-			   (u32 *)&ser->state);
+	debugfs_create_xul("ser_state", 0400, ser->debugfs_tty_dir,
+			   &ser->state);
 
 	debugfs_create_x8("tty_status", 0400, ser->debugfs_tty_dir,
 			  &ser->tty_status);
-- 
2.17.1
