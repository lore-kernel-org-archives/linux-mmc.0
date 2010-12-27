From: Chuanxiao Dong <chuanxiao.dong@intel.com>
Subject: [PATCH v6 3/3]mmc: implement hwreset_emmc and reinit_emmc callbacks
Date: Mon, 27 Dec 2010 18:14:43 +0800
Message-ID: <20101227101443.GD20143@intel.com>
Reply-To: Chuanxiao Dong <chuanxiao.dong@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:1737 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab0L0KT4 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Dec 2010 05:19:56 -0500
Content-Disposition: inline
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, cjb@laptop.org, akpm@linux-foundation.org

hwreset_emmc: used for host to trigger a RST_n signal as eMMC4.4 spec
recommanded to reset eMMC card. It is useful when eMMC card cannot response
any command.

reinit_emmc: reinitialize eMMC card after HW reset occurs.

Signed-off-by: Chuanxiao Dong <chuanxiao.dong@intel.com>
---
 drivers/mmc/core/mmc.c   |   83 ++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mmc/host.h |    2 +
 2 files changed, 85 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index ebb5748..8c82b9d 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -12,6 +12,7 @@
 
 #include <linux/err.h>
 #include <linux/slab.h>
+#include <linux/gpio.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -745,6 +746,84 @@ static int mmc_awake(struct mmc_host *host)
 	return err;
 }
 
+/**
+ * mmc_reinit_card - reinitialize eMMC card after HW reset
+ * @host: mmc host structure
+ *
+ * this callback is used to reinitialize card after a HW
+ * reset occurs.
+ * mmc_claim_host should be called before using this callback and
+ * mmc_release_host should be called after.
+ *
+ * Return value:
+ * 0 - successfully reinitialize
+ * other - failed to reinitialize
+ */
+static int mmc_reinit_card(struct mmc_host *host)
+{
+	int err;
+	/*
+	 * Before init card, set the clock to be
+	 * the init frequency
+	 */
+	host->ios.clock = host->f_init;
+	mmc_set_clock(host, host->ios.clock);
+
+	err = mmc_init_card(host, host->ocr, host->card);
+	if (err)
+		pr_err("%s: Error %d while reinit card\n",
+				mmc_hostname(host), err);
+
+	return err;
+}
+
+/**
+ * mmc_reset_card - reset eMMC card
+ *
+ * this callback is used to trigger RST_n signal by using GPIO to reset eMMC
+ * card. The RST_n signal is defined in eMMC4.4 spec
+ *
+ * Return value:
+ * 0 - successfully reset eMMC card
+ * -ENODEV - no valid GPIO line to be used
+ * -ENOSYS - GPIO functions is not implemented
+ * other - failed to reset eMMC card
+ */
+static int mmc_hwreset_emmc(struct mmc_host *host)
+{
+	int gpio = host->rst_gpio;
+	int ret;
+	if (gpio <= 0)
+		return -ENODEV;
+
+	/* request reset pin for eMMC */
+	ret = gpio_request(gpio, "eMMC_rst_pin");
+	if (ret < 0) {
+		pr_err("gpio %d request failed, err %d\n",
+				gpio, ret);
+		return ret;
+	}
+	/* set to be output and to be low state */
+	ret = gpio_direction_output(gpio, 0);
+	if (ret < 0) {
+		pr_err("gpio %d direction output failed, err %d\n",
+				gpio, ret);
+		gpio_free(gpio);
+		return ret;
+	}
+	/* delay 10us for tRSTW */
+	udelay(10);
+	/* set to be high and delay 300us */
+	gpio_set_value(gpio, 1);
+	udelay(300);
+	/* set to be output and to be low state */
+	gpio_direction_output(gpio, 0);
+	/* free reset gpio pin */
+	gpio_free(gpio);
+
+	return 0;
+}
+
 static const struct mmc_bus_ops mmc_ops = {
 	.awake = mmc_awake,
 	.sleep = mmc_sleep,
@@ -753,6 +832,8 @@ static const struct mmc_bus_ops mmc_ops = {
 	.suspend = NULL,
 	.resume = NULL,
 	.power_restore = mmc_power_restore,
+	.reinit_emmc = mmc_reinit_card,
+	.hwreset_emmc = mmc_hwreset_emmc,
 };
 
 static const struct mmc_bus_ops mmc_ops_unsafe = {
@@ -763,6 +844,8 @@ static const struct mmc_bus_ops mmc_ops_unsafe = {
 	.suspend = mmc_suspend,
 	.resume = mmc_resume,
 	.power_restore = mmc_power_restore,
+	.reinit_emmc = mmc_reinit_card,
+	.hwreset_emmc = mmc_hwreset_emmc,
 };
 
 static void mmc_attach_bus_ops(struct mmc_host *host)
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index bcb793e..d2b3bf6 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -243,6 +243,8 @@ struct mmc_host {
 
 	struct dentry		*debugfs_root;
 
+	unsigned int	rst_gpio;	/* gpio pin to reset eMMC card */
+
 	unsigned long		private[0] ____cacheline_aligned;
 };
 
-- 
1.6.6.1

