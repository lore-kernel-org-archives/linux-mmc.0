From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] MMCI: fetch pinctrl handle and set default state
Date: Mon, 29 Oct 2012 14:28:39 +0100
Message-ID: <1351517319-22357-1-git-send-email-linus.walleij@linaro.org>
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
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>, Ulf Hansson <ulf.hansson@stericsson.com>
List-Id: linux-mmc@vger.kernel.org

This fetches the pinctrl resource for the MMCI driver, and if
a "default" state is found, it is activated.

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Change dev_err() to dev_warn() when grabbing the default pins
  since being unable to obtain the default state is not in any
  way fatal.
---
 drivers/mmc/host/mmci.c |   18 ++++++++++++++++++
 drivers/mmc/host/mmci.h |    4 ++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index edc3e9b..9a36226 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -33,6 +33,7 @@
 #include <linux/amba/mmci.h>
 #include <linux/pm_runtime.h>
 #include <linux/types.h>
+#include <linux/pinctrl/consumer.h>
 
 #include <asm/div64.h>
 #include <asm/io.h>
@@ -1360,6 +1361,23 @@ static int __devinit mmci_probe(struct amba_device *dev,
 		mmc->f_max = min(host->mclk, fmax);
 	dev_dbg(mmc_dev(mmc), "clocking block at %u Hz\n", mmc->f_max);
 
+	host->pinctrl = devm_pinctrl_get(&dev->dev);
+	if (IS_ERR(host->pinctrl)) {
+		ret = PTR_ERR(host->pinctrl);
+		goto clk_disable;
+	}
+
+	host->pins_default = pinctrl_lookup_state(host->pinctrl,
+			PINCTRL_STATE_DEFAULT);
+
+	/* enable pins to be muxed in and configured */
+	if (!IS_ERR(host->pins_default)) {
+		ret = pinctrl_select_state(host->pinctrl, host->pins_default);
+		if (ret)
+			dev_warn(&dev->dev, "could not set default pins\n");
+	} else
+		dev_warn(&dev->dev, "could not get default pinstate\n");
+
 #ifdef CONFIG_REGULATOR
 	/* If we're using the regulator framework, try to fetch a regulator */
 	host->vcc = regulator_get(&dev->dev, "vmmc");
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index d437ccf..d34d8c0 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -195,6 +195,10 @@ struct mmci_host {
 	unsigned int		size;
 	struct regulator	*vcc;
 
+	/* pinctrl handles */
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pins_default;
+
 #ifdef CONFIG_DMA_ENGINE
 	/* DMA stuff */
 	struct dma_chan		*dma_current;
-- 
1.7.7.6
