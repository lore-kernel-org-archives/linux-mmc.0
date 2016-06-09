From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFC v4 02/14] simplefb: Use new devm_of_regulator_all_get helper and
 bulk API
Date: Thu, 09 Jun 2016 11:44:19 +0200
Message-ID: <1465465471-28740-3-git-send-email-k.kozlowski@samsung.com>
References: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1465465471-28740-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Hans de Goede <hdegoede@redhat.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Heiko Stuebner <heiko@sntech.de>, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-usb@v
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-mmc@vger.kernel.org

Switch from manual way of getting all regulators to usage of
devm_of_regulator_all_get().  Additionally use the regulator bulk API
which changes the logic in case of failure of regulator enable.  Before
if regulator_enable() returned error for one regulator, rest of them
were still enabled.  The bulk API does everything atomically.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

Not tested.
---
 drivers/video/fbdev/simplefb.c | 71 +++++++++---------------------------------
 1 file changed, 14 insertions(+), 57 deletions(-)

diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplefb.c
index e9cf19977285..897b95efa40d 100644
--- a/drivers/video/fbdev/simplefb.c
+++ b/drivers/video/fbdev/simplefb.c
@@ -32,6 +32,7 @@
 #include <linux/of_platform.h>
 #include <linux/parser.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/of_regulator.h>
 
 static struct fb_fix_screeninfo simplefb_fix = {
 	.id		= "simple",
@@ -178,8 +179,8 @@ struct simplefb_par {
 	struct clk **clks;
 #endif
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
-	u32 regulator_count;
-	struct regulator **regulators;
+	unsigned int regulator_count;
+	struct regulator_bulk_data *regulators;
 #endif
 };
 
@@ -278,8 +279,6 @@ static void simplefb_clocks_destroy(struct simplefb_par *par) { }
 
 #if defined CONFIG_OF && defined CONFIG_REGULATOR
 
-#define SUPPLY_SUFFIX "-supply"
-
 /*
  * Regulator handling code.
  *
@@ -303,61 +302,23 @@ static int simplefb_regulators_init(struct simplefb_par *par,
 	struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
-	struct property *prop;
-	struct regulator *regulator;
-	const char *p;
-	int count = 0, i = 0, ret;
+	int ret;
 
 	if (dev_get_platdata(&pdev->dev) || !np)
 		return 0;
 
-	/* Count the number of regulator supplies */
-	for_each_property_of_node(np, prop) {
-		p = strstr(prop->name, SUPPLY_SUFFIX);
-		if (p && p != prop->name)
-			count++;
-	}
-
-	if (!count)
+	ret = devm_of_regulator_all_get(&pdev->dev, &par->regulator_count, &par->regulators);
+	if (ret)
+		return ret;
+	else if (!par->regulator_count)
 		return 0;
 
-	par->regulators = devm_kcalloc(&pdev->dev, count,
-				       sizeof(struct regulator *), GFP_KERNEL);
-	if (!par->regulators)
-		return -ENOMEM;
-
-	/* Get all the regulators */
-	for_each_property_of_node(np, prop) {
-		char name[32]; /* 32 is max size of property name */
-
-		p = strstr(prop->name, SUPPLY_SUFFIX);
-		if (!p || p == prop->name)
-			continue;
-
-		strlcpy(name, prop->name,
-			strlen(prop->name) - strlen(SUPPLY_SUFFIX) + 1);
-		regulator = devm_regulator_get_optional(&pdev->dev, name);
-		if (IS_ERR(regulator)) {
-			if (PTR_ERR(regulator) == -EPROBE_DEFER)
-				return -EPROBE_DEFER;
-			dev_err(&pdev->dev, "regulator %s not found: %ld\n",
-				name, PTR_ERR(regulator));
-			continue;
-		}
-		par->regulators[i++] = regulator;
-	}
-	par->regulator_count = i;
-
 	/* Enable all the regulators */
-	for (i = 0; i < par->regulator_count; i++) {
-		ret = regulator_enable(par->regulators[i]);
-		if (ret) {
-			dev_err(&pdev->dev,
-				"failed to enable regulator %d: %d\n",
-				i, ret);
-			devm_regulator_put(par->regulators[i]);
-			par->regulators[i] = NULL;
-		}
+	ret = regulator_bulk_enable(par->regulator_count, par->regulators);
+	if (ret) {
+		dev_err(&pdev->dev,
+			"failed to enable regulators: %d\n", ret);
+		return ret;
 	}
 
 	return 0;
@@ -365,14 +326,10 @@ static int simplefb_regulators_init(struct simplefb_par *par,
 
 static void simplefb_regulators_destroy(struct simplefb_par *par)
 {
-	int i;
-
 	if (!par->regulators)
 		return;
 
-	for (i = 0; i < par->regulator_count; i++)
-		if (par->regulators[i])
-			regulator_disable(par->regulators[i]);
+	regulator_bulk_disable(par->regulator_count, par->regulators);
 }
 #else
 static int simplefb_regulators_init(struct simplefb_par *par,
-- 
1.9.1
