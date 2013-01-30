From: Jan Luebbe <jlu@pengutronix.de>
Subject: [PATCH] mmc: omap_hsmmc: support deferred probing for GPIOs
Date: Wed, 30 Jan 2013 10:07:17 +0100
Message-ID: <1359536837-14874-1-git-send-email-jlu@pengutronix.de>
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Venkatraman S <svenkatr@ti.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Jan Luebbe <jlu@pengutronix.de>
List-Id: linux-mmc@vger.kernel.org

If the CD/WP-GPIOs are not provided by the SoC's GPIO controller,
we need to handle the case where omap_hsmmc is probed earlier than
the GPIO controller chosen in the device tree.

Fix this by checking the return value of of_get_named_gpio against
-EPROBE_DEFER and passing it through to the probe function.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---

I've tested this on an AM335x based board which uses an external
GPIO expander.

 drivers/mmc/host/omap_hsmmc.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index e30c1ee..fd1b342 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1717,6 +1717,12 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 	struct omap_mmc_platform_data *pdata;
 	struct device_node *np = dev->of_node;
 	u32 bus_width, max_freq;
+	int cd_gpio, wp_gpio;
+
+	cd_gpio = of_get_named_gpio(np, "cd-gpios", 0);
+	wp_gpio = of_get_named_gpio(np, "wp-gpios", 0);
+	if (cd_gpio == -EPROBE_DEFER || wp_gpio == -EPROBE_DEFER)
+		return ERR_PTR(-EPROBE_DEFER);
 
 	pdata = devm_kzalloc(dev, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
@@ -1727,8 +1733,8 @@ static struct omap_mmc_platform_data *of_get_hsmmc_pdata(struct device *dev)
 
 	/* This driver only supports 1 slot */
 	pdata->nr_slots = 1;
-	pdata->slots[0].switch_pin = of_get_named_gpio(np, "cd-gpios", 0);
-	pdata->slots[0].gpio_wp = of_get_named_gpio(np, "wp-gpios", 0);
+	pdata->slots[0].switch_pin = cd_gpio;
+	pdata->slots[0].gpio_wp = wp_gpio;
 
 	if (of_find_property(np, "ti,non-removable", NULL)) {
 		pdata->slots[0].nonremovable = true;
@@ -1775,6 +1781,10 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
 		pdata = of_get_hsmmc_pdata(&pdev->dev);
+
+		if (IS_ERR(pdata))
+			return PTR_ERR(pdata);
+
 		if (match->data) {
 			const u16 *offsetp = match->data;
 			pdata->reg_offset = *offsetp;
-- 
1.7.10.4

