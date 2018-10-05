From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V5 11/24] mmc: mmci: add set_clk/pwrreg callbacks
Date: Fri, 5 Oct 2018 15:22:49 +0200
Message-ID: <1538745782-27446-12-git-send-email-ludovic.Barre@st.com>
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

This patch adds set_clkreg and set_pwrreg callbacks
at mmci_host_ops to allow to call specific variant.
extends visibility of mmci_write_clk/pwrreg functions
to be used into specific file variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 16 ++++++++++++----
 drivers/mmc/host/mmci.h |  5 +++++
 2 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 0444aba..e5cd199 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -251,7 +251,7 @@ static void mmci_reg_delay(struct mmci_host *host)
 /*
  * This must be called with host->lock held
  */
-static void mmci_write_clkreg(struct mmci_host *host, u32 clk)
+void mmci_write_clkreg(struct mmci_host *host, u32 clk)
 {
 	if (host->clk_reg != clk) {
 		host->clk_reg = clk;
@@ -262,7 +262,7 @@ static void mmci_write_clkreg(struct mmci_host *host, u32 clk)
 /*
  * This must be called with host->lock held
  */
-static void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
+void mmci_write_pwrreg(struct mmci_host *host, u32 pwr)
 {
 	if (host->pwr_reg != pwr) {
 		host->pwr_reg = pwr;
@@ -1565,8 +1565,16 @@ static void mmci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 
 	spin_lock_irqsave(&host->lock, flags);
 
-	mmci_set_clkreg(host, ios->clock);
-	mmci_write_pwrreg(host, pwr);
+	if (host->ops && host->ops->set_clkreg)
+		host->ops->set_clkreg(host, ios->clock);
+	else
+		mmci_set_clkreg(host, ios->clock);
+
+	if (host->ops && host->ops->set_pwrreg)
+		host->ops->set_pwrreg(host, pwr);
+	else
+		mmci_write_pwrreg(host, pwr);
+
 	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index f103465..e4bb527 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -284,6 +284,8 @@ struct mmci_host_ops {
 	int (*dma_start)(struct mmci_host *host, unsigned int *datactrl);
 	void (*dma_finalize)(struct mmci_host *host, struct mmc_data *data);
 	void (*dma_error)(struct mmci_host *host);
+	void (*set_clkreg)(struct mmci_host *host, unsigned int desired);
+	void (*set_pwrreg)(struct mmci_host *host, unsigned int pwr);
 };
 
 struct mmci_host {
@@ -344,6 +346,9 @@ static inline void mmci_variant_init(struct mmci_host *host)
 }
 #endif
 
+void mmci_write_clkreg(struct mmci_host *host, u32 clk);
+void mmci_write_pwrreg(struct mmci_host *host, u32 pwr);
+
 int mmci_dmae_prep_data(struct mmci_host *host, struct mmc_data *data,
 			bool next);
 void mmci_dmae_unprep_data(struct mmci_host *host, struct mmc_data *data,
-- 
2.7.4
