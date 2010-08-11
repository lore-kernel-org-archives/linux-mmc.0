From: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 5/8] wireless: wl1271: make ref_clock configurable by board
Date: Wed, 11 Aug 2010 21:21:50 +0300
Message-ID: <1281550913-17633-6-git-send-email-ohad@wizery.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1281550913-17633-1-git-send-email-ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Ido Yariv <ido-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Chikkature Rajashekar Madhusudhan <madhu.cr-l0cyMroinI0@public.gmane.org>, Luciano Coelho <luciano.coelho-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, San Mehat <san-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Roger Quadros <roger.quadros-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Nicolas Pitre <nico-vtqb6HGKxmzR7s880joybQ@public.gmane.org>, Pandita Vikram <vikram.pandita-l0cyMroinI0@public.gmane.org>, Kalle Valo <kalle.valo-X3B1VOXEql0@public.gmane.org>, Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

The wl1271 device is using a reference clock that may change
between board to board.

Make the ref_clock parameter configurable by the board
files that set up the device, instead of having a hard coded
value in the driver source itself.

Signed-off-by: Ohad Ben-Cohen <ohad-Ix1uc/W3ht7QT0dZR+AlfA@public.gmane.org>
---
 drivers/net/wireless/wl12xx/wl1271.h      |    1 +
 drivers/net/wireless/wl12xx/wl1271_boot.c |    9 +++++----
 drivers/net/wireless/wl12xx/wl1271_boot.h |    1 -
 drivers/net/wireless/wl12xx/wl1271_sdio.c |    1 +
 drivers/net/wireless/wl12xx/wl1271_spi.c  |    2 ++
 include/linux/wl12xx.h                    |    1 +
 6 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/wl12xx/wl1271.h b/drivers/net/wireless/wl12xx/wl1271.h
index 013eabb..f0988a4 100644
--- a/drivers/net/wireless/wl12xx/wl1271.h
+++ b/drivers/net/wireless/wl12xx/wl1271.h
@@ -342,6 +342,7 @@ struct wl1271 {
 
 	void (*set_power)(bool enable);
 	int irq;
+	int ref_clock;
 
 	spinlock_t wl_lock;
 
diff --git a/drivers/net/wireless/wl12xx/wl1271_boot.c b/drivers/net/wireless/wl12xx/wl1271_boot.c
index f36430b..95c636a 100644
--- a/drivers/net/wireless/wl12xx/wl1271_boot.c
+++ b/drivers/net/wireless/wl12xx/wl1271_boot.c
@@ -457,17 +457,18 @@ int wl1271_boot(struct wl1271 *wl)
 {
 	int ret = 0;
 	u32 tmp, clk, pause;
+	int ref_clock = wl->ref_clock;
 
 	wl1271_boot_hw_version(wl);
 
-	if (REF_CLOCK == 0 || REF_CLOCK == 2 || REF_CLOCK == 4)
+	if (ref_clock == 0 || ref_clock == 2 || ref_clock == 4)
 		/* ref clk: 19.2/38.4/38.4-XTAL */
 		clk = 0x3;
-	else if (REF_CLOCK == 1 || REF_CLOCK == 3)
+	else if (ref_clock == 1 || ref_clock == 3)
 		/* ref clk: 26/52 */
 		clk = 0x5;
 
-	if (REF_CLOCK != 0) {
+	if (ref_clock != 0) {
 		u16 val;
 		/* Set clock type (open drain) */
 		val = wl1271_top_reg_read(wl, OCP_REG_CLK_TYPE);
@@ -516,7 +517,7 @@ int wl1271_boot(struct wl1271 *wl)
 	wl1271_debug(DEBUG_BOOT, "clk2 0x%x", clk);
 
 	/* 2 */
-	clk |= (REF_CLOCK << 1) << 4;
+	clk |= (ref_clock << 1) << 4;
 	wl1271_write32(wl, DRPW_SCRATCH_START, clk);
 
 	wl1271_set_partition(wl, &part_table[PART_WORK]);
diff --git a/drivers/net/wireless/wl12xx/wl1271_boot.h b/drivers/net/wireless/wl12xx/wl1271_boot.h
index f829699..f73b0b1 100644
--- a/drivers/net/wireless/wl12xx/wl1271_boot.h
+++ b/drivers/net/wireless/wl12xx/wl1271_boot.h
@@ -46,7 +46,6 @@ struct wl1271_static_data {
 /* delay between retries */
 #define INIT_LOOP_DELAY 50
 
-#define REF_CLOCK            2
 #define WU_COUNTER_PAUSE_VAL 0x3FF
 #define WELP_ARM_COMMAND_VAL 0x4
 
diff --git a/drivers/net/wireless/wl12xx/wl1271_sdio.c b/drivers/net/wireless/wl12xx/wl1271_sdio.c
index 228f5af..2f558a6 100644
--- a/drivers/net/wireless/wl12xx/wl1271_sdio.c
+++ b/drivers/net/wireless/wl12xx/wl1271_sdio.c
@@ -296,6 +296,7 @@ static int __devinit wl1271_probe(struct sdio_func *func,
 	}
 
 	wl->irq = wlan_data->irq;
+	wl->ref_clock = wlan_data->board_ref_clock;
 
 	ret = request_irq(wl->irq, wl1271_irq, 0, DRIVER_NAME, wl);
 	if (ret < 0) {
diff --git a/drivers/net/wireless/wl12xx/wl1271_spi.c b/drivers/net/wireless/wl12xx/wl1271_spi.c
index de56d8d..ced0a9e 100644
--- a/drivers/net/wireless/wl12xx/wl1271_spi.c
+++ b/drivers/net/wireless/wl12xx/wl1271_spi.c
@@ -372,6 +372,8 @@ static int __devinit wl1271_probe(struct spi_device *spi)
 		goto out_free;
 	}
 
+	wl->ref_clock = pdata->board_ref_clock;
+
 	wl->irq = spi->irq;
 	if (wl->irq < 0) {
 		wl1271_error("irq missing in platform data");
diff --git a/include/linux/wl12xx.h b/include/linux/wl12xx.h
index 137ac89..ef6eed9 100644
--- a/include/linux/wl12xx.h
+++ b/include/linux/wl12xx.h
@@ -29,6 +29,7 @@ struct wl12xx_platform_data {
 	/* SDIO only: IRQ number if WLAN_IRQ line is used, 0 for SDIO IRQs */
 	int irq;
 	bool use_eeprom;
+	int board_ref_clock;
 };
 
 #endif
-- 
1.7.0.4

--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
