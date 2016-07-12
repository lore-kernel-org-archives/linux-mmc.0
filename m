From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 01/15] mmc: sdhci: using common mmc_regulator_set_vqmmc()
Date: Tue, 12 Jul 2016 15:46:10 +0800
Message-ID: <1468309584-3591-2-git-send-email-aisheng.dong@nxp.com>
References: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1468309584-3591-1-git-send-email-aisheng.dong@nxp.com>
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

Switch to use the more robust common mmc_regulator_set_vqmmc()
function in MMC core which set the target voltage as close as
possible to target voltage.

We did not re-factor the whole sdhci_start_signal_voltage_switch()
cause we want to keep the original signal switch order between host
and card to avoid potential break.

Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
---
 drivers/mmc/host/sdhci.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 2ee8bfa77116..7894652b9929 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -1835,8 +1835,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
 
 		if (!IS_ERR(mmc->supply.vqmmc)) {
-			ret = regulator_set_voltage(mmc->supply.vqmmc, 2700000,
-						    3600000);
+			ret = mmc_regulator_set_vqmmc(mmc, ios);
 			if (ret) {
 				pr_warn("%s: Switching to 3.3V signalling voltage failed\n",
 					mmc_hostname(mmc));
@@ -1859,8 +1858,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		if (!(host->flags & SDHCI_SIGNALING_180))
 			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
-			ret = regulator_set_voltage(mmc->supply.vqmmc,
-					1700000, 1950000);
+			ret = mmc_regulator_set_vqmmc(mmc, ios);
 			if (ret) {
 				pr_warn("%s: Switching to 1.8V signalling voltage failed\n",
 					mmc_hostname(mmc));
@@ -1892,8 +1890,7 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
 		if (!(host->flags & SDHCI_SIGNALING_120))
 			return -EINVAL;
 		if (!IS_ERR(mmc->supply.vqmmc)) {
-			ret = regulator_set_voltage(mmc->supply.vqmmc, 1100000,
-						    1300000);
+			ret = mmc_regulator_set_vqmmc(mmc, ios);
 			if (ret) {
 				pr_warn("%s: Switching to 1.2V signalling voltage failed\n",
 					mmc_hostname(mmc));
-- 
1.9.1
