From: Timo Kokkonen <timo.kokkonen@offcode.fi>
Subject: [PATCH] mmc: host: atmel-mci: Add support for non-removable slots
Date: Mon,  3 Nov 2014 13:12:59 +0200
Message-ID: <1415013179-16823-1-git-send-email-timo.kokkonen@offcode.fi>
References: <CAPDyKFpMGk4M=fjBKufxb9iMbV6FmRTEfE_ptXPmM=CHx3Q7iQ@mail.gmail.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from oul135-36.netplaza.fi ([80.75.100.36]:44130 "EHLO
	lime.offcode.fi" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751838AbaKCLNa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 3 Nov 2014 06:13:30 -0500
In-Reply-To: <CAPDyKFpMGk4M=fjBKufxb9iMbV6FmRTEfE_ptXPmM=CHx3Q7iQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ludovic.desroches@atmel.com
Cc: Timo Kokkonen <timo.kokkonen@offcode.fi>

Add support for non-removable slots which have no card detection GPIO
and which should not be polled for a card change.

Signed-off-by: Timo Kokkonen <timo.kokkonen@offcode.fi>
---
 drivers/mmc/host/atmel-mci.c | 11 +++++++++--
 include/linux/atmel-mci.h    |  2 ++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-mci.c
index 77250d4..4de1a31 100644
--- a/drivers/mmc/host/atmel-mci.c
+++ b/drivers/mmc/host/atmel-mci.c
@@ -560,6 +560,9 @@ atmci_of_init(struct platform_device *pdev)
 		pdata->slot[slot_id].detect_is_active_high =
 			of_property_read_bool(cnp, "cd-inverted");
 
+		pdata->slot[slot_id].non_removable =
+			of_property_read_bool(cnp, "non-removable");
+
 		pdata->slot[slot_id].wp_pin =
 			of_get_named_gpio(cnp, "wp-gpios", 0);
 	}
@@ -2206,8 +2209,12 @@ static int __init atmci_init_slot(struct atmel_mci *host,
 		}
 	}
 
-	if (!gpio_is_valid(slot->detect_pin))
-		mmc->caps |= MMC_CAP_NEEDS_POLL;
+	if (!gpio_is_valid(slot->detect_pin)) {
+		if (slot_data->non_removable)
+			mmc->caps |= MMC_CAP_NONREMOVABLE;
+		else
+			mmc->caps |= MMC_CAP_NEEDS_POLL;
+	}
 
 	if (gpio_is_valid(slot->wp_pin)) {
 		if (devm_gpio_request(&host->pdev->dev, slot->wp_pin,
diff --git a/include/linux/atmel-mci.h b/include/linux/atmel-mci.h
index 91b77f8..9177947 100644
--- a/include/linux/atmel-mci.h
+++ b/include/linux/atmel-mci.h
@@ -11,6 +11,7 @@
  * @detect_pin: GPIO pin wired to the card detect switch
  * @wp_pin: GPIO pin wired to the write protect sensor
  * @detect_is_active_high: The state of the detect pin when it is active
+ * @non_removable: The slot is not removable, only detect once
  *
  * If a given slot is not present on the board, @bus_width should be
  * set to 0. The other fields are ignored in this case.
@@ -26,6 +27,7 @@ struct mci_slot_pdata {
 	int			detect_pin;
 	int			wp_pin;
 	bool			detect_is_active_high;
+	bool			non_removable;
 };
 
 /**
-- 
1.9.1

