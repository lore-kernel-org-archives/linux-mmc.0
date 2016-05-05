From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v2 02/13] power/mmc: Move pwrseq drivers to power/pwrseq
Date: Thu, 05 May 2016 14:34:15 +0200
Message-ID: <1462451666-17945-3-git-send-email-k.kozlowski@samsung.com>
References: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-reply-to: <1462451666-17945-1-git-send-email-k.kozlowski@samsung.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-mmc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>
Cc: hverkuil@xs4all.nl, tjakobi@math.uni-bielefeld.de, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, m.szyprowski@samsung.com
List-Id: linux-mmc@vger.kernel.org

The MMC power sequence drivers are useful also outside of MMC world: for
USB devices needed a hard-reset before probing. Before extending and
re-using pwrseq drivers, move them to a new place.

The commit does not introduce significant changes in the pwrseq drivers
code so still all the functions are prefixed with "mmc_pwrseq". However
the MMC-specific pwrseq functions has to be now exported and everything
is hidden not by CONFIG_OF but by new CONFIG_POWER_SEQ option.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 drivers/mmc/Kconfig                                |  2 --
 drivers/mmc/core/Makefile                          |  3 ---
 drivers/mmc/core/core.c                            |  2 +-
 drivers/mmc/core/host.c                            |  2 +-
 drivers/power/Kconfig                              |  1 +
 drivers/power/Makefile                             |  1 +
 drivers/{mmc/core => power/pwrseq}/Kconfig         | 17 ++++++++++++-----
 drivers/power/pwrseq/Makefile                      |  3 +++
 drivers/{mmc/core => power/pwrseq}/pwrseq.c        |  8 ++++++--
 drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c   |  3 +--
 drivers/{mmc/core => power/pwrseq}/pwrseq_simple.c |  3 +--
 {drivers/mmc/core => include/linux}/pwrseq.h       |  6 +++---
 12 files changed, 30 insertions(+), 21 deletions(-)
 rename drivers/{mmc/core => power/pwrseq}/Kconfig (71%)
 create mode 100644 drivers/power/pwrseq/Makefile
 rename drivers/{mmc/core => power/pwrseq}/pwrseq.c (90%)
 rename drivers/{mmc/core => power/pwrseq}/pwrseq_emmc.c (99%)
 rename drivers/{mmc/core => power/pwrseq}/pwrseq_simple.c (99%)
 rename {drivers/mmc/core => include/linux}/pwrseq.h (94%)

diff --git a/drivers/mmc/Kconfig b/drivers/mmc/Kconfig
index f2eeb38efa65..7ade379e0634 100644
--- a/drivers/mmc/Kconfig
+++ b/drivers/mmc/Kconfig
@@ -21,8 +21,6 @@ config MMC_DEBUG
 
 if MMC
 
-source "drivers/mmc/core/Kconfig"
-
 source "drivers/mmc/card/Kconfig"
 
 source "drivers/mmc/host/Kconfig"
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index f007151dfdc6..a901d3cd09d3 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -8,7 +8,4 @@ mmc_core-y			:= core.o bus.o host.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
 				   quirks.o slot-gpio.o
-mmc_core-$(CONFIG_OF)		+= pwrseq.o
-obj-$(CONFIG_PWRSEQ_SIMPLE)	+= pwrseq_simple.o
-obj-$(CONFIG_PWRSEQ_EMMC)	+= pwrseq_emmc.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 99275e40bf2f..0f145ff6e4f1 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -25,6 +25,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeup.h>
 #include <linux/suspend.h>
+#include <linux/pwrseq.h>
 #include <linux/fault-inject.h>
 #include <linux/random.h>
 #include <linux/slab.h>
@@ -43,7 +44,6 @@
 #include "bus.h"
 #include "host.h"
 #include "sdio_bus.h"
-#include "pwrseq.h"
 
 #include "mmc_ops.h"
 #include "sd_ops.h"
diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
index e0a3ee16c0d3..98164a352dfb 100644
--- a/drivers/mmc/core/host.c
+++ b/drivers/mmc/core/host.c
@@ -21,6 +21,7 @@
 #include <linux/export.h>
 #include <linux/leds.h>
 #include <linux/slab.h>
+#include <linux/pwrseq.h>
 
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -29,7 +30,6 @@
 #include "core.h"
 #include "host.h"
 #include "slot-gpio.h"
-#include "pwrseq.h"
 
 #define cls_dev_to_mmc_host(d)	container_of(d, struct mmc_host, class_dev)
 
diff --git a/drivers/power/Kconfig b/drivers/power/Kconfig
index 421770ddafa3..2702aca6cd2c 100644
--- a/drivers/power/Kconfig
+++ b/drivers/power/Kconfig
@@ -511,5 +511,6 @@ config AXP20X_POWER
 
 endif # POWER_SUPPLY
 
+source "drivers/power/pwrseq/Kconfig"
 source "drivers/power/reset/Kconfig"
 source "drivers/power/avs/Kconfig"
diff --git a/drivers/power/Makefile b/drivers/power/Makefile
index e46b75d448a5..02f9d5da2e76 100644
--- a/drivers/power/Makefile
+++ b/drivers/power/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_POWER_AVS)		+= avs/
 obj-$(CONFIG_CHARGER_SMB347)	+= smb347-charger.o
 obj-$(CONFIG_CHARGER_TPS65090)	+= tps65090-charger.o
 obj-$(CONFIG_CHARGER_TPS65217)	+= tps65217_charger.o
+obj-$(CONFIG_POWER_SEQ)		+= pwrseq/
 obj-$(CONFIG_POWER_RESET)	+= reset/
 obj-$(CONFIG_AXP288_FUEL_GAUGE) += axp288_fuel_gauge.o
 obj-$(CONFIG_AXP288_CHARGER)	+= axp288_charger.o
diff --git a/drivers/mmc/core/Kconfig b/drivers/power/pwrseq/Kconfig
similarity index 71%
rename from drivers/mmc/core/Kconfig
rename to drivers/power/pwrseq/Kconfig
index 250f223aaa80..b5d2d6c65f28 100644
--- a/drivers/mmc/core/Kconfig
+++ b/drivers/power/pwrseq/Kconfig
@@ -1,7 +1,12 @@
-#
-# MMC core configuration
-#
-config PWRSEQ_EMMC
+menuconfig POWER_SEQ
+	default y if OF
+	bool "Hardware reset support for specific devices"
+	help
+	  Provides drivers which reset the specific device before...
+
+if POWER_SEQ
+
+config POWER_SEQ_EMMC
 	tristate "HW reset support for eMMC"
 	default y
 	depends on OF
@@ -12,7 +17,7 @@ config PWRSEQ_EMMC
 	  This driver can also be built as a module. If so, the module
 	  will be called pwrseq_emmc.
 
-config PWRSEQ_SIMPLE
+config POWER_SEQ_SIMPLE
 	tristate "Simple HW reset support for MMC"
 	default y
 	depends on OF
@@ -22,3 +27,5 @@ config PWRSEQ_SIMPLE
 
 	  This driver can also be built as a module. If so, the module
 	  will be called pwrseq_simple.
+
+endif
diff --git a/drivers/power/pwrseq/Makefile b/drivers/power/pwrseq/Makefile
new file mode 100644
index 000000000000..9e40e4b9068b
--- /dev/null
+++ b/drivers/power/pwrseq/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_POWER_SEQ)		+= pwrseq.o
+obj-$(CONFIG_POWER_SEQ_SIMPLE)	+= pwrseq_simple.o
+obj-$(CONFIG_POWER_SEQ_EMMC)	+= pwrseq_emmc.o
diff --git a/drivers/mmc/core/pwrseq.c b/drivers/power/pwrseq/pwrseq.c
similarity index 90%
rename from drivers/mmc/core/pwrseq.c
rename to drivers/power/pwrseq/pwrseq.c
index 9386c4771814..66310d7643cc 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/power/pwrseq/pwrseq.c
@@ -11,11 +11,10 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/pwrseq.h>
 
 #include <linux/mmc/host.h>
 
-#include "pwrseq.h"
-
 static DEFINE_MUTEX(pwrseq_list_mutex);
 static LIST_HEAD(pwrseq_list);
 
@@ -51,6 +50,7 @@ int mmc_pwrseq_alloc(struct mmc_host *host)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(mmc_pwrseq_alloc);
 
 void mmc_pwrseq_pre_power_on(struct mmc_host *host)
 {
@@ -59,6 +59,7 @@ void mmc_pwrseq_pre_power_on(struct mmc_host *host)
 	if (pwrseq && pwrseq->ops->pre_power_on)
 		pwrseq->ops->pre_power_on(host);
 }
+EXPORT_SYMBOL_GPL(mmc_pwrseq_pre_power_on);
 
 void mmc_pwrseq_post_power_on(struct mmc_host *host)
 {
@@ -67,6 +68,7 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host)
 	if (pwrseq && pwrseq->ops->post_power_on)
 		pwrseq->ops->post_power_on(host);
 }
+EXPORT_SYMBOL_GPL(mmc_pwrseq_post_power_on);
 
 void mmc_pwrseq_power_off(struct mmc_host *host)
 {
@@ -75,6 +77,7 @@ void mmc_pwrseq_power_off(struct mmc_host *host)
 	if (pwrseq && pwrseq->ops->power_off)
 		pwrseq->ops->power_off(host);
 }
+EXPORT_SYMBOL_GPL(mmc_pwrseq_power_off);
 
 void mmc_pwrseq_free(struct mmc_host *host)
 {
@@ -85,6 +88,7 @@ void mmc_pwrseq_free(struct mmc_host *host)
 		host->pwrseq = NULL;
 	}
 }
+EXPORT_SYMBOL_GPL(mmc_pwrseq_free);
 
 int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
 {
diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/power/pwrseq/pwrseq_emmc.c
similarity index 99%
rename from drivers/mmc/core/pwrseq_emmc.c
rename to drivers/power/pwrseq/pwrseq_emmc.c
index adc9c0c614fb..a0583ed46d7f 100644
--- a/drivers/mmc/core/pwrseq_emmc.c
+++ b/drivers/power/pwrseq/pwrseq_emmc.c
@@ -17,11 +17,10 @@
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
 #include <linux/reboot.h>
+#include <linux/pwrseq.h>
 
 #include <linux/mmc/host.h>
 
-#include "pwrseq.h"
-
 struct mmc_pwrseq_emmc {
 	struct mmc_pwrseq pwrseq;
 	struct notifier_block reset_nb;
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/power/pwrseq/pwrseq_simple.c
similarity index 99%
rename from drivers/mmc/core/pwrseq_simple.c
rename to drivers/power/pwrseq/pwrseq_simple.c
index 450d907c6e6c..786f1db53a3f 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/power/pwrseq/pwrseq_simple.c
@@ -16,11 +16,10 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/pwrseq.h>
 
 #include <linux/mmc/host.h>
 
-#include "pwrseq.h"
-
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
diff --git a/drivers/mmc/core/pwrseq.h b/include/linux/pwrseq.h
similarity index 94%
rename from drivers/mmc/core/pwrseq.h
rename to include/linux/pwrseq.h
index d69e751f148b..e230670c1d8d 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/include/linux/pwrseq.h
@@ -23,7 +23,7 @@ struct mmc_pwrseq {
 	struct module *owner;
 };
 
-#ifdef CONFIG_OF
+#ifdef CONFIG_POWER_SEQ
 
 int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq);
 void mmc_pwrseq_unregister(struct mmc_pwrseq *pwrseq);
@@ -34,7 +34,7 @@ void mmc_pwrseq_post_power_on(struct mmc_host *host);
 void mmc_pwrseq_power_off(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
-#else
+#else /* CONFIG_POWER_SEQ */
 
 static inline int mmc_pwrseq_register(struct mmc_pwrseq *pwrseq)
 {
@@ -47,6 +47,6 @@ static inline void mmc_pwrseq_post_power_on(struct mmc_host *host) {}
 static inline void mmc_pwrseq_power_off(struct mmc_host *host) {}
 static inline void mmc_pwrseq_free(struct mmc_host *host) {}
 
-#endif
+#endif /* CONFIG_POWER_SEQ */
 
 #endif
-- 
1.9.1
