From: LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>
Subject: [PATCH 1/3] mmc: sdhci-pci-o2micro: Add hardware tuning for eMMC
Date: Mon, 4 Dec 2017 09:39:30 +0000
Message-ID: <CY4PR04MB047375B124358A33FB077C6EED3C0@CY4PR04MB0473.namprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-cys01nam02on0128.outbound.protection.outlook.com ([104.47.37.128]:44352
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751522AbdLDJje (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 4 Dec 2017 04:39:34 -0500
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: LinuxPatchCommit <LinuxPatchCommit@bayhubtech.com>, "Shirley Her (SC)" <shirley.her@bayhubtech.com>

Dear All,

For O2micro/Bayhubtech SD Host DeviceID 8620, eMMC HS200 mode is working at=
 1.8v and it uses hardware tuning. The hardware tuning only needs to send o=
ne tuning command instead of multiple tuning commands with software tuning.

Signed-off-by: ernest.zhang <ernest.zhang@bayhubtech.com>
---
 drivers/mmc/host/sdhci-pci-o2micro.c | 276 ++++++++++++++++++++++++++++++-=
----
 1 file changed, 239 insertions(+), 37 deletions(-)

diff --git a/drivers/mmc/host/sdhci-pci-o2micro.c b/drivers/mmc/host/sdhci-=
pci-o2micro.c
index 14273ca00641..2a7ffd240497 100644
--- a/drivers/mmc/host/sdhci-pci-o2micro.c
+++ b/drivers/mmc/host/sdhci-pci-o2micro.c
@@ -16,22 +16,223 @@
  */
=20
 #include <linux/pci.h>
-
+#include <linux/platform_device.h>
+#include <linux/regulator/fixed.h>
+#include <linux/regulator/machine.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
+#include <linux/delay.h>
 #include "sdhci.h"
 #include "sdhci-pci.h"
 #include "sdhci-pci-o2micro.h"
=20
+static void sdhci_o2_start_tuning(struct sdhci_host *host) {
+	u16 ctrl;
+
+	ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl |=3D SDHCI_CTRL_EXEC_TUNING;
+	if (host->quirks2 & SDHCI_QUIRK2_TUNING_WORK_AROUND)
+		ctrl |=3D SDHCI_CTRL_TUNED_CLK;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2);
+
+	/*
+	 * As per the Host Controller spec v3.00, tuning command
+	 * generates Buffer Read Ready interrupt, so enable that.
+	 *
+	 * Note: The spec clearly says that when tuning sequence
+	 * is being performed, the controller does not generate
+	 * interrupts other than Buffer Read Ready interrupt. But
+	 * to make sure we don't hit a controller bug, we _only_
+	 * enable Buffer Read Ready interrupt here.
+	 */
+	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_INT_ENABLE);
+	sdhci_writel(host, SDHCI_INT_DATA_AVAIL, SDHCI_SIGNAL_ENABLE); }
+
+static void sdhci_o2_end_tuning(struct sdhci_host *host) {
+	sdhci_writel(host, host->ier, SDHCI_INT_ENABLE);
+	sdhci_writel(host, host->ier, SDHCI_SIGNAL_ENABLE); }
+
+static inline bool sdhci_data_line_cmd(struct mmc_command *cmd) {
+	return cmd->data || cmd->flags & MMC_RSP_BUSY; }
+
+static void sdhci_del_timer(struct sdhci_host *host, struct mmc_request=20
+*mrq) {
+	if (sdhci_data_line_cmd(mrq->cmd))
+		del_timer(&host->data_timer);
+	else
+		del_timer(&host->timer);
+}
+
+static void sdhci_o2_set_tuning_mode(struct sdhci_host *host, bool hw)=20
+{
+	u16 reg;
+
+	if (hw) {
+		// enable hardware tuning
+		reg =3D sdhci_readw(host, O2_SD_VENDOR_SETTING);
+		reg &=3D (~O2_SD_HW_TUNING_ENABLE);
+		sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
+	} else {
+		reg =3D sdhci_readw(host, O2_SD_VENDOR_SETTING);
+		reg |=3D O2_SD_HW_TUNING_ENABLE;
+		sdhci_writew(host, reg, O2_SD_VENDOR_SETTING);
+	}
+}
+
+static u8 data_buf[64];
+
+static void sdhci_o2_send_tuning(struct sdhci_host *host, u32 opcode) {
+	struct mmc_command cmd =3D { };
+	struct mmc_data data =3D { };
+	struct scatterlist sg;
+	struct mmc_request mrq =3D { };
+	unsigned long flags;
+	u32 b =3D host->sdma_boundary;
+	int size =3D sizeof(data_buf);
+
+	cmd.opcode =3D opcode;
+	cmd.flags =3D MMC_RSP_PRESENT | MMC_RSP_OPCODE | MMC_RSP_CRC;
+	cmd.mrq =3D &mrq;
+	mrq.cmd =3D &cmd;
+	mrq.data =3D &data;
+	data.blksz =3D size;
+	data.blocks =3D 1;
+	data.flags =3D MMC_DATA_READ;
+
+	data.timeout_ns =3D 150 * NSEC_PER_MSEC;
+
+	data.sg =3D &sg;
+	data.sg_len =3D 1;
+	sg_init_one(&sg, data_buf, size);
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	sdhci_writew(host, SDHCI_MAKE_BLKSZ(b, 64), SDHCI_BLOCK_SIZE);
+
+	/*
+	 * The tuning block is sent by the card to the host controller.
+	 * So we set the TRNS_READ bit in the Transfer Mode register.
+	 * This also takes care of setting DMA Enable and Multi Block
+	 * Select in the same register to 0.
+	 */
+	sdhci_writew(host, SDHCI_TRNS_READ, SDHCI_TRANSFER_MODE);
+
+	sdhci_send_command(host, &cmd);
+
+	host->cmd =3D NULL;
+
+	sdhci_del_timer(host, &mrq);
+
+	host->tuning_done =3D 0;
+
+	mmiowb();
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	/* Wait for Buffer Read Ready interrupt */
+	wait_event_timeout(host->buf_ready_int, (host->tuning_done =3D=3D 1),
+			   msecs_to_jiffies(50));
+
+}
+
+static void sdhci_o2_reset_tuning(struct sdhci_host *host) {
+	u16 ctrl;
+
+	ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl &=3D ~SDHCI_CTRL_TUNED_CLK;
+	ctrl &=3D ~SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, ctrl, SDHCI_HOST_CONTROL2); }
+
+static void __sdhci_o2_execute_tuning(struct sdhci_host *host, u32=20
+opcode) {
+
+	int i;
+
+	sdhci_o2_send_tuning(host, MMC_SEND_TUNING_BLOCK_HS200);
+
+	for (i =3D 0; i < 150; i++) {
+		u16 ctrl =3D sdhci_readw(host, SDHCI_HOST_CONTROL2);
+
+		if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+			if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+				pr_info("%s: HW tuning ok !\n",
+					mmc_hostname(host->mmc));
+				host->tuning_done =3D true;
+				return;
+			}
+			pr_warn("%s: HW tuning failed !\n",
+				mmc_hostname(host->mmc));
+
+			break;
+		}
+
+		mdelay(1);
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_o2_reset_tuning(host);
+
+}
+
+static int sdhci_o2_execute_tuning(struct mmc_host *mmc, u32 opcode) {
+	struct sdhci_host *host =3D mmc_priv(mmc);
+	int current_bus_width =3D 0;
+
+	/*
+	 * This handler only implements the eMMC tuning that is specific to
+	 * this controller.  Fall back to the standard method for other TINMING.
+	 */
+	if (host->timing !=3D MMC_TIMING_MMC_HS200)
+		return sdhci_execute_tuning(mmc, opcode);
+
+	if (WARN_ON(opcode !=3D MMC_SEND_TUNING_BLOCK_HS200))
+		return -EINVAL;
+
+	/*
+	 * o2 sdhci host didn't support 8bit emmc tuning
+	 */
+	if (mmc->ios.bus_width =3D=3D MMC_BUS_WIDTH_8) {
+		current_bus_width =3D mmc->ios.bus_width;
+		mmc->ios.bus_width =3D MMC_BUS_WIDTH_4;
+		mmc->ops->set_ios(mmc, &mmc->ios);
+	}
+
+	sdhci_o2_set_tuning_mode(host, true);
+
+	sdhci_o2_start_tuning(host);
+
+	__sdhci_o2_execute_tuning(host, opcode);
+
+	sdhci_o2_end_tuning(host);
+
+	if (current_bus_width =3D=3D MMC_BUS_WIDTH_8) {
+		mmc->ios.bus_width =3D current_bus_width;
+		mmc->ops->set_ios(mmc, &mmc->ios);
+	}
+
+	host->flags &=3D ~SDHCI_HS400_TUNING;
+	return 0;
+}
+
 static void o2_pci_set_baseclk(struct sdhci_pci_chip *chip, u32 value)  {
 	u32 scratch_32;
-	pci_read_config_dword(chip->pdev,
-			      O2_SD_PLL_SETTING, &scratch_32);
+	pci_read_config_dword(chip->pdev, O2_SD_PLL_SETTING, &scratch_32);
=20
 	scratch_32 &=3D 0x0000FFFF;
 	scratch_32 |=3D value;
=20
-	pci_write_config_dword(chip->pdev,
-			       O2_SD_PLL_SETTING, scratch_32);
+	pci_write_config_dword(chip->pdev, O2_SD_PLL_SETTING, scratch_32);
 }
=20
 static void o2_pci_led_enable(struct sdhci_pci_chip *chip) @@ -40,23 +241,=
19 @@ static void o2_pci_led_enable(struct sdhci_pci_chip *chip)
 	u32 scratch_32;
=20
 	/* Set led of SD host function enable */
-	ret =3D pci_read_config_dword(chip->pdev,
-				    O2_SD_FUNC_REG0, &scratch_32);
+	ret =3D pci_read_config_dword(chip->pdev, O2_SD_FUNC_REG0, &scratch_32);
 	if (ret)
 		return;
=20
 	scratch_32 &=3D ~O2_SD_FREG0_LEDOFF;
-	pci_write_config_dword(chip->pdev,
-			       O2_SD_FUNC_REG0, scratch_32);
+	pci_write_config_dword(chip->pdev, O2_SD_FUNC_REG0, scratch_32);
=20
-	ret =3D pci_read_config_dword(chip->pdev,
-				    O2_SD_TEST_REG, &scratch_32);
+	ret =3D pci_read_config_dword(chip->pdev, O2_SD_TEST_REG, &scratch_32);
 	if (ret)
 		return;
=20
 	scratch_32 |=3D O2_SD_LED_ENABLE;
-	pci_write_config_dword(chip->pdev,
-			       O2_SD_TEST_REG, scratch_32);
+	pci_write_config_dword(chip->pdev, O2_SD_TEST_REG, scratch_32);
=20
 }
=20
@@ -104,8 +301,7 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_p=
ci_chip *chip)
 	scratch_32 |=3D 0x00CC;
 	pci_write_config_dword(chip->pdev, O2_SD_CAP_REG0, scratch_32);
 	/* Set DLL Tuning Window */
-	ret =3D pci_read_config_dword(chip->pdev,
-				    O2_SD_TUNING_CTRL, &scratch_32);
+	ret =3D pci_read_config_dword(chip->pdev, O2_SD_TUNING_CTRL,=20
+&scratch_32);
 	if (ret)
 		return;
 	scratch_32 &=3D ~(0x000000FF);
@@ -137,8 +333,7 @@ static void sdhci_pci_o2_fujin2_pci_init(struct sdhci_p=
ci_chip *chip)
 	scratch_32 |=3D 0x30000000;
 	pci_write_config_dword(chip->pdev, O2_SD_CAPS, scratch_32);
=20
-	ret =3D pci_read_config_dword(chip->pdev,
-				    O2_SD_MISC_CTRL4, &scratch_32);
+	ret =3D pci_read_config_dword(chip->pdev, O2_SD_MISC_CTRL4,=20
+&scratch_32);
 	if (ret)
 		return;
 	scratch_32 &=3D ~(0x000f0000);
@@ -151,6 +346,7 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot=
)
 	struct sdhci_pci_chip *chip;
 	struct sdhci_host *host;
 	u32 reg;
+	int ret;
=20
 	chip =3D slot->chip;
 	host =3D slot->host;
@@ -164,6 +360,22 @@ int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slo=
t)
 		if (reg & 0x1)
 			host->quirks |=3D SDHCI_QUIRK_MULTIBLOCK_READ_ACMD12;
=20
+		if (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_SEABIRD0) {
+			ret =3D pci_read_config_dword(chip->pdev,
+						    O2_SD_MISC_SETTING, &reg);
+			if (ret)
+				return -EIO;
+			if (reg & (1 << 4)) {
+				pr_info("%s: emmc 1.8v flag is set,
+					force 1.8v signaling voltage\n",
+					mmc_hostname(host->mmc));
+				host->flags &=3D ~(SDHCI_SIGNALING_330);
+				host->flags |=3D SDHCI_SIGNALING_180;
+			}
+		}
+
+		host->mmc_host_ops.execute_tuning =3D sdhci_o2_execute_tuning;
+
 		if (chip->pdev->device !=3D PCI_DEVICE_ID_O2_FUJIN2)
 			break;
 		/* set dll watch dog timer */
@@ -191,8 +403,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 	case PCI_DEVICE_ID_O2_8320:
 	case PCI_DEVICE_ID_O2_8321:
 		/* This extra setup is required due to broken ADMA. */
-		ret =3D pci_read_config_byte(chip->pdev,
-				O2_SD_LOCK_WP, &scratch);
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 		if (ret)
 			return ret;
 		scratch &=3D 0x7f;
@@ -202,8 +413,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		pci_write_config_byte(chip->pdev, O2_SD_MULTI_VCC3V, 0x08);
=20
 		/* Disable CLK_REQ# support after media DET */
-		ret =3D pci_read_config_byte(chip->pdev,
-				O2_SD_CLKREQ, &scratch);
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_CLKREQ, &scratch);
 		if (ret)
 			return ret;
 		scratch |=3D 0x20;
@@ -224,16 +434,14 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		pci_write_config_byte(chip->pdev, O2_SD_ADMA2, 0x08);
=20
 		/* Disable the infinite transfer mode */
-		ret =3D pci_read_config_byte(chip->pdev,
-				O2_SD_INF_MOD, &scratch);
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_INF_MOD, &scratch);
 		if (ret)
 			return ret;
 		scratch |=3D 0x08;
 		pci_write_config_byte(chip->pdev, O2_SD_INF_MOD, scratch);
=20
 		/* Lock WP */
-		ret =3D pci_read_config_byte(chip->pdev,
-				O2_SD_LOCK_WP, &scratch);
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 		if (ret)
 			return ret;
 		scratch |=3D 0x80;
@@ -243,8 +451,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 	case PCI_DEVICE_ID_O2_SDS1:
 	case PCI_DEVICE_ID_O2_FUJIN2:
 		/* UnLock WP */
-		ret =3D pci_read_config_byte(chip->pdev,
-				O2_SD_LOCK_WP, &scratch);
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 		if (ret)
 			return ret;
=20
@@ -319,15 +526,13 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		if (ret)
 			return ret;
 		scratch_32 &=3D ~(0xE0);
-		pci_write_config_dword(chip->pdev,
-				       O2_SD_CAP_REG2, scratch_32);
+		pci_write_config_dword(chip->pdev, O2_SD_CAP_REG2, scratch_32);
=20
 		if (chip->pdev->device =3D=3D PCI_DEVICE_ID_O2_FUJIN2)
 			sdhci_pci_o2_fujin2_pci_init(chip);
=20
 		/* Lock WP */
-		ret =3D pci_read_config_byte(chip->pdev,
-					   O2_SD_LOCK_WP, &scratch);
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 		if (ret)
 			return ret;
 		scratch |=3D 0x80;
@@ -336,8 +541,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 	case PCI_DEVICE_ID_O2_SEABIRD0:
 	case PCI_DEVICE_ID_O2_SEABIRD1:
 		/* UnLock WP */
-		ret =3D pci_read_config_byte(chip->pdev,
-				O2_SD_LOCK_WP, &scratch);
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 		if (ret)
 			return ret;
=20
@@ -369,11 +573,9 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip)
 		}
=20
 		/* Set Tuning Windows to 5 */
-		pci_write_config_byte(chip->pdev,
-				O2_SD_TUNING_CTRL, 0x55);
+		pci_write_config_byte(chip->pdev, O2_SD_TUNING_CTRL, 0x55);
 		/* Lock WP */
-		ret =3D pci_read_config_byte(chip->pdev,
-					   O2_SD_LOCK_WP, &scratch);
+		ret =3D pci_read_config_byte(chip->pdev, O2_SD_LOCK_WP, &scratch);
 		if (ret)
 			return ret;
 		scratch |=3D 0x80;
--
2.14.1
