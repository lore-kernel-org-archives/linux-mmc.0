From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V7 3/3] mmc: mmci: sdmmc: add busy_complete callback
Date: Tue, 8 Oct 2019 11:56:04 +0200
Message-ID: <20191008095604.20675-4-ludovic.Barre@st.com>
References: <20191008095604.20675-1-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191008095604.20675-1-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds a specific busy_complete callback for sdmmc variant.

sdmmc has 2 status flags:
-busyd0: This is a hardware status flag (inverted value of d0 line).
it does not generate an interrupt.
-busyd0end: This indicates only end of busy following a CMD response.
On busy to Not busy changes, an interrupt is generated (if unmask)
and BUSYD0END status flag is set. Status flag is cleared by writing
corresponding interrupt clear bit in MMCICLEAR.

The legacy busy completion has no dedicated interrupt for the end
of busy, so it's must monitor step by step the busy progression.
On sdmmc variant, this procedure is not needed, it's just need
to wait the busyd0end interrupt.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c             |  4 +++
 drivers/mmc/host/mmci.h             |  1 +
 drivers/mmc/host/mmci_stm32_sdmmc.c | 42 +++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 5e53f9b6d82a..40e72c30ea84 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -262,6 +262,10 @@ static struct variant_data variant_stm32_sdmmc = {
 	.datalength_bits	= 25,
 	.datactrl_blocksz	= 14,
 	.stm32_idmabsize_mask	= GENMASK(12, 5),
+	.busy_timeout		= true,
+	.busy_detect		= true,
+	.busy_detect_flag	= MCI_STM32_BUSYD0,
+	.busy_detect_mask	= MCI_STM32_BUSYD0ENDMASK,
 	.init			= sdmmc_variant_init,
 };
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 2a0b98f98c36..158e1231aa23 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -164,6 +164,7 @@
 #define MCI_ST_CARDBUSY		(1 << 24)
 /* Extended status bits for the STM32 variants */
 #define MCI_STM32_BUSYD0	BIT(20)
+#define MCI_STM32_BUSYD0END	BIT(21)
 
 #define MMCICLEAR		0x038
 #define MCI_CMDCRCFAILCLR	(1 << 0)
diff --git a/drivers/mmc/host/mmci_stm32_sdmmc.c b/drivers/mmc/host/mmci_stm32_sdmmc.c
index 8e83ae6920ae..1de855d29ad4 100644
--- a/drivers/mmc/host/mmci_stm32_sdmmc.c
+++ b/drivers/mmc/host/mmci_stm32_sdmmc.c
@@ -282,6 +282,47 @@ static u32 sdmmc_get_dctrl_cfg(struct mmci_host *host)
 	return datactrl;
 }
 
+static bool sdmmc_busy_complete(struct mmci_host *host, u32 status, u32 err_msk)
+{
+	void __iomem *base = host->base;
+	u32 busy_d0, busy_d0end, mask, sdmmc_status;
+
+	mask = readl_relaxed(base + MMCIMASK0);
+	sdmmc_status = readl_relaxed(base + MMCISTATUS);
+	busy_d0end = sdmmc_status & MCI_STM32_BUSYD0END;
+	busy_d0 = sdmmc_status & MCI_STM32_BUSYD0;
+
+	/* complete if there is an error or busy_d0end */
+	if ((status & err_msk) || busy_d0end)
+		goto complete;
+
+	/*
+	 * On response the busy signaling is reflected in the BUSYD0 flag.
+	 * if busy_d0 is in-progress we must activate busyd0end interrupt
+	 * to wait this completion. Else this request has no busy step.
+	 */
+	if (busy_d0) {
+		if (!host->busy_status) {
+			writel_relaxed(mask | host->variant->busy_detect_mask,
+				       base + MMCIMASK0);
+			host->busy_status = status &
+				(MCI_CMDSENT | MCI_CMDRESPEND);
+		}
+		return false;
+	}
+
+complete:
+	if (host->busy_status) {
+		writel_relaxed(mask & ~host->variant->busy_detect_mask,
+			       base + MMCIMASK0);
+		writel_relaxed(host->variant->busy_detect_mask,
+			       base + MMCICLEAR);
+		host->busy_status = 0;
+	}
+
+	return true;
+}
+
 static struct mmci_host_ops sdmmc_variant_ops = {
 	.validate_data = sdmmc_idma_validate_data,
 	.prep_data = sdmmc_idma_prep_data,
@@ -292,6 +333,7 @@ static struct mmci_host_ops sdmmc_variant_ops = {
 	.dma_finalize = sdmmc_idma_finalize,
 	.set_clkreg = mmci_sdmmc_set_clkreg,
 	.set_pwrreg = mmci_sdmmc_set_pwrreg,
+	.busy_complete = sdmmc_busy_complete,
 };
 
 void sdmmc_variant_init(struct mmci_host *host)
-- 
2.17.1
