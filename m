From: Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH RESEND 8/9] mmc: slot-gpio: Add a function to enable/disable card detect IRQ wakeup
Date: Tue,  9 Jan 2018 09:52:25 +0200
Message-ID: <1515484346-800-9-git-send-email-adrian.hunter@intel.com>
References: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
In-Reply-To: <1515484346-800-1-git-send-email-adrian.hunter@intel.com>
Sender: linux-pm-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>, Haridhar Kalvala <haridhar.kalvala@intel.com>
List-Id: linux-mmc@vger.kernel.org

Commit 03dbaa04a2e5 ("mmc: slot-gpio: Add support to enable irq wake on
cd_irq") enabled wakeup irrespective of the host controller's PM flags.
However, users also want to control it from sysfs power/wakeup attribute.
That means the driver needs to check the PM flags before enabling it in the
suspend callback. Add helper function mmc_gpio_set_cd_wake() to make it
easy for drivers to do that.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 drivers/mmc/core/core.c       |  3 +--
 drivers/mmc/core/slot-gpio.c  | 23 +++++++++++++++++++++++
 include/linux/mmc/slot-gpio.h |  1 +
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index c0ba6d8823b7..7bed23c877de 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -2655,8 +2655,7 @@ void mmc_start_host(struct mmc_host *host)
 void mmc_stop_host(struct mmc_host *host)
 {
 	if (host->slot.cd_irq >= 0) {
-		if (host->slot.cd_wake_enabled)
-			disable_irq_wake(host->slot.cd_irq);
+		mmc_gpio_set_cd_wake(host, false);
 		disable_irq(host->slot.cd_irq);
 	}
 
diff --git a/drivers/mmc/core/slot-gpio.c b/drivers/mmc/core/slot-gpio.c
index f7c6e0542de7..3a30535c2f31 100644
--- a/drivers/mmc/core/slot-gpio.c
+++ b/drivers/mmc/core/slot-gpio.c
@@ -154,6 +154,29 @@ void mmc_gpiod_request_cd_irq(struct mmc_host *host)
 }
 EXPORT_SYMBOL(mmc_gpiod_request_cd_irq);
 
+int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on)
+{
+	int ret = 0;
+
+	if (!(host->caps & MMC_CAP_CD_WAKE) ||
+	    host->slot.cd_irq < 0 ||
+	    on == host->slot.cd_wake_enabled)
+		return 0;
+
+	if (on) {
+		if (device_may_wakeup(mmc_dev(host))) {
+			ret = enable_irq_wake(host->slot.cd_irq);
+			host->slot.cd_wake_enabled = !ret;
+		}
+	} else {
+		disable_irq_wake(host->slot.cd_irq);
+		host->slot.cd_wake_enabled = false;
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(mmc_gpio_set_cd_wake);
+
 /* Register an alternate interrupt service routine for
  * the card-detect GPIO.
  */
diff --git a/include/linux/mmc/slot-gpio.h b/include/linux/mmc/slot-gpio.h
index 82f0d289f110..1ee9f15bf2c0 100644
--- a/include/linux/mmc/slot-gpio.h
+++ b/include/linux/mmc/slot-gpio.h
@@ -33,5 +33,6 @@ void mmc_gpio_set_cd_isr(struct mmc_host *host,
 			 irqreturn_t (*isr)(int irq, void *dev_id));
 void mmc_gpiod_request_cd_irq(struct mmc_host *host);
 bool mmc_can_gpio_cd(struct mmc_host *host);
+int mmc_gpio_set_cd_wake(struct mmc_host *host, bool on);
 
 #endif
-- 
1.9.1
