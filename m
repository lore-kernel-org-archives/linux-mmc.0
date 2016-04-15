From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 02/23] mmc: sdhci: move sdhci_get_cd() forward to avoid
 declaration
Date: Sat, 16 Apr 2016 01:29:26 +0800
Message-ID: <1460741387-23815-3-git-send-email-aisheng.dong@nxp.com>
References: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1460741387-23815-1-git-send-email-aisheng.dong@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-mmc@vger.kernel.org
Cc: aisheng.dong@nxp.com, ulf.hansson@linaro.org, dongas86@gmail.com, chris@printf.net, haibo.chen@nxp.com, adrian.hunter@intel.com, shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

Move sdhci_get_cd() to avoid needing to declare this function
before use.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci.c | 55 ++++++++++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 28 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index be52a3a..839aa4c 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -53,7 +53,6 @@ static void sdhci_finish_data(struct sdhci_host *);
 static void sdhci_finish_command(struct sdhci_host *);
 static int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode);
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
-static int sdhci_get_cd(struct mmc_host *mmc);
 
 #ifdef CONFIG_PM
 static void sdhci_runtime_pm_bus_on(struct sdhci_host *host);
@@ -161,6 +160,33 @@ static void sdhci_disable_card_detection(struct sdhci_host *host)
 	sdhci_set_card_detection(host, false);
 }
 
+static int sdhci_get_cd(struct mmc_host *mmc)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int gpio_cd = mmc_gpio_get_cd(mmc);
+
+	if (host->flags & SDHCI_DEVICE_DEAD)
+		return 0;
+
+	/* If nonremovable, assume that the card is always present. */
+	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
+		return 1;
+
+	/*
+	 * Try slot gpio detect, if defined it take precedence
+	 * over build in controller functionality
+	 */
+	if (!IS_ERR_VALUE(gpio_cd))
+		return !!gpio_cd;
+
+	/* If polling, assume that the card is always present. */
+	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
+		return 1;
+
+	/* Host native card detect */
+	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
+}
+
 void sdhci_reset(struct sdhci_host *host, u8 mask)
 {
 	unsigned long timeout;
@@ -1551,33 +1577,6 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int sdhci_get_cd(struct mmc_host *mmc)
-{
-	struct sdhci_host *host = mmc_priv(mmc);
-	int gpio_cd = mmc_gpio_get_cd(mmc);
-
-	if (host->flags & SDHCI_DEVICE_DEAD)
-		return 0;
-
-	/* If nonremovable, assume that the card is always present. */
-	if (host->mmc->caps & MMC_CAP_NONREMOVABLE)
-		return 1;
-
-	/*
-	 * Try slot gpio detect, if defined it take precedence
-	 * over build in controller functionality
-	 */
-	if (!IS_ERR_VALUE(gpio_cd))
-		return !!gpio_cd;
-
-	/* If polling, assume that the card is always present. */
-	if (host->quirks & SDHCI_QUIRK_BROKEN_CARD_DETECTION)
-		return 1;
-
-	/* Host native card detect */
-	return !!(sdhci_readl(host, SDHCI_PRESENT_STATE) & SDHCI_CARD_PRESENT);
-}
-
 static int sdhci_check_ro(struct sdhci_host *host)
 {
 	unsigned long flags;
-- 
1.9.1
