From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 4/6] mmc: dw_mmc: split out dw_mci_set_power_reg
Date: Sun,  7 Aug 2016 09:34:46 +0800
Message-ID: <1470533686-16482-1-git-send-email-shawn.lin@rock-chips.com>
References: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

Splite out dw_mci_set_power_reg to set PWREN register
in case that we need more complicated power control.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 0e5ed23..c35a26a 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1276,10 +1276,25 @@ static void dw_mci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	spin_unlock_bh(&host->lock);
 }
 
+static inline void dw_mci_set_power_reg(struct dw_mci_slot *slot,
+					bool enable)
+{
+	u32 regs;
+
+	if (enable) {
+		regs = mci_readl(slot->host, PWREN);
+		regs |= (1 << slot->id);
+		mci_writel(slot->host, PWREN, regs);
+	} else {
+		regs = mci_readl(slot->host, PWREN);
+		regs &= ~(1 << slot->id);
+		mci_writel(slot->host, PWREN, regs);
+	}
+}
+
 static int dw_mci_set_power(struct mmc_host *mmc, struct mmc_ios *ios)
 {
 	struct dw_mci_slot *slot = mmc_priv(mmc);
-	u32 regs;
 
 	switch (ios->power_mode) {
 	case MMC_POWER_UP:
@@ -1291,9 +1306,7 @@ static int dw_mci_set_power(struct mmc_host *mmc, struct mmc_ios *ios)
 			return -EINVAL;
 		}
 		set_bit(DW_MMC_CARD_NEED_INIT, &slot->flags);
-		regs = mci_readl(slot->host, PWREN);
-		regs |= (1 << slot->id);
-		mci_writel(slot->host, PWREN, regs);
+		dw_mci_set_power_reg(slot, true);
 		break;
 	case MMC_POWER_ON:
 		if (!slot->host->vqmmc_enabled) {
@@ -1325,10 +1338,7 @@ static int dw_mci_set_power(struct mmc_host *mmc, struct mmc_ios *ios)
 		if (!IS_ERR(mmc->supply.vqmmc) && slot->host->vqmmc_enabled)
 			regulator_disable(mmc->supply.vqmmc);
 		slot->host->vqmmc_enabled = false;
-
-		regs = mci_readl(slot->host, PWREN);
-		regs &= ~(1 << slot->id);
-		mci_writel(slot->host, PWREN, regs);
+		dw_mci_set_power_reg(slot, false);
 		break;
 	default:
 		break;
-- 
2.3.7
