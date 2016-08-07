From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 5/6] mmc: dw_mmc: support inverted power control
Date: Sun,  7 Aug 2016 09:34:54 +0800
Message-ID: <1470533694-16523-1-git-send-email-shawn.lin@rock-chips.com>
References: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

If DW_MMC_CARD_PWR_INVERT is set, we should configure
PWREN register on the opposite way as it means we need to
output high level from the power io to indicate the off state.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

Changes in v2: None

 drivers/mmc/host/dw_mmc.c | 3 +++
 drivers/mmc/host/dw_mmc.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index c35a26a..20d786c 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1281,6 +1281,9 @@ static inline void dw_mci_set_power_reg(struct dw_mci_slot *slot,
 {
 	u32 regs;
 
+	if (test_bit(DW_MMC_CARD_PWR_INVERT, &slot->flags))
+		enable = !enable;
+
 	if (enable) {
 		regs = mci_readl(slot->host, PWREN);
 		regs |= (1 << slot->id);
diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
index 9e740bc..5719fd1 100644
--- a/drivers/mmc/host/dw_mmc.h
+++ b/drivers/mmc/host/dw_mmc.h
@@ -269,6 +269,7 @@ struct dw_mci_slot {
 #define DW_MMC_CARD_NEED_INIT	1
 #define DW_MMC_CARD_NO_LOW_PWR	2
 #define DW_MMC_CARD_NO_USE_HOLD 3
+#define DW_MMC_CARD_PWR_INVERT	4
 	int			id;
 	int			sdio_id;
 };
-- 
2.3.7
