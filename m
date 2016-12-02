From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH 1/4] mmc: pwrseq-simple: add an optional pre-power-on-delay
Date: Thu,  1 Dec 2016 22:17:39 -0800
Message-ID: <1480659462-29536-2-git-send-email-matt@ranostay.consulting>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480659462-29536-1-git-send-email-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some devices need some time between asserting reset-gpios before can
receive sdio commands.

This commits adds a pre-power-on-delay-ms devicetree property to
mmc-pwrseq-simple for use with such devices.

Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
 drivers/mmc/core/pwrseq_simple.c                            | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index e25436861867..88826f7d1d38 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -16,6 +16,8 @@ Optional properties:
   See ../clocks/clock-bindings.txt for details.
 - clock-names : Must include the following entry:
   "ext_clock" (External clock provided to the card).
+- pre-power-on-delay-ms : Delay in ms before powering the card which
+	the reset-gpios (if any) are asserted
 - post-power-on-delay-ms : Delay in ms after powering the card and
 	de-asserting the reset-gpios (if any)
 
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 1304160de168..cb2ba7b11383 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -26,6 +26,7 @@
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
+	u32 pre_power_on_delay_ms;
 	u32 post_power_on_delay_ms;
 	struct clk *ext_clk;
 	struct gpio_descs *reset_gpios;
@@ -60,6 +61,9 @@ static void mmc_pwrseq_simple_pre_power_on(struct mmc_host *host)
 	}
 
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, 1);
+
+	if (pwrseq->pre_power_on_delay_ms)
+		msleep(pwrseq->pre_power_on_delay_ms);
 }
 
 static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
@@ -117,6 +121,9 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 		return PTR_ERR(pwrseq->reset_gpios);
 	}
 
+	device_property_read_u32(dev, "pre-power-on-delay-ms",
+				 &pwrseq->pre_power_on_delay_ms);
+
 	device_property_read_u32(dev, "post-power-on-delay-ms",
 				 &pwrseq->post_power_on_delay_ms);
 
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
