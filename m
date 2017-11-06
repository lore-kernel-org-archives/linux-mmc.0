From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc:host:sdhci-pci:V3-Addition of Arasan PCI Controller
 with integrated phy.
Date: Mon, 6 Nov 2017 14:14:58 +0200
Message-ID: <47941879-678a-1462-3685-b906fbd67734@intel.com>
References: <1509390636-4644-1-git-send-email-agarg@arasan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:1785 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752369AbdKFMPO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 6 Nov 2017 07:15:14 -0500
In-Reply-To: <1509390636-4644-1-git-send-email-agarg@arasan.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Atul Garg <agarg@arasan.com>, linux-mmc@vger.kernel.org, kishon@ti.com, rk@ti.com, nm@ti.com, nsekhar@ti.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org

On 30/10/17 21:10, Atul Garg wrote:
> The Arasan controller is based on a FPGA platform and has integrated phy
> with specific registers used during initialization and
> management of different modes. The phy and the controller are integrated
> and registers are very specific to Arasan.
> 
> Arasan being an IP provider, licenses these IPs to various companies for
> integration of IP in custom SOCs. The custom SOCs define own register
> map depending on how bits are tied inside the SOC for phy registers,
> depending on SOC memory plan and hence will require own platform drivers.
> 
> If more details on phy registers are required, an interface document is
> hosted at https: //arasandotcom/NF/eMMC5.1 PHY Programming in Linux.pdf.
> 
> Changes from V2: Removed sdhci-pci-arasan.h. Code and document mentioned
> above are made relevant. Applied code style suggestions from
> Sekhar Nori <nsekhar@ti.com> and Adrian Hunter <adrian.hunter@intel.com>.

Please put the version changes after the --- line.

Also please put the version correctly in the patch subject and use more
conventional prefixes i.e.

[PATCH V3] mmc: sdhci-pci: Addition of Arasan PCI Controller with integrated phy

> 
> Signed-off-by: Atul Garg <agarg@arasan.com>
> ---
>  drivers/mmc/host/Makefile           |   2 +-
>  drivers/mmc/host/sdhci-pci-arasan.c | 369 ++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci-core.c   |  14 ++
>  drivers/mmc/host/sdhci-pci.h        |   6 +
>  4 files changed, 390 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-arasan.c
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index ab61a3e..6781b81 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -10,7 +10,7 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
> -sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o
> +sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o sdhci-pci-arasan.o
>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
> diff --git a/drivers/mmc/host/sdhci-pci-arasan.c b/drivers/mmc/host/sdhci-pci-arasan.c
> new file mode 100644
> index 0000000..a0a4f3e
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-arasan.c
> @@ -0,0 +1,369 @@
> +/*
> + * Copyright (C) 2017 Arasan Chip Systems Inc.,
> + *
> + * Authors: Atul Garg <agarg@arasan.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/delay.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pci.h"
> +
> +/* Extra registers for Arasan SD Host Controller for eMMC5.1 PHY */
> +#define HOST_PHY_ADDR_REG	0x300
> +#define HOST_PHY_DATA_REG	0x304
> +
> +/* eMMC5.1 PHY Specific Registers */
> +#define DLL_CONTROL_STS	0x00
> +#define IOPAD_CONTROL1	0x01
> +#define IOPAD_CONTROL2	0x02
> +#define IOPAD_STATUS	0x03
> +#define IO_ODEN_CONTROL1	0x04
> +#define IO_ODEN_CONTROL2	0x05
> +#define IO_REN_CONTROL1	0x06
> +#define IO_REN_CONTROL2	0x07
> +#define IO_PU_CONTROL1	0x08
> +#define IO_PU_CONTROL2	0x09
> +#define IO_OD_REL_CONTROL1	0x0A
> +#define IO_OD_REL_CONTROL2	0x0B
> +#define ITAP_DELAY	0x0C
> +#define OTAP_DELAY	0x0D
> +#define STROBE_SELECT	0x0E
> +#define CLKBUF_SELECT	0x0F
> +#define MODE_CONTROL	0x11
> +#define DLL_TRIM	0x12
> +#define LDO_CONTROL	0x1F
> +#define CMD_CONTROL	0x20
> +#define DATA_CONTROL	0x21
> +#define STROBE_CONTROL	0x22
> +#define CLK_CONTROL	0x23
> +#define PHY_CONTROL	0x24
> +
> +#define DLL_ENABLE	BIT(3)
> +#define RTRIM_ENABLE	BIT(1)
> +#define PDB_ENABLE	BIT(1)
> +#define RETB_ENABLE	BIT(6)
> +#define ODEN_CMD	BIT(1)
> +#define ODEN_DAT	0xFF
> +#define REN_STRB	BIT(0)
> +#define REN_CMD	BIT(1)
> +#define REN_DAT	0xFF
> +#define PU_CMD		BIT(1)
> +#define PU_DAT		0xFF
> +#define ITAP_DLY_EN	BIT(0)
> +#define OTAP_DLY_EN	BIT(0)
> +#define OD_REL_CMD	BIT(1)
> +#define OD_REL_DAT	0xFF
> +#define DLL_TRIM_ICP	0x8
> +#define PDB_CMD	BIT(0)
> +#define PDB_DAT	0xFF
> +#define PDB_STRB	BIT(0)
> +#define PDB_CLK	BIT(0)
> +#define LDO_RDYB	0xFE
> +#define CALDONE_MASK	0x10
> +#define DLL_RDY_MASK	0x10
> +#define MAX_CLK_BUF	0x7
> +
> +/* Mode Controls */
> +#define ENHSTRB_MODE	BIT(0)
> +#define HS400_MODE	BIT(1)
> +#define LEGACY_MODE	BIT(2)
> +#define DDR50_MODE	BIT(3)
> +
> +#define OTAPDLY(x)	((x << 1) | OTAP_DLY_EN)
> +#define ITAPDLY(x)	((x << 1) | ITAP_DLY_EN)
> +#define FREQ_SEL(x)	((x << 5) | DLL_ENABLE)
> +#define IOPAD(x, y)	((x) | (y << 2))

Please make all the defines line up.

> +
> +

Please do not have double blank lines.

> +static int arasan_phy_write(struct sdhci_host *host, u8 data, u8 offset)
> +{
> +	u32 timeout;
> +	u8 busy;
> +
> +	sdhci_writew(host, data, HOST_PHY_DATA_REG);
> +	sdhci_writew(host, ((1<<8) | offset), HOST_PHY_ADDR_REG);

Why no define for (1 << 8)?

> +	timeout = 20;
> +	do {
> +		busy = sdhci_readw(host, HOST_PHY_ADDR_REG) & (1<<9);

Why no define for (1 << 9)?

> +		if (!busy)
> +			break;
> +		usleep_range(1, 5);
> +	} while (timeout--);
> +	if (!timeout)
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +static int arasan_phy_read(struct sdhci_host *host, u8 offset, u8 *data)
> +{
> +	u32 timeout;
> +	u8 busy;
> +
> +	sdhci_writew(host, 0, HOST_PHY_DATA_REG);
> +	sdhci_writew(host, offset, HOST_PHY_ADDR_REG);
> +	timeout = 20;
> +	do {
> +		busy = sdhci_readw(host, HOST_PHY_ADDR_REG) & (1<<9);
> +		if (!busy)
> +			break;
> +		usleep_range(1, 5);
> +	} while (timeout--);
> +	if (!timeout)
> +		return -EBUSY;

This timeout code is exactly the same as in arasan_phy_write().  Maybe
make it a separate function.

> +	/*Masking valid data bits*/

Comment is nicer if there is a space after /* and before */

> +	*data = sdhci_readw(host, HOST_PHY_DATA_REG) & 0xFF;
> +	return 0;
> +}
> +
> +/* Initialize the Arasan PHY */
> +static int arasan_phy_init(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct pci_dev *pdev = slot->chip->pdev;
> +	u32 timeout;
> +	u8 val, ret;

According to arasan_phy_read(), 'ret' needs to be an 'int'.

> +
> +	/* Program IOPADs and wait for calibration to be done */
> +	if (arasan_phy_read(host, IOPAD_CONTROL1, &val) ||
> +		arasan_phy_write(host, val | RETB_ENABLE | PDB_ENABLE,
> +			IOPAD_CONTROL1) ||
> +		arasan_phy_read(host, IOPAD_CONTROL2, &val) ||
> +		arasan_phy_write(host, val | RTRIM_ENABLE, IOPAD_CONTROL2))

It would be better to align to open parenthessis.  Try checkpatch.pl --strict

> +		return -EBUSY;
> +	timeout = 10;
> +	do {
> +		ret = arasan_phy_read(host, IOPAD_STATUS, &val);
> +		if (val & CALDONE_MASK)
> +			break;
> +		usleep_range(1, 5);
> +	} while (timeout--);

You have a lot of these timeouts.  Please try to make a function.
Here is an example:

static int arasan_phy_poll(struct sdhci_host *host, u8 offset, u8 mask)
{
	ktime_t timeout = ktime_add_us(ktime_get(), 100);
	bool failed;
	u8 val = 0;

	while (1) {
		failed = ktime_after(ktime_get(), timeout);
		arasan_phy_read(host, offset, &val);
		if (val & mask)
			return 0;
		if (failed)
			return -EBUSY;
	}
}


> +	if (!timeout) {
> +		dev_err(&pdev->dev, "Phy Calibration not done\n");
> +		return ret;
> +	}
> +
> +	/* Program CMD/Data lines */
> +	if (arasan_phy_read(host, IO_REN_CONTROL1, &val) ||
> +		arasan_phy_write(host, val | REN_CMD | REN_STRB,
> +			IO_REN_CONTROL1) ||
> +		arasan_phy_read(host, IO_PU_CONTROL1, &val) ||
> +		arasan_phy_write(host, val | PU_CMD, IO_PU_CONTROL1) ||
> +		arasan_phy_read(host, CMD_CONTROL, &val) ||
> +		arasan_phy_write(host, val | PDB_CMD, CMD_CONTROL) ||
> +		arasan_phy_read(host, IO_REN_CONTROL2, &val) ||
> +		arasan_phy_write(host, val | REN_DAT, IO_REN_CONTROL2) ||
> +		arasan_phy_read(host, IO_PU_CONTROL2, &val) ||
> +		arasan_phy_write(host, val | PU_DAT, IO_PU_CONTROL2) ||
> +		arasan_phy_read(host, DATA_CONTROL, &val) ||
> +		arasan_phy_write(host, val | PDB_DAT, DATA_CONTROL) ||
> +		arasan_phy_read(host, STROBE_CONTROL, &val) ||
> +		arasan_phy_write(host, val | PDB_STRB, STROBE_CONTROL) ||
> +		arasan_phy_read(host, CLK_CONTROL, &val) ||
> +		arasan_phy_write(host, val | PDB_CLK, CLK_CONTROL) ||
> +		arasan_phy_read(host, CLKBUF_SELECT, &val) ||
> +		arasan_phy_write(host, val | MAX_CLK_BUF, CLKBUF_SELECT) ||
> +		arasan_phy_write(host, LEGACY_MODE, MODE_CONTROL))
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +static int arasan_set_phy(struct sdhci_host *host)
> +{
> +	u8 freq_sel;
> +	static u32 chg_clk;

Please put chg_clk in private data - refer:
	commit ac9f67b5800b9a96987ec602a34dd256a92ac7ca
	mmc: sdhci-pci: Let devices define their own private data

> +	u32 timeout;
> +	u8 val, ret;
> +
> +	if (chg_clk == host->mmc->ios.clock)
> +		return 0;
> +
> +	chg_clk = host->mmc->ios.clock;
> +	if (host->mmc->ios.clock == 200000000)
> +		freq_sel = 0x0;
> +	else if (host->mmc->ios.clock == 100000000)
> +		freq_sel = 0x2;
> +	else if (host->mmc->ios.clock == 50000000)
> +		freq_sel = 0x1;
> +	else
> +		freq_sel = 0x0;
> +
> +	if (host->mmc_host_ops.hs400_enhanced_strobe) {
> +		if (arasan_phy_write(host, 0x1, MODE_CONTROL) ||
> +			arasan_phy_write(host, OTAPDLY(1), OTAP_DELAY) ||
> +			arasan_phy_write(host, 0, ITAP_DELAY) ||
> +			arasan_phy_write(host, DLL_TRIM_ICP, DLL_TRIM) ||
> +			arasan_phy_write(host, 0, DLL_CONTROL_STS) ||
> +			arasan_phy_write(host, FREQ_SEL(freq_sel),
> +				DLL_CONTROL_STS))
> +			return -EBUSY;
> +		timeout = 10;
> +		do {
> +			ret = arasan_phy_read(host, DLL_CONTROL_STS, &val);
> +			if (val & DLL_RDY_MASK)
> +				break;
> +		} while (timeout--);
> +		if (!timeout) {
> +			dev_err(&pdev->dev, "DLL status not set\n");

drivers/mmc/host/sdhci-pci-arasan.c: In function ‘arasan_set_phy’:
drivers/mmc/host/sdhci-pci-arasan.c:218:13: error: ‘pdev’ undeclared (first use in this function)
    dev_err(&pdev->dev, "DLL status not set\n");
             ^

> +			return -EBUSY;
> +		}
> +	} else {
> +		switch (host->mmc->ios.timing) {
> +		case MMC_TIMING_LEGACY:
> +			if (arasan_phy_write(host, 0x4, MODE_CONTROL) ||
> +				arasan_phy_write(host, 0, ITAP_DELAY) ||
> +				arasan_phy_write(host, 0, OTAP_DELAY) ||
> +				arasan_phy_write(host, 0, DLL_CONTROL_STS))
> +				return -EBUSY;
> +			break;
> +		case MMC_TIMING_MMC_HS:
> +		case MMC_TIMING_SD_HS:
> +			if (arasan_phy_write(host, 0, MODE_CONTROL) ||
> +				arasan_phy_write(host, OTAPDLY(3),
> +					OTAP_DELAY) ||
> +				arasan_phy_write(host, ITAPDLY(0x2),
> +					ITAP_DELAY) ||
> +				arasan_phy_write(host, 0, ITAP_DELAY) ||
> +				arasan_phy_write(host, DLL_TRIM_ICP,
> +					DLL_TRIM) ||
> +				arasan_phy_write(host, 0, DLL_CONTROL_STS) ||
> +				arasan_phy_write(host, FREQ_SEL(freq_sel),
> +					DLL_CONTROL_STS))
> +				return -EBUSY;
> +			timeout = 10;
> +			do {
> +				ret = arasan_phy_read(host, DLL_CONTROL_STS,
> +						&val);
> +				if (val & DLL_RDY_MASK)
> +					break;
> +			} while (timeout--);
> +			if (!timeout) {
> +				dev_err(&pdev->dev, "DLL status not set\n");
> +				return -EBUSY;
> +			}
> +			break;
> +		case MMC_TIMING_MMC_HS200:
> +		case MMC_TIMING_UHS_SDR104:
> +			if (arasan_phy_write(host, 0, MODE_CONTROL) ||
> +				arasan_phy_read(host, IOPAD_CONTROL1, &val) ||
> +				arasan_phy_write(host, IOPAD(val,
> +					host->mmc->ios.drv_type),
> +					IOPAD_CONTROL1) ||

Please restructure to avoid wrapping lines.

> +				arasan_phy_write(host, OTAPDLY(1),
> +					OTAP_DELAY) ||
> +				arasan_phy_write(host, 0, ITAP_DELAY) ||
> +				arasan_phy_write(host, DLL_TRIM_ICP,
> +					DLL_TRIM) ||
> +				arasan_phy_write(host, 0, DLL_CONTROL_STS) ||
> +				arasan_phy_write(host, FREQ_SEL(freq_sel),
> +					DLL_CONTROL_STS))
> +				return -EBUSY;
> +			timeout = 10;
> +			do {
> +				ret = arasan_phy_read(host, DLL_CONTROL_STS,
> +						&val);
> +				if (val & DLL_RDY_MASK)
> +					break;
> +			} while (timeout--);
> +			if (!timeout) {
> +				dev_err(&pdev->dev, "DLL status not set\n");
> +				return -EBUSY;
> +			}
> +			break;
> +		case MMC_TIMING_MMC_DDR52:
> +		case MMC_TIMING_UHS_DDR50:
> +			if (arasan_phy_write(host, 0x8, MODE_CONTROL) ||
> +				arasan_phy_write(host, OTAPDLY(3),
> +					OTAP_DELAY) ||
> +				arasan_phy_write(host, ITAPDLY(0x2),
> +					ITAP_DELAY) ||
> +				arasan_phy_write(host, DLL_TRIM_ICP,
> +					DLL_TRIM) ||
> +				arasan_phy_write(host, 0, DLL_CONTROL_STS) ||
> +				arasan_phy_write(host, FREQ_SEL(freq_sel),
> +					DLL_CONTROL_STS))
> +				return -EBUSY;
> +			timeout = 10;
> +			do {
> +				ret = arasan_phy_read(host, DLL_CONTROL_STS,
> +						&val);
> +				if (val & DLL_RDY_MASK)
> +					break;
> +			} while (timeout--);
> +			if (!timeout) {
> +				dev_err(&pdev->dev, "DLL status not set\n");
> +				return -EBUSY;
> +			}
> +			break;
> +		case MMC_TIMING_MMC_HS400:
> +			if (arasan_phy_write(host, 0x2, MODE_CONTROL) ||
> +				arasan_phy_read(host, IOPAD_CONTROL1, &val) ||
> +				arasan_phy_write(host, IOPAD(val,
> +					host->mmc->ios.drv_type),
> +					IOPAD_CONTROL1) ||
> +				arasan_phy_write(host, OTAPDLY(1),
> +					OTAP_DELAY) ||
> +				arasan_phy_write(host, ITAPDLY(0xa),
> +					ITAP_DELAY) ||
> +				arasan_phy_write(host, DLL_TRIM_ICP,
> +					DLL_TRIM) ||
> +				arasan_phy_write(host, 0, DLL_CONTROL_STS) ||
> +				arasan_phy_write(host, FREQ_SEL(freq_sel),
> +					DLL_CONTROL_STS))
> +				return -EBUSY;
> +			timeout = 10;
> +			do {
> +				ret = arasan_phy_read(host, DLL_CONTROL_STS,
> +					       &val);
> +				if (val & DLL_RDY_MASK)
> +					break;
> +			} while (timeout--);
> +			if (!timeout) {
> +				dev_err(&pdev->dev, "DLL status not set\n");
> +				return -EBUSY;
> +			}
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +int arasan_pci_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +	int err;
> +
> +	slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE |
> +				MMC_CAP_8_BIT_DATA;

unnecessary line wrap.

> +	err = arasan_phy_init(slot->host);
> +	if (err)
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +void arasan_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	u16 clk;
> +
> +	host->mmc->actual_clock = 0;
> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +	if (clock == 0)
> +		return;
> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
> +	sdhci_enable_clk(host, clk);

That is the same as sdhci_set_clock().  Please call sdhci_set_clock() instead.

> +
> +	/*Change phy settings for the new clock */

Please add space after /*

> +	arasan_set_phy(host);
> +}
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 3e4f04f..cb89161 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -1104,6 +1104,19 @@ static const struct sdhci_pci_fixes sdhci_rtsx = {
>  	.probe_slot	= rtsx_probe_slot,
>  };
>  
> +static const struct sdhci_ops arasan_sdhci_pci_ops = {
> +	.set_clock		= arasan_sdhci_set_clock,
> +	.enable_dma		= sdhci_pci_enable_dma,
> +	.set_bus_width		= sdhci_set_bus_width,
> +	.reset			= sdhci_reset,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +};
> +
> +static const struct sdhci_pci_fixes sdhci_arasan = {
> +	.probe_slot = arasan_pci_probe_slot,
> +	.ops	    = &arasan_sdhci_pci_ops,
> +};
> +
>  /*AMD chipset generation*/
>  enum amd_chipset_gen {
>  	AMD_CHIPSET_BEFORE_ML,
> @@ -1306,6 +1319,7 @@ static const struct pci_device_id pci_ids[] = {
>  	SDHCI_PCI_DEVICE(O2, SDS1,     o2),
>  	SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
>  	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
> +	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
>  	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>  	/* Generic SD host controller */
>  	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 063506c..63cdab5 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -54,6 +54,9 @@
>  
>  #define PCI_SUBDEVICE_ID_NI_7884	0x7884
>  
> +#define PCI_VENDOR_ID_ARASAN	0x16e6
> +#define PCI_DEVICE_ID_ARASAN_PHY_EMMC	0x0670
> +
>  /*
>   * PCI device class and mask
>   */
> @@ -176,4 +179,7 @@ int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip);
>  int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip);
>  #endif
>  
> +int arasan_pci_probe_slot(struct sdhci_pci_slot *slot);
> +void arasan_sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
> +
>  #endif /* __SDHCI_PCI_H */
> 

