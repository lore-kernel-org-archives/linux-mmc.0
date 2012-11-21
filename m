From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Subject: [PATCH 1/1] mmc:atmel-mci: use devm_gpio_request/free and configure
 the pin corrently
Date: Wed, 21 Nov 2012 11:29:22 +0100
Message-ID: <1353493762-31137-1-git-send-email-plagnioj@jcrosoft.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: linux-mmc@vger.kernel.org, Ludovic Desroches <ludovic.desroches@atmel.com>, Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
List-Id: linux-mmc@vger.kernel.org

as on DT we do not configure the pin via AT91 custom pinmux as before

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-mmc@vger.kernel.org
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
---

based on next-20121115

Best Regards,
J.
 drivers/mmc/host/atmel-mci.c |   39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 767706b..d97771d 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -2108,6 +2108,7 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 {
 	struct mmc_host			*mmc;
 	struct atmel_mci_slot		*slot;
+	int ret;
 
 	mmc = mmc_alloc_host(sizeof(struct atmel_mci_slot), &host->pdev->dev);
 	if (!mmc)
@@ -2161,12 +2162,20 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 	/* Assume card is present initially */
 	set_bit(ATMCI_CARD_PRESENT, &slot->flags);
 	if (gpio_is_valid(slot->detect_pin)) {
-		if (gpio_request(slot->detect_pin, "mmc_detect")) {
-			dev_dbg(&mmc->class_dev, "no detect pin available\n");
-			slot->detect_pin = -EBUSY;
-		} else if (gpio_get_value(slot->detect_pin) ^
-				slot->detect_is_active_high) {
-			clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
+		ret = devm_gpio_request(&mmc->class_dev, slot->detect_pin, "mmc_detect");
+		if (ret) {
+			dev_warn(&mmc->class_dev, "can't request detect pin\n");
+			slot->detect_pin = ret;
+		} else {
+			ret = gpio_direction_input(slot->detect_pin);
+			if (ret) {
+				dev_err(&mmc->class_dev, "can't set detect pin direction\n");
+				devm_gpio_free(&mmc->class_dev, slot->detect_pin);
+				slot->detect_pin = -ret;
+			} else if (gpio_get_value(slot->detect_pin) ^
+					slot->detect_is_active_high) {
+				clear_bit(ATMCI_CARD_PRESENT, &slot->flags);
+			}
 		}
 	}
 
@@ -2174,9 +2183,17 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 		mmc->caps |= MMC_CAP_NEEDS_POLL;
 
 	if (gpio_is_valid(slot->wp_pin)) {
-		if (gpio_request(slot->wp_pin, "mmc_wp")) {
-			dev_dbg(&mmc->class_dev, "no WP pin available\n");
-			slot->wp_pin = -EBUSY;
+		ret = devm_gpio_request(&mmc->class_dev, slot->wp_pin, "mmc_wp");
+		if (ret) {
+			dev_warn(&mmc->class_dev, "no WP pin available\n");
+			slot->wp_pin = ret;
+		} else {
+			ret = gpio_direction_output(slot->wp_pin, 0);
+			if (ret) {
+				dev_err(&mmc->class_dev, "can't set WP pin direction\n");
+				devm_gpio_free(&mmc->class_dev, slot->wp_pin);
+				slot->wp_pin = ret;
+			}
 		}
 	}
 
@@ -2197,8 +2214,8 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 			dev_dbg(&mmc->class_dev,
 				"could not request IRQ %d for detect pin\n",
 				gpio_to_irq(slot->detect_pin));
-			gpio_free(slot->detect_pin);
-			slot->detect_pin = -EBUSY;
+			devm_gpio_free(&mmc->class_dev, slot->detect_pin);
+			slot->detect_pin = ret;
 		}
 	}
 
-- 
1.7.10.4
