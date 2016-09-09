From: Chris Brandt <chris.brandt@renesas.com>
Subject: [PATCH 2/3] mmc: tmio-mmc: add support for 32bit data port
Date: Fri,  9 Sep 2016 11:52:37 -0400
Message-ID: <20160909155238.17852-3-chris.brandt@renesas.com>
References: <20160909155238.17852-1-chris.brandt@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <20160909155238.17852-1-chris.brandt@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc: Simon Horman <horms+renesas@verge.net.au>, linux-mmc@vger.kernel.org, linux-renesas-soc@vger.kernel.org, Chris Brandt <chris.brandt@renesas.com>
List-Id: linux-mmc@vger.kernel.org

For the r7s72100 SOC, the DATA_PORT register was change to be 32-bits wide.
Therefore a new flag has been created that will allow 32-bit reads/writes
to the DATA_PORT register instead of 16-bit (because 16-bits accesses are
not supported).

Signed-off-by: Chris Brandt <chris.brandt@renesas.com>
---
 drivers/mmc/host/tmio_mmc.h     | 12 ++++++++++++
 drivers/mmc/host/tmio_mmc_pio.c | 35 +++++++++++++++++++++++++++++++++++
 include/linux/mfd/tmio.h        |  5 +++++
 3 files changed, 52 insertions(+)

diff --git a/drivers/mmc/host/tmio_mmc.h b/drivers/mmc/host/tmio_mmc.h
index ecb99fc..1f9a322 100644
--- a/drivers/mmc/host/tmio_mmc.h
+++ b/drivers/mmc/host/tmio_mmc.h
@@ -237,6 +237,12 @@ static inline u32 sd_ctrl_read16_and_16_as_32(struct tmio_mmc_host *host, int ad
 	       readw(host->ctl + ((addr + 2) << host->bus_shift)) << 16;
 }
 
+static inline void sd_ctrl_read32_rep(struct tmio_mmc_host *host, int addr,
+		u32 *buf, int count)
+{
+	readsl(host->ctl + (addr << host->bus_shift), buf, count);
+}
+
 static inline void sd_ctrl_write16(struct tmio_mmc_host *host, int addr, u16 val)
 {
 	/* If there is a hook and it returns non-zero then there
@@ -259,4 +265,10 @@ static inline void sd_ctrl_write32_as_16_and_16(struct tmio_mmc_host *host, int
 	writew(val >> 16, host->ctl + ((addr + 2) << host->bus_shift));
 }
 
+static inline void sd_ctrl_write32_rep(struct tmio_mmc_host *host, int addr,
+		u32 *buf, int count)
+{
+	writesl(host->ctl + (addr << host->bus_shift), buf, count);
+}
+
 #endif
diff --git a/drivers/mmc/host/tmio_mmc_pio.c b/drivers/mmc/host/tmio_mmc_pio.c
index 017a4dc..c38542d 100644
--- a/drivers/mmc/host/tmio_mmc_pio.c
+++ b/drivers/mmc/host/tmio_mmc_pio.c
@@ -439,10 +439,45 @@ static void tmio_mmc_transfer_data(struct tmio_mmc_host *host,
 {
 	int is_read = host->data->flags & MMC_DATA_READ;
 	u8  *buf8;
+	u32 data;
 
 	/*
 	 * Transfer the data
 	 */
+	if (host->pdata->flags & TMIO_MMC_32BIT_DATA_PORT) {
+		if (is_read)
+			sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, (u32 *)buf,
+					   count >> 2);
+		else
+			sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, (u32 *)buf,
+					    count >> 2);
+
+		/* if count was multiple of 4 */
+		if (!(count & 0x3))
+			return;
+
+		buf8 = (u8 *)(buf + (count >> 2));
+		count %= 4;
+
+		if (is_read) {
+			sd_ctrl_read32_rep(host, CTL_SD_DATA_PORT, &data, 1);
+			while (count--) {
+				*buf8 = data * 0xFF;
+				data = data >> 8;
+				buf8++;
+			}
+		} else {
+			data = *buf8++;
+			if (count > 1)
+				data |= (*buf8++ << 8);
+			if (count > 2)
+				data |= (*buf8++ << 16);
+			sd_ctrl_write32_rep(host, CTL_SD_DATA_PORT, &data, 1);
+		}
+
+		return;
+	}
+
 	if (is_read)
 		sd_ctrl_read16_rep(host, CTL_SD_DATA_PORT, buf, count >> 1);
 	else
diff --git a/include/linux/mfd/tmio.h b/include/linux/mfd/tmio.h
index 3b95dc7..0dbcb7e 100644
--- a/include/linux/mfd/tmio.h
+++ b/include/linux/mfd/tmio.h
@@ -100,6 +100,11 @@
 #define TMIO_MMC_SDIO_STATUS_QUIRK	(1 << 8)
 
 /*
+ * Some controllers have a 32-bit wide data port register
+ */
+#define TMIO_MMC_32BIT_DATA_PORT	(1 << 9)
+
+/*
  * Some controllers allows to set SDx actual clock
  */
 #define TMIO_MMC_CLK_ACTUAL		(1 << 10)
-- 
2.9.2
