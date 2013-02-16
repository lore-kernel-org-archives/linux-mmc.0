From: Kevin Liu <kliu5@marvell.com>
Subject: [PATCH] mmc: core: update start_signal_voltage_switch argument type
Date: Sat, 16 Feb 2013 12:11:14 +0800
Message-ID: <1360987875-23786-1-git-send-email-kliu5@marvell.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog130.obsmtp.com ([74.125.149.143]:59736 "EHLO
	na3sys009aog130.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751099Ab3BPEMK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Feb 2013 23:12:10 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Sujit Reddy Thumma <sthumma@codeaurora.org>, Jaehoon Chung <jh80.chung@samsung.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaron Lu <aaron.lu@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Alexander Stein <alexander.stein@systec-electronic.com>, Wei WANG <wei_wang@realsil.com.cn>, Fabio Estevam <fabio.estevam@freescale.com>
Cc: Nicolas Pitre <nico@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Philip Rakity <prakity@nvidia.com>, Shawn Guo <shawn.guo@linaro.org>, Johan Rudholm <johan.rudholm@stericsson.com>, Daniel Drake <dsd@laptop.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Jerry Huang <Chang-Ming.Huang@freescale.com>, Girish K S <girish.shivananjappa@linaro.org>, Haijun Zhang <Haijun.Zhang@freescale.com>, Viresh Kumar <viresh.kumar@linaro.org>, Heiko Stuebner <heiko@sntech.de>, Thomas Abraham <thomas.abraham@linaro.org>, Chander Kashyap <chander.kashyap@linaro.com>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Zhangfei Gao <zhangfei.gao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Chao Xie <cxie4@marvell.com>, Kevin Liu <keyuan.liu@gmail.com>, Kevin Liu <kliu5@marvell.com>

1. Change the second argument of start_signal_voltage_switch from
"struct mmc_ios *ios" to "unsigned char signal_voltage" since
host->ops->start_signal_voltage_switch only need this value. So
only transfer the voltage rather than update ios.signal_voltage and
then transfer total ios is more straight forward. And then no need
to backup the origianl signal voltage in ios.

2. Change the argument type from "int" to "unsigned char" to align
with ios->signal_voltage.

3. Only host driver sdhci.c and rtsx_pci_sdmmc.c implemented function
start_signal_voltage_switch. So update them accordingly.

Signed-off-by: Kevin Liu <kliu5@marvell.com>
---
 drivers/mmc/core/core.c           |   14 +++++++-------
 drivers/mmc/core/core.h           |    4 ++--
 drivers/mmc/host/rtsx_pci_sdmmc.c |    7 ++++---
 drivers/mmc/host/sdhci.c          |   11 ++++++-----
 include/linux/mmc/host.h          |    2 +-
 5 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 08a3cf2..1703833 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1317,26 +1317,26 @@ u32 mmc_select_voltage(struct mmc_host *host, u32 ocr)
 	return ocr;
 }
 
-int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+int __mmc_set_signal_voltage(struct mmc_host *host,
+			     unsigned char signal_voltage)
 {
 	int err = 0;
-	int old_signal_voltage = host->ios.signal_voltage;
 
-	host->ios.signal_voltage = signal_voltage;
 	if (host->ops->start_signal_voltage_switch) {
 		mmc_host_clk_hold(host);
-		err = host->ops->start_signal_voltage_switch(host, &host->ios);
+		err = host->ops->start_signal_voltage_switch(host,
+			signal_voltage);
 		mmc_host_clk_release(host);
 	}
 
-	if (err)
-		host->ios.signal_voltage = old_signal_voltage;
+	if (!err)
+		host->ios.signal_voltage = signal_voltage;
 
 	return err;
 
 }
 
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage)
+int mmc_set_signal_voltage(struct mmc_host *host, unsigned char signal_voltage)
 {
 	struct mmc_command cmd = {0};
 	int err = 0;
diff --git a/drivers/mmc/core/core.h b/drivers/mmc/core/core.h
index b9f18a2..c13babd 100644
--- a/drivers/mmc/core/core.h
+++ b/drivers/mmc/core/core.h
@@ -40,8 +40,8 @@ void mmc_set_ungated(struct mmc_host *host);
 void mmc_set_bus_mode(struct mmc_host *host, unsigned int mode);
 void mmc_set_bus_width(struct mmc_host *host, unsigned int width);
 u32 mmc_select_voltage(struct mmc_host *host, u32 ocr);
-int mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
-int __mmc_set_signal_voltage(struct mmc_host *host, int signal_voltage);
+int mmc_set_signal_voltage(struct mmc_host *host, unsigned char signal_voltage);
+int __mmc_set_signal_voltage(struct mmc_host *host, unsigned char signal_voltage);
 void mmc_set_timing(struct mmc_host *host, unsigned int timing);
 void mmc_set_driver_type(struct mmc_host *host, unsigned int drv_type);
 void mmc_power_off(struct mmc_host *host);
diff --git a/drivers/mmc/host/rtsx_pci_sdmmc.c b/drivers/mmc/host/rtsx_pci_sdmmc.c
index f93f100..014abf7 100644
--- a/drivers/mmc/host/rtsx_pci_sdmmc.c
+++ b/drivers/mmc/host/rtsx_pci_sdmmc.c
@@ -1060,7 +1060,8 @@ static int sd_wait_voltage_stable_2(struct realtek_pci_sdmmc *host)
 	return 0;
 }
 
-static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
+static int sdmmc_switch_voltage(struct mmc_host *mmc,
+	unsigned char signal_voltage)
 {
 	struct realtek_pci_sdmmc *host = mmc_priv(mmc);
 	struct rtsx_pcr *pcr = host->pcr;
@@ -1068,7 +1069,7 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 	u8 voltage;
 
 	dev_dbg(sdmmc_dev(host), "%s: signal_voltage = %d\n",
-			__func__, ios->signal_voltage);
+			__func__, signal_voltage);
 
 	if (host->eject)
 		return -ENOMEDIUM;
@@ -1077,7 +1078,7 @@ static int sdmmc_switch_voltage(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	rtsx_pci_start_run(pcr);
 
-	if (ios->signal_voltage == MMC_SIGNAL_VOLTAGE_330)
+	if (signal_voltage == MMC_SIGNAL_VOLTAGE_330)
 		voltage = OUTPUT_3V3;
 	else
 		voltage = OUTPUT_1V8;
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 51bbba4..7ace91b 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1675,7 +1675,7 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 }
 
 static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
-						struct mmc_ios *ios)
+						unsigned char signal_voltage)
 {
 	u16 ctrl;
 	int ret;
@@ -1689,7 +1689,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
-	switch (ios->signal_voltage) {
+	switch (signal_voltage) {
 	case MMC_SIGNAL_VOLTAGE_330:
 		/* Set 1.8V Signal Enable in the Host Control2 register to 0 */
 		ctrl &= ~SDHCI_CTRL_VDD_180;
@@ -1762,7 +1762,7 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
 }
 
 static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
-	struct mmc_ios *ios)
+	unsigned char signal_voltage)
 {
 	struct sdhci_host *host = mmc_priv(mmc);
 	int err;
@@ -1770,7 +1770,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 	if (host->version < SDHCI_SPEC_300)
 		return 0;
 	sdhci_runtime_pm_get(host);
-	err = sdhci_do_start_signal_voltage_switch(host, ios);
+	err = sdhci_do_start_signal_voltage_switch(host, signal_voltage);
 	sdhci_runtime_pm_put(host);
 	return err;
 }
@@ -2635,7 +2635,8 @@ int sdhci_runtime_resume_host(struct sdhci_host *host)
 	host->clock = 0;
 	sdhci_do_set_ios(host, &host->mmc->ios);
 
-	sdhci_do_start_signal_voltage_switch(host, &host->mmc->ios);
+	sdhci_do_start_signal_voltage_switch(host,
+		host->mmc->ios->signal_voltage);
 	if ((host_flags & SDHCI_PV_ENABLED) &&
 		!(host->quirks2 & SDHCI_QUIRK2_PRESET_VALUE_BROKEN)) {
 		spin_lock_irqsave(&host->lock, flags);
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index fd5fd5a..22b813a 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -129,7 +129,7 @@ struct mmc_host_ops {
 	/* optional callback for HC quirks */
 	void	(*init_card)(struct mmc_host *host, struct mmc_card *card);
 
-	int	(*start_signal_voltage_switch)(struct mmc_host *host, struct mmc_ios *ios);
+	int	(*start_signal_voltage_switch)(struct mmc_host *host, unsigned char signal_voltage);
 
 	/* Check if the card is pulling dat[0:3] low */
 	int	(*card_busy)(struct mmc_host *host);
-- 
1.7.9.5

