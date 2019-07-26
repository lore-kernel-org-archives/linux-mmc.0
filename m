From: "Michael K. Johnson" <johnsonm@danlj.org>
Subject: [PATCH v2 2/2] mmc: sdhci: sdhci-pci-core: Add Genesis Logic GL975x
 support
Date: Thu, 25 Jul 2019 22:07:54 -0400
Message-ID: <20190726020754.GA12078@people.danlj.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, Ben Chuang <ben.chuang@genesyslogic.com.tw>
List-Id: linux-mmc@vger.kernel.org

Add support for the GL9750 and GL9755 chipsets.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>

diff --git a/drivers/mmc/host/sdhci-gli.h b/drivers/mmc/host/sdhci-gli.h
new file mode 100644
index 000000000000..0acd35b6d3e2
--- /dev/null
+++ b/drivers/mmc/host/sdhci-gli.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+#ifndef __SDHCI_GLI_H
+#define __SDHCI_GLI_H
+
+/* the define PCI_VENDOR_ID_GLI may put in kernel/include/linux/pci_ids.h */
+#ifndef PCI_VENDOR_ID_GLI
+#define PCI_VENDOR_ID_GLI		0x17a0
+#endif
+
+/*  Genesys Logic extra registers */
+#define SDHCI_GLI_9750_WT         0x800
+#define SDHCI_GLI_9750_DRIVING    0x860
+#define SDHCI_GLI_9750_PLL        0x864
+#define SDHCI_GLI_9750_SW_CTRL    0x874
+#define SDHCI_GLI_9750_MISC       0x878
+
+#define SDHCI_GLI_9750_TUNING_CONTROL		0x540
+#define SDHCI_GLI_9750_TUNING_PARAMETERS	0x544
+
+#define GLI_9755_DRIVER_VER      "Genesys Logic (GL9755 v0.9.0-y190703)"
+#define GLI_9750_DRIVER_VER      "Genesys Logic (GL9750 v0.9.0-y190703)"
+
+#define GLI_MAX_TUNING_LOOP 40
+
+void gli_set_9750(struct sdhci_host *host);
+
+#endif /* __SDHCI_GLI_H */
diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 4154ee11b47d..b5c28df39de1 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -35,6 +35,7 @@
 
 #include "sdhci.h"
 #include "sdhci-pci.h"
+#include "sdhci-gli.h"
 
 static void sdhci_pci_hw_reset(struct sdhci_host *host);
 
@@ -1453,6 +1454,223 @@ static const struct sdhci_pci_fixes sdhci_rtsx = {
 	.probe_slot	= rtsx_probe_slot,
 };
 
+/* Genesys Logic chipset */
+static int gli_probe_slot_gl9755(struct sdhci_pci_slot *slot)
+{
+	struct sdhci_host *host = slot->host;
+
+	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+	dev_info(&slot->chip->pdev->dev, "%s\n", GLI_9755_DRIVER_VER);
+	sdhci_enable_v4_mode(host);
+
+	return 0;
+}
+
+static void gli_set_9750_rx_inv(struct sdhci_host *host, bool b)
+{
+	u32 wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
+	u32 misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
+
+	if ((wt_value & 0x1) == 0) {
+		wt_value |= 0x1;
+		sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
+	}
+
+	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
+	if (b) {
+		misc_value |= 0x8;
+		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
+	} else {
+		misc_value &= ~0x8;
+		sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
+	}
+
+	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
+	wt_value &= ~0x1;
+	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
+}
+
+static int __sdhci_execute_tuning_9750(struct sdhci_host *host, u32 opcode)
+{
+	int i;
+	int rx_inv = 0;
+
+	for (rx_inv = 0; rx_inv < 2; rx_inv++) {
+		if (rx_inv & 0x1)
+			gli_set_9750_rx_inv(host, true);
+		else
+			gli_set_9750_rx_inv(host, false);
+
+		sdhci_start_tuning(host);
+
+		for (i = 0; i < GLI_MAX_TUNING_LOOP; i++) {
+			u16 ctrl;
+
+			sdhci_send_tuning(host, opcode);
+
+			if (!host->tuning_done) {
+				if (rx_inv == 1) {
+					pr_info("%s: Tuning timeout, falling back to fixed sampling clock\n",
+						mmc_hostname(host->mmc));
+					sdhci_abort_tuning(host, opcode);
+					return -ETIMEDOUT;
+				}
+				pr_info("%s: Tuning timeout, try next tuning\n",
+					mmc_hostname(host->mmc));
+				sdhci_abort_tuning(host, opcode);
+				break;
+			}
+
+			ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+			if (!(ctrl & SDHCI_CTRL_EXEC_TUNING)) {
+				if (ctrl & SDHCI_CTRL_TUNED_CLK) {
+					pr_info("%s: Tuning successful\n",
+						mmc_hostname(host->mmc));
+					return 0; /* Success! */
+				}
+				break;
+			}
+		}
+	}
+
+	pr_info("%s: Tuning failed, falling back to fixed sampling clock\n",
+		mmc_hostname(host->mmc));
+	sdhci_reset_tuning(host);
+	return -EAGAIN;
+}
+
+static int gl9750_execute_tuning(struct mmc_host *mmc, u32 opcode)
+{
+	struct sdhci_host *host = mmc_priv(mmc);
+	int err = 0;
+	unsigned int tuning_count = 0;
+	bool hs400_tuning;
+
+	hs400_tuning = host->flags & SDHCI_HS400_TUNING;
+
+	if (host->tuning_mode == SDHCI_TUNING_MODE_1)
+		tuning_count = host->tuning_count;
+
+	/*
+	 * The Host Controller needs tuning in case of SDR104 and DDR50
+	 * mode, and for SDR50 mode when Use Tuning for SDR50 is set in
+	 * the Capabilities register.
+	 * If the Host Controller supports the HS200 mode then the
+	 * tuning function has to be executed.
+	 */
+	switch (host->timing) {
+	/* HS400 tuning is done in HS200 mode */
+	case MMC_TIMING_MMC_HS400:
+		err = -EINVAL;
+		goto out;
+
+	case MMC_TIMING_MMC_HS200:
+		/*
+		 * Periodic re-tuning for HS400 is not expected to be needed, so
+		 * disable it here.
+		 */
+		if (hs400_tuning)
+			tuning_count = 0;
+		break;
+
+	case MMC_TIMING_UHS_SDR104:
+	case MMC_TIMING_UHS_DDR50:
+		break;
+
+	case MMC_TIMING_UHS_SDR50:
+		if (host->flags & SDHCI_SDR50_NEEDS_TUNING)
+			break;
+		/* FALLTHROUGH */
+
+	default:
+		goto out;
+	}
+
+	if (host->ops->platform_execute_tuning) {
+		err = host->ops->platform_execute_tuning(host, opcode);
+		goto out;
+	}
+
+	host->mmc->retune_period = tuning_count;
+
+	if (host->tuning_delay < 0)
+		host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
+
+	gli_set_9750(host);
+	host->tuning_err = __sdhci_execute_tuning_9750(host, opcode);
+
+	sdhci_end_tuning(host);
+out:
+	host->flags &= ~SDHCI_HS400_TUNING;
+
+	return err;
+}
+
+static int gli_probe_slot_gl9750(struct sdhci_pci_slot *slot)
+{
+	struct sdhci_host *host = slot->host;
+	struct mmc_host_ops *ops = &host->mmc_host_ops;
+
+	u32 gli_wt = sdhci_readl(host, SDHCI_GLI_9750_WT);
+
+	dev_info(&slot->chip->pdev->dev, "%s\n", GLI_9750_DRIVER_VER);
+	slot->host->mmc->caps2 |= MMC_CAP2_NO_SDIO;
+
+	if ((gli_wt & 0x1) == 0) {
+		gli_wt |= 0x1;
+		sdhci_writel(host, gli_wt, SDHCI_GLI_9750_WT);
+	}
+
+	gli_wt = sdhci_readl(host, SDHCI_GLI_9750_WT);
+	gli_wt &= ~0x1;
+	sdhci_writel(host, gli_wt, SDHCI_GLI_9750_WT);
+
+	sdhci_enable_v4_mode(host);
+
+	ops->execute_tuning = gl9750_execute_tuning;
+
+	return 0;
+}
+
+static void sdhci_gli_voltage_switch(struct sdhci_host *host)
+{
+	usleep_range(5000, 5500);
+}
+
+static const struct sdhci_ops sdhci_gl9755_ops = {
+	.set_clock			= sdhci_set_clock,
+	.enable_dma			= sdhci_pci_enable_dma,
+	.set_bus_width			= sdhci_set_bus_width,
+	.reset				= sdhci_reset,
+	.set_uhs_signaling		= sdhci_set_uhs_signaling,
+	.hw_reset			= sdhci_pci_hw_reset,
+	.voltage_switch			= sdhci_gli_voltage_switch,
+};
+
+static const struct sdhci_pci_fixes sdhci_gl9755 = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
+	.probe_slot	= gli_probe_slot_gl9755,
+	.ops            = &sdhci_gl9755_ops,
+};
+
+static const struct sdhci_ops sdhci_gl9750_ops = {
+	.set_clock			= sdhci_set_clock,
+	.enable_dma			= sdhci_pci_enable_dma,
+	.set_bus_width			= sdhci_set_bus_width,
+	.reset				= sdhci_reset,
+	.set_uhs_signaling		= sdhci_set_uhs_signaling,
+	.hw_reset			= sdhci_pci_hw_reset,
+	.voltage_switch			= sdhci_gli_voltage_switch,
+};
+
+static const struct sdhci_pci_fixes sdhci_gl9750 = {
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_BROKEN_DDR50,
+	.probe_slot	= gli_probe_slot_gl9750,
+	.ops            = &sdhci_gl9750_ops,
+};
+
 /*AMD chipset generation*/
 enum amd_chipset_gen {
 	AMD_CHIPSET_BEFORE_ML,
@@ -1682,6 +1900,8 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
 	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
 	SDHCI_PCI_DEVICE(SYNOPSYS, DWC_MSHC, snps),
+	SDHCI_PCI_DEVICE(GLI, 9755, gl9755),
+	SDHCI_PCI_DEVICE(GLI, 9750, gl9750),
 	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
 	/* Generic SD host controller */
 	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index e5dc6e44c7a4..78e6b631e252 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -65,6 +65,9 @@
 
 #define PCI_DEVICE_ID_SYNOPSYS_DWC_MSHC 0xc202
 
+#define PCI_DEVICE_ID_GLI_9755		0x9755
+#define PCI_DEVICE_ID_GLI_9750		0x9750
+
 /*
  * PCI device class and mask
  */
diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
index 14957578bf2e..1ccf1b692d04 100644
--- a/drivers/mmc/host/sdhci.c
+++ b/drivers/mmc/host/sdhci.c
@@ -25,6 +25,8 @@
 
 #include <linux/leds.h>
 
+#include <linux/pci.h>
+
 #include <linux/mmc/mmc.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/card.h>
@@ -32,6 +34,8 @@
 #include <linux/mmc/slot-gpio.h>
 
 #include "sdhci.h"
+#include "sdhci-pci.h"
+#include "sdhci-gli.h"
 
 #define DRIVER_NAME "sdhci"
 
@@ -50,6 +54,8 @@ static void sdhci_finish_data(struct sdhci_host *);
 
 static void sdhci_enable_preset_value(struct sdhci_host *host, bool enable);
 
+static bool gli_is_9750(struct sdhci_host *);
+
 void sdhci_dumpregs(struct sdhci_host *host)
 {
 	SDHCI_DUMP("============ SDHCI REGISTER DUMP ===========\n");
@@ -328,6 +334,8 @@ static void sdhci_init(struct sdhci_host *host, int soft)
 
 	host->cqe_on = false;
 
+	gli_set_9750(host);
+
 	if (soft) {
 		/* force clock reconfiguration */
 		host->clock = 0;
@@ -2326,7 +2334,7 @@ void sdhci_reset_tuning(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_reset_tuning);
 
-static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
+void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 {
 	sdhci_reset_tuning(host);
 
@@ -2337,6 +2345,7 @@ static void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode)
 
 	mmc_abort_tuning(host->mmc, opcode);
 }
+EXPORT_SYMBOL_GPL(sdhci_abort_tuning);
 
 /*
  * We use sdhci_send_tuning() because mmc_send_tuning() is not a good fit. SDHCI
@@ -2493,9 +2502,7 @@ int sdhci_execute_tuning(struct mmc_host *mmc, u32 opcode)
 		host->tuning_delay = opcode == MMC_SEND_TUNING_BLOCK;
 
 	sdhci_start_tuning(host);
-
 	host->tuning_err = __sdhci_execute_tuning(host, opcode);
-
 	sdhci_end_tuning(host);
 out:
 	host->flags &= ~SDHCI_HS400_TUNING;
@@ -4090,6 +4097,12 @@ int sdhci_setup_host(struct sdhci_host *host)
 	 * value.
 	 */
 	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
+
+	if (gli_is_9750(host)) {
+		if (!(max_current_caps & 0xff))
+			max_current_caps |= 0xc8;
+	}
+
 	if (!max_current_caps && !IS_ERR(mmc->supply.vmmc)) {
 		int curr = regulator_get_current_limit(mmc->supply.vmmc);
 		if (curr > 0) {
@@ -4269,6 +4282,106 @@ void sdhci_cleanup_host(struct sdhci_host *host)
 }
 EXPORT_SYMBOL_GPL(sdhci_cleanup_host);
 
+// for Genesys Logic
+void gli_set_9750(struct sdhci_host *host)
+{
+	u32 wt_value = 0;
+	u32 driving_value = 0;
+	u32 pll_value = 0;
+	u32 sw_ctrl_value = 0;
+	u32 misc_value = 0;
+	u32 parameter_value = 0;
+	u32 control_value = 0;
+
+	u16 ctrl2 = 0;
+
+	if (!gli_is_9750(host))
+		return;
+
+	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
+	if ((wt_value & 0x1) == 0) {
+		wt_value |= 0x1;
+		sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
+	}
+
+	driving_value = sdhci_readl(host, SDHCI_GLI_9750_DRIVING);
+	pll_value = sdhci_readl(host, SDHCI_GLI_9750_PLL);
+	sw_ctrl_value = sdhci_readl(host, SDHCI_GLI_9750_SW_CTRL);
+	misc_value = sdhci_readl(host, SDHCI_GLI_9750_MISC);
+	parameter_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_PARAMETERS);
+	control_value = sdhci_readl(host, SDHCI_GLI_9750_TUNING_CONTROL);
+
+	driving_value &= ~(0x0C000FFF);
+	driving_value |= 0x0C000FFF;
+	sdhci_writel(host, driving_value, SDHCI_GLI_9750_DRIVING);
+
+	sw_ctrl_value |= 0xc0;
+	sdhci_writel(host, sw_ctrl_value, SDHCI_GLI_9750_SW_CTRL);
+
+	// reset the tuning flow after reinit and before starting tuning
+	pll_value |= 0x800000; // bit23-1
+	pll_value &= ~(0x00700000); // bit22:20-0
+
+	misc_value &= ~(0x8); // bit3-0
+	misc_value &= ~(0x4); // bit2-0
+
+	misc_value &= ~(0x70); // bit6:4-0
+	misc_value |= 0x50; // bit6:4-5
+
+	parameter_value &= ~(0x7); // bit2:0-0
+	parameter_value |= 0x1; // bit2:0-1
+
+	control_value &= ~(0x190000); // bit20:19-0, bit16-0
+	control_value |=   0x110000; // bit20:19-b10, bit16-1
+
+	sdhci_writel(host, pll_value, SDHCI_GLI_9750_PLL);
+	sdhci_writel(host, misc_value, SDHCI_GLI_9750_MISC);
+
+	// disable tuned clk
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+	// 540 enable tuning parameters control
+	control_value |= 0x10;
+	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
+
+	// write 544 tuning parameters
+	sdhci_writel(host, parameter_value, SDHCI_GLI_9750_TUNING_PARAMETERS);
+
+	// 540 disable tuning parameters control
+	control_value &= ~0x10;
+	sdhci_writel(host, control_value, SDHCI_GLI_9750_TUNING_CONTROL);
+
+	// clear tuned clk
+	ctrl2 = sdhci_readw(host, SDHCI_HOST_CONTROL2);
+	ctrl2 &= ~SDHCI_CTRL_TUNED_CLK;
+	sdhci_writew(host, ctrl2, SDHCI_HOST_CONTROL2);
+
+	udelay(1);
+	wt_value = sdhci_readl(host, SDHCI_GLI_9750_WT);
+	wt_value &= ~0x1;
+	sdhci_writel(host, wt_value, SDHCI_GLI_9750_WT);
+}
+EXPORT_SYMBOL_GPL(gli_set_9750);
+
+bool gli_is_9750(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct sdhci_pci_chip *chip;
+	struct pci_dev *pdev;
+
+	chip = slot->chip;
+	pdev = chip->pdev;
+
+	if (pdev->vendor == PCI_VENDOR_ID_GLI &&
+	    pdev->device == PCI_DEVICE_ID_GLI_9750) {
+		return true;
+	}
+
+	return false;
+}
+
 int __sdhci_add_host(struct sdhci_host *host)
 {
 	unsigned int flags = WQ_UNBOUND | WQ_MEM_RECLAIM | WQ_HIGHPRI;
diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
index 72601a4d2e95..437bab3af195 100644
--- a/drivers/mmc/host/sdhci.h
+++ b/drivers/mmc/host/sdhci.h
@@ -797,5 +797,6 @@ void sdhci_start_tuning(struct sdhci_host *host);
 void sdhci_end_tuning(struct sdhci_host *host);
 void sdhci_reset_tuning(struct sdhci_host *host);
 void sdhci_send_tuning(struct sdhci_host *host, u32 opcode);
+void sdhci_abort_tuning(struct sdhci_host *host, u32 opcode);
 
 #endif /* __SDHCI_HW_H */
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 70e86148cb1e..e668da5c8df5 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2403,6 +2403,7 @@
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
 #define PCI_DEVICE_ID_RDC_D1010		0x1010
 
+#define PCI_VENDOR_ID_GLI		0x17a0
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
 #define PCI_VENDOR_ID_QCOM		0x17cb
