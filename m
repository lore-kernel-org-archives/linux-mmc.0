From: Doug Anderson <dianders@chromium.org>
Subject: [PATCH 1/2] mmc: dw_mmc: Only enable CD after setup and only if needed
Date: Wed, 25 Feb 2015 10:11:51 -0800
Message-ID: <1424887912-20015-1-git-send-email-dianders@chromium.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, Sonny Rao <sonnyrao@chromium.org>, Andrew Bresticker <abrestic@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Addy Ke <addy.ke@rock-chips.com>, Alexandru Stan <amstan@chromium.org>, javier.martinez@collabora.co.uk, linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Doug Anderson <dianders@chromium.org>, chris@printf.net, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

We really don't want to get a card detect interrupt during probe time
since it can confuse things.  Let's disable the card detect interrupt
until we're in a really good place: the end of probe.  Let's also
simply avoid enabling the card detect interrupt if it's not used.

It appears that (at least on rk3288) when vqmmc is turned on it can
cause a bogus "card detect" interrupt.  That meant that we were
getting a predictable card detect interrupt while we were in
mmc_add_host().  On the version of the kernel I'm working with at
least (3.14), this is not a great time to get a card detect interrupt
since I think that we don't grab all the needed locks in
mmc_add_host() and children.  I put stack dumps in dw_mci_setup_bus()
and found that I could see two distinct stack crawls that looked like:

Caller one:
* dw_mci_setup_bus
* dw_mci_set_ios
* mmc_power_up
* mmc_start_host
* mmc_add_host

Caller two:
* dw_mci_setup_bus
* dw_mci_set_ios
* mmc_set_chip_select
* mmc_go_idle
* mmc_rescan
* process_one_work
* worker_thread
* kthread

Signed-off-by: Doug Anderson <dianders@chromium.org>
---
 drivers/mmc/host/dw_mmc.c | 41 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 4d2e3c2..8df2a92 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -2574,6 +2574,34 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
 }
 #endif /* CONFIG_OF */
 
+static void dw_mci_enable_cd(struct dw_mci *host)
+{
+	struct dw_mci_board *brd = host->pdata;
+	unsigned long irqflags;
+	u32 temp;
+	int i;
+
+	/* No need for CD if broken card detection */
+	if (brd->quirks & DW_MCI_QUIRK_BROKEN_CARD_DETECTION)
+		return;
+
+	/* No need for CD if all slots have a non-error GPIO */
+	for (i = 0; i < host->num_slots; i++) {
+		struct dw_mci_slot *slot = host->slot[i];
+
+		if (IS_ERR_VALUE(mmc_gpio_get_cd(slot->mmc)))
+			break;
+	}
+	if (i == host->num_slots)
+		return;
+
+	spin_lock_irqsave(&host->irq_lock, irqflags);
+	temp = mci_readl(host, INTMASK);
+	temp  |= SDMMC_INT_CD;
+	mci_writel(host, INTMASK, temp);
+	spin_unlock_irqrestore(&host->irq_lock, irqflags);
+}
+
 int dw_mci_probe(struct dw_mci *host)
 {
 	const struct dw_mci_drv_data *drv_data = host->drv_data;
@@ -2747,13 +2775,13 @@ int dw_mci_probe(struct dw_mci *host)
 		host->num_slots = ((mci_readl(host, HCON) >> 1) & 0x1F) + 1;
 
 	/*
-	 * Enable interrupts for command done, data over, data empty, card det,
+	 * Enable interrupts for command done, data over, data empty,
 	 * receive ready and error such as transmit, receive timeout, crc error
 	 */
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
 		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
-		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
+		   DW_MCI_ERROR_FLAGS);
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE); /* Enable mci interrupt */
 
 	dev_info(host->dev, "DW MMC controller at irq %d, "
@@ -2770,6 +2798,9 @@ int dw_mci_probe(struct dw_mci *host)
 			init_slots++;
 	}
 
+	/* Now that slots are all setup, we can enable card detect */
+	dw_mci_enable_cd(host);
+
 	if (init_slots) {
 		dev_info(host->dev, "%d slots initialized\n", init_slots);
 	} else {
@@ -2864,7 +2895,7 @@ int dw_mci_resume(struct dw_mci *host)
 	mci_writel(host, RINTSTS, 0xFFFFFFFF);
 	mci_writel(host, INTMASK, SDMMC_INT_CMD_DONE | SDMMC_INT_DATA_OVER |
 		   SDMMC_INT_TXDR | SDMMC_INT_RXDR |
-		   DW_MCI_ERROR_FLAGS | SDMMC_INT_CD);
+		   DW_MCI_ERROR_FLAGS);
 	mci_writel(host, CTRL, SDMMC_CTRL_INT_ENABLE);
 
 	for (i = 0; i < host->num_slots; i++) {
@@ -2876,6 +2907,10 @@ int dw_mci_resume(struct dw_mci *host)
 			dw_mci_setup_bus(slot, true);
 		}
 	}
+
+	/* Now that slots are all setup, we can enable card detect */
+	dw_mci_enable_cd(host);
+
 	return 0;
 }
 EXPORT_SYMBOL(dw_mci_resume);
-- 
2.2.0.rc0.207.ga3a616c
