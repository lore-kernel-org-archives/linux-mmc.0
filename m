From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 06/11] at91/mmc: use gpio_is_valid to check the gpio
Date: Mon, 19 Sep 2011 16:03:17 +0200
Message-ID: <1316441002-27381-1-git-send-email-plagnioj@jcrosoft.com>
References: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1316436695-19194-1-git-send-email-plagnioj@jcrosoft.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, linux-mmc@vger.kernel.org, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
List-Id: linux-mmc@vger.kernel.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-mmc@vger.kernel.org
---
Hi,

	I'd like to apply this patch via AT91 with the whole gpio patch series

Best Regards,
J.
 drivers/mmc/host/at91_mci.c |   30 +++++++++++++++---------------
 1 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index a4aa3af..7504b22 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -741,7 +741,7 @@ static void at91_mci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	at91_mci_write(host, AT91_MCI_MR, (at91_mci_read(host, AT91_MCI_MR) & ~AT91_MCI_CLKDIV) | clkdiv);
 
 	/* maybe switch power to the card */
-	if (host->board->vcc_pin) {
+	if (gpio_is_valid(host->board->vcc_pin)) {
 		switch (ios->power_mode) {
 			case MMC_POWER_OFF:
 				gpio_set_value(host->board->vcc_pin, 0);
@@ -893,7 +893,7 @@ static int at91_mci_get_ro(struct mmc_host *mmc)
 {
 	struct at91mci_host *host = mmc_priv(mmc);
 
-	if (host->board->wp_pin)
+	if (gpio_is_valid(host->board->wp_pin))
 		return !!gpio_get_value(host->board->wp_pin);
 	/*
 	 * Board doesn't support read only detection; let the mmc core
@@ -987,21 +987,21 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	 * Reserve GPIOs ... board init code makes sure these pins are set
 	 * up as GPIOs with the right direction (input, except for vcc)
 	 */
-	if (host->board->det_pin) {
+	if (gpio_is_valid(host->board->det_pin)) {
 		ret = gpio_request(host->board->det_pin, "mmc_detect");
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "couldn't claim card detect pin\n");
 			goto fail4b;
 		}
 	}
-	if (host->board->wp_pin) {
+	if (gpio_is_valid(host->board->wp_pin)) {
 		ret = gpio_request(host->board->wp_pin, "mmc_wp");
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "couldn't claim wp sense pin\n");
 			goto fail4;
 		}
 	}
-	if (host->board->vcc_pin) {
+	if (gpio_is_valid(host->board->vcc_pin)) {
 		ret = gpio_request(host->board->vcc_pin, "mmc_vcc");
 		if (ret < 0) {
 			dev_dbg(&pdev->dev, "couldn't claim vcc switch pin\n");
@@ -1053,7 +1053,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	/*
 	 * Add host to MMC layer
 	 */
-	if (host->board->det_pin) {
+	if (gpio_is_valid(host->board->det_pin)) {
 		host->present = !gpio_get_value(host->board->det_pin);
 	}
 	else
@@ -1064,7 +1064,7 @@ static int __init at91_mci_probe(struct platform_device *pdev)
 	/*
 	 * monitor card insertion/removal if we can
 	 */
-	if (host->board->det_pin) {
+	if (gpio_is_valid(host->board->det_pin)) {
 		ret = request_irq(gpio_to_irq(host->board->det_pin),
 				at91_mmc_det_irq, 0, mmc_hostname(mmc), host);
 		if (ret)
@@ -1083,13 +1083,13 @@ fail0:
 fail1:
 	clk_put(host->mci_clk);
 fail2:
-	if (host->board->vcc_pin)
+	if (gpio_is_valid(host->board->vcc_pin))
 		gpio_free(host->board->vcc_pin);
 fail3:
-	if (host->board->wp_pin)
+	if (gpio_is_valid(host->board->wp_pin))
 		gpio_free(host->board->wp_pin);
 fail4:
-	if (host->board->det_pin)
+	if (gpio_is_valid(host->board->det_pin))
 		gpio_free(host->board->det_pin);
 fail4b:
 	if (host->buffer)
@@ -1121,7 +1121,7 @@ static int __exit at91_mci_remove(struct platform_device *pdev)
 		dma_free_coherent(&pdev->dev, MCI_BUFSIZE,
 				host->buffer, host->physical_address);
 
-	if (host->board->det_pin) {
+	if (gpio_is_valid(host->board->det_pin)) {
 		if (device_can_wakeup(&pdev->dev))
 			free_irq(gpio_to_irq(host->board->det_pin), host);
 		device_init_wakeup(&pdev->dev, 0);
@@ -1136,9 +1136,9 @@ static int __exit at91_mci_remove(struct platform_device *pdev)
 	clk_disable(host->mci_clk);			/* Disable the peripheral clock */
 	clk_put(host->mci_clk);
 
-	if (host->board->vcc_pin)
+	if (gpio_is_valid(host->board->vcc_pin))
 		gpio_free(host->board->vcc_pin);
-	if (host->board->wp_pin)
+	if (gpio_is_valid(host->board->wp_pin))
 		gpio_free(host->board->wp_pin);
 
 	iounmap(host->baseaddr);
@@ -1159,7 +1159,7 @@ static int at91_mci_suspend(struct platform_device *pdev, pm_message_t state)
 	struct at91mci_host *host = mmc_priv(mmc);
 	int ret = 0;
 
-	if (host->board->det_pin && device_may_wakeup(&pdev->dev))
+	if (gpio_is_valid(host->board->det_pin) && device_may_wakeup(&pdev->dev))
 		enable_irq_wake(host->board->det_pin);
 
 	if (mmc)
@@ -1174,7 +1174,7 @@ static int at91_mci_resume(struct platform_device *pdev)
 	struct at91mci_host *host = mmc_priv(mmc);
 	int ret = 0;
 
-	if (host->board->det_pin && device_may_wakeup(&pdev->dev))
+	if (gpio_is_valid(host->board->det_pin) && device_may_wakeup(&pdev->dev))
 		disable_irq_wake(host->board->det_pin);
 
 	if (mmc)
-- 
1.7.5.4
