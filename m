From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: [PATCH 22/22] mmc: omap_hsmmc: add a hardware reset before initialization
Date: Thu,  5 May 2011 14:51:22 +0300
Message-ID: <1304596282-4095-23-git-send-email-adrian.hunter@nokia.com>
References: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([147.243.128.24]:63436 "EHLO mgw-da01.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753170Ab1EELwx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 May 2011 07:52:53 -0400
In-Reply-To: <1304596282-4095-1-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Adrian Hunter <adrian.hunter@nokia.com>

After a warm restart, an eMMC which cannot be powered off is
in an unknown state, so reset it to be sure it will initialize.

Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
---
 drivers/mmc/host/omap_hsmmc.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 37 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 8c5e7d3..c791230 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -542,10 +542,25 @@ static int omap_hsmmc_gpio_init(struct omap_mmc_platform_data *pdata)
 	} else
 		pdata->slots[0].gpio_wp = -EINVAL;
 
+	if (gpio_is_valid(pdata->slots[0].gpio_hw_reset)) {
+		ret = gpio_request(pdata->slots[0].gpio_hw_reset,
+				   "mmc_hw_reset");
+		if (ret)
+			goto err_free_wp;
+		ret = gpio_direction_output(pdata->slots[0].gpio_hw_reset, 1);
+		if (ret)
+			goto err_free_hw_reset;
+	} else
+		pdata->slots[0].gpio_hw_reset = -EINVAL;
+
 	return 0;
 
+
+err_free_hw_reset:
+	gpio_free(pdata->slots[0].gpio_hw_reset);
 err_free_wp:
-	gpio_free(pdata->slots[0].gpio_wp);
+	if (gpio_is_valid(pdata->slots[0].gpio_wp))
+		gpio_free(pdata->slots[0].gpio_wp);
 err_free_cd:
 	if (gpio_is_valid(pdata->slots[0].switch_pin))
 err_free_sp:
@@ -555,6 +570,8 @@ err_free_sp:
 
 static void omap_hsmmc_gpio_free(struct omap_mmc_platform_data *pdata)
 {
+	if (gpio_is_valid(pdata->slots[0].gpio_hw_reset))
+		gpio_free(pdata->slots[0].gpio_hw_reset);
 	if (gpio_is_valid(pdata->slots[0].gpio_wp))
 		gpio_free(pdata->slots[0].gpio_wp);
 	if (gpio_is_valid(pdata->slots[0].switch_pin))
@@ -815,6 +832,18 @@ static void omap_hsmmc_context_save(struct omap_hsmmc_host *host)
 
 #endif
 
+static void omap_hsmmc_do_hw_reset(struct omap_hsmmc_host *host)
+{
+	if (!gpio_is_valid(mmc_slot(host).gpio_hw_reset))
+		return;
+
+	gpio_set_value_cansleep(mmc_slot(host).gpio_hw_reset, 0);
+	udelay(9);
+	gpio_set_value_cansleep(mmc_slot(host).gpio_hw_reset, 1);
+	usleep_range(1000, 2000);
+	printk(KERN_INFO "%s: hardware reset done\n", mmc_hostname(host->mmc));
+}
+
 /*
  * Send init stream sequence to card
  * before sending IDLE command
@@ -827,6 +856,13 @@ static void send_init_stream(struct omap_hsmmc_host *host)
 	if (host->protect_card)
 		return;
 
+	/*
+	 * After a warm restart, an eMMC which cannot be powered off is in an
+	 * unknown state so reset it to be sure it will initialize.
+	 */
+	if (mmc_slot(host).no_off)
+		omap_hsmmc_do_hw_reset(host);
+
 	disable_irq(host->irq);
 
 	OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
-- 
1.7.0.4

