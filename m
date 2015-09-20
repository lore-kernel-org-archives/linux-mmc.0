From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH RFC 3/3] mmc: sunxi: Add card busy detection
Date: Sun, 20 Sep 2015 15:45:58 -0400
Message-ID: <1442778358-7491-4-git-send-email-hdegoede@redhat.com>
References: <1442778358-7491-1-git-send-email-hdegoede@redhat.com>
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44728 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755096AbbITTqT (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Sep 2015 15:46:19 -0400
In-Reply-To: <1442778358-7491-1-git-send-email-hdegoede@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <chris@printf.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-mmc@vger.kernel.org, linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>, Eugene K <sigintmailru@gmail.com>, Arend van Spriel <arend@broadcom.com>

Some sdio wifi modules have not been working reliable with the sunxi-mmc
host code. This turns out to be caused by starting new io-rw commands while
the card signals that it is still busy processing a previous command.

This commit adds card-busy detection to the sunxi-mmc driver which together
with recent core changes to check card-busy before starting io-rw commands
fixes the wifi reliability issues on the Cubietruck and other sunxi boards
using sdio wifi.

Reported-by: Eugene K <sigintmailru@gmail.com>
Suggested-by: Eugene K <sigintmailru@gmail.com>
Cc: Eugene K <sigintmailru@gmail.com>
Cc: Arend van Spriel <arend@broadcom.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Properly accredit Eugene K for coming up with the fix for this
Changes in v3:
-Add card-busy detection and let the core decide when to actually use
 card-busy the added detection
---
 drivers/mmc/host/sunxi-mmc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index a7b7a67..e6226cd 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -868,6 +868,13 @@ static void sunxi_mmc_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_irqrestore(&host->lock, iflags);
 }
 
+static int sunxi_mmc_card_busy(struct mmc_host *mmc)
+{
+	struct sunxi_mmc_host *host = mmc_priv(mmc);
+
+	return !!(mmc_readl(host, REG_STAS) & SDXC_CARD_DATA_BUSY);
+}
+
 static const struct of_device_id sunxi_mmc_of_match[] = {
 	{ .compatible = "allwinner,sun4i-a10-mmc", },
 	{ .compatible = "allwinner,sun5i-a13-mmc", },
@@ -882,6 +889,7 @@ static struct mmc_host_ops sunxi_mmc_ops = {
 	.get_cd		 = mmc_gpio_get_cd,
 	.enable_sdio_irq = sunxi_mmc_enable_sdio_irq,
 	.hw_reset	 = sunxi_mmc_hw_reset,
+	.card_busy	 = sunxi_mmc_card_busy,
 };
 
 static int sunxi_mmc_resource_request(struct sunxi_mmc_host *host,
-- 
2.4.3

