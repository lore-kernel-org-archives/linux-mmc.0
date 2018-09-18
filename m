From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 26/27] mmc: mmci: add DT bindings for STM32 sdmmc
Date: Tue, 18 Sep 2018 12:55:43 +0200
Message-ID: <1537268144-21152-27-git-send-email-ludovic.Barre@st.com>
References: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537268144-21152-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

STM32 sdmmc variant has support to:
-Indicate signal directions (only one property
for d0dir, d123dir, cmd_dir)
-Select command and data phase relation.
-Select "clock in" from an external driver.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 Documentation/devicetree/bindings/mmc/mmci.txt | 9 +++++++++
 drivers/mmc/host/mmci.c                        | 6 ++++++
 drivers/mmc/host/mmci.h                        | 1 +
 3 files changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/mmc/mmci.txt b/Documentation/devicetree/bindings/mmc/mmci.txt
index e952707..d678933 100644
--- a/Documentation/devicetree/bindings/mmc/mmci.txt
+++ b/Documentation/devicetree/bindings/mmc/mmci.txt
@@ -19,6 +19,7 @@ Optional properties:
                            the ID provided by the HW
 - vqmmc-supply           : phandle to the regulator device tree node, mentioned
                            as the VCCQ/VDD_IO supply in the eMMC/SD specs.
+specific for ux500 variant:
 - st,sig-dir-dat0        : bus signal direction pin used for DAT[0].
 - st,sig-dir-dat2        : bus signal direction pin used for DAT[2].
 - st,sig-dir-dat31       : bus signal direction pin used for DAT[3] and DAT[1].
@@ -26,6 +27,14 @@ Optional properties:
 - st,sig-dir-cmd         : cmd signal direction pin used for CMD.
 - st,sig-pin-fbclk       : feedback clock signal pin used.
 
+specific for sdmmc variant:
+- st,sig-dir             : signal direction polarity used for cmd, dat0 dat123.
+- st,neg-edge            : data & command phase relation, generated on
+                           sd clock falling edge.
+- st,use-ckin            : use ckin pin from an external driver to sample
+                           the receive data (example: with voltage
+			   switch transceiver).
+
 Deprecated properties:
 - mmc-cap-mmc-highspeed  : indicates whether MMC is high speed capable.
 - mmc-cap-sd-highspeed   : indicates whether SD is high speed capable.
diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index d622fbb..ce230cd 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1708,6 +1708,12 @@ static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
 		host->pwr_reg_add |= MCI_ST_CMDDIREN;
 	if (of_get_property(np, "st,sig-pin-fbclk", NULL))
 		host->pwr_reg_add |= MCI_ST_FBCLKEN;
+	if (of_get_property(np, "st,sig-dir", NULL))
+		host->pwr_reg_add |= MCI_STM32_DIRPOL;
+	if (of_get_property(np, "st,neg-edge", NULL))
+		host->clk_reg_add |= MCI_STM32_CLK_NEGEDGE;
+	if (of_get_property(np, "st,use-ckin ", NULL))
+		host->clk_reg_add |= MCI_STM32_CLK_SELCKIN;
 
 	if (of_get_property(np, "mmc-cap-mmc-highspeed", NULL))
 		mmc->caps |= MMC_CAP_MMC_HIGHSPEED;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 50098fa..3ad568c 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -389,6 +389,7 @@ struct mmci_host {
 	u32			pwr_reg;
 	u32			pwr_reg_add;
 	u32			clk_reg;
+	u32			clk_reg_add;
 	u32			datactrl_reg;
 	u32			busy_status;
 	u32			mask1_reg;
-- 
2.7.4
