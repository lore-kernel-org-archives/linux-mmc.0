From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 2/6] mmc: mmci: add helper functions to define datactrl
 value for variants
Date: Thu, 7 Mar 2019 17:38:58 +0100
Message-ID: <1551976742-4358-3-git-send-email-ludovic.Barre@st.com>
References: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551976742-4358-1-git-send-email-ludovic.Barre@st.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org, Alexandre Torgue <alexandre.torgue@st.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, srinivas.kandagatla@linaro.org, Ludovic Barre <ludovic.barre@st.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds default helper functions to define datactrl value.
Each variant could use these helpers to define datactrl and adds
their specific field.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 25 +++++++++++++++++++++++++
 drivers/mmc/host/mmci.h |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9e6a2c1..28b76c5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -983,6 +983,31 @@ static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
 	mmci_unprep_data(host, data, err);
 }
 
+u32 mmci_dctrl_blksz(struct mmci_host *host)
+{
+	return (ffs(host->data->blksz) - 1) << 4;
+}
+
+u32 mmci_dctrl_dir(struct mmci_host *host)
+{
+	return host->data->flags & MMC_DATA_READ ? MCI_DPSM_DIRECTION : 0;
+}
+
+u32 mmci_dctrl_ddr(struct mmci_host *host)
+{
+	if (host->mmc->ios.timing == MMC_TIMING_UHS_DDR50 ||
+	    host->mmc->ios.timing == MMC_TIMING_MMC_DDR52)
+		return host->variant->datactrl_mask_ddrmode;
+	return 0;
+}
+
+u32 mmci_dctrl_sdio(struct mmci_host *host)
+{
+	if (host->mmc->card && mmc_card_sdio(host->mmc->card))
+		return host->variant->datactrl_mask_sdio;
+	return 0;
+}
+
 static void mmci_start_data(struct mmci_host *host, struct mmc_data *data)
 {
 	struct variant_data *variant = host->variant;
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index a59049b..32ae41d 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -430,6 +430,11 @@ struct mmci_host {
 void mmci_write_clkreg(struct mmci_host *host, u32 clk);
 void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
 
+u32 mmci_dctrl_blksz(struct mmci_host *host);
+u32 mmci_dctrl_dir(struct mmci_host *host);
+u32 mmci_dctrl_ddr(struct mmci_host *host);
+u32 mmci_dctrl_sdio(struct mmci_host *host);
+
 #ifdef CONFIG_DMA_ENGINE
 int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 			bool next);
-- 
2.7.4
