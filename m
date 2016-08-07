From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2 6/6] mmc: dw_mmc-rockchip: add parsing of power control from DT
Date: Sun,  7 Aug 2016 09:35:02 +0800
Message-ID: <1470533702-16567-1-git-send-email-shawn.lin@rock-chips.com>
References: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1470533618-16312-1-git-send-email-shawn.lin@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-mmc@vger.kernel.org

By default, the power io of dw_mmc is fixed which means we could
only output high level voltage to indicate the power-on state.
But that is not always correct as the usage of power io should
be board specific. Let's expose it to dt for supporting this
kind of specific design.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- fix copy-paste err and typo

 drivers/mmc/host/dw_mmc-rockchip.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-rockchip.c b/drivers/mmc/host/dw_mmc-rockchip.c
index 25eae35..2e51202 100644
--- a/drivers/mmc/host/dw_mmc-rockchip.c
+++ b/drivers/mmc/host/dw_mmc-rockchip.c
@@ -24,6 +24,7 @@ struct dw_mci_rockchip_priv_data {
 	struct clk		*drv_clk;
 	struct clk		*sample_clk;
 	int			default_sample_phase;
+	bool			power_invert;
 };
 
 static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
@@ -67,6 +68,10 @@ static void dw_mci_rk3288_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	if (!IS_ERR(priv->sample_clk))
 		clk_set_phase(priv->sample_clk, priv->default_sample_phase);
 
+	/* Make sure we need to invert the output of PWREN */
+	if (priv->power_invert)
+		set_bit(DW_MMC_CARD_PWR_INVERT, &host->cur_slot->flags);
+
 	/*
 	 * Set the drive phase offset based on speed mode to achieve hold times.
 	 *
@@ -267,6 +272,9 @@ static int dw_mci_rk3288_parse_dt(struct dw_mci *host)
 					&priv->default_sample_phase))
 		priv->default_sample_phase = 0;
 
+	if (of_property_read_bool(np, "rockchip,power-invert"))
+		priv->power_invert = true;
+
 	priv->drv_clk = devm_clk_get(host->dev, "ciu-drive");
 	if (IS_ERR(priv->drv_clk))
 		dev_dbg(host->dev, "ciu_drv not available\n");
-- 
2.3.7
