From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V5 01/24] mmc: mmci: Change struct members from bool to u8
Date: Fri, 5 Oct 2018 15:22:39 +0200
Message-ID: <1538745782-27446-2-git-send-email-ludovic.Barre@st.com>
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

Recent versions of checkpatch have a new warning based on a documented
preference of Linus to not use bool in structures due to wasted space and
the size of bool is implementation dependent.  For more information, see
the email thread at https://lkml.org/lkml/2017/11/21/384

fix checkpatch --strict issues:
-CHECK: Avoid using bool structure members because of possible alignment
 issues - see: https://lkml.org/lkml/2017/11/21/384
-WARNING: Avoid using bool as bitfield. Prefer bool bitfields as
 unsigned int or u<8|16|32>

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 21aaf9a..01e6c6b 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -248,24 +248,24 @@ struct variant_data {
 	unsigned int		data_cmd_enable;
 	unsigned int		datactrl_mask_ddrmode;
 	unsigned int		datactrl_mask_sdio;
-	bool			st_sdio;
-	bool			st_clkdiv;
-	bool			blksz_datactrl16;
-	bool			blksz_datactrl4;
+	u8			st_sdio:1;
+	u8			st_clkdiv:1;
+	u8			blksz_datactrl16:1;
+	u8			blksz_datactrl4:1;
 	u32			pwrreg_powerup;
 	u32			f_max;
-	bool			signal_direction;
-	bool			pwrreg_clkgate;
-	bool			busy_detect;
+	u8			signal_direction:1;
+	u8			pwrreg_clkgate:1;
+	u8			busy_detect:1;
 	u32			busy_dpsm_flag;
 	u32			busy_detect_flag;
 	u32			busy_detect_mask;
-	bool			pwrreg_nopower;
-	bool			explicit_mclk_control;
-	bool			qcom_fifo;
-	bool			qcom_dml;
-	bool			reversed_irq_handling;
-	bool			mmcimask1;
+	u8			pwrreg_nopower:1;
+	u8			explicit_mclk_control:1;
+	u8			qcom_fifo:1;
+	u8			qcom_dml:1;
+	u8			reversed_irq_handling:1;
+	u8			mmcimask1:1;
 	u32			start_err;
 	u32			opendrain;
 	void (*init)(struct mmci_host *host);
@@ -290,7 +290,7 @@ struct mmci_host {
 	struct mmc_data		*data;
 	struct mmc_host		*mmc;
 	struct clk		*clk;
-	bool			singleirq;
+	u8			singleirq:1;
 
 	spinlock_t		lock;
 
@@ -304,7 +304,7 @@ struct mmci_host {
 	u32			datactrl_reg;
 	u32			busy_status;
 	u32			mask1_reg;
-	bool			vqmmc_enabled;
+	u8			vqmmc_enabled:1;
 	struct mmci_platform_data *plat;
 	struct mmci_host_ops	*ops;
 	struct variant_data	*variant;
@@ -330,7 +330,7 @@ struct mmci_host {
 	struct dma_chan		*dma_tx_channel;
 	struct dma_async_tx_descriptor	*dma_desc_current;
 	struct mmci_host_next	next_data;
-	bool			dma_in_progress;
+	u8			dma_in_progress:1;
 
 #define dma_inprogress(host)	((host)->dma_in_progress)
 #endif
-- 
2.7.4
