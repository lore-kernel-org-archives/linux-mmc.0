From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: [PATCH] mmc: sunxi: Prevent against null dereference for vmmc
Date: Wed, 19 Oct 2016 14:36:29 +0200
Message-ID: <20161019123629.14525-1-maxime.ripard@free-electrons.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

VMMC is an optional regulator, which means that mmc_regulator_get_supply
will only return an error in case of a deferred probe, but not when the
regulator is not set in the DT.

However, the sunxi driver assumes that VMMC is always there, and doesn't
check the value of the regulator pointer before using it, which obviously
leads to a (close to) null pointer dereference.

Add proper checks to prevent that.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/mmc/host/sunxi-mmc.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
index c0a5c676d0e8..45a051e7d650 100644
--- a/drivers/mmc/host/sunxi-mmc.c
+++ b/drivers/mmc/host/sunxi-mmc.c
@@ -822,10 +822,16 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 		break;
 
 	case MMC_POWER_UP:
-		host->ferror = mmc_regulator_set_ocr(mmc, mmc->supply.vmmc,
-						     ios->vdd);
-		if (host->ferror)
-			return;
+		if (!IS_ERR(mmc->supply.vmmc)) {
+			host->ferror = mmc_regulator_set_ocr(mmc,
+							     mmc->supply.vmmc,
+							     ios->vdd);
+			if (host->ferror) {
+				dev_err(mmc_dev(mmc),
+					"failed to enable vmmc\n");
+				return;
+			}
+		}
 
 		if (!IS_ERR(mmc->supply.vqmmc)) {
 			host->ferror = regulator_enable(mmc->supply.vqmmc);
@@ -847,7 +853,9 @@ static void sunxi_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
 	case MMC_POWER_OFF:
 		dev_dbg(mmc_dev(mmc), "power off!\n");
 		sunxi_mmc_reset_host(host);
-		mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+		if (!IS_ERR(mmc->supply.vmmc))
+			mmc_regulator_set_ocr(mmc, mmc->supply.vmmc, 0);
+
 		if (!IS_ERR(mmc->supply.vqmmc) && host->vqmmc_enabled)
 			regulator_disable(mmc->supply.vqmmc);
 		host->vqmmc_enabled = false;
-- 
2.9.3
