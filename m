From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/11] mmc: host: omap_hsmmc: add voltage switch support for
 UHS SD card
Date: Thu, 30 Jul 2015 13:16:27 +0530
Message-ID: <1438242394-25599-5-git-send-email-kishon@ti.com>
References: <1438242394-25599-1-git-send-email-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1438242394-25599-1-git-send-email-kishon@ti.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: tony@atomide.com, ulf.hansson@linaro.org, afenkart@gmail.com, linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org
Cc: mugunthanvnm@ti.com, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

UHS sd card i/o data line can operate at 3V and 1.8V on UHS speed
modes. Add support for signal voltage switch and check for card_busy.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
[kishon@ti.com : cleanup the voltage switch sequence]
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c |  129 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 129 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 306e5c0..e960b5c 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -112,6 +112,9 @@
 /* PSTATE */
 #define DLEV_DAT(x)		(1 << (20 + (x)))
 
+/* AC12 */
+#define AC12_V1V8_SIGEN		(1 << 19)
+
 /* Interrupt masks for IE and ISE register */
 #define CC_EN			(1 << 0)
 #define TC_EN			(1 << 1)
@@ -151,6 +154,12 @@
 #define VDD_1V8			1800000		/* 180000 uV */
 #define VDD_3V0			3000000		/* 300000 uV */
 #define VDD_165_195		(ffs(MMC_VDD_165_195) - 1)
+#define VDD_30_31		(ffs(MMC_VDD_30_31) - 1)
+
+#define CON_CLKEXTFREE		(1 << 16)
+#define CON_PADEN		(1 << 15)
+#define PSTATE_CLEV		(1 << 24)
+#define PSTATE_DLEV		(0xF << 20)
 
 /*
  * One controller can have multiple slots, like on some omap boards using
@@ -1851,6 +1860,124 @@ static int omap_hsmmc_multi_io_quirk(struct mmc_card *card,
 	return blk_size;
 }
 
+static int omap_hsmmc_start_signal_voltage_switch(struct mmc_host *mmc,
+						  struct mmc_ios *ios)
+{
+	struct omap_hsmmc_host *host;
+	u32 val = 0;
+	int ret = 0;
+
+	host  = mmc_priv(mmc);
+
+	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330) {
+		val = OMAP_HSMMC_READ(host->base, CAPA);
+		if (!(val & VS30))
+			return -EOPNOTSUPP;
+
+		omap_hsmmc_conf_bus_power(host, ios->signal_voltage);
+
+		val = OMAP_HSMMC_READ(host->base, AC12);
+		val &= ~AC12_V1V8_SIGEN;
+		OMAP_HSMMC_WRITE(host->base, AC12, val);
+
+		ret = mmc_pdata(host)->set_power(host->dev, 1, VDD_30_31);
+		if (ret) {
+			dev_dbg(mmc_dev(host->mmc), "failed to switch to 3v\n");
+			return ret;
+		}
+
+		dev_dbg(mmc_dev(host->mmc), " i/o voltage switch to 3V\n");
+	} else if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_180) {
+		val = OMAP_HSMMC_READ(host->base, CAPA);
+		if (!(val & VS18))
+			return -EOPNOTSUPP;
+
+		omap_hsmmc_conf_bus_power(host, ios->signal_voltage);
+
+		val = OMAP_HSMMC_READ(host->base, AC12);
+		val |= AC12_V1V8_SIGEN;
+		OMAP_HSMMC_WRITE(host->base, AC12, val);
+
+		ret = mmc_pdata(host)->set_power(host->dev, 1, VDD_165_195);
+		if (ret < 0) {
+			dev_dbg(mmc_dev(host->mmc), "failed to switch 1.8v\n");
+			return ret;
+		}
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
+static int omap_hsmmc_card_busy_low(struct omap_hsmmc_host *host)
+{
+	u32 val;
+	unsigned long timeout;
+
+	val = OMAP_HSMMC_READ(host->base, CON);
+	val &= ~CON_CLKEXTFREE;
+	val |= CON_PADEN;
+	OMAP_HSMMC_WRITE(host->base, CON, val);
+
+	timeout = jiffies + msecs_to_jiffies(1);
+	do {
+		val = OMAP_HSMMC_READ(host->base, PSTATE);
+		if (!(val & (PSTATE_CLEV | PSTATE_DLEV)))
+			return true;
+
+		usleep_range(100, 200);
+	} while (!time_after(jiffies, timeout));
+
+	dev_err(mmc_dev(host->mmc), "timeout : i/o low 0x%x\n", val);
+
+	return false;
+}
+
+static int omap_hsmmc_card_busy_high(struct omap_hsmmc_host *host)
+{
+	u32 val;
+	unsigned long timeout;
+
+	val = OMAP_HSMMC_READ(host->base, CON);
+	val |= CLKEXTFREE;
+	OMAP_HSMMC_WRITE(host->base, CON, val);
+
+	timeout = jiffies + msecs_to_jiffies(1);
+	do {
+		val = OMAP_HSMMC_READ(host->base, PSTATE);
+		if ((val & PSTATE_CLEV) && (val & PSTATE_DLEV)) {
+			val = OMAP_HSMMC_READ(host->base, CON);
+			val &= ~(CON_CLKEXTFREE | CON_PADEN);
+			OMAP_HSMMC_WRITE(host->base, CON, val);
+			return false;
+		}
+
+		usleep_range(100, 200);
+	} while (!time_after(jiffies, timeout));
+
+	dev_err(mmc_dev(host->mmc), "timeout : i/o high 0x%x\n", val);
+
+	return true;
+}
+
+static int omap_hsmmc_card_busy(struct mmc_host *mmc)
+{
+	struct omap_hsmmc_host *host;
+	u32 val;
+	int ret;
+
+	host  = mmc_priv(mmc);
+
+	val = OMAP_HSMMC_READ(host->base, AC12);
+	if (val & AC12_V1V8_SIGEN)
+		ret = omap_hsmmc_card_busy_high(host);
+	else
+		ret = omap_hsmmc_card_busy_low(host);
+
+	return ret;
+}
+
 static struct mmc_host_ops omap_hsmmc_ops = {
 	.post_req = omap_hsmmc_post_req,
 	.pre_req = omap_hsmmc_pre_req,
@@ -1860,6 +1987,8 @@ static struct mmc_host_ops omap_hsmmc_ops = {
 	.get_ro = mmc_gpio_get_ro,
 	.init_card = omap_hsmmc_init_card,
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
+	.start_signal_voltage_switch = omap_hsmmc_start_signal_voltage_switch,
+	.card_busy = omap_hsmmc_card_busy,
 };
 
 #ifdef CONFIG_DEBUG_FS
-- 
1.7.9.5
