From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 03/17] mmc: mmci: Mask IRQs for all variants during runtime
 suspend
Date: Tue,  4 Feb 2014 16:58:44 +0100
Message-ID: <1391529538-21685-4-git-send-email-ulf.hansson@linaro.org>
References: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1391529538-21685-1-git-send-email-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Chris Ball <chris@printf.net>, Mark Brown <broonie@kernel.org>, linux-i2c@vger.kernel.org, linux-spi@vger.kernel.org, Alessandro Rubini <rubini@unipv.it>
List-Id: linux-mmc@vger.kernel.org

In runtime suspended state, we are not expecting IRQs and thus we can
safely mask them, not only for pwrreg_nopower variants but for all.

Obviously we then also need to make sure we restore the IRQ mask while
becoming runtime resumed.

Cc: Russell King <linux@arm.linux.org.uk>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/mmc/host/mmci.c |   23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
index b931226..178868a 100644
--- a/drivers/mmc/host/mmci.c
+++ b/drivers/mmc/host/mmci.c
@@ -1758,35 +1758,34 @@ static void mmci_save(struct mmci_host *host)
 {
 	unsigned long flags;
 
-	if (host->variant->pwrreg_nopower) {
-		spin_lock_irqsave(&host->lock, flags);
+	spin_lock_irqsave(&host->lock, flags);
 
-		writel(0, host->base + MMCIMASK0);
+	writel(0, host->base + MMCIMASK0);
+	if (host->variant->pwrreg_nopower) {
 		writel(0, host->base + MMCIDATACTRL);
 		writel(0, host->base + MMCIPOWER);
 		writel(0, host->base + MMCICLOCK);
-		mmci_reg_delay(host);
-
-		spin_unlock_irqrestore(&host->lock, flags);
 	}
+	mmci_reg_delay(host);
 
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static void mmci_restore(struct mmci_host *host)
 {
 	unsigned long flags;
 
-	if (host->variant->pwrreg_nopower) {
-		spin_lock_irqsave(&host->lock, flags);
+	spin_lock_irqsave(&host->lock, flags);
 
+	if (host->variant->pwrreg_nopower) {
 		writel(host->clk_reg, host->base + MMCICLOCK);
 		writel(host->datactrl_reg, host->base + MMCIDATACTRL);
 		writel(host->pwr_reg, host->base + MMCIPOWER);
-		writel(MCI_IRQENABLE, host->base + MMCIMASK0);
-		mmci_reg_delay(host);
-
-		spin_unlock_irqrestore(&host->lock, flags);
 	}
+	writel(MCI_IRQENABLE, host->base + MMCIMASK0);
+	mmci_reg_delay(host);
+
+	spin_unlock_irqrestore(&host->lock, flags);
 }
 
 static int mmci_runtime_suspend(struct device *dev)
-- 
1.7.9.5
