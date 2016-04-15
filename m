From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 04/23] mmc: sdhci: re-factor sdhci_start_signal_voltage()
Date: Sat, 16 Apr 2016 01:29:28 +0800
Message-ID: <1460741387-23815-5-git-send-email-aisheng.dong@nxp.com>
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

Handle host and regulator signal voltage switch separately.
Move host signal voltage switch code into a separated function
sdhci_do_signal_voltage_switch() first, the following patches will
remove the regulator voltage switch code and use the common
mmc_regulator_set_vqmmc() instead.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci.c | 97 ++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 40 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 839aa4c..7f63f5d 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1657,19 +1657,10 @@ static void sdhci_enable_sdio_irq(struct mmc_host *mmc, int enable)
 	spin_unlock_irqrestore(&host->lock, flags);
 }
 
-static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
-					     struct mmc_ios *ios)
+static int sdhci_do_signal_voltage_switch(struct sdhci_host *host,
+					  struct mmc_ios *ios)
 {
-	struct sdhci_host *host = mmc_priv(mmc);
 	u16 ctrl;
-	int ret;
-
-	/*
-	 * Signal Voltage Switching is only applicable for Host Controllers
-	 * v3.00 and above.
-	 */
-	if (host->version < SDHCI_SPEC_300)
-		return 0;
 
 	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
 
@@ -1679,15 +1670,6 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		ctrl &= ~SDHCI_CTRL_VDD_180;
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
-		if (!IS_ERR(mmc->supply.vqmmc)) {
-			ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
-						    3600000);
-			if (ret) {
-				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
-					mmc_hostname(mmc));
-				return -EIO;
-			}
-		}
 		/* Wait for 5ms */
 		usleep_range(5000, 5500);
 
@@ -1697,20 +1679,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 			return 0;
 
 		pr_warn("%s: 3.3V regulator output did not became stable\n",
-			mmc_hostname(mmc));
+			mmc_hostname(host->mmc));
 
 		return -EAGAIN;
 	case MMC_SIGNAL_VOLTAGE_180:
-		if (!IS_ERR(mmc->supply.vqmmc)) {
-			ret = regulator_set_voltage(mmc->supply.vqmmc,
-					1700000, 1950000);
-			if (ret) {
-				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
-					mmc_hostname(mmc));
-				return -EIO;
-			}
-		}
-
 		/*
 		 * Enable 1.8V Signal Enable in the Host Control2
 		 * register
@@ -1728,18 +1700,63 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 			return 0;
 
 		pr_warn("%s: 1.8V regulator output did not became stable\n",
-			mmc_hostname(mmc));
+			mmc_hostname(host->mmc));
 
 		return -EAGAIN;
+	default:
+		/* No signal voltage switch required */
+		return 0;
+	}
+}
+
+static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
+					     struct mmc_ios *ios)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int ret;
+
+	/*
+	 * Signal Voltage Switching is only applicable for Host Controllers
+	 * v3.00 and above.
+	 */
+	if (host->version < SDHCI_SPEC_300)
+		return 0;
+
+	ret = sdhci_do_signal_voltage_switch(host, ios);
+	if (ret)
+		return ret;
+
+	if (IS_ERR(mmc->supply.vqmmc))
+		return 0;
+
+	switch (ios->signal_voltage) {
+	case MMC_SIGNAL_VOLTAGE_330:
+		ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
+					    3600000);
+		if (ret) {
+			pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
+				mmc_hostname(mmc));
+			return -EIO;
+		}
+
+		return 0;
+	case MMC_SIGNAL_VOLTAGE_180:
+		ret = regulator_set_voltage(mmc->supply.vqmmc,
+				1700000, 1950000);
+		if (ret) {
+			pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
+				mmc_hostname(mmc));
+			return -EIO;
+		}
+
+		return 0;
 	case MMC_SIGNAL_VOLTAGE_120:
-		if (!IS_ERR(mmc->supply.vqmmc)) {
-			ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
-						    1300000);
-			if (ret) {
-				pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
-					mmc_hostname(mmc));
-				return -EIO;
-			}
+		ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
+					    1300000);
+		if (ret) {
+			pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
+				mmc_hostname(mmc));
+			return -EIO;
 		}
 		return 0;
 	default:
-- 
1.9.1
