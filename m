From: Jin Guojun <kid.jin@hisilicon.com>
Subject: [PATCH 1/2] Support SD UHS for hikey-mainline-rebase
Date: Tue, 19 Jul 2016 15:51:52 +0800
Message-ID: <1468914713-63347-1-git-send-email-kid.jin@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ulf.hansson@linaro.org, adrian.hunter@intel.com, jh80.chung@samsung.com, wsa+renesas@sang-engineering.com, arnd@arndb.de, rmk+kernel@arm.linux.org.uk, shawn.lin@rock-chips.com, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, xuwei5@hisilicon.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, catalin.marinas@arm.com, will.deacon@arm.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linuxarm@huawei.com, suzhuangluan@hisilicon.com, kongfei@hisilicon.com, kid.jin@hisilicon.com
List-Id: linux-mmc@vger.kernel.org

From: j00226943 <j00226943@notesmail.huawei.com>

Two more changes:

Before we send cmd,we need to set CMD bit29 to
1 so that CMD and DATA sent to card through the HOLD Register,
This is the explication in synosys host:To meet the relatively
high Input Hold Time requirement for SDR12, SDR25, and other MMC
speed modes, you should program bit[29]use_hold_Reg of the CMD
register to 1'b1; the output data is then registered again in the
cclk_in_drv domain by using the Hold Register as shown in Path B
of Figure 10-8. However, for the higher speed modes of SDR104, SDR50
and DDR50, you can meet the much smaller Input Hold Time requirement
of 0.8ns by bypassing the Hold Register (Path A in Figure 10-8,
programming CMD.use_hold_reg = 1'b0) and then adding delay elements
on the output path as indicated

We have no tuning function in our drivers,so we must do the
Function piling when we init UHS card.

Signed-off-by: Jin Guojun <kid.jin@hisilicon.com>
---
 drivers/mmc/host/dw_mmc-k3.c | 6 ++++++
 drivers/mmc/host/dw_mmc.c    | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
index 63c2e2e..2cbfcc7 100644
--- a/drivers/mmc/host/dw_mmc-k3.c
+++ b/drivers/mmc/host/dw_mmc-k3.c
@@ -125,10 +125,16 @@ static void dw_mci_hi6220_set_ios(struct dw_mci *host, struct mmc_ios *ios)
 	host->bus_hz = clk_get_rate(host->biu_clk);
 }
 
+static void dw_mci_hi6220_prepare_command(struct dw_mci *host, u32 *cmdr)
+{
+	*cmdr |= SDMMC_CMD_USE_HOLD_REG;
+}
+
 static const struct dw_mci_drv_data hi6220_data = {
 	.switch_voltage		= dw_mci_hi6220_switch_voltage,
 	.set_ios		= dw_mci_hi6220_set_ios,
 	.parse_dt		= dw_mci_hi6220_parse_dt,
+	.prepare_command        = dw_mci_hi6220_prepare_command,
 };
 
 static const struct of_device_id dw_mci_k3_match[] = {
diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 9dd1bd3..047e116 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -1564,6 +1564,8 @@ static int dw_mci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 
 	if (drv_data && drv_data->execute_tuning)
 		err = drv_data->execute_tuning(slot, opcode);
+	else
+		err = 0;
 	return err;
 }
 
-- 
1.8.3.2
