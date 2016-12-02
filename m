From: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Subject: [PATCH 3/4] mmc: pwrseq-simple: allow inverting of off state logic
Date: Thu,  1 Dec 2016 22:17:41 -0800
Message-ID: <1480659462-29536-4-git-send-email-matt@ranostay.consulting>
References: <1480659462-29536-1-git-send-email-matt@ranostay.consulting>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1480659462-29536-1-git-send-email-matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Some devices need a logic level low instead of high to be in the
off state.

Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Signed-off-by: Matt Ranostay <matt-sk+viVC6FLCDq+mSdOJa79kegs52MxvZ@public.gmane.org>
---
 .../devicetree/bindings/mmc/mmc-pwrseq-simple.txt         |  2 ++
 drivers/mmc/core/pwrseq_simple.c                          | 15 +++++++++++----
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
index 703a714201d8..bea306d772d1 100644
--- a/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
+++ b/Documentation/devicetree/bindings/mmc/mmc-pwrseq-simple.txt
@@ -22,6 +22,8 @@ Optional properties:
 	the reset-gpios (if any) are asserted
 - post-power-on-delay-ms : Delay in ms after powering the card and
 	de-asserting the reset-gpios (if any)
+- invert-off-state: Invert the power down state for the reset-gpios (if any)
+	and pwrdn-gpios (if any)
 
 Example:
 
diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index adf1f7161fe3..857dde3e0456 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -26,6 +26,7 @@
 struct mmc_pwrseq_simple {
 	struct mmc_pwrseq pwrseq;
 	bool clk_enabled;
+	bool invert_off_state;
 	u32 pre_power_on_delay_ms;
 	u32 post_power_on_delay_ms;
 	struct clk *ext_clk;
@@ -80,9 +81,10 @@ static void mmc_pwrseq_simple_post_power_on(struct mmc_host *host)
 static void mmc_pwrseq_simple_power_off(struct mmc_host *host)
 {
 	struct mmc_pwrseq_simple *pwrseq = to_pwrseq_simple(host->pwrseq);
+	unsigned int off_state = !(pwrseq->invert_off_state);
 
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->reset_gpios, 1);
-	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->pwrdn_gpios, 1);
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->reset_gpios, off_state);
+	mmc_pwrseq_simple_set_gpios_value(pwrseq, pwrseq->pwrdn_gpios, off_state);
 
 	if (!IS_ERR(pwrseq->ext_clk) && pwrseq->clk_enabled) {
 		clk_disable_unprepare(pwrseq->ext_clk);
@@ -107,6 +109,7 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 {
 	struct mmc_pwrseq_simple *pwrseq;
 	struct device *dev = &pdev->dev;
+	bool invert_off_state = false;
 
 	pwrseq = devm_kzalloc(dev, sizeof(*pwrseq), GFP_KERNEL);
 	if (!pwrseq)
@@ -116,8 +119,11 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
 		return PTR_ERR(pwrseq->ext_clk);
 
+	if (device_property_read_bool(dev, "invert-off-state"))
+		invert_off_state = true;
+
 	pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
-							GPIOD_OUT_HIGH);
+			invert_off_state ? GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
 	if (IS_ERR(pwrseq->reset_gpios) &&
 	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
 	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
@@ -125,7 +131,7 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	}
 
 	pwrseq->pwrdn_gpios = devm_gpiod_get_array(dev, "pwrdn",
-							GPIOD_OUT_HIGH);
+			invert_off_state ? GPIOD_OUT_LOW : GPIOD_OUT_HIGH);
 
 	device_property_read_u32(dev, "pre-power-on-delay-ms",
 				 &pwrseq->pre_power_on_delay_ms);
@@ -136,6 +142,7 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 	pwrseq->pwrseq.dev = dev;
 	pwrseq->pwrseq.ops = &mmc_pwrseq_simple_ops;
 	pwrseq->pwrseq.owner = THIS_MODULE;
+	pwrseq->invert_off_state = invert_off_state;
 	platform_set_drvdata(pdev, pwrseq);
 
 	return mmc_pwrseq_register(&pwrseq->pwrseq);
-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
