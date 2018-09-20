From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] mmc: mmci: Drop support for pdata GPIO numbers
Date: Thu, 20 Sep 2018 16:01:10 -0700
Message-ID: <20180920230110.19927-1-linus.walleij@linaro.org>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@arm.linux.org.uk>
List-Id: linux-mmc@vger.kernel.org

All the machines using the MMCI are passing GPIOs for the
card detect and write protect using the device tree or
descriptor table (one single case, Integrator/AP IM-PD1).

Drop support for passing global GPIO numbers through
platform data, noone is using it.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/mach-integrator/integrator_cp.c |  2 --
 arch/arm/mach-versatile/versatile_dt.c   |  4 ---
 drivers/mmc/host/mmci.c                  | 34 +++++-------------------
 include/linux/amba/mmci.h                | 11 ++------
 4 files changed, 8 insertions(+), 43 deletions(-)

diff --git a/arch/arm/mach-integrator/integrator_cp.c b/arch/arm/mach-integrator/integrator_cp.c
index 772a7cf2010e..976ded5c5916 100644
--- a/arch/arm/mach-integrator/integrator_cp.c
+++ b/arch/arm/mach-integrator/integrator_cp.c
@@ -80,8 +80,6 @@ static unsigned int mmc_status(struct device *dev)
 static struct mmci_platform_data mmc_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.status		= mmc_status,
-	.gpio_wp	= -1,
-	.gpio_cd	= -1,
 };
 
 static u64 notrace intcp_read_sched_clock(void)
diff --git a/arch/arm/mach-versatile/versatile_dt.c b/arch/arm/mach-versatile/versatile_dt.c
index 3c8d39c12909..e9d60687e416 100644
--- a/arch/arm/mach-versatile/versatile_dt.c
+++ b/arch/arm/mach-versatile/versatile_dt.c
@@ -89,15 +89,11 @@ unsigned int mmc_status(struct device *dev)
 static struct mmci_platform_data mmc0_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.status		= mmc_status,
-	.gpio_wp	= -1,
-	.gpio_cd	= -1,
 };
 
 static struct mmci_platform_data mmc1_plat_data = {
 	.ocr_mask	= MMC_VDD_32_33|MMC_VDD_33_34,
 	.status		= mmc_status,
-	.gpio_wp	= -1,
-	.gpio_cd	= -1,
 };
 
 /*
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 1841d250e9e2..4b843712dc01 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -28,8 +28,7 @@
 #include <linux/amba/bus.h>
 #include <linux/clk.h>
 #include <linux/scatterlist.h>
-#include <linux/gpio.h>
-#include <linux/of_gpio.h>
+#include <linux/of.h>
 #include <linux/regulator/consumer.h>
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
@@ -1675,13 +1674,6 @@ static int mmci_probe(struct amba_device *dev,
 	else if (plat->ocr_mask)
 		dev_warn(mmc_dev(mmc), "Platform OCR mask is ignored\n");
 
-	/* DT takes precedence over platform data. */
-	if (!np) {
-		if (!plat->cd_invert)
-			mmc->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
-		mmc->caps2 |= MMC_CAP2_RO_ACTIVE_HIGH;
-	}
-
 	/* We support these capabilities. */
 	mmc->caps |= MMC_CAP_CMD23;
 
@@ -1749,30 +1741,16 @@ static int mmci_probe(struct amba_device *dev,
 	 * - not using DT but using a descriptor table, or
 	 * - using a table of descriptors ALONGSIDE DT, or
 	 * look up these descriptors named "cd" and "wp" right here, fail
-	 * silently of these do not exist and proceed to try platform data
+	 * silently of these do not exist
 	 */
 	if (!np) {
 		ret = mmc_gpiod_request_cd(mmc, "cd", 0, false, 0, NULL);
-		if (ret < 0) {
-			if (ret == -EPROBE_DEFER)
-				goto clk_disable;
-			else if (gpio_is_valid(plat->gpio_cd)) {
-				ret = mmc_gpio_request_cd(mmc, plat->gpio_cd, 0);
-				if (ret)
-					goto clk_disable;
-			}
-		}
+		if (ret == -EPROBE_DEFER)
+			goto clk_disable;
 
 		ret = mmc_gpiod_request_ro(mmc, "wp", 0, false, 0, NULL);
-		if (ret < 0) {
-			if (ret == -EPROBE_DEFER)
-				goto clk_disable;
-			else if (gpio_is_valid(plat->gpio_wp)) {
-				ret = mmc_gpio_request_ro(mmc, plat->gpio_wp);
-				if (ret)
-					goto clk_disable;
-			}
-		}
+		if (ret == -EPROBE_DEFER)
+			goto clk_disable;
 	}
 
 	ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
diff --git a/include/linux/amba/mmci.h b/include/linux/amba/mmci.h
index da8357ba11bc..c92ebc39fc1f 100644
--- a/include/linux/amba/mmci.h
+++ b/include/linux/amba/mmci.h
@@ -18,20 +18,13 @@
  * mask into a value to be binary (or set some other custom bits
  * in MMCIPWR) or:ed and written into the MMCIPWR register of the
  * block.  May also control external power based on the power_mode.
- * @status: if no GPIO read function was given to the block in
- * gpio_wp (below) this function will be called to determine
- * whether a card is present in the MMC slot or not
- * @gpio_wp: read this GPIO pin to see if the card is write protected
- * @gpio_cd: read this GPIO pin to detect card insertion
- * @cd_invert: true if the gpio_cd pin value is active low
+ * @status: if no GPIO line was given to the block in this function will
+ * be called to determine whether a card is present in the MMC slot or not
  */
 struct mmci_platform_data {
 	unsigned int ocr_mask;
 	int (*ios_handler)(struct device *, struct mmc_ios *);
 	unsigned int (*status)(struct device *);
-	int	gpio_wp;
-	int	gpio_cd;
-	bool	cd_invert;
 };
 
 #endif
-- 
2.17.1
