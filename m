From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH 1/1] mmc: mmci: add threaded irq to abort DPSM of
 non-functional state
Date: Wed, 13 Nov 2019 18:25:14 +0100
Message-ID: <20191113172514.19052-1-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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

If datatimeout occurs on R1B request, the Data Path State Machine stays
in busy and is non-functional. Only a reset aborts the DPSM.

Like a reset must be outside of critical section, this patch adds
threaded irq function to release state machine. In this case,
the mmc_request_done is called at the end of threaded irq and
skipped into irq handler.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 44 ++++++++++++++++++++++++++++++++++++-----
 drivers/mmc/host/mmci.h |  1 +
 2 files changed, 40 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 40e72c30ea84..ec6e249c87ca 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -556,6 +556,9 @@ static void mmci_dma_error(struct mmci_host *host)
 static void
 mmci_request_end(struct mmci_host *host, struct mmc_request *mrq)
 {
+	if (host->irq_action == IRQ_WAKE_THREAD)
+		return;
+
 	writel(0, host->base + MMCICOMMAND);
 
 	BUG_ON(host->data);
@@ -1321,6 +1324,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	} else if (host->variant->busy_timeout && busy_resp &&
 		   status & MCI_DATATIMEOUT) {
 		cmd->error = -ETIMEDOUT;
+		host->irq_action = IRQ_WAKE_THREAD;
 	} else {
 		cmd->resp[0] = readl(base + MMCIRESPONSE0);
 		cmd->resp[1] = readl(base + MMCIRESPONSE1);
@@ -1532,9 +1536,9 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 {
 	struct mmci_host *host = dev_id;
 	u32 status;
-	int ret = 0;
 
 	spin_lock(&host->lock);
+	host->irq_action = IRQ_HANDLED;
 
 	do {
 		status = readl(host->base + MMCISTATUS);
@@ -1574,12 +1578,41 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		if (host->variant->busy_detect_flag)
 			status &= ~host->variant->busy_detect_flag;
 
-		ret = 1;
 	} while (status);
 
 	spin_unlock(&host->lock);
 
-	return IRQ_RETVAL(ret);
+	return host->irq_action;
+}
+
+/*
+ * mmci_irq_threaded is call if the mmci host need to release state machines
+ * before to terminate the request.
+ * If datatimeout occurs on R1B request, the Data Path State Machine stays
+ * in busy and is non-functional. Only a reset can to abort the DPSM.
+ */
+static irqreturn_t mmci_irq_threaded(int irq, void *dev_id)
+{
+	struct mmci_host *host = dev_id;
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
+
+	host->irq_action = IRQ_HANDLED;
+	mmci_request_end(host, host->mrq);
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return host->irq_action;
 }
 
 static void mmci_request(struct mmc_host *mmc, struct mmc_request *mrq)
@@ -2071,8 +2104,9 @@ static int mmci_probe(struct amba_device *dev,
 			goto clk_disable;
 	}
 
-	ret = devm_request_irq(&dev->dev, dev->irq[0], mmci_irq, IRQF_SHARED,
-			DRIVER_NAME " (cmd)", host);
+	ret = devm_request_threaded_irq(&dev->dev, dev->irq[0], mmci_irq,
+					mmci_irq_threaded, IRQF_SHARED,
+					DRIVER_NAME " (cmd)", host);
 	if (ret)
 		goto clk_disable;
 
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 158e1231aa23..5e63c0596364 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -412,6 +412,7 @@ struct mmci_host {
 
 	struct timer_list	timer;
 	unsigned int		oldstat;
+	u32			irq_action;
 
 	/* pio stuff */
 	struct sg_mapping_iter	sg_miter;
-- 
2.17.1
