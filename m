From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH  1/4] mmc: mmci: avoid fake busy polling
Date: Tue, 5 Mar 2019 17:10:02 +0100
Message-ID: <1551802205-32188-2-git-send-email-ludovic.Barre@st.com>
References: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1551802205-32188-1-git-send-email-ludovic.Barre@st.com>
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

The busy status bit could occurred even if no busy response is
expected (example cmd11). On sdmmc variant, the busy_detect_flag
reflects inverted value of d0 state, it's sampled at the end of a
CMD response and a second time 2 clk cycles after the CMD response.
To avoid a fake busy, the busy status could be checked and polled
only if the command has RSP_BUSY flag.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 387ff14..4901b73 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1220,12 +1220,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	     unsigned int status)
 {
 	void __iomem *base = host->base;
-	bool sbc;
+	bool sbc, busy_resp;
 
 	if (!cmd)
 		return;
 
 	sbc = (cmd == host->mrq->sbc);
+	busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
 
 	/*
 	 * We need to be one of these interrupts to be considered worth
@@ -1239,8 +1240,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	/*
 	 * ST Micro variant: handle busy detection.
 	 */
-	if (host->variant->busy_detect) {
-		bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
+	if (busy_resp && host->variant->busy_detect) {
 
 		/* We are busy with a command, return */
 		if (host->busy_status &&
@@ -1253,7 +1253,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 * that the special busy status bit is still set before
 		 * proceeding.
 		 */
-		if (!host->busy_status && busy_resp &&
+		if (!host->busy_status &&
 		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
 		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
 
@@ -1508,6 +1508,7 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 {
 	struct mmci_host *host = dev_id;
 	u32 status;
+	bool busy_resp;
 	int ret = 0;
 
 	spin_lock(&host->lock);
@@ -1550,9 +1551,15 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
 		}
 
 		/*
-		 * Don't poll for busy completion in irq context.
+		 * Don't poll for:
+		 * -busy completion in irq context.
+		 * -no busy response expected.
 		 */
-		if (host->variant->busy_detect && host->busy_status)
+		busy_resp = host->cmd ?
+			!!(host->cmd->flags & MMC_RSP_BUSY) : false;
+
+		if (host->variant->busy_detect &&
+		    (!busy_resp || host->busy_status))
 			status &= ~host->variant->busy_detect_flag;
 
 		ret = 1;
-- 
2.7.4
