From: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Subject: [PATCH v2 08/11] mmc: pwrseq_simple: Add support for a delay
Date: Thu, 15 Jan 2015 17:12:20 +0100
Message-ID: <1421338359-27467-9-git-send-email-tomeu.vizoso@collabora.com>
References: <1421338359-27467-1-git-send-email-tomeu.vizoso@collabora.com>
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1421338359-27467-1-git-send-email-tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Javier Martinez Canillas <javier.martinez-ZGY8ohtN/8pPYcu2f3hruQ@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Simon Glass <sjg-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Tomeu Vizoso <tomeu.vizoso-ZGY8ohtN/8qB+jHODAdFcQ@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt | 2 ++
 drivers/mmc/core/pwrseq_simple.c                            | 8 ++++++++
 2 files changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
index 6fe0cd6..b353381 100644
--- a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
@@ -14,10 +14,12 @@ Required properties:
 Optional properties:
 - reset-gpios : contains a list of GPIO specifiers, though currently only one
 		specifier is supported.
+- delay : delay to wait after driving the reset gpio active [ms].
 
 Example:
 
 	sdhci0_pwrseq {
 		compatible = "mmc,pwrseq-simple";
 		reset-gpios = <&gpio1 12 0>;
+		delay = <20>;
 	}
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 42d9836..3e521cc 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -12,14 +12,17 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/of_platform.h>
 
 #include <linux/mmc/host.h>
 
+#include "core.h"
 #include "pwrseq.h"
 
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	struct gpio_desc *reset_gpio;
+	unsigned int delay_ms;
 };
 
 static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
@@ -29,6 +32,9 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 
 	if (!IS_ERR(pwrseq->reset_gpio))
 		gpiod_set_value_cansleep(pwrseq->reset_gpio, 1);
+
+	if (pwrseq->delay_ms)
+		mmc_delay(pwrseq->delay_ms);
 }
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
@@ -76,6 +82,8 @@ int mmc_pwrseq_simple_alloc(struct mmc_host *host, struct device *dev)
 		goto free;
 	}
 
+	of_property_read_u32(dev->of_node, "delay", &pwrseq->delay_ms);
+
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	host->pwrseq = &pwrseq->pwrseq;
 
-- 
1.9.3
