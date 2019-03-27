From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V4 1/5] mmc: mmci: add get_datactrl_cfg callback and helper functions
Date: Wed, 27 Mar 2019 10:05:28 +0100
Message-ID: <1553677532-3539-2-git-send-email-ludovic.Barre@st.com>
References: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1553677532-3539-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch adds get_datactrl_cfg callback in mmci_host_ops
to allow to get datactrl configuration specific at variant.
Common helper function is defined and could be call by variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 6bde28c..35c91d0 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -362,6 +362,7 @@ struct mmci_host_ops {
 			 bool next);
 	void (*unprep_data)(struct mmci_host *host, struct mmc_data *data,
 			    int err);
+	u32 (*get_datactrl_cfg)(struct mmci_host *host);
 	void (*get_next_data)(struct mmci_host *host, struct mmc_data *data);
 	int (*dma_setup)(struct mmci_host *host);
 	void (*dma_release)(struct mmci_host *host);
@@ -429,6 +430,11 @@ struct mmci_host {
 void mmci_write_clkreg(struct mmci_host *host, u32 clk);
 void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
 
+static inline u32 mmci_dctrl_blksz(struct mmci_host *host)
+{
+	return (ffs(host->data->blksz) - 1) << 4;
+}
+
 #ifdef CONFIG_DMA_ENGINE
 int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 			bool next);
-- 
2.7.4
