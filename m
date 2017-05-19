From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 04/41] mmc: host: omap_hsmmc: Add voltage switch support for UHS SD card
Date: Fri, 19 May 2017 13:45:04 +0530
Message-ID: <20170519081541.26753-5-kishon@ti.com>
References: <20170519081541.26753-1-kishon@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170519081541.26753-1-kishon@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, nsekhar@ti.com, kishon@ti.com
List-Id: linux-mmc@vger.kernel.org

From: Balaji T K <balajitk@ti.com>

UHS SD card i/o data line operates at 1.8V when in UHS speed
mode.

Add support for signal voltage switch to support UHS cards.

Also, enable CIRQ before checking for CLEV/DLEV. MMC module can
sense when the clock lines and data lines are driven high by the
card, if MMC is active and CIRQ can be used to keep the MMC
module active. This is required for voltage switching to succeed
and the card to enumerate in UHS mode.

Signed-off-by: Balaji T K <balajitk@ti.com>
Signed-off-by: Sourav Poddar <sourav.poddar@ti.com>
[kishon@ti.com : cleanup the voltage switch sequence]
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
[nsekhar@ti.com: make card busy functions preempt safe]
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
---
 drivers/mmc/host/omap_hsmmc.c | 165 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 893d1624a5a3..4dbf75ad2376 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -44,6 +44,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/platform_data/hsmmc-omap.h>
+#include <linux/mmc/sd.h>
 
 /* OMAP HSMMC Host Controller Registers */
 #define OMAP_HSMMC_SYSSTATUS	0x0014
@@ -111,6 +112,9 @@
 /* PSTATE */
 #define DLEV_DAT(x)		(1 << (20 + (x)))
 
+/* AC12 */
+#define AC12_V1V8_SIGEN		(1 << 19)
+
 /* Interrupt masks for IE and ISE register */
 #define CC_EN			(1 << 0)
 #define TC_EN			(1 << 1)
@@ -150,6 +154,13 @@
 #define VDD_1V8			1800000		/* 180000 uV */
 #define VDD_3V0			3000000		/* 300000 uV */
 #define VDD_165_195		(ffs(MMC_VDD_165_195) - 1)
+#define VDD_30_31		(ffs(MMC_VDD_30_31) - 1)
+
+#define CON_CLKEXTFREE		(1 << 16)
+#define CON_PADEN		(1 << 15)
+#define PSTATE_CLEV		(1 << 24)
+#define PSTATE_DLEV		(0xF << 20)
+#define PSTATE_DLEV_DAT0	(0x1 << 20)
 
 /*
  * One controller can have multiple slots, like on some omap boards using
@@ -177,6 +188,7 @@ struct omap_hsmmc_host {
 	struct	mmc_host	*mmc;
 	struct	mmc_request	*mrq;
 	struct	mmc_command	*cmd;
+	u32			last_cmd;
 	struct	mmc_data	*data;
 	struct	clk		*fclk;
 	struct	clk		*dbclk;
@@ -209,6 +221,7 @@ struct omap_hsmmc_host {
 	unsigned int		flags;
 #define AUTO_CMD23		(1 << 0)        /* Auto CMD23 support */
 #define HSMMC_SDIO_IRQ_ENABLED	(1 << 1)        /* SDIO irq enabled */
+#define CLKEXTFREE_ENABLED	(1 << 2)        /* CLKEXTFREE enabled */
 	struct omap_hsmmc_next	next_data;
 	struct	omap_hsmmc_platform_data	*pdata;
 
@@ -604,6 +617,9 @@ static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host,
 	if (cmd->opcode == MMC_ERASE)
 		irq_mask &= ~DTO_EN;
 
+	if (host->flags & CLKEXTFREE_ENABLED)
+		irq_mask |= CIRQ_EN;
+
 	spin_lock_irqsave(&host->irq_lock, flags);
 	OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
 	OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
@@ -947,6 +963,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host *host, struct mmc_command *cmd,
 		cmdreg |= DMAE;
 
 	host->req_in_progress = 1;
+	host->last_cmd = cmd->opcode;
 
 	OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
 	OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
@@ -1848,6 +1865,152 @@ static int omap_hsmmc_multi_io_quirk(struct mmc_card *card,
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
+		ret = omap_hsmmc_set_power(host, 1, VDD_30_31);
+		if (ret) {
+			dev_err(mmc_dev(host->mmc), "failed to switch to 3v\n");
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
+		ret = omap_hsmmc_set_power(host, 1, VDD_165_195);
+		if (ret < 0) {
+			dev_err(mmc_dev(host->mmc), "failed to switch 1.8v\n");
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
+	int i;
+	u32 val;
+
+	val = OMAP_HSMMC_READ(host->base, CON);
+	val &= ~CON_CLKEXTFREE;
+	val |= CON_PADEN;
+	OMAP_HSMMC_WRITE(host->base, CON, val);
+
+	/* By observation, card busy status reflects in 100 - 200us */
+	for (i = 0; i < 5; i++) {
+		val = OMAP_HSMMC_READ(host->base, PSTATE);
+		if (!(val & (PSTATE_CLEV | PSTATE_DLEV)))
+			return true;
+
+		usleep_range(100, 200);
+	}
+
+	dev_err(mmc_dev(host->mmc), "card busy\n");
+
+	return false;
+}
+
+static int omap_hsmmc_card_busy_high(struct omap_hsmmc_host *host)
+{
+	int i;
+	u32 val;
+	int ret = true;
+
+	val = OMAP_HSMMC_READ(host->base, CON);
+	val |= CLKEXTFREE;
+	OMAP_HSMMC_WRITE(host->base, CON, val);
+
+	host->flags |= CLKEXTFREE_ENABLED;
+	disable_irq(host->irq);
+	omap_hsmmc_enable_irq(host, NULL);
+
+	/* By observation, card busy status reflects in 100 - 200us */
+	for (i = 0; i < 5; i++) {
+		val = OMAP_HSMMC_READ(host->base, PSTATE);
+		if ((val & PSTATE_CLEV) && (val & PSTATE_DLEV)) {
+			val = OMAP_HSMMC_READ(host->base, CON);
+			val &= ~(CON_CLKEXTFREE | CON_PADEN);
+			OMAP_HSMMC_WRITE(host->base, CON, val);
+			ret = false;
+			goto disable_irq;
+		}
+
+		usleep_range(100, 200);
+	}
+
+	dev_err(mmc_dev(host->mmc), "card busy\n");
+
+disable_irq:
+	omap_hsmmc_disable_irq(host);
+	enable_irq(host->irq);
+	host->flags &= ~CLKEXTFREE_ENABLED;
+
+	return ret;
+}
+
+static int omap_hsmmc_card_busy(struct mmc_host *mmc)
+{
+	struct omap_hsmmc_host *host;
+	u32 val;
+	u32 reg;
+	int ret;
+
+	host  = mmc_priv(mmc);
+
+	if (host->last_cmd != SD_SWITCH_VOLTAGE) {
+		/*
+		 * PADEN should be set for DLEV to reflect the correct
+		 * state of data lines atleast for MMC1 on AM57x.
+		 */
+		reg = OMAP_HSMMC_READ(host->base, CON);
+		reg |= CON_PADEN;
+		OMAP_HSMMC_WRITE(host->base, CON, reg);
+		val = OMAP_HSMMC_READ(host->base, PSTATE);
+		reg &= ~CON_PADEN;
+		OMAP_HSMMC_WRITE(host->base, CON, reg);
+		if (val & PSTATE_DLEV_DAT0)
+			return false;
+		return true;
+	}
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
@@ -1857,6 +2020,8 @@ static struct mmc_host_ops omap_hsmmc_ops = {
 	.get_ro = mmc_gpio_get_ro,
 	.init_card = omap_hsmmc_init_card,
 	.enable_sdio_irq = omap_hsmmc_enable_sdio_irq,
+	.start_signal_voltage_switch = omap_hsmmc_start_signal_voltage_switch,
+	.card_busy = omap_hsmmc_card_busy,
 };
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.11.0
