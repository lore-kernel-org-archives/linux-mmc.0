From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] mmc: sdhci: use IS_REACHABLE(CONFIG_LEDS_CLASS) to enable LED code
Date: Wed, 13 Apr 2016 17:55:30 +0900
Message-ID: <1460537730-23430-1-git-send-email-yamada.masahiro@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-kernel@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
List-Id: linux-mmc@vger.kernel.org

defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
    defined(CONFIG_MMC_SDHCI_MODULE))

is equivalent to:

defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
    defined(MODULE))

and it can also be written shortly as:

IS_REACHABLE(CONFIG_LEDS_CLASS)

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/mmc/host/sdhci.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 6bd3d17..7a4fbe8 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -38,11 +38,6 @@
 #define DBG(f, x...) \
 	pr_debug(DRIVER_NAME " [%s()]: " f, __func__,## x)
 
-#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
-	defined(CONFIG_MMC_SDHCI_MODULE))
-#define SDHCI_USE_LEDS_CLASS
-#endif
-
 #define MAX_TUNING_LOOP 40
 
 static unsigned int debug_quirks = 0;
@@ -270,7 +265,7 @@ static void sdhci_deactivate_led(struct sdhci_host *host)
 	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
 }
 
-#ifdef SDHCI_USE_LEDS_CLASS
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
 static void sdhci_led_control(struct led_classdev *led,
 	enum led_brightness brightness)
 {
@@ -1328,7 +1323,7 @@ static void sdhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 
 	WARN_ON(host->mrq != NULL);
 
-#ifndef SDHCI_USE_LEDS_CLASS
+#if !IS_REACHABLE(CONFIG_LEDS_CLASS)
 	sdhci_activate_led(host);
 #endif
 
@@ -2214,7 +2209,7 @@ static void sdhci_tasklet_finish(unsigned long param)
 	host->cmd = NULL;
 	host->data = NULL;
 
-#ifndef SDHCI_USE_LEDS_CLASS
+#if !IS_REACHABLE(CONFIG_LEDS_CLASS)
 	sdhci_deactivate_led(host);
 #endif
 
@@ -3360,7 +3355,7 @@ int sdhci_add_host(struct sdhci_host *host)
 	sdhci_dumpregs(host);
 #endif
 
-#ifdef SDHCI_USE_LEDS_CLASS
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
 	snprintf(host->led_name, sizeof(host->led_name),
 		"%s::", mmc_hostname(mmc));
 	host->led.name = host->led_name;
@@ -3390,7 +3385,7 @@ int sdhci_add_host(struct sdhci_host *host)
 
 	return 0;
 
-#ifdef SDHCI_USE_LEDS_CLASS
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
 reset:
 	sdhci_do_reset(host, SDHCI_RESET_ALL);
 	sdhci_writel(host, 0, SDHCI_INT_ENABLE);
@@ -3430,7 +3425,7 @@ void sdhci_remove_host(struct sdhci_host *host, int dead)
 
 	mmc_remove_host(mmc);
 
-#ifdef SDHCI_USE_LEDS_CLASS
+#if IS_REACHABLE(CONFIG_LEDS_CLASS)
 	led_classdev_unregister(&host->led);
 #endif
 
-- 
1.9.1
