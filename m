From: <patrice.chotard@st.com>
Subject: [PATCH v2 04/15] mmc: mmci: Add support for setting pad type via pinctrl
Date: Tue, 16 Jan 2018 13:30:48 +0100
Message-ID: <1516105859-3525-5-git-send-email-patrice.chotard@st.com>
References: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516105859-3525-1-git-send-email-patrice.chotard@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King <linux@armlinux.org.uk>, Ulf Hansson <ulf.hansson@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@codeaurora.org>, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Alexandre Torgue <alexandre.torgue@st.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, Patrice Chotard <patrice.chotard@st.com>, Andrea Merello <andrea.merello@gmail.com>
List-Id: linux-mmc@vger.kernel.org

From: Patrice Chotard <patrice.chotard@st.com>

If variant hasn't the control bit to switch pads in opendrain mode,
we can achieve the same result by asking to the pinmux driver to
configure pins for us.

This patch make the mmci driver able to do this whenever needed.

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>
Signed-off-by: Patrice Chotard <patrice.chotard@st.com>
---

v2: _ Add pinctrl pin management when open drain bit is not available


 drivers/mmc/host/mmci.c | 45 ++++++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h |  5 +++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index eb5fcfe..2a7aea7 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1465,13 +1465,22 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 				~MCI_ST_DATA2DIREN);
 	}
 
-	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN &&
-	    host->variant->opendrain) {
+	if (host->variant->opendrain) {
+		if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
+			/*
+			 * The ST Micro variant use the ROD bit for
+			 * something else and only has OD (Open Drain).
+			 */
+			pwr |= host->variant->opendrain;
+	} else {
 		/*
-		 * The ST Micro variant use the ROD bit for
-		 * something else and only has OD (Open Drain).
+		 * If the variant cannot configure the pads by its own, then we
+		 * expect the pinctrl to be able to do that for us
 		 */
-		pwr |= host->variant->opendrain;
+		if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN)
+			pinctrl_select_state(host->pinctrl, host->pins_opendrain);
+		else
+			pinctrl_select_state(host->pinctrl, host->pins_default);
 	}
 
 	/*
@@ -1616,6 +1625,32 @@ static int mmci_probe(struct amba_device *dev,
 	host = mmc_priv(mmc);
 	host->mmc = mmc;
 
+	/*
+	 * Some variant (STM32) doesn't have opendrain bit, nevertheless
+	 * pins can be set accordingly using pinctrl
+	 */
+	if (!variant->opendrain) {
+		host->pinctrl = devm_pinctrl_get(&dev->dev);
+		if (IS_ERR(host->pinctrl)) {
+			dev_err(&dev->dev, "failed to get pinctrl");
+			goto host_free;
+		}
+
+		host->pins_default = pinctrl_lookup_state(host->pinctrl,
+							  PINCTRL_STATE_DEFAULT);
+		if (IS_ERR(host->pins_default)) {
+			dev_warn(mmc_dev(mmc), "Can't select default pins\n");
+			host->pins_default = NULL;
+		}
+
+		host->pins_opendrain = pinctrl_lookup_state(host->pinctrl,
+							    MMCI_PINCTRL_STATE_OPENDRAIN);
+		if (IS_ERR(host->pins_opendrain)) {
+			dev_warn(mmc_dev(mmc), "Can't select opendrain pins\n");
+			host->pins_opendrain = NULL;
+		}
+	}
+
 	host->hw_designer = amba_manf(dev);
 	host->hw_revision = amba_rev(dev);
 	dev_dbg(mmc_dev(mmc), "designer ID = 0x%02x\n", host->hw_designer);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 83160a9..f91cdf7 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -192,6 +192,8 @@
 
 #define NR_SG		128
 
+#define MMCI_PINCTRL_STATE_OPENDRAIN "opendrain"
+
 struct clk;
 struct variant_data;
 struct dma_chan;
@@ -227,6 +229,9 @@ struct mmci_host {
 	bool			vqmmc_enabled;
 	struct mmci_platform_data *plat;
 	struct variant_data	*variant;
+	struct pinctrl		*pinctrl;
+	struct pinctrl_state	*pins_default;
+	struct pinctrl_state	*pins_opendrain;
 
 	u8			hw_designer;
 	u8			hw_revision:4;
-- 
1.9.1
