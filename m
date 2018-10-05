From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V5 13/24] mmc: mmci: expand startbiterr to irqmask and error check
Date: Fri, 5 Oct 2018 15:22:51 +0200
Message-ID: <1538745782-27446-14-git-send-email-ludovic.Barre@st.com>
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

All variants don't pretend to have a startbiterr.
-While data error check, if status register return an error
(like  MCI_DATACRCFAIL) we must avoid to check MCI_STARTBITERR
(if not desired).
-expand start_err to MCI_IRQENABLE to avoid to set this bit by default.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 27 ++++++++++++++++-----------
 drivers/mmc/host/mmci.h |  6 +++---
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index aeefb6d..7e90dbe 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1036,14 +1036,18 @@ static void
 mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 	      unsigned int status)
 {
+	unsigned int status_err;
+
 	/* Make sure we have data to handle */
 	if (!data)
 		return;
 
 	/* First check for errors */
-	if (status & (MCI_DATACRCFAIL | MCI_DATATIMEOUT |
-		      host->variant->start_err |
-		      MCI_TXUNDERRUN | MCI_RXOVERRUN)) {
+	status_err = status & (host->variant->start_err |
+			       MCI_DATACRCFAIL | MCI_DATATIMEOUT |
+			       MCI_TXUNDERRUN | MCI_RXOVERRUN);
+
+	if (status_err) {
 		u32 remain, success;
 
 		/* Terminate the DMA transfer */
@@ -1060,18 +1064,18 @@ mmci_data_irq(struct mmci_host *host, struct mmc_data *data,
 		success = data->blksz * data->blocks - remain;
 
 		dev_dbg(mmc_dev(host->mmc), "MCI ERROR IRQ, status 0x%08x at 0x%08x\n",
-			status, success);
-		if (status & MCI_DATACRCFAIL) {
+			status_err, success);
+		if (status_err & MCI_DATACRCFAIL) {
 			/* Last block was not successful */
 			success -= 1;
 			data->error = -EILSEQ;
-		} else if (status & MCI_DATATIMEOUT) {
+		} else if (status_err & MCI_DATATIMEOUT) {
 			data->error = -ETIMEDOUT;
-		} else if (status & MCI_STARTBITERR) {
+		} else if (status_err & MCI_STARTBITERR) {
 			data->error = -ECOMM;
-		} else if (status & MCI_TXUNDERRUN) {
+		} else if (status_err & MCI_TXUNDERRUN) {
 			data->error = -EIO;
-		} else if (status & MCI_RXOVERRUN) {
+		} else if (status_err & MCI_RXOVERRUN) {
 			if (success > host->variant->fifosize)
 				success -= host->variant->fifosize;
 			else
@@ -1912,7 +1916,7 @@ static int mmci_probe(struct amba_device *dev,
 			goto clk_disable;
 	}
 
-	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	writel(MCI_IRQENABLE | variant->start_err, host->base + MMCIMASK0);
 
 	amba_set_drvdata(dev, mmc);
 
@@ -1999,7 +2003,8 @@ static void mmci_restore(struct mmci_host *host)
 		writel(host->datactrl_reg, host->base + MMCIDATACTRL);
 		writel(host->pwr_reg, host->base + MMCIPOWER);
 	}
-	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	writel(MCI_IRQENABLE | host->variant->start_err,
+	       host->base + MMCIMASK0);
 	mmci_reg_delay(host);
 
 	spin_unlock_irqrestore(&host->lock, flags);
diff --git a/drivers/mmc/host/mmci.h b/drivers/mmc/host/mmci.h
index 3e7b729a..87846db 100644
--- a/drivers/mmc/host/mmci.h
+++ b/drivers/mmc/host/mmci.h
@@ -181,9 +181,9 @@
 #define MMCIFIFO		0x080 /* to 0x0bc */
 
 #define MCI_IRQENABLE	\
-	(MCI_CMDCRCFAILMASK|MCI_DATACRCFAILMASK|MCI_CMDTIMEOUTMASK|	\
-	MCI_DATATIMEOUTMASK|MCI_TXUNDERRUNMASK|MCI_RXOVERRUNMASK|	\
-	MCI_CMDRESPENDMASK|MCI_CMDSENTMASK|MCI_STARTBITERRMASK)
+	(MCI_CMDCRCFAILMASK | MCI_DATACRCFAILMASK | MCI_CMDTIMEOUTMASK | \
+	MCI_DATATIMEOUTMASK | MCI_TXUNDERRUNMASK | MCI_RXOVERRUNMASK |	\
+	MCI_CMDRESPENDMASK | MCI_CMDSENTMASK)
 
 /* These interrupts are directed to IRQ1 when two IRQ lines are available */
 #define MCI_IRQ1MASK \
-- 
2.7.4
