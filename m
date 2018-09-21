From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 05/27] mmc: mmci: move mmci next cookie to mci host
Date: Fri, 21 Sep 2018 11:45:59 +0200
Message-ID: <1537523181-14578-6-git-send-email-ludovic.Barre@st.com>
References: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1537523181-14578-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, benjamin.gaignard@linaro.org, Gerald Baeza <gerald.baeza@st.com>, Loic Pallardy <loic.pallardy@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch moves next cookie to mmci host structure to
share same cookie management between all variants.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 10 ++++------
 drivers/mmc/host/mmci.h |  2 ++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 6de7c8d..43f2a1a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -418,7 +418,6 @@ static void mmci_init_sg(struct mmci_host *host, struct mmc_data *data)
 struct mmci_dmae_next {
 	struct dma_async_tx_descriptor *desc;
 	struct dma_chan	*chan;
-	s32 cookie;
 };
 
 struct mmci_dmae_priv {
@@ -449,7 +448,7 @@ static int mmci_dma_setup(struct mmci_host *host)
 						     "tx");
 
 	/* initialize pre request cookie */
-	dmae->next_data.cookie = 1;
+	host->next_cookie = 1;
 
 	/*
 	 * If only an RX channel is specified, the driver will
@@ -716,7 +715,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmci_dmae_next *next = &dmae->next_data;
 
-	WARN_ON(data->host_cookie && data->host_cookie != next->cookie);
+	WARN_ON(data->host_cookie && data->host_cookie != host->next_cookie);
 	WARN_ON(!data->host_cookie && (next->desc || next->chan));
 
 	dmae->desc_current = next->desc;
@@ -728,9 +727,7 @@ static void mmci_get_next_data(struct mmci_host *host, struct mmc_data *data)
 static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 {
 	struct mmci_host *host = mmc_priv(mmc);
-	struct mmci_dmae_priv *dmae = host->dma_priv;
 	struct mmc_data *data = mrq->data;
-	struct mmci_dmae_next *nd = &dmae->next_data;
 
 	if (!data)
 		return;
@@ -741,7 +738,8 @@ static void mmci_pre_request(struct mmc_host *mmc, struct mmc_request *mrq)
 		return;
 
 	if (!mmci_dma_prep_next(host, data))
-		data->host_cookie = ++nd->cookie < 0 ? 1 : nd->cookie;
+		data->host_cookie = ++host->next_cookie < 0 ?
+			1 : host->next_cookie;
 }
 
 static void mmci_post_request(struct mmc_host *mmc, struct mmc_request *mrq,
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 1e9a45b..5bb1ce2 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -318,5 +318,7 @@ struct mmci_host {
 	int (*get_rx_fifocnt)(struct mmci_host *h, u32 status, int remain);
 
 	void			*dma_priv;
+
+	s32			next_cookie;
 };
 
-- 
2.7.4
