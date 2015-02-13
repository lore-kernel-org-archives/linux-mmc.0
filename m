From: Addy Ke <addy.ke@rock-chips.com>
Subject: [PATCH v3 2/3] mmc: dw_mmc: fix bug that cause 'Timeout sending command'
Date: Fri, 13 Feb 2015 19:52:47 +0800
Message-ID: <1423828368-18456-3-git-send-email-addy.ke@rock-chips.com>
References: <1423466726-20833-1-git-send-email-addy.ke@rock-chips.com>
 <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1423828368-18456-1-git-send-email-addy.ke@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jh80.chung@samsung.com, ulf.hansson@linaro.org, olof@lixom.net, alim.akhtar@gmail.com, a.hajda@samsung.com, dianders@chromium.org
Cc: heiko@sntech.de, cf@rock-chips.com, lintao@rock-chips.com, huangtao@rock-chips.com, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, Addy Ke <addy.ke@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Because of some uncertain factors, such as worse card or worse hardware,
DAT[3:0](the data lines) may be pulled down by card, and mmc controller
will be in busy state. This should not happend when mmc controller
send command to update card clocks. If this happends, mci_send_cmd will
be failed and we will get 'Timeout sending command', and then system will
be blocked. To avoid this, we need reset mmc controller.

Signed-off-by: Addy Ke <addy.ke@rock-chips.com>
---
 drivers/mmc/host/dw_mmc.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 3472f9b..f0d9da5 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -100,6 +100,7 @@ struct idmac_desc {
 };
 #endif /* CONFIG_MMC_DW_IDMAC */
 
+static int dw_mci_card_busy(struct mmc_host *mmc);
 static bool dw_mci_reset(struct dw_mci *host);
 static bool dw_mci_ctrl_reset(struct dw_mci *host, u32 reset);
 
@@ -888,6 +889,35 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
 		cmd, arg, cmd_status);
 }
 
+static void dw_mci_wait_busy(struct dw_mci_slot *slot)
+{
+	int ret;
+	struct dw_mci *host = slot->host;
+	unsigned long timeout = jiffies + msecs_to_jiffies(500);
+
+	if (host->state == STATE_WAITING_CMD11_DONE)
+		return;
+
+	do {
+		if (!dw_mci_card_busy(slot->mmc))
+			return;
+		usleep_range(50, 100);
+	} while (time_before(jiffies, timeout));
+
+	dev_err(host->dev, "Data busy (status %#x)\n",
+		mci_readl(slot->host, STATUS));
+
+	/*
+	 * Data busy, this should not happend when mmc controller send command
+	 * to update card clocks in non-volt-switch state. If it happends, we
+	 * should reset controller to avoid getting "Timeout sending command".
+	 */
+	ret = dw_mci_ctrl_reset(host, SDMMC_CTRL_ALL_RESET_FLAGS);
+
+	/* Fail to reset controller or still data busy, WARN_ON! */
+	WARN_ON(!ret || dw_mci_card_busy(slot->mmc));
+}
+
 static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 {
 	struct dw_mci *host = slot->host;
@@ -896,6 +926,8 @@ static void dw_mci_setup_bus(struct dw_mci_slot *slot, bool force_clkinit)
 	u32 clk_en_a;
 	u32 sdmmc_cmd_bits = SDMMC_CMD_UPD_CLK | SDMMC_CMD_PRV_DAT_WAIT;
 
+	dw_mci_wait_busy(slot);
+
 	/* We must continue to set bit 28 in CMD until the change is complete */
 	if (host->state == STATE_WAITING_CMD11_DONE)
 		sdmmc_cmd_bits |= SDMMC_CMD_VOLT_SWITCH;
-- 
1.8.3.2
