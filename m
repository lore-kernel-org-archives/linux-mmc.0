From: Kurt Kanzenbach <kurt@linutronix.de>
Subject: [PATCH 1/1] mmc: sdhci-pci: fix eMMC controller issue on Intel Baytrail SoCs
Date: Tue, 19 Jun 2018 08:31:19 +0200
Message-ID: <20180619063119.3955-2-kurt@linutronix.de>
References: <20180619063119.3955-1-kurt@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180619063119.3955-1-kurt@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: adrian.hunter@intel.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, kurt@linutronix.de
List-Id: linux-mmc@vger.kernel.org

Sometimes the eMMC controller doesn't respond anymore on Intel Baytrail
SoCs. The resulting error looks like:

|mmc1: Reset 0x1 never completed.
|sdhci: =========== REGISTER DUMP (mmc1)===========
|sdhci: Sys addr: 0xffffffff | Version:  0x0000ffff
|sdhci: Blk size: 0x0000ffff | Blk cnt:  0x0000ffff
|sdhci: Argument: 0xffffffff | Trn mode: 0x0000ffff
|sdhci: Present:  0xffffffff | Host ctl: 0x000000ff
|sdhci: Power:    0x000000ff | Blk gap:  0x000000ff
|sdhci: Wake-up:  0x000000ff | Clock:    0x0000ffff
|sdhci: Timeout:  0x000000ff | Int stat: 0xffffffff
|sdhci: Int enab: 0xffffffff | Sig enab: 0xffffffff
|sdhci: AC12 err: 0x0000ffff | Slot int: 0x0000ffff
|sdhci: Caps:     0xffffffff | Caps_1:   0xffffffff
|sdhci: Cmd:      0x0000ffff | Max curr: 0xffffffff
|sdhci: Host ctl2: 0x0000ffff
|sdhci: ADMA Err: 0xffffffff | ADMA Ptr: 0xffffffff

The behavior was observed on an Intel Atom E3825 performing lots of reboots. The
issue seems to occur if runtime power management is used. Found by utilizing
ftrace.

The erratum VLI10 for the Intel E3825 states, that the eMMC controller
incorrectly announces that it supports suspend/resume. However, that shouldn't
be used, as the controller may incorrectly transfer data between memory and the
SD device.

Therefore, disallowing runtime pm resolves the issue. Tested on the E3825.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/mmc/host/sdhci-pci-core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 77dd3521daae..df89381944cd 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -870,6 +870,21 @@ static const struct sdhci_pci_fixes sdhci_intel_byt_emmc = {
 	.priv_size	= sizeof(struct intel_host),
 };
 
+/*
+ * See Erratum VLI10 from Errata List for Intel Atom E3825, Link:
+ * https://www.intel.ca/content/dam/www/public/us/en/documents/specification-updates/atom-e3800-family-spec-update.pdf
+ */
+static const struct sdhci_pci_fixes sdhci_intel_byt_emmc_no_runtime_pm = {
+	.allow_runtime_pm = false,
+	.probe_slot	= byt_emmc_probe_slot,
+	.quirks		= SDHCI_QUIRK_NO_ENDATTR_IN_NOPDESC,
+	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
+			  SDHCI_QUIRK2_CAPS_BIT63_FOR_HS400 |
+			  SDHCI_QUIRK2_STOP_WITH_TC,
+	.ops		= &sdhci_intel_byt_ops,
+	.priv_size	= sizeof(struct intel_host),
+};
+
 static const struct sdhci_pci_fixes sdhci_intel_glk_emmc = {
 	.allow_runtime_pm	= true,
 	.probe_slot		= glk_emmc_probe_slot,
@@ -1470,7 +1485,7 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_SUBDEVICE(INTEL, BYT_SDIO, NI, 7884, ni_byt_sdio),
 	SDHCI_PCI_DEVICE(INTEL, BYT_SDIO,  intel_byt_sdio),
 	SDHCI_PCI_DEVICE(INTEL, BYT_SD,    intel_byt_sd),
-	SDHCI_PCI_DEVICE(INTEL, BYT_EMMC2, intel_byt_emmc),
+	SDHCI_PCI_DEVICE(INTEL, BYT_EMMC2, intel_byt_emmc_no_runtime_pm),
 	SDHCI_PCI_DEVICE(INTEL, BSW_EMMC,  intel_byt_emmc),
 	SDHCI_PCI_DEVICE(INTEL, BSW_SDIO,  intel_byt_sdio),
 	SDHCI_PCI_DEVICE(INTEL, BSW_SD,    intel_byt_sd),
-- 
2.11.0
