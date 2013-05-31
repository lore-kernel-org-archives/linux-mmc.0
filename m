From: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Subject: [PATCH 09/11] mmc: omap_hsmmc: enhance pinctrl support
Date: Fri, 31 May 2013 15:43:09 +0530
Message-ID: <1369995191-20855-10-git-send-email-gururaja.hebbar@ti.com>
References: <1369995191-20855-1-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
In-Reply-To: <1369995191-20855-1-git-send-email-gururaja.hebbar-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss/>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: "devicetree-discuss"
 <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
To: khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, sudhakar.raj-l0cyMroinI0@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, vaibhav.bedia-l0cyMroinI0@public.gmane.org, gururaja.hebbar-l0cyMroinI0@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Amend the hsmmc controller to optionally take a pin control handle and
set the state of the pins to:

- "default" on boot, resume and before performing a mmc transfer
- "idle" after initial default, after resume default, and after each
mmc/sd card access
- "sleep" on suspend()

By optionally putting the pins into sleep state in the suspend callback
we can accomplish two things.
- One is to minimize current leakage from pins and thus save power,
- second, we can prevent the IP from driving pins output in an
uncontrolled manner, which may happen if the power domain drops the
domain regulator.

If any of the above pin states are missing in dt, a warning message
about the missing state is displayed.
If certain pin-states are not available, to remove this warning message
pass respective state name with null phandler.

Signed-off-by: Hebbar Gururaja <gururaja.hebbar-l0cyMroinI0@public.gmane.org>
Cc: Balaji T K <balajitk-l0cyMroinI0@public.gmane.org>
Cc: Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
---
:100644 100644 6e44025... a2d69aa... M	drivers/mmc/host/omap_hsmmc.c
 drivers/mmc/host/omap_hsmmc.c |   79 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 74 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 6e44025..a2d69aa 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -183,6 +183,12 @@ struct omap_hsmmc_host {
 	struct omap_hsmmc_next	next_data;
 
 	struct	omap_mmc_platform_data	*pdata;
+
+	/* Three pin states - default, idle & sleep */
+	struct pinctrl			*pinctrl;
+	struct pinctrl_state		*pins_default;
+	struct pinctrl_state		*pins_idle;
+	struct pinctrl_state		*pins_sleep;
 };
 
 static int omap_hsmmc_card_detect(struct device *dev, int slot)
@@ -1775,7 +1781,6 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 	const struct of_device_id *match;
 	dma_cap_mask_t mask;
 	unsigned tx_req, rx_req;
-	struct pinctrl *pinctrl;
 
 	match = of_match_device(of_match_ptr(omap_mmc_of_match), &pdev->dev);
 	if (match) {
@@ -1982,10 +1987,46 @@ static int omap_hsmmc_probe(struct platform_device *pdev)
 
 	omap_hsmmc_disable_irq(host);
 
-	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
-	if (IS_ERR(pinctrl))
-		dev_warn(&pdev->dev,
-			"pins are not configured from the driver\n");
+	host->pinctrl = devm_pinctrl_get(&pdev->dev);
+	if (!IS_ERR(host->pinctrl)) {
+		host->pins_default = pinctrl_lookup_state(host->pinctrl,
+							PINCTRL_STATE_DEFAULT);
+		if (IS_ERR(host->pins_default))
+			dev_dbg(&pdev->dev, "could not get default pinstate\n");
+		else
+			if (pinctrl_select_state(host->pinctrl,
+						 host->pins_default))
+				dev_err(&pdev->dev,
+					"could not set default pinstate\n");
+
+		host->pins_idle = pinctrl_lookup_state(host->pinctrl,
+							PINCTRL_STATE_IDLE);
+		if (IS_ERR(host->pins_idle))
+			dev_dbg(&pdev->dev, "could not get idle pinstate\n");
+		else
+			/* If possible, let's idle until the first transfer */
+			if (pinctrl_select_state(host->pinctrl,
+						 host->pins_idle))
+				dev_err(&pdev->dev,
+					"could not set idle pinstate\n");
+
+		host->pins_sleep = pinctrl_lookup_state(host->pinctrl,
+							PINCTRL_STATE_SLEEP);
+		if (IS_ERR(host->pins_sleep))
+			dev_dbg(&pdev->dev, "could not get sleep pinstate\n");
+	} else {
+		/*
+		* Since we continue even when pinctrl node is not found,
+		* Invalidate pins as not available. This is to make sure that
+		* IS_ERR(pins_xxx) results in failure when used.
+		*/
+		host->pins_default = ERR_PTR(-ENODATA);
+		host->pins_idle = ERR_PTR(-ENODATA);
+		host->pins_sleep = ERR_PTR(-ENODATA);
+
+		dev_dbg(&pdev->dev, "did not get pins for mmc error: %li\n",
+			PTR_ERR(host->pinctrl));
+	}
 
 	omap_hsmmc_protect_card(host);
 
@@ -2135,6 +2176,12 @@ static int omap_hsmmc_suspend(struct device *dev)
 		clk_disable_unprepare(host->dbclk);
 err:
 	pm_runtime_put_sync(host->dev);
+
+	/* Optionally let pins go into sleep states */
+	if (!IS_ERR(host->pins_sleep))
+		if (pinctrl_select_state(host->pinctrl, host->pins_sleep))
+			dev_err(dev, "could not set pins to sleep state\n");
+
 	return ret;
 }
 
@@ -2152,6 +2199,16 @@ static int omap_hsmmc_resume(struct device *dev)
 
 	pm_runtime_get_sync(host->dev);
 
+	/* First go to the default state */
+	if (!IS_ERR(host->pins_default))
+		if (pinctrl_select_state(host->pinctrl, host->pins_default))
+			dev_err(host->dev, "could not set pins to default state\n");
+
+	/* Then let's idle the pins until the next transfer happens */
+	if (!IS_ERR(host->pins_idle))
+		if (pinctrl_select_state(host->pinctrl, host->pins_idle))
+			dev_err(host->dev, "couldn't set pins to idle state\n");
+
 	if (host->dbclk)
 		clk_prepare_enable(host->dbclk);
 
@@ -2185,6 +2242,12 @@ static int omap_hsmmc_runtime_suspend(struct device *dev)
 
 	host = platform_get_drvdata(to_platform_device(dev));
 	omap_hsmmc_context_save(host);
+
+	/* Optionally let pins go into sleep states */
+	if (!IS_ERR(host->pins_idle))
+		if (pinctrl_select_state(host->pinctrl, host->pins_idle))
+			dev_err(dev, "could not set pins to idle state\n");
+
 	dev_dbg(dev, "disabled\n");
 
 	return 0;
@@ -2195,6 +2258,12 @@ static int omap_hsmmc_runtime_resume(struct device *dev)
 	struct omap_hsmmc_host *host;
 
 	host = platform_get_drvdata(to_platform_device(dev));
+
+	/* Optionaly enable pins to be muxed in and configured */
+	if (!IS_ERR(host->pins_default))
+		if (pinctrl_select_state(host->pinctrl, host->pins_default))
+			dev_err(host->dev, "could not set default pins\n");
+
 	omap_hsmmc_context_restore(host);
 	dev_dbg(dev, "enabled\n");
 
-- 
1.7.9.5
