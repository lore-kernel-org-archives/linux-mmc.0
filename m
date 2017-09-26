From: Atul Garg <agarg@arasan.com>
Subject: [PATCH] mmc:host:sdhci-pci: Addition of Arasan PCI controller with integrated phy.
Date: Tue, 26 Sep 2017 11:59:54 -0700
Message-ID: <1506452394-23655-1-git-send-email-agarg@arasan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pf0-f174.google.com ([209.85.192.174]:48353 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933917AbdIZTAH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 26 Sep 2017 15:00:07 -0400
Received: by mail-pf0-f174.google.com with SMTP id n24so5985984pfk.5
        for <linux-mmc@vger.kernel.org>; Tue, 26 Sep 2017 12:00:06 -0700 (PDT)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: agarg@arasan.com, linux-mmc@vger.kernel.org, kishon@ti.com, rk@ti.com, nm@ti.com, nsekhar@ti.com, ulf.hansson@linaro.org, adrian.hunter@intel.com
Cc: linux-kernel@vger.kernel.org

The Arasan controller is based on a FPGA platform and has integrated phy
with specific phy registers used during the initialization and
management of different modes. The phy and the controller are integrated
and registers are very specific to Arasan.

Arasan being an IP provider licenses these IPs to various companies for
integration of IP in custom SOCs. The custom SOCs define own register
map depending on how bits are tied inside the SOC for phy registers,
depending on SOC memory plan and hence will require own platform drivers.
If more details on phy registers are required, an interfacce document is
hosted at https://arasan.com/NF/eMMC5.1 PHY Programming in Linux.pdf.

Signed-off-by: Atul Garg <agarg@arasan.com>
---
 drivers/mmc/host/sdhci-pci-core.c | 372 ++++++++++++++++++++++++++++++++++++++
 drivers/mmc/host/sdhci-pci.h      |   4 +
 2 files changed, 376 insertions(+)

diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
index 5f3f7b5..52efd63 100644
--- a/drivers/mmc/host/sdhci-pci-core.c
+++ b/drivers/mmc/host/sdhci-pci-core.c
@@ -1112,6 +1112,377 @@ static const struct sdhci_pci_fixes sdhci_rtsx = {
 	.probe_slot	= rtsx_probe_slot,
 };
 
+/* Extra registers for Arasan SD Host Controller for eMMC5.1 PHY */
+#define HOST_PHY_ADDR_REG	0x300
+#define HOST_PHY_DATA_REG	0x304
+
+#define PHY_DLLCONTROL		0x00
+#define PHY_IOPADCONTROL1	0x01
+#define PHY_IOPADCONTROL2	0x02
+#define PHY_IOPADSTATUS	0x03
+#define PHY_IOODCONTROL1	0x04
+#define PHY_IOODCONTROL2	0x05
+#define PHY_IORENCONTROL1	0x06
+#define PHY_IORENCONTROL2	0x07
+#define PHY_IOPUCONTROL1	0x08
+#define PHY_IOPUCONTROL2	0x09
+#define PHY_IOODRELCONTROL1	0x0A
+#define PHY_IOODRELCONTROL2	0x0B
+#define PHY_INPUTTAPDELAY	0x0C
+#define PHY_OUTPUTTAPDELAY	0x0D
+#define PHY_STROBESELECT	0x0E
+#define PHY_CLKBUFSELECT	0x0F
+#define PHY_MODECONTROL	0x11
+#define PHY_DLLTRIM		0x12
+#define PHY_LDOCONTROL		0x1F
+#define PHY_CMDCONTROL		0x20
+#define PHY_DATACONTROL	0x21
+#define PHY_STROBECONTROL	0x22
+#define PHY_CLKCONTROL		0x23
+#define PHY_CONTROL		0x24
+
+#define DLL_ENABLE	BIT(3)
+#define RTRIM_ENABLE	BIT(1)
+#define PDB_ENABLE	BIT(1)
+#define RETB_ENABLE	BIT(6)
+#define ODEN_CMD	BIT(1)
+#define ODEN_DAT	0xFF
+#define REN_STRB	BIT(0)
+#define REN_CMD	BIT(1)
+#define REN_DAT	0xFF
+#define PU_CMD		BIT(1)
+#define PU_DAT		0xFF
+#define ITAP_DLY_EN	BIT(0)
+#define OTAP_DLY_EN	BIT(0)
+#define OD_REL_CMD	BIT(1)
+#define OD_REL_DAT	0xFF
+#define DLL_TRIM	0x8
+#define PDB_CMD	BIT(0)
+#define PDB_DAT	0xFF
+#define PDB_STRB	BIT(0)
+#define PDB_CLK	BIT(0)
+#define LDO_RDYB	0xFE
+#define CALDONE_MASK	0x10
+
+int arasan_phy_write(struct sdhci_host *host, u8 data, u8 offset)
+{
+	u32 timeout;
+	u8 busy;
+
+	sdhci_writew(host, data, HOST_PHY_DATA_REG);
+	sdhci_writew(host, ((1<<8) | offset), HOST_PHY_ADDR_REG);
+	timeout = 20;
+	do {
+		busy = sdhci_readw(host, HOST_PHY_ADDR_REG) & (1<<9);
+		if (!busy)
+			break;
+		mdelay(1);
+	} while (timeout--);
+	if (!timeout)
+		return -ENODEV;
+	return 0;
+}
+
+static int arasan_phy_read(struct sdhci_host *host, u8 offset, u8 *data)
+{
+	u32 timeout;
+	u8 busy;
+
+	sdhci_writew(host, 0, HOST_PHY_DATA_REG);
+	*data = sdhci_readw(host, HOST_PHY_DATA_REG) & 0xFF;
+	sdhci_writew(host, ((0<<8) | offset), HOST_PHY_ADDR_REG);
+	timeout = 20;
+	do {
+		busy = sdhci_readw(host, HOST_PHY_ADDR_REG) & (1<<9);
+		if (!busy)
+			break;
+		mdelay(1);
+	} while (timeout--);
+	if (!timeout)
+		return -ENODEV;
+	*data = sdhci_readw(host, HOST_PHY_DATA_REG) & 0xFF;
+	return 0;
+}
+
+/* Initialize the Arasan PHY */
+int arasan_phy_init(struct sdhci_host *host)
+{
+	struct sdhci_pci_slot *slot = sdhci_priv(host);
+	struct pci_dev *pdev = slot->chip->pdev;
+	u8 val;
+
+	if (arasan_phy_write(host, 0, PHY_CONTROL))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_IOPADCONTROL1, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | RETB_ENABLE, PHY_IOPADCONTROL1))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_IOPADCONTROL2, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | RTRIM_ENABLE, PHY_IOPADCONTROL2))
+		return -ENODEV;
+	mdelay(10);
+
+	if (arasan_phy_read(host, PHY_IOPADSTATUS, &val)) {
+		if (!(val & CALDONE_MASK)) {
+			dev_err(&pdev->dev, "Phy calibration not done\n");
+			return -ENODEV;
+		}
+	}
+	if (arasan_phy_read(host, PHY_IOPADCONTROL1, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | PDB_ENABLE, PHY_IOPADCONTROL1))
+		return -ENODEV;
+	mdelay(10);
+
+	if (arasan_phy_read(host, PHY_IOPADSTATUS, &val)) {
+		if (!(val & CALDONE_MASK)) {
+			dev_err(&pdev->dev, "Phy calibration not done\n");
+			return -ENODEV;
+		}
+	}
+	if (arasan_phy_read(host, PHY_IORENCONTROL1, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | REN_CMD | REN_STRB, PHY_IORENCONTROL1))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_IOPUCONTROL1, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | PU_CMD, PHY_IOPUCONTROL1))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_CMDCONTROL, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | PDB_CMD, PHY_CMDCONTROL))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_IORENCONTROL2, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | REN_DAT, PHY_IORENCONTROL2))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_IOPUCONTROL2, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | PU_DAT, PHY_IOPUCONTROL2))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_DATACONTROL, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | PDB_DAT, PHY_DATACONTROL))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_STROBECONTROL, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | PDB_STRB, PHY_STROBECONTROL))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_CLKCONTROL, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | PDB_CLK, PHY_CLKCONTROL))
+		return -ENODEV;
+	if (arasan_phy_read(host, PHY_CLKBUFSELECT, &val))
+		return -ENODEV;
+	if (arasan_phy_write(host, val | 0x7, PHY_CLKBUFSELECT))
+		return -ENODEV;
+	if (arasan_phy_write(host, 0x4, PHY_MODECONTROL))
+		return -ENODEV;
+	return 0;
+}
+
+
+int arasan_set_phy(struct sdhci_host *host)
+{
+	u8 clk_sel;
+	static u32 chg_clk;
+	u8 val;
+	u8 otap, itap, dll_sts, io_pad;
+
+	if (chg_clk != host->mmc->ios.clock) {
+		chg_clk = host->mmc->ios.clock;
+		if (host->mmc->ios.clock == 200000000)
+			clk_sel = 0;
+		else if (host->mmc->ios.clock == 100000000)
+			clk_sel = 2;
+		else if (host->mmc->ios.clock == 50000000)
+			clk_sel = 1;
+		else
+			clk_sel = 0;
+		/* Change phy settings only if there is a change in clock */
+		goto set_phy;
+	} else
+		return 0;
+set_phy:
+	if (host->mmc_host_ops.hs400_enhanced_strobe) {
+		if (arasan_phy_write(host, 0x1, PHY_MODECONTROL))
+			return -ENODEV;
+		otap = ((0x2<<1) | OTAP_DLY_EN);
+		if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELAY))
+			return -ENODEV;
+		if (arasan_phy_write(host, 0, PHY_INPUTTAPDELAY))
+			return -ENODEV;
+		if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
+			return -ENODEV;
+		if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
+			return -ENODEV;
+		dll_sts = (clk_sel<<5) | DLL_ENABLE;
+		if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL))
+			return -ENODEV;
+		if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
+			return -ENODEV;
+	} else {
+		switch (host->mmc->ios.timing) {
+		case MMC_TIMING_LEGACY:
+			if (arasan_phy_write(host, 0x4, PHY_MODECONTROL))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_INPUTTAPDELAY))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_OUTPUTTAPDELAY))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
+				return -ENODEV;
+			if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
+				return -ENODEV;
+			break;
+		case MMC_TIMING_MMC_HS:
+			if (arasan_phy_write(host, 0, PHY_MODECONTROL))
+				return -ENODEV;
+			otap = ((0x2<<3) | OTAP_DLY_EN);
+			if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELAY))
+				return -ENODEV;
+			itap = ((0x2<<1) | ITAP_DLY_EN);
+			if (arasan_phy_write(host, itap, PHY_INPUTTAPDELAY))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_INPUTTAPDELAY))
+				return -ENODEV;
+			if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
+				return -ENODEV;
+			dll_sts = (clk_sel<<5) | DLL_ENABLE;
+			if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL))
+				return -ENODEV;
+			if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
+				return -ENODEV;
+			break;
+		case MMC_TIMING_MMC_HS200:
+			if (arasan_phy_write(host, 0, PHY_MODECONTROL))
+				return -ENODEV;
+			if (arasan_phy_read(host, PHY_IOPADCONTROL1, &val))
+				return -ENODEV;
+			io_pad = val | (host->mmc->ios.drv_type<<2);
+			if (arasan_phy_write(host, io_pad, PHY_IOPADCONTROL1))
+				return -ENODEV;
+			otap = ((0x2<<1) | OTAP_DLY_EN);
+			if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELAY))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_INPUTTAPDELAY))
+				return -ENODEV;
+			if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
+				return -ENODEV;
+			dll_sts = (clk_sel<<5) | DLL_ENABLE;
+			if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL))
+				return -ENODEV;
+			if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
+				return -ENODEV;
+			if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
+				return -ENODEV;
+			break;
+		case MMC_TIMING_UHS_DDR50:
+			if (arasan_phy_write(host, 0x8, PHY_MODECONTROL))
+				return -ENODEV;
+			otap = ((0x2<<3) | OTAP_DLY_EN);
+			if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELAY))
+				return -ENODEV;
+			itap = ((0x2<<1) | ITAP_DLY_EN);
+			if (arasan_phy_write(host, itap, PHY_INPUTTAPDELAY))
+				return -ENODEV;
+			if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
+				return -ENODEV;
+			dll_sts = (clk_sel<<5) | DLL_ENABLE;
+			if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL))
+				return -ENODEV;
+			if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
+				return -ENODEV;
+			break;
+		case MMC_TIMING_MMC_HS400:
+			if (arasan_phy_write(host, 0x2, PHY_MODECONTROL))
+				return -ENODEV;
+			if (arasan_phy_read(host, PHY_IOPADCONTROL1, &val))
+				return -ENODEV;
+			io_pad = val | (host->mmc->ios.drv_type<<2);
+			if (arasan_phy_write(host, io_pad, PHY_IOPADCONTROL1))
+				return -ENODEV;
+			otap = ((0x2<<1) | OTAP_DLY_EN);
+			if (arasan_phy_write(host, otap, PHY_OUTPUTTAPDELAY))
+				return -ENODEV;
+			itap = ((0xA<<1) | ITAP_DLY_EN);
+			if (arasan_phy_write(host, itap, PHY_INPUTTAPDELAY))
+				return -ENODEV;
+			if (arasan_phy_write(host, DLL_TRIM, PHY_DLLTRIM))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0, PHY_DLLCONTROL))
+				return -ENODEV;
+			dll_sts = (clk_sel<<5) | DLL_ENABLE;
+			if (arasan_phy_write(host, dll_sts, PHY_DLLCONTROL))
+				return -ENODEV;
+			if (arasan_phy_read(host, PHY_DLLCONTROL, &val))
+				return -ENODEV;
+			if (arasan_phy_write(host, 0x0E, PHY_CLKBUFSELECT))
+				return -ENODEV;
+			break;
+		default:
+			break;
+		}
+	}
+	return 0;
+}
+
+static int arasan_probe(struct sdhci_pci_chip *chip)
+{
+	struct pci_dev *dev;
+
+	dev = pci_get_device(PCI_VENDOR_ID_ARASAN,
+			PCI_DEVICE_ID_ARASAN, NULL);
+	return 0;
+}
+static int arasan_probe_slot(struct sdhci_pci_slot *slot)
+{
+	int err;
+
+	err = arasan_phy_init(slot->host);
+	if (err)
+		return -ENODEV;
+	return 0;
+}
+
+void arasan_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
+{
+	u16 clk;
+
+	host->mmc->actual_clock = 0;
+	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
+	if (clock == 0)
+		return;
+	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
+	sdhci_enable_clk(host, clk);
+
+	/*Change phy settings for the new clock */
+	arasan_set_phy(host);
+}
+
+
+static const struct sdhci_ops arasan_sdhci_pci_ops = {
+	.set_clock			= arasan_sdhci_set_clock,
+	.enable_dma			= sdhci_pci_enable_dma,
+	.set_bus_width			= sdhci_pci_set_bus_width,
+	.reset				= sdhci_reset,
+	.set_uhs_signaling		= sdhci_set_uhs_signaling,
+};
+
+static const struct sdhci_pci_fixes sdhci_arasan = {
+	.probe      = arasan_probe,
+	.probe_slot = arasan_probe_slot,
+	.ops	    = &arasan_sdhci_pci_ops,
+};
+
+
 /*AMD chipset generation*/
 enum amd_chipset_gen {
 	AMD_CHIPSET_BEFORE_ML,
@@ -1314,6 +1685,7 @@ static const struct pci_device_id pci_ids[] = {
 	SDHCI_PCI_DEVICE(O2, SDS1,     o2),
 	SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
 	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
+	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
 	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
 	/* Generic SD host controller */
 	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
index 3c1dd79..e370836 100644
--- a/drivers/mmc/host/sdhci-pci.h
+++ b/drivers/mmc/host/sdhci-pci.h
@@ -48,6 +48,10 @@
 
 #define PCI_SUBDEVICE_ID_NI_7884	0x7884
 
+/* Arasan Device IDs */
+#define PCI_VENDOR_ID_ARASAN	0x16e6
+#define PCI_DEVICE_ID_ARASAN_PHY_EMMC	0x0670
+
 /*
  * PCI device class and mask
  */
-- 
2.7.4


-- 
ATTENTION: 

The information contained in this message may be legally privileged and 
confidential.  It is intended to be read only by the individual or entity 
to whom it is addressed or by their designee. If the reader of this message 
is not the intended recipient, you are on notice that any distribution of 
this message, in any form, is strictly prohibited by law.


If you have received this message in error, please immediately notify the 
sender and/or Arasan Chip Systems, Inc. by telephone at (408) 282-1600 and 
delete or destroy any copy of this message.
