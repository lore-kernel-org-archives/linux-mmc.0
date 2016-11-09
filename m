From: Shyam Sundar S K <ssundark@amd.com>
Subject: [PATCH] mmc: sdhci-pci: Add support for HS200 tuning mode, on AMD
 eMMC-4.5.1
Date: Wed, 9 Nov 2016 12:16:28 +0530
Message-ID: <23bdf5b6-08ef-4de7-c612-49861b6693a1@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2nam03on0041.outbound.protection.outlook.com ([104.47.42.41]:10595
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751297AbcKIGqy (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 9 Nov 2016 01:46:54 -0500
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: adrian.hunter@intel.com, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, Pankaj.Sen@amd.com, Nehal-bakulchandra.Shah@amd.com, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>

This patch adds support for HS200 tuning mode, on AMD eMMC-4.5.1

Made changes to the earlier submission based on the comments
received from Adrian.

Also re-spinned to the latest version based on feedback from Ulf.

Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 178 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 177 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 782c8d2..9576f82 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -817,6 +817,171 @@ enum amd_chipset_gen {
 	AMD_CHIPSET_UNKNOWN,
 };

+static const struct sdhci_ops amd_sdhci_pci_ops;
+
+struct amd_tuning_descriptor {
+	u8 tune_around;
+	bool this_tune_ok;
+	bool last_tune_ok;
+	u8 valid_front;
+	u8 valid_window_max;
+	u8 tune_low_max;
+	u8 tune_low;
+	u8 valid_window;
+	u8 tune_result;
+};
+
+static int amd_tuning_reset(struct sdhci_host *host)
+{
+	unsigned int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	val |= SDHCI_CTRL_PRESET_VAL_ENABLE | SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
+
+	val = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	val &= ~SDHCI_CTRL_EXEC_TUNING;
+	sdhci_writew(host, val, SDHCI_HOST_CONTROL2);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+static int amd_config_tuning_phase(struct sdhci_host *host, u8 phase)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	unsigned int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	pci_read_config_dword(pdev, 0xb8, &val);
+	val &= ~0x1f;
+	val |= (0x10800 | (phase << 1));
+	pci_write_config_dword(pdev, 0xb8, val);
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+static int amd_find_good_phase(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
+
+	unsigned int val;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	if (td->this_tune_ok)
+		td->valid_front += 1;
+	if ((!td->this_tune_ok && td->last_tune_ok) ||
+	    (td->tune_around == 11)) {
+		if (td->valid_window > td->valid_window_max) {
+			td->valid_window_max = td->valid_window;
+			td->tune_low_max = td->tune_low;
+		}
+	}
+	if (td->this_tune_ok && (!td->last_tune_ok))
+		td->tune_low = td->tune_around;
+	if (!td->this_tune_ok && td->last_tune_ok)
+		td->valid_window = 0;
+	else if (td->this_tune_ok)
+		td->valid_window += 1;
+
+	td->last_tune_ok = td->this_tune_ok;
+
+	if (td->tune_around == 11) {
+		if ((td->valid_front + td->valid_window) >
+						td->valid_window_max) {
+			if (td->valid_front > td->valid_window)
+				td->tune_result = ((td->valid_front -
+						td->valid_window) >> 1);
+			else
+				td->tune_result = td->tune_low +
+				((td->valid_window + td->valid_front) >> 1);
+		} else {
+			td->tune_result = td->tune_low_max +
+					(td->valid_window_max >> 1);
+		}
+
+		if (td->tune_result > 0x0b)
+			td->tune_result = 0x0b;
+
+		pci_read_config_dword(pdev, 0xb8, &val);
+		val &= ~0x1f;
+		val |= (0x10800 | (td->tune_result << 1));
+		pci_write_config_dword(pdev, 0xb8, val);
+	}
+
+	spin_unlock_irqrestore(&host->lock, flags);
+
+	return 0;
+}
+
+static int amd_enable_manual_tuning(struct sdhci_pci_slot *slot)
+{
+	struct pci_dev *pdev = slot->chip->pdev;
+	unsigned int val;
+
+	pci_read_config_dword(pdev, 0xd0, &val);
+	val &= 0xffffffcf;
+	val |= 0x30;
+	pci_write_config_dword(pdev, 0xd0, val);
+
+	return 0;
+}
+
+static int amd_execute_tuning(struct sdhci_host *host, u32 opcode)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct amd_tuning_descriptor *td = sdhci_pci_priv(slot);
+	u8 ctrl;
+
+	amd_tuning_reset(host);
+	memset(td, 0, sizeof(struct amd_tuning_descriptor));
+
+	/*********************************************************************/
+	/* Enabling Software Tuning */
+	/********************************************************************/
+	/* 1. First switch the eMMC to HS200 Mode
+	 * 2. Prepare the registers by using the sampling clock select
+	 * 3. Send the CMD21 12 times with block length of 64 bytes
+	 * 4. Everytime change the clk phase and check for CRC error
+	 *	(CMD and DATA),if error, soft reset the CMD and DATA line
+	 * 5. Calculate the window and set the clock phase.
+	 */
+
+	for (td->tune_around = 0; td->tune_around < 12; td->tune_around++) {
+		amd_config_tuning_phase(host, td->tune_around);
+
+		if (mmc_send_tuning(host->mmc, opcode, NULL)) {
+			td->this_tune_ok = false;
+			host->mmc->need_retune = 0;
+			mdelay(4);
+			ctrl = SDHCI_RESET_CMD | SDHCI_RESET_DATA;
+			sdhci_writeb(host, ctrl, SDHCI_SOFTWARE_RESET);
+		} else {
+			td->this_tune_ok = true;
+		}
+
+		amd_find_good_phase(host);
+	}
+
+	host->mmc->retune_period = 0;
+
+	amd_enable_manual_tuning(slot);
+	return 0;
+}
+
 static int amd_probe(struct sdhci_pci_chip *chip)
 {
 	struct pci_dev	*smbus_dev;
@@ -841,7 +1006,6 @@ static int amd_probe(struct sdhci_pci_chip *chip)

 	if ((gen == AMD_CHIPSET_BEFORE_ML) || (gen == AMD_CHIPSET_CZ)) {
 		chip->quirks2 |= SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD;
-		chip->quirks2 |= SDHCI_QUIRK2_BROKEN_HS200;
 	}

 	return 0;
@@ -849,6 +1013,7 @@ static int amd_probe(struct sdhci_pci_chip *chip)

 static const struct sdhci_pci_fixes sdhci_amd = {
 	.probe		= amd_probe,
+	.ops		= &amd_sdhci_pci_ops,
 };

 static const struct pci_device_id pci_ids[] = {
@@ -1469,6 +1634,17 @@ static const struct sdhci_ops sdhci_pci_ops = {
 	.select_drive_strength	= sdhci_pci_select_drive_strength,
 };

+static const struct sdhci_ops amd_sdhci_pci_ops = {
+	.set_clock	= sdhci_set_clock,
+	.enable_dma	= sdhci_pci_enable_dma,
+	.set_bus_width	= sdhci_pci_set_bus_width,
+	.reset		= sdhci_reset,
+	.set_uhs_signaling = sdhci_set_uhs_signaling,
+	.hw_reset		= sdhci_pci_hw_reset,
+	.select_drive_strength	= sdhci_pci_select_drive_strength,
+	.platform_execute_tuning = amd_execute_tuning,
+};
+
 /*****************************************************************************\
  *                                                                           *
  * Suspend/resume                                                            *
-- 
2.7.4
