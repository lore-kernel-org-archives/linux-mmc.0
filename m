From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V5 18/24] mmc: mmci: add variant property to not read datacnt
Date: Fri, 5 Oct 2018 15:22:56 +0200
Message-ID: <1538745782-27446-19-git-send-email-ludovic.Barre@st.com>
References: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1538745782-27446-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a boolean property to not read datacnt register.
Needed to support the STM32 sdmmc variant. MMCIDATACNT
register should be read only after the data transfer is completed.
When reading after an error event the read data count value may be
different from the real number of data bytes transferred.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 8 ++++++--
 drivers/mmc/host/mmci.h | 3 +++
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index bc04329..84e92d1 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1117,8 +1117,12 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		 * can be as much as a FIFO-worth of data ahead.  This
 		 * matters for FIFO overruns only.
 		 */
-		remain = readl(host->base + MMCIDATACNT);
-		success = data->blksz * data->blocks - remain;
+		if (!host->variant->datacnt_useless) {
+			remain = readl(host->base + MMCIDATACNT);
+			success = data->blksz * data->blocks - remain;
+		} else {
+			success = 0;
+		}
 
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ, status 0x%08x at 0x%08x\n",
 			status_err, success);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 1aa8eac..bbc4332 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -224,6 +224,8 @@ struct mmci_host;
  * @datactrl_blksz: block size in power of two
  * @datactrl_dpsm_enable: enable value for DPSM
  * @datactrl_first: true if data must be setup before send command
+ * @datacnt_useless: true if you could not use datacnt register to read
+ *		     remaining data
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
@@ -264,6 +266,7 @@ struct variant_data {
 	unsigned int		datactrl_blocksz;
 	unsigned int		datactrl_dpsm_enable;
 	u8			datactrl_first:1;
+	u8			datacnt_useless:1;
 	u8			st_sdio:1;
 	u8			st_clkdiv:1;
 	u8			blksz_datactrl16:1;
-- 
2.7.4
