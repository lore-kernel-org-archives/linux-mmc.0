From: Alexander Stein <alexander.stein@systec-electronic.com>
Subject: [PATCH] at91_mci: Add Support for low active write protect
Date: Tue,  4 Oct 2011 12:31:20 +0200
Message-ID: <1317724280-12182-1-git-send-email-alexander.stein@systec-electronic.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from webbox1416.server-home.net ([77.236.96.61]:42326 "EHLO
	webbox1416.server-home.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755712Ab1JDKla (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Oct 2011 06:41:30 -0400
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Victor <linux@maxim.org.za>, Nicolas Ferre <nicolas.ferre@atmel.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Russell King <linux@arm.linux.org.uk>, Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, Alexander Stein <alexander.stein@systec-electronic.com>

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 arch/arm/mach-at91/include/mach/board.h |    1 +
 drivers/mmc/host/at91_mci.c             |    3 ++-
 2 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/board.h b/arch/arm/mach-at91/include/mach/board.h
index ed544a0..1b0f3f7 100644
--- a/arch/arm/mach-at91/include/mach/board.h
+++ b/arch/arm/mach-at91/include/mach/board.h
@@ -74,6 +74,7 @@ struct at91_mmc_data {
 	unsigned	slot_b:1;	/* uses Slot B */
 	unsigned	wire4:1;	/* (SD) supports DAT0..DAT3 */
 	u8		wp_pin;		/* (SD) writeprotect detect */
+	bool	wp_active_low;		/* (SD) writeprotect logic inverted */
 	u8		vcc_pin;	/* power switching (high == on) */
 };
 extern void __init at91_add_device_mmc(short mmc_id, struct at91_mmc_data *data);
diff --git a/drivers/mmc/host/at91_mci.c b/drivers/mmc/host/at91_mci.c
index a4aa3af..36ba69e 100644
--- a/drivers/mmc/host/at91_mci.c
+++ b/drivers/mmc/host/at91_mci.c
@@ -894,7 +894,8 @@ static int at91_mci_get_ro(struct mmc_host *mmc)
 	struct at91mci_host *host = mmc_priv(mmc);
 
 	if (host->board->wp_pin)
-		return !!gpio_get_value(host->board->wp_pin);
+		return !!gpio_get_value(host->board->wp_pin)
+					^ host->board->wp_active_low;
 	/*
 	 * Board doesn't support read only detection; let the mmc core
 	 * decide what to do.
-- 
1.7.3.4

