From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 2/2] mmc: mmci: add unstuck feature
Date: Fri, 11 Oct 2019 15:15:02 +0200
Message-ID: <20191011131502.29579-3-ludovic.Barre@st.com>
References: <20191011131502.29579-1-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191011131502.29579-1-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

On busy_timeout feature if busy is too long on R1B command
a datatimeout occurs and a specific actions is needed to clear
the DPSM bit:
-reset the controller to clear the DPSM bit.
-restore registers: clk, pwr, datactrl.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 40e72c30ea84..dafba4e0afc5 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1320,7 +1320,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		cmd->error = -EILSEQ;
 	} else if (host->variant->busy_timeout && busy_resp &&
 		   status & MCI_DATATIMEOUT) {
-		cmd->error = -ETIMEDOUT;
+		cmd->error = -EDEADLK;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
 		cmd->resp[1] = readl(base + MMCIRESPONSE1);
@@ -1332,7 +1332,6 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		if (host->data) {
 			/* Terminate the DMA transfer */
 			mmci_dma_error(host);
-
 			mmci_stop_data(host);
 			if (host->variant->cmdreg_stop && cmd->error) {
 				mmci_stop_command(host);
@@ -1787,6 +1786,25 @@ static int mmci_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
 	return ret;
 }
 
+static void mmci_hw_unstuck(struct mmc_host *mmc)
+{
+	struct mmci_host *host = mmc_priv(mmc);
+	unsigned long flags;
+
+	if (host->rst) {
+		reset_control_assert(host->rst);
+		udelay(2);
+		reset_control_deassert(host->rst);
+	}
+
+	spin_lock_irqsave(&host->lock, flags);
+	writel(host->clk_reg, host->base + MMCICLOCK);
+	writel(host->pwr_reg, host->base + MMCIPOWER);
+	writel(MCI_IRQENABLE | host->variant->start_err,
+	       host->base + MMCIMASK0);
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
 static struct mmc_host_ops mmci_ops = {
 	.request	= mmci_request,
 	.pre_req	= mmci_pre_request,
@@ -1795,6 +1813,7 @@ static struct mmc_host_ops mmci_ops = {
 	.get_ro		= mmc_gpio_get_ro,
 	.get_cd		= mmci_get_cd,
 	.start_signal_voltage_switch = mmci_sig_volt_switch,
+	.hw_unstuck	= mmci_hw_unstuck,
 };
 
 static int mmci_of_parse(struct device_node *np, struct mmc_host *mmc)
-- 
2.17.1
