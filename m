From: Thomas Abraham <thomas.abraham@linaro.org>
Subject: [PATCH v3] mmc: dw_mmc: let device core setup the default pin
 configuration
Date: Fri, 05 Apr 2013 19:23:35 +0530
Message-ID: <1365170015-3009-1-git-send-email-thomas.abraham@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org, heiko@sntech.de, patches@linaro.org, tgih.jun@samsung.com, t.figa@samsung.com, jh80.chung@samsung.com, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, cjb@laptop.org, linus.walleij@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

With device core now able to setup the default pin configuration,
the pin configuration code based on the deprecated Samsung specific
gpio bindings is removed.

Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
---
Changes since v2:
- Changed patch subject from "mmc: dwmmc: let..." to "mmc: dw_mmc: let..."
- Rebased to Chris's latest mmc-next branch.

 drivers/mmc/host/dw_mmc-exynos.c |   38 --------------------------------------
 drivers/mmc/host/dw_mmc.c        |   12 ++----------
 drivers/mmc/host/dw_mmc.h        |    3 ---
 3 files changed, 2 insertions(+), 51 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc-exynos.c b/drivers/mmc/host/dw_mmc-exynos.c
index c7f0976..f013e7e 100644
--- a/drivers/mmc/host/dw_mmc-exynos.c
+++ b/drivers/mmc/host/dw_mmc-exynos.c
@@ -152,43 +152,6 @@ static int dw_mci_exynos_parse_dt(struct dw_mci *host)
 	return 0;
 }
 
-static int dw_mci_exynos_setup_bus(struct dw_mci *host,
-				struct device_node *slot_np, u8 bus_width)
-{
-	int idx, gpio, ret;
-
-	if (!slot_np)
-		return -EINVAL;
-
-	/* cmd + clock + bus-width pins */
-	for (idx = 0; idx < NUM_PINS(bus_width); idx++) {
-		gpio = of_get_gpio(slot_np, idx);
-		if (!gpio_is_valid(gpio)) {
-			dev_err(host->dev, "invalid gpio: %d\n", gpio);
-			return -EINVAL;
-		}
-
-		ret = devm_gpio_request(host->dev, gpio, "dw-mci-bus");
-		if (ret) {
-			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
-			return -EBUSY;
-		}
-	}
-
-	if (host->pdata->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
-		return 0;
-
-	gpio = of_get_named_gpio(slot_np, "samsung,cd-pinmux-gpio", 0);
-	if (gpio_is_valid(gpio)) {
-		if (devm_gpio_request(host->dev, gpio, "dw-mci-cd"))
-			dev_err(host->dev, "gpio [%d] request failed\n", gpio);
-	} else {
-		dev_info(host->dev, "cd gpio not available");
-	}
-
-	return 0;
-}
-
 /* Common capabilities of Exynos4/Exynos5 SoC */
 static unsigned long exynos_dwmmc_caps[4] = {
 	MMC_CAP_UHS_DDR50 | MMC_CAP_1_8V_DDR |
@@ -205,7 +168,6 @@ static const struct dw_mci_drv_data exynos_drv_data = {
 	.prepare_command	= dw_mci_exynos_prepare_command,
 	.set_ios		= dw_mci_exynos_set_ios,
 	.parse_dt		= dw_mci_exynos_parse_dt,
-	.setup_bus		= dw_mci_exynos_setup_bus,
 };
 
 static const struct of_device_id dw_mci_exynos_match[] = {
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index a443820..2ed9989 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1945,14 +1945,6 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 	else
 		bus_width = 1;
 
-	if (drv_data && drv_data->setup_bus) {
-		struct device_node *slot_np;
-		slot_np = dw_mci_of_find_slot_node(host->dev, slot->id);
-		ret = drv_data->setup_bus(host, slot_np, bus_width);
-		if (ret)
-			goto err_setup_bus;
-	}
-
 	switch (bus_width) {
 	case 8:
 		mmc->caps |= MMC_CAP_8_BIT_DATA;
@@ -2002,7 +1994,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 	ret = mmc_add_host(mmc);
 	if (ret)
-		goto err_setup_bus;
+		goto err_add_host;
 
 #if defined(CONFIG_DEBUG_FS)
 	dw_mci_init_debugfs(slot);
@@ -2019,7 +2011,7 @@ static int dw_mci_init_slot(struct dw_mci *host, unsigned int id)
 
 	return 0;
 
-err_setup_bus:
+err_add_host:
 	mmc_free_host(mmc);
 	return -EINVAL;
 }
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 53b8fd9..0b74189 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -190,7 +190,6 @@ extern int dw_mci_resume(struct dw_mci *host);
  * @prepare_command: handle CMD register extensions.
  * @set_ios: handle bus specific extensions.
  * @parse_dt: parse implementation specific device tree properties.
- * @setup_bus: initialize io-interface
  *
  * Provide controller implementation specific extensions. The usage of this
  * data structure is fully optional and usage of each member in this structure
@@ -203,7 +202,5 @@ struct dw_mci_drv_data {
 	void		(*prepare_command)(struct dw_mci *host, u32 *cmdr);
 	void		(*set_ios)(struct dw_mci *host, struct mmc_ios *ios);
 	int		(*parse_dt)(struct dw_mci *host);
-	int		(*setup_bus)(struct dw_mci *host,
-				struct device_node *slot_np, u8 bus_width);
 };
 #endif /* _DW_MMC_H_ */
-- 
1.6.6.rc2
