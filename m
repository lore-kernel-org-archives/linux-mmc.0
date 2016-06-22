From: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH] mmc: pwrseq-simple: Add an optional post-power-on-delay
Date: Wed, 22 Jun 2016 19:59:08 +0200
Message-ID: <1466618348-32304-1-git-send-email-hdegoede@redhat.com>
Reply-To: hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDRZXY4CYYORB5VDVO5QKGQE7R2YZYY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Srinivas Kandagatla <srinivas.kandagatla-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some devices need a while to boot their firmware after providing clks /
de-asserting resets before they are ready to receive sdio commands.

This commits adds a post-power-on-delay-ms devicetree property to
mmc-pwrseq-simple for use with such devices.

Signed-off-by: Hans de Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
 drivers/mmc/core/pwrseq_simple.c                            | 9 +++++++++
 2 files changed, 11 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index ce0e767..e254368 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -16,6 +16,8 @@ Optional properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entry:
   "ext_clock" (External clock provided to the card).
+- post-power-on-delay-ms : Delay in ms after powering the card and
+	de-asserting the reset-gpios (if any)
 
 Example:
 
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 450d907..1304160 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -16,6 +16,8 @@
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/gpio/consumer.h>
+#include <linux/delay.h>
+#include <linux/property.h>
 
 #include <linux/mmc/host.h>
 
@@ -24,6 +26,7 @@
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
+	u32 post_power_on_delay_ms;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
 };
@@ -64,6 +67,9 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 0);
+
+	if (pwrseq->post_power_on_delay_ms)
+		msleep(pwrseq->post_power_on_delay_ms);
 }
 
 static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
@@ -111,6 +117,9 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 		return PTR_ERR(pwrseq->reset_gpios);
 	}
 
+	device_property_read_u32(dev, "post-power-on-delay-ms",
+				 &pwrseq->post_power_on_delay_ms);
+
 	pwrseq->pwrseq.dev = dev;
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	pwrseq->pwrseq.owner = THIS_MODULE;
-- 
2.7.4
