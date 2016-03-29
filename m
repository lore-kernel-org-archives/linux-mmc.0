From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH V3] mmc: sdhci: Fix regression setting power on Trats2 board
Date: Tue, 29 Mar 2016 12:45:43 +0300
Message-ID: <56FA4EC7.8090004@intel.com>
References: <CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com>
 <20160324155840.50474b98@xhacker> <56F3A0B7.4050509@samsung.com>
 <20160324162449.29c9cf78@xhacker> <56F3A88F.50603@samsung.com>
 <56F3E77D.7030201@intel.com> <56F3E9EB.3090207@intel.com>
 <56F8CA0C.2080908@samsung.com> <56FA4D66.3030109@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:26080 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752005AbcC2Jt1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 29 Mar 2016 05:49:27 -0400
In-Reply-To: <56FA4D66.3030109@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Krzysztof Kozlowski <k.kozlowski@samsung.com>, Jisheng Zhang <jszhang@marvell.com>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, ludovic.desroches@atmel.com, "Ivan T. Ivanov" <ivan.ivanov@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org

Several commits relating to setting power have been introducing
problems by putting driver-specific rules into generic SDHCI code.

Krzysztof Kozlowski reported that after commit 918f4cbd4340 ("mmc:
sdhci: restore behavior when setting VDD via external regulator")
on Trats2 board there are warnings for invalid VDD  value (2.8V):

[    3.119656] ------------[ cut here ]------------
[    3.119666] WARNING: CPU: 3 PID: 90 at
../drivers/mmc/host/sdhci.c:1234 sdhci_do_set_ios+0x4cc/0x5e0
[    3.119669] mmc0: Invalid vdd 0x10
[    3.119673] Modules linked in:
[    3.119679] CPU: 3 PID: 90 Comm: kworker/3:1 Tainted: G        W
   4.5.0-next-20160324 #23
[    3.119681] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    3.119690] Workqueue: events_freezable mmc_rescan
[    3.119708] [<c010e0ac>] (unwind_backtrace) from [<c010ae10>]
(show_stack+0x10/0x14)
[    3.119719] [<c010ae10>] (show_stack) from [<c0323260>]
(dump_stack+0x88/0x9c)
[    3.119728] [<c0323260>] (dump_stack) from [<c011b754>] (__warn+0xe8/0x100)
[    3.119734] [<c011b754>] (__warn) from [<c011b7a4>]
(warn_slowpath_fmt+0x38/0x48)
[    3.119740] [<c011b7a4>] (warn_slowpath_fmt) from [<c0527d28>]
(sdhci_do_set_ios+0x4cc/0x5e0)
[    3.119748] [<c0527d28>] (sdhci_do_set_ios) from [<c0528018>]
(sdhci_runtime_resume_host+0x60/0x114)
[    3.119758] [<c0528018>] (sdhci_runtime_resume_host) from
[<c0402570>] (__rpm_callback+0x2c/0x60)
[    3.119767] [<c0402570>] (__rpm_callback) from [<c04025c4>]
(rpm_callback+0x20/0x80)
[    3.119773] [<c04025c4>] (rpm_callback) from [<c04034b8>]
(rpm_resume+0x36c/0x558)
[    3.119780] [<c04034b8>] (rpm_resume) from [<c04036f0>]
(__pm_runtime_resume+0x4c/0x64)
[    3.119788] [<c04036f0>] (__pm_runtime_resume) from [<c0512728>]
(__mmc_claim_host+0x170/0x1b0)
[    3.119795] [<c0512728>] (__mmc_claim_host) from [<c0514e2c>]
(mmc_rescan+0x54/0x348)
[    3.119807] [<c0514e2c>] (mmc_rescan) from [<c0130dac>]
(process_one_work+0x120/0x3f4)
[    3.119815] [<c0130dac>] (process_one_work) from [<c01310b8>]
(worker_thread+0x38/0x554)
[    3.119823] [<c01310b8>] (worker_thread) from [<c01365a4>]
(kthread+0xdc/0xf4)
[    3.119831] [<c01365a4>] (kthread) from [<c0107878>]
(ret_from_fork+0x14/0x3c)
[    3.119834] ---[ end trace a22d652aa3276886 ]---

Fix by adding a 'set_power' callback and restoring the default
behaviour prior to commit 918f4cbd4340 ("mmc: sdhci: restore
behavior when setting VDD via external regulator").  The desired
behaviour of that commit is gotten by having sdhci-pxav3 provide
its own set_power callback.

Reported-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Link: http://lkml.kernel.org/r/CAJKOXPcGDnPm-Ykh6wHqV1YxfTaov5E8iVqBoBn4OJc7BnhgEQ@mail.gmail.com
Fixes: 918f4cbd4340 ("mmc: sdhci: restore behavior when setting VDD...)
Tested-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: stable@vger.kernel.org # v4.5+
---


Changes in V3:

	Expanded commit message.

	Removed redundant vdd = 0 from sdhci_set_power()

	Make pxav3_set_power() check the regulator was created successfully
	before using it, and ensure vdd is 0 when pwr is 0.


 drivers/mmc/host/sdhci-pxav3.c | 22 ++++++++++++++++++++++
 drivers/mmc/host/sdhci.c       | 39 ++++++++++++++++++++++++++++++---------
 drivers/mmc/host/sdhci.h       |  4 ++++
 3 files changed, 56 insertions(+), 9 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pxav3.c b/drivers/mmc/host/sdhci-pxav3.c
index f5edf9d3a18a..0535827b02ee 100644
--- a/drivers/mmc/host/sdhci-pxav3.c
+++ b/drivers/mmc/host/sdhci-pxav3.c
@@ -307,8 +307,30 @@ static void pxav3_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
 		__func__, uhs, ctrl_2);
 }
 
+static void pxav3_set_power(struct sdhci_host *host, unsigned char mode,
+			    unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+	u8 pwr = host->pwr;
+
+	sdhci_set_power(host, mode, vdd);
+
+	if (host->pwr == pwr)
+		return;
+
+	if (host->pwr == 0)
+		vdd = 0;
+
+	if (!IS_ERR(mmc->supply.vmmc)) {
+		spin_unlock_irq(&host->lock);
+		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+		spin_lock_irq(&host->lock);
+	}
+}
+
 static const struct sdhci_ops pxav3_sdhci_ops = {
 	.set_clock = sdhci_set_clock,
+	.set_power = pxav3_set_power,
 	.platform_send_init_74_clocks = pxav3_gen_init_74_clocks,
 	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
 	.set_bus_width = sdhci_set_bus_width,
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index add9fdfd1d8f..f5b52b4308cc 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1269,10 +1269,24 @@ clock_set:
 }
 EXPORT_SYMBOL_GPL(sdhci_set_clock);
 
-static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
-			    unsigned short vdd)
+static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
+				unsigned short vdd)
 {
 	struct mmc_host *mmc = host->mmc;
+
+	spin_unlock_irq(&host->lock);
+	mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
+	spin_lock_irq(&host->lock);
+
+	if (mode != MMC_POWER_OFF)
+		sdhci_writeb(host, SDHCI_POWER_ON, SDHCI_POWER_CONTROL);
+	else
+		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
+}
+
+void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+		     unsigned short vdd)
+{
 	u8 pwr = 0;
 
 	if (mode != MMC_POWER_OFF) {
@@ -1304,7 +1318,6 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		sdhci_writeb(host, 0, SDHCI_POWER_CONTROL);
 		if (host->quirks2 & SDHCI_QUIRK2_CARD_ON_NEEDS_BUS_ON)
 			sdhci_runtime_pm_bus_off(host);
-		vdd = 0;
 	} else {
 		/*
 		 * Spec says that we should clear the power reg before setting
@@ -1335,12 +1348,20 @@ static void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
 		if (host->quirks & SDHCI_QUIRK_DELAY_AFTER_POWER)
 			mdelay(10);
 	}
+}
+EXPORT_SYMBOL_GPL(sdhci_set_power);
 
-	if (!IS_ERR(mmc->supply.vmmc)) {
-		spin_unlock_irq(&host->lock);
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, vdd);
-		spin_lock_irq(&host->lock);
-	}
+static void __sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+			      unsigned short vdd)
+{
+	struct mmc_host *mmc = host->mmc;
+
+	if (host->ops->set_power)
+		host->ops->set_power(host, mode, vdd);
+	else if (!IS_ERR(mmc->supply.vmmc))
+		sdhci_set_power_reg(host, mode, vdd);
+	else
+		sdhci_set_power(host, mode, vdd);
 }
 
 /*****************************************************************************\
@@ -1490,7 +1511,7 @@ static void sdhci_do_set_ios(struct sdhci_host *host, struct mmc_ios *ios)
 		}
 	}
 
-	sdhci_set_power(host, ios->power_mode, ios->vdd);
+	__sdhci_set_power(host, ios->power_mode, ios->vdd);
 
 	if (host->ops->platform_send_init_74_clocks)
 		host->ops->platform_send_init_74_clocks(host, ios->power_mode);
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 0115e9907bf8..033d72b5bbd5 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -529,6 +529,8 @@ struct sdhci_ops {
 #endif
 
 	void	(*set_clock)(struct sdhci_host *host, unsigned int clock);
+	void	(*set_power)(struct sdhci_host *host, unsigned char mode,
+			     unsigned short vdd);
 
 	int		(*enable_dma)(struct sdhci_host *host);
 	unsigned int	(*get_max_clock)(struct sdhci_host *host);
@@ -660,6 +662,8 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
 }
 
 void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
+void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
+		     unsigned short vdd);
 void sdhci_set_bus_width(struct sdhci_host *host, int width);
 void sdhci_reset(struct sdhci_host *host, u8 mask);
 void sdhci_set_uhs_signaling(struct sdhci_host *host, unsigned timing);
-- 
1.9.1


