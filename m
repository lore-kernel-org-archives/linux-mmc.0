From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 21/27] mmc: mmci: add variant property to write datactrl before command
Date: Tue, 18 Sep 2018 12:55:38 +0200
Message-ID: <1537268144-21152-22-git-send-email-ludovic.Barre@st.com>
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

This patch adds a boolean property to allow to write datactrl
before to send command, whatever the command type (read or write).
Needed to support the STM32 sdmmc variant.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 6 ++++--
 drivers/mmc/host/mmci.h | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index f61b10b..b525ba4 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1239,7 +1239,8 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		mmci_request_end(host, host->mrq);
 	} else if (sbc) {
 		mmci_start_command(host, host->mrq->cmd, 0);
-	} else if (!(cmd->data->flags & MMC_DATA_READ)) {
+	} else if (!host->variant->datactrl_first &&
+		   !(cmd->data->flags & MMC_DATA_READ)) {
 		mmci_start_data(host, cmd->data);
 	}
 }
@@ -1503,7 +1504,8 @@ static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
 	if (mrq->data)
 		mmci_get_next_data(host, mrq->data);
 
-	if (mrq->data && mrq->data->flags & MMC_DATA_READ)
+	if (mrq->data &&
+	    (host->variant->datactrl_first || mrq->data->flags & MMC_DATA_READ))
 		mmci_start_data(host, mrq->data);
 
 	if (mrq->sbc)
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index bb25160..89e6733 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -223,6 +223,7 @@ struct mmci_host;
  * @datactrl_mask_sdio: SDIO enable mask in datactrl register
  * @datactrl_blksz: block size in power of two
  * @datactrl_dpsm_enable: enable value for DPSM
+ * @datactrl_first: true if data must be setup before send command
  * @pwrreg_powerup: power up value for MMCIPOWER register
  * @f_max: maximum clk frequency supported by the controller.
  * @signal_direction: input/out direction of bus signals can be indicated
@@ -262,6 +263,7 @@ struct variant_data {
 	unsigned int		datactrl_mask_sdio;
 	unsigned int		datactrl_blocksz;
 	unsigned int		datactrl_dpsm_enable;
+	bool			datactrl_first;
 	bool			st_sdio;
 	bool			st_clkdiv;
 	bool			blksz_datactrl16;
-- 
2.7.4
