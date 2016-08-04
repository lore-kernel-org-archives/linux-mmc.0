From: Jin Guojun <kid.jin@hisilicon.com>
Subject: [PATCH V4]mmc: dw_mmc-k3: UHS-SD card for Hisilicon Hikey
Date: Thu, 4 Aug 2016 10:16:13 +0800
Message-ID: <1470276973-41683-1-git-send-email-kid.jin@hisilicon.com>
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
To: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, kid.jin@hisilicon.com, ulf.hansson@linaro.org, adrian.hunter@intel.com, jh80.chung@samsung.com, wsa+renesas@sang-engineering.com, arnd@arndb.de, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com
Cc: suzhuangluan@hisilicon.com, kongfei@hisilicon.com, guodong.xu@linaro.org
List-Id: linux-mmc@vger.kernel.org

mmc: dw_mmc-k3: Hisilicon Hikey have no tuning function in 
dw_mmc-k3.c,so we must do the tuning function stub when we init UHS card.

V1:add .prepare_command in dw_mmc.c
V2:delete .prepare_command, add err = 0 in dw_mci_execute_tuning
V3:delete err = 0 in dw_mci_execute_tuning,add .execute_tuning in 
dw_mmc-k3.c
V4:add "linux-mmc@vger.kernel.org", patch version, Changelog, etc..

Signed-off-by: Jin Guojun <kid.jin@hisilicon.com>
---
 drivers/mmc/host/dw_mmc-k3.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 8e9d886..6247894 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -131,11 +131,17 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	host->bus_hz = clk_get_rate(host->biu_clk);
 }
 
+static int dw_mci_hi6220_execute_tuning(struct dw_mci_slot *slot, u32 opcode)
+{
+	return 0;
+}
+
 static const struct dw_mci_drv_data hi6220_data = {
 	.caps			= dw_mci_hi6220_caps,
 	.switch_voltage		= dw_mci_hi6220_switch_voltage,
 	.set_ios		= dw_mci_hi6220_set_ios,
 	.parse_dt		= dw_mci_hi6220_parse_dt,
+	.execute_tuning		= dw_mci_hi6220_execute_tuning,
 };
 
 static const struct of_device_id dw_mci_k3_match[] = {
-- 
1.9.1
