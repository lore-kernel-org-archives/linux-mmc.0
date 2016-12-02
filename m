From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH 4/4] mmc: pwrseq-simple: add disable-post-power-on option
Date: Thu,  1 Dec 2016 22:17:42 -0800
Message-ID: <1480659462-29536-5-git-send-email-matt@ranostay.consulting>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480659462-29536-1-git-send-email-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Add optional device-post-power-on parameters to disable post_power_on
function from being called since this breaks some device.

Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt | 2 ++
 drivers/mmc/core/pwrseq_simple.c                            | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index bea306d772d1..09fa153f743e 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -24,6 +24,8 @@ Optional properties:
 	de-asserting the reset-gpios (if any)
 - invert-off-state: Invert the power down state for the reset-gpios (if any)
 	and pwrdn-gpios (if any)
+- disable-post-power-on : Avoid post_power_on function from being called since
+	this breaks some devices
 
 Example:
 
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 857dde3e0456..d34084c51f9c 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -26,6 +26,7 @@
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
+	bool disable_post_power_on;
 	bool invert_off_state;
 	u32 pre_power_on_delay_ms;
 	u32 post_power_on_delay_ms;
@@ -72,6 +73,9 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
 
+	if (pwrseq->disable_post_power_on)
+		return;
+
 	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->reset_gpios, 0);
 
 	if (pwrseq->post_power_on_delay_ms)
@@ -139,6 +143,9 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	device_property_read_u32(dev, "post-power-on-delay-ms",
 				 &pwrseq->post_power_on_delay_ms);
 
+	if (device_property_read_bool(dev, "disable-post-power-on"))
+		pwrseq->disable_post_power_on = true;
+
 	pwrseq->pwrseq.dev = dev;
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	pwrseq->pwrseq.owner = THIS_MODULE;
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
