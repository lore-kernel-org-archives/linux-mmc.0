From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v4 1/3] mmc: pwrseq: add driver for emmc hardware reset
Date: Tue, 03 Feb 2015 14:07:53 +0100
Message-ID: <1422968873-15991-1-git-send-email-m.szyprowski@samsung.com>
References: <CAPDyKFr0YxFXSvknUE=CPbDwge0uSN0JJMCM=aP+JrXAMnFHCA@mail.gmail.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAPDyKFr0YxFXSvknUE=CPbDwge0uSN0JJMCM=aP+JrXAMnFHCA@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Tobias Jakobi <liquid.acid@gmx.net>, Daniel Drake <drake@endlessm.com>, Sebastian Reichel <sre@kernel.org>, Seungwon Jeon <tgih.jun@samsung.com>, Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Chris Ball <chris@printf.net>, Joonyoung Shim <jy0922.shim@samsung.com>, Javier Martinez Canillas <javier@dowhile0.org>
List-Id: linux-mmc@vger.kernel.org

This patch provides a simple mmc-pwrseq-emmc driver, which controls
single gpio line. It perform standard eMMC hw reset procedure, as
descibed by Jedec 4.4 specification. This procedure is performed just
after MMC core enabled power to the given mmc host (to fix possible
issues if bootloader has left eMMC card in initialized or unknown
state), and before performing complete system reboot (also in case of
emergency reboot call). The latter is needed on boards, which doesn't
have hardware reset logic connected to emmc card and (limited or broken)
ROM bootloaders are unable to read second stage from the emmc card if
the card is left in unknown or already initialized state.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changelog:
v4:
- fixed minor issues reported by Ulf Hansson (comment adjustments,
  removed .shutdown callback, reduced delay time)

v3: http://www.spinics.net/lists/linux-samsung-soc/msg41956.html
- removed optional support for reset-gpio, reported by Javier Martinez Canillas

v2: http://www.spinics.net/lists/linux-mmc/msg30621.html
---
 .../devicetree/bindings/mmc/mmc-pwrseq-emmc.txt    |  25 +++++
 drivers/mmc/core/Makefile                          |   2 +-
 drivers/mmc/core/pwrseq.c                          |   3 +
 drivers/mmc/core/pwrseq.h                          |   1 +
 drivers/mmc/core/pwrseq_emmc.c                     | 101 +++++++++++++++++++++
 5 files changed, 131 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
 create mode 100644 drivers/mmc/core/pwrseq_emmc.c

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
new file mode 100644
index 0000000..0cb827b
--- /dev/null
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-emmc.txt
@@ -0,0 +1,25 @@
+* The simple eMMC hardware reset provider
+
+The purpose of this driver is to perform standard eMMC hw reset
+procedure, as descibed by Jedec 4.4 specification. This procedure is
+performed just after MMC core enabled power to the given mmc host (to
+fix possible issues if bootloader has left eMMC card in initialized or
+unknown state), and before performing complete system reboot (also in
+case of emergency reboot call). The latter is needed on boards, which
+doesn't have hardware reset logic connected to emmc card and (limited or
+broken) ROM bootloaders are unable to read second stage from the emmc
+card if the card is left in unknown or already initialized state.
+
+Required properties:
+- compatible : contains "mmc-pwrseq-emmc".
+- reset-gpios : contains a GPIO specifier. The reset GPIO is asserted
+	and then deasserted to perform eMMC card reset. To perform
+	reset procedure as described in Jedec 4.4 specification, the
+	gpio line should be defined as GPIO_ACTIVE_LOW.
+
+Example:
+
+	sdhci0_pwrseq {
+		compatible = "mmc-pwrseq-emmc";
+		reset-gpios = <&gpio1 12 GPIO_ACTIVE_LOW>;
+	}
diff --git a/drivers/mmc/core/Makefile b/drivers/mmc/core/Makefile
index b39cbd2..2c25138 100644
--- a/drivers/mmc/core/Makefile
+++ b/drivers/mmc/core/Makefile
@@ -8,5 +8,5 @@ mmc_core-y			:= core.o bus.o host.o \
 				   sdio.o sdio_ops.o sdio_bus.o \
 				   sdio_cis.o sdio_io.o sdio_irq.o \
 				   quirks.o slot-gpio.o
-mmc_core-$(CONFIG_OF)		+= pwrseq.o pwrseq_simple.o
+mmc_core-$(CONFIG_OF)		+= pwrseq.o pwrseq_simple.o pwrseq_emmc.o
 mmc_core-$(CONFIG_DEBUG_FS)	+= debugfs.o
diff --git a/drivers/mmc/core/pwrseq.c b/drivers/mmc/core/pwrseq.c
index 2cea00e..8623561 100644
--- a/drivers/mmc/core/pwrseq.c
+++ b/drivers/mmc/core/pwrseq.c
@@ -26,6 +26,9 @@ static struct mmc_pwrseq_match pwrseq_match[] = {
 	{
 		.compatible = "mmc-pwrseq-simple",
 		.alloc = mmc_pwrseq_simple_alloc,
+	}, {
+		.compatible = "mmc-pwrseq-emmc",
+		.alloc = mmc_pwrseq_emmc_alloc,
 	},
 };
 
diff --git a/drivers/mmc/core/pwrseq.h b/drivers/mmc/core/pwrseq.h
index bd860d8..aba3409 100644
--- a/drivers/mmc/core/pwrseq.h
+++ b/drivers/mmc/core/pwrseq.h
@@ -28,6 +28,7 @@ void mmc_pwrseq_power_off(struct mmc_host *host);
 void mmc_pwrseq_free(struct mmc_host *host);
 
 int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev);
+int mmc_pwrseq_emmc_alloc(struct mmc_host *host, struct device *dev);
 
 #else
 
diff --git a/drivers/mmc/core/pwrseq_emmc.c b/drivers/mmc/core/pwrseq_emmc.c
new file mode 100644
index 0000000..8a434d7
--- /dev/null
+++ b/drivers/mmc/core/pwrseq_emmc.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright (C) 2015, Samsung Electronics Co., Ltd.
+ *
+ * Author: Marek Szyprowski <m.szyprowski@samsung.com>
+ *
+ * License terms: GNU General Public License (GPL) version 2
+ *
+ * Simple eMMC hardware reset provider
+ */
+#include <linux/delay.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/reboot.h>
+
+#include <linux/mmc/host.h>
+
+#include "pwrseq.h"
+
+struct mmc_pwrseq_emmc {
+	struct mmc_pwrseq pwrseq;
+	struct notifier_block reset_nb;
+	struct gpio_desc *reset_gpio;
+};
+
+static void __mmc_pwrseq_emmc_reset(struct mmc_pwrseq_emmc *pwrseq)
+{
+	gpiod_set_value(pwrseq->reset_gpio, 1);
+	udelay(1);
+	gpiod_set_value(pwrseq->reset_gpio, 0);
+	udelay(200);
+}
+
+static void mmc_pwrseq_emmc_reset(struct mmc_host *host)
+{
+	struct mmc_pwrseq_emmc *pwrseq = container_of(host->pwrseq,
+					struct mmc_pwrseq_emmc, pwrseq);
+
+	__mmc_pwrseq_emmc_reset(pwrseq);
+}
+
+static void mmc_pwrseq_emmc_free(struct mmc_host *host)
+{
+	struct mmc_pwrseq_emmc *pwrseq = container_of(host->pwrseq,
+					struct mmc_pwrseq_emmc, pwrseq);
+
+	unregister_restart_handler(&pwrseq->reset_nb);
+	gpiod_put(pwrseq->reset_gpio);
+	kfree(pwrseq);
+	host->pwrseq = NULL;
+}
+
+static struct mmc_pwrseq_ops mmc_pwrseq_emmc_ops = {
+	.post_power_on = mmc_pwrseq_emmc_reset,
+	.free = mmc_pwrseq_emmc_free,
+};
+
+static int mmc_pwrseq_emmc_reset_nb(struct notifier_block *this,
+				    unsigned long mode, void *cmd)
+{
+	struct mmc_pwrseq_emmc *pwrseq;
+	pwrseq = container_of(this, struct mmc_pwrseq_emmc, reset_nb);
+
+	__mmc_pwrseq_emmc_reset(pwrseq);
+	return NOTIFY_DONE;
+}
+
+int mmc_pwrseq_emmc_alloc(struct mmc_host *host, struct device *dev)
+{
+	struct mmc_pwrseq_emmc *pwrseq;
+	int ret = 0;
+
+	pwrseq = kzalloc(sizeof(struct mmc_pwrseq_emmc), GFP_KERNEL);
+	if (!pwrseq)
+		return -ENOMEM;
+
+	pwrseq->reset_gpio = gpiod_get_index(dev, "reset", 0, GPIOD_OUT_LOW);
+	if (IS_ERR(pwrseq->reset_gpio)) {
+		ret = PTR_ERR(pwrseq->reset_gpio);
+		goto free;
+	}
+
+	/*
+	 * register reset handler to ensure emmc reset also from
+	 * emergency_reboot(), priority 129 schedules it just before
+	 * system reboot
+	 */
+	pwrseq->reset_nb.notifier_call = mmc_pwrseq_emmc_reset_nb;
+	pwrseq->reset_nb.priority = 129;
+	register_restart_handler(&pwrseq->reset_nb);
+
+	pwrseq->pwrseq.ops = &mmc_pwrseq_emmc_ops;
+	host->pwrseq = &pwrseq->pwrseq;
+
+	return 0;
+free:
+	kfree(pwrseq);
+	return ret;
+}
-- 
1.9.2
