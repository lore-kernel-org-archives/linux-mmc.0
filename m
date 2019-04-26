From: Ludovic Barre <ludovic.Barre@st.com>
Subject: [PATCH V2 1/5] mmc: mmci: cleanup mmci_cmd_irq for busy detect feature
Date: Fri, 26 Apr 2019 09:46:34 +0200
Message-ID: <1556264798-18540-2-git-send-email-ludovic.Barre@st.com>
References: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1556264798-18540-1-git-send-email-ludovic.Barre@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: srinivas.kandagatla@linaro.org, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue <alexandre.torgue@st.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, Ludovic Barre <ludovic.barre@st.com>
List-Id: linux-mmc@vger.kernel.org

From: Ludovic Barre <ludovic.barre@st.com>

This patch cleans mmci_cmd_irq function for busy detect feature.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
---
 drivers/mmc/host/mmci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index 9e9596a..049f8e3 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1205,12 +1205,13 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
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
@@ -1224,8 +1225,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 	/*
 	 * ST Micro variant: handle busy detection.
 	 */
-	if (host->variant->busy_detect) {
-		bool busy_resp = !!(cmd->flags & MMC_RSP_BUSY);
+	if (busy_resp && host->variant->busy_detect) {
 
 		/* We are busy with a command, return */
 		if (host->busy_status &&
@@ -1238,7 +1238,7 @@ mmci_cmd_irq(struct mmci_host *host, struct mmc_command *cmd,
 		 * that the special busy status bit is still set before
 		 * proceeding.
 		 */
-		if (!host->busy_status && busy_resp &&
+		if (!host->busy_status &&
 		    !(status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT)) &&
 		    (readl(base + MMCISTATUS) & host->variant->busy_detect_flag)) {
 
-- 
2.7.4
