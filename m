From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH V6] mmc:host:sdhci-pci:Addition of Arasan PCI Controller
 with integrated phy.
Date: Wed, 3 Jan 2018 10:27:14 +0200
Message-ID: <dbc2b819-eecd-d82d-26ae-e90badf44457@intel.com>
References: <1514938282-3794-1-git-send-email-agarg@arasan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:59276 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750748AbeACI1q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Wed, 3 Jan 2018 03:27:46 -0500
In-Reply-To: <1514938282-3794-1-git-send-email-agarg@arasan.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Atul Garg <agarg@arasan.com>, linux-mmc@vger.kernel.org, kishon@ti.com, rk@ti.com, nm@ti.com, nsekhar@ti.com, ulf.hansson@linaro.org
Cc: linux-kernel@vger.kernel.org

On 03/01/18 02:11, Atul Garg wrote:
> The Arasan Controller is based on a FPGA platform and has integrated phy
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
> Signed-off-by: Atul Garg <agarg@arasan.com>

Thanks for making the changes.  Still a couple of tiny things below.

> ---
> V6 - Parameters are enclosed in parantheses in macros. Adjusted tab space.
> Removed ret variable in arasan_phy_addr_poll.
> V5 - Separated arasan_phy_poll function into arasan_phy_addr_poll and
> arasan_phy_sts_poll  Tabspace corrected. Checked return values of poll functions.
> Removed static declaration of sdhci_pci_enable_dma and defined in
> sdhci-pci.h as suggested by Adrian Hunter <adrian.hunter@intel.com>.
> V4 - Created arasan_phy_poll function to have common timeout call.
> .Restructured arasan_set_phy to arasan_select_phy_clock and
> .arasan_phy_set to have single set of registers to be programmed for different modes.
> .Applied code style suggestions from Adrian Hunter <adrian.hunter@intel.com>.
> V3 - Removed sdhci-pci-arasan.h. Code and interface document mentioned
> above are made relevant..Applied code style suggestions from
> Sekhar Nori <nsekhar@ti.com> and .Adrian Hunter <adrian.hunter@intel.com>.
> V2 - Removed code from sdhci-pci-core.c and created sdhci-pci-arasan.c and
> .sdhci-pci-arasan.h.
> V1 - Initial Patch coded in sdhci-pci-core.c.
> 
>  drivers/mmc/host/Makefile           |   2 +-
>  drivers/mmc/host/sdhci-pci-arasan.c | 338 ++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-pci-core.c   |   4 +-
>  drivers/mmc/host/sdhci-pci.h        |   7 +-
>  4 files changed, 347 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/mmc/host/sdhci-pci-arasan.c
> 
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 191a040..84cd138 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -11,7 +11,7 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
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
> index 0000000..79d1f74
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-arasan.c
> @@ -0,0 +1,338 @@
> +/*
> + * Copyright (C) 2017 Arasan Chip Systems Inc.
> + *
> + * Author: Atul Garg <agarg@arasan.com>
> + *
> + * This software is licensed under the terms of the GNU General Public
> + * License version 2, as published by the Free Software Foundation, and
> + * may be copied, distributed, and modified under those terms.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.

Please consider using SPDX license identifiers:

	https://marc.info/?l=linux-kernel&m=151447555910302&w=2

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
> +#define PHY_ADDR_REG	0x300
> +#define PHY_DAT_REG	0x304
> +
> +#define PHY_WRITE	BIT(8)
> +#define PHY_BUSY	BIT(9)
> +#define DATA_MASK	0xFF
> +
> +/* eMMC5.1 PHY Specific Registers */
> +#define DLL_STATUS	0x00
> +#define IPAD_CTRL1	0x01
> +#define IPAD_CTRL2	0x02
> +#define IPAD_STS	0x03
> +#define IOREN_CTRL1	0x06
> +#define IOREN_CTRL2	0x07
> +#define IOPU_CTRL1	0x08
> +#define IOPU_CTRL2	0x09
> +#define ITAP_DELAY	0x0C
> +#define OTAP_DELAY	0x0D
> +#define STRB_SEL	0x0E
> +#define CLKBUF_SEL	0x0F
> +#define MODE_CTRL	0x11
> +#define DLL_TRIM	0x12
> +#define CMD_CTRL	0x20
> +#define DATA_CTRL	0x21
> +#define STRB_CTRL	0x22
> +#define CLK_CTRL	0x23
> +#define PHY_CTRL	0x24
> +
> +#define DLL_ENBL	BIT(3)
> +#define RTRIM_EN	BIT(1)
> +#define PDB_ENBL	BIT(1)
> +#define RETB_ENBL	BIT(6)
> +#define ODEN_CMD	BIT(1)
> +#define ODEN_DAT	0xFF
> +#define REN_STRB	BIT(0)
> +#define REN_CMND	BIT(1)
> +#define REN_DATA	0xFF
> +#define PU_CMD		BIT(1)
> +#define PU_DAT		0xFF
> +#define ITAPDLY_EN	BIT(0)
> +#define OTAPDLY_EN	BIT(0)
> +#define OD_REL_CMD	BIT(1)
> +#define OD_REL_DAT	0xFF
> +#define DLLTRM_ICP	0x8
> +#define PDB_CMND	BIT(0)
> +#define PDB_DATA	0xFF
> +#define PDB_STRB	BIT(0)
> +#define PDB_CLOCK	BIT(0)
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
> +/*
> + * Controller has no specific bits for HS200/HS.
> + * Used BIT(4), BIT(5) for software programming.
> + */
> +#define HS200_MODE	BIT(4)
> +#define HISPD_MODE	BIT(5)
> +
> +#define OTAPDLY(x)	(((x) << 1) | OTAPDLY_EN)
> +#define ITAPDLY(x)	(((x) << 1) | ITAPDLY_EN)
> +#define FREQSEL(x)	(((x) << 5) | DLL_ENBL)
> +#define IOPAD(x, y)	((x) | (y << 2))

'y' also needs to be enclosed in parentheses.

> +
> +/* Arasan private data */
> +struct arasan_host {
> +	u32 chg_clk;
> +};
> +
> +static int arasan_phy_addr_poll(struct sdhci_host *host, u32 offset, u32 mask)
> +{
> +	ktime_t timeout = ktime_add_us(ktime_get(), 100);
> +	bool failed;
> +	u8 val = 0;
> +
> +	while (1) {
> +		failed = ktime_after(ktime_get(), timeout);
> +		val = sdhci_readw(host, PHY_ADDR_REG);
> +		if (!(val & mask))
> +			return 0;
> +		if (failed)
> +			return -EBUSY;
> +	}
> +}
> +
> +static int arasan_phy_write(struct sdhci_host *host, u8 data, u8 offset)
> +{
> +	sdhci_writew(host, data, PHY_DAT_REG);
> +	sdhci_writew(host, (PHY_WRITE | offset), PHY_ADDR_REG);
> +	return arasan_phy_addr_poll(host, PHY_ADDR_REG, PHY_BUSY);
> +}
> +
> +static int arasan_phy_read(struct sdhci_host *host, u8 offset, u8 *data)
> +{
> +	int ret;
> +
> +	sdhci_writew(host, 0, PHY_DAT_REG);
> +	sdhci_writew(host, offset, PHY_ADDR_REG);
> +	ret = arasan_phy_addr_poll(host, PHY_ADDR_REG, PHY_BUSY);
> +
> +	/* Masking valid data bits */
> +	*data = sdhci_readw(host, PHY_DAT_REG) & DATA_MASK;
> +	return ret;
> +}
> +
> +static int arasan_phy_sts_poll(struct sdhci_host *host, u32 offset, u32 mask)
> +{
> +	int ret;
> +	ktime_t timeout = ktime_add_us(ktime_get(), 100);
> +	bool failed;
> +	u8 val = 0;
> +
> +	while (1) {
> +		failed = ktime_after(ktime_get(), timeout);
> +		ret = arasan_phy_read(host, offset, &val);
> +		if (ret)
> +			return -EBUSY;
> +		else if (val & mask)
> +			return 0;
> +		if (failed)
> +			return -EBUSY;
> +	}
> +}
> +
> +/* Initialize the Arasan PHY */
> +static int arasan_phy_init(struct sdhci_host *host)
> +{
> +	int ret;
> +	u8 val;
> +
> +	/* Program IOPADs and wait for calibration to be done */
> +	if (arasan_phy_read(host, IPAD_CTRL1, &val) ||
> +	    arasan_phy_write(host, val | RETB_ENBL | PDB_ENBL, IPAD_CTRL1) ||
> +	    arasan_phy_read(host, IPAD_CTRL2, &val) ||
> +	    arasan_phy_write(host, val | RTRIM_EN, IPAD_CTRL2))
> +		return -EBUSY;
> +	ret = arasan_phy_sts_poll(host, IPAD_STS, CALDONE_MASK);
> +	if (ret)
> +		return -EBUSY;
> +
> +	/* Program CMD/Data lines */
> +	if (arasan_phy_read(host, IOREN_CTRL1, &val) ||
> +	    arasan_phy_write(host, val | REN_CMND | REN_STRB, IOREN_CTRL1) ||
> +	    arasan_phy_read(host, IOPU_CTRL1, &val) ||
> +	    arasan_phy_write(host, val | PU_CMD, IOPU_CTRL1) ||
> +	    arasan_phy_read(host, CMD_CTRL, &val) ||
> +	    arasan_phy_write(host, val | PDB_CMND, CMD_CTRL) ||
> +	    arasan_phy_read(host, IOREN_CTRL2, &val) ||
> +	    arasan_phy_write(host, val | REN_DATA, IOREN_CTRL2) ||
> +	    arasan_phy_read(host, IOPU_CTRL2, &val) ||
> +	    arasan_phy_write(host, val | PU_DAT, IOPU_CTRL2) ||
> +	    arasan_phy_read(host, DATA_CTRL, &val) ||
> +	    arasan_phy_write(host, val | PDB_DATA, DATA_CTRL) ||
> +	    arasan_phy_read(host, STRB_CTRL, &val) ||
> +	    arasan_phy_write(host, val | PDB_STRB, STRB_CTRL) ||
> +	    arasan_phy_read(host, CLK_CTRL, &val) ||
> +	    arasan_phy_write(host, val | PDB_CLOCK, CLK_CTRL) ||
> +	    arasan_phy_read(host, CLKBUF_SEL, &val) ||
> +	    arasan_phy_write(host, val | MAX_CLK_BUF, CLKBUF_SEL) ||
> +	    arasan_phy_write(host, LEGACY_MODE, MODE_CTRL))
> +		return -EBUSY;
> +	return 0;
> +}
> +
> +/* Set Arasan PHY for different modes */
> +static int arasan_phy_set(struct sdhci_host *host, u8 mode, u8 otap,
> +			  u8 drv_type, u8 itap, u8 trim, u8 clk)
> +{
> +	u8 val;
> +	int ret;
> +
> +	if (mode == HISPD_MODE || mode == HS200_MODE)
> +		ret = arasan_phy_write(host, 0x0, MODE_CTRL);
> +	else
> +		ret = arasan_phy_write(host, mode, MODE_CTRL);
> +	if (ret)
> +		return ret;
> +	if (mode == HS400_MODE || mode == HS200_MODE) {
> +		ret = arasan_phy_read(host, IPAD_CTRL1, &val);
> +		if (ret)
> +			return ret;
> +		ret = arasan_phy_write(host, IOPAD(val, drv_type), IPAD_CTRL1);
> +		if (ret)
> +			return ret;
> +	}
> +	if (mode == LEGACY_MODE) {
> +		ret = arasan_phy_write(host, 0x0, OTAP_DELAY);
> +		if (ret)
> +			return ret;
> +		ret = arasan_phy_write(host, 0x0, ITAP_DELAY);
> +	} else {
> +		ret = arasan_phy_write(host, OTAPDLY(otap), OTAP_DELAY);
> +		if (ret)
> +			return ret;
> +		if (mode != HS200_MODE)
> +			ret = arasan_phy_write(host, ITAPDLY(itap), ITAP_DELAY);
> +		else
> +			ret = arasan_phy_write(host, 0x0, ITAP_DELAY);
> +	}
> +	if (ret)
> +		return ret;
> +	if (mode != LEGACY_MODE) {
> +		ret = arasan_phy_write(host, trim, DLL_TRIM);
> +		if (ret)
> +			return ret;
> +	}
> +	ret = arasan_phy_write(host, 0, DLL_STATUS);
> +	if (ret)
> +		return ret;
> +	if (mode != LEGACY_MODE) {
> +		ret = arasan_phy_write(host, FREQSEL(clk), DLL_STATUS);
> +		if (ret)
> +			return ret;
> +		ret = arasan_phy_sts_poll(host, DLL_STATUS, DLL_RDY_MASK);
> +		if (ret)
> +			return -EBUSY;
> +	}
> +	return 0;
> +}
> +
> +static int arasan_select_phy_clock(struct sdhci_host *host)
> +{
> +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> +	struct arasan_host *arasan_host = sdhci_pci_priv(slot);
> +	u8 clk;
> +
> +	if (arasan_host->chg_clk == host->mmc->ios.clock)
> +		return 0;
> +
> +	arasan_host->chg_clk = host->mmc->ios.clock;
> +	if (host->mmc->ios.clock == 200000000)
> +		clk = 0x0;
> +	else if (host->mmc->ios.clock == 100000000)
> +		clk = 0x2;
> +	else if (host->mmc->ios.clock == 50000000)
> +		clk = 0x1;
> +	else
> +		clk = 0x0;
> +
> +	if (host->mmc_host_ops.hs400_enhanced_strobe) {
> +		arasan_phy_set(host, ENHSTRB_MODE, 1, 0x0, 0x0,
> +			       DLLTRM_ICP, clk);
> +	} else {
> +		switch (host->mmc->ios.timing) {
> +		case MMC_TIMING_LEGACY:
> +			arasan_phy_set(host, LEGACY_MODE, 0x0, 0x0, 0x0,
> +				       0x0, 0x0);
> +			break;
> +		case MMC_TIMING_MMC_HS:
> +		case MMC_TIMING_SD_HS:
> +			arasan_phy_set(host, HISPD_MODE, 0x3, 0x0, 0x2,
> +				       DLLTRM_ICP, clk);
> +			break;
> +		case MMC_TIMING_MMC_HS200:
> +		case MMC_TIMING_UHS_SDR104:
> +			arasan_phy_set(host, HS200_MODE, 0x2,
> +				       host->mmc->ios.drv_type, 0x0,
> +				       DLLTRM_ICP, clk);
> +			break;
> +		case MMC_TIMING_MMC_DDR52:
> +		case MMC_TIMING_UHS_DDR50:
> +			arasan_phy_set(host, DDR50_MODE, 0x1, 0x0,
> +				       0x0, DLLTRM_ICP, clk);
> +			break;
> +		case MMC_TIMING_MMC_HS400:
> +			arasan_phy_set(host, HS400_MODE, 0x1,
> +				       host->mmc->ios.drv_type, 0xa,
> +				       DLLTRM_ICP, clk);
> +			break;
> +		default:
> +			break;
> +		}
> +	}
> +	return 0;
> +}
> +
> +static int arasan_pci_probe_slot(struct sdhci_pci_slot *slot)
> +{
> +	int err;
> +
> +	slot->host->mmc->caps |= MMC_CAP_NONREMOVABLE | MMC_CAP_8_BIT_DATA;
> +	err = arasan_phy_init(slot->host);
> +	if (err)
> +		return -ENODEV;
> +	return 0;
> +}
> +
> +static void arasan_sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
> +{
> +	sdhci_set_clock(host, clock);
> +
> +	/* Change phy settings for the new clock */
> +	arasan_select_phy_clock(host);
> +}
> +
> +static const struct sdhci_ops arasan_sdhci_pci_ops = {
> +	.set_clock	= arasan_sdhci_set_clock,
> +	.enable_dma	= sdhci_pci_enable_dma,
> +	.set_bus_width	= sdhci_set_bus_width,
> +	.reset		= sdhci_reset,
> +	.set_uhs_signaling	= sdhci_set_uhs_signaling,
> +};
> +
> +const struct sdhci_pci_fixes sdhci_arasan = {
> +	.probe_slot = arasan_pci_probe_slot,
> +	.ops        = &arasan_sdhci_pci_ops,
> +	.priv_size  = sizeof(struct arasan_host),
> +};
> +

Please remove blank line at end of file.

> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 110c634..c5b229b 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -35,7 +35,6 @@
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
>  
> -static int sdhci_pci_enable_dma(struct sdhci_host *host);
>  static void sdhci_pci_hw_reset(struct sdhci_host *host);
>  
>  #ifdef CONFIG_PM_SLEEP
> @@ -1459,6 +1458,7 @@ static const struct pci_device_id pci_ids[] = {
>  	SDHCI_PCI_DEVICE(O2, SDS1,     o2),
>  	SDHCI_PCI_DEVICE(O2, SEABIRD0, o2),
>  	SDHCI_PCI_DEVICE(O2, SEABIRD1, o2),
> +	SDHCI_PCI_DEVICE(ARASAN, PHY_EMMC, arasan),
>  	SDHCI_PCI_DEVICE_CLASS(AMD, SYSTEM_SDHCI, PCI_CLASS_MASK, amd),
>  	/* Generic SD host controller */
>  	{PCI_DEVICE_CLASS(SYSTEM_SDHCI, PCI_CLASS_MASK)},
> @@ -1473,7 +1473,7 @@ MODULE_DEVICE_TABLE(pci, pci_ids);
>   *                                                                           *
>  \*****************************************************************************/
>  
> -static int sdhci_pci_enable_dma(struct sdhci_host *host)
> +int sdhci_pci_enable_dma(struct sdhci_host *host)
>  {
>  	struct sdhci_pci_slot *slot;
>  	struct pci_dev *pdev;
> diff --git a/drivers/mmc/host/sdhci-pci.h b/drivers/mmc/host/sdhci-pci.h
> index 0056f08..5cbcdc4 100644
> --- a/drivers/mmc/host/sdhci-pci.h
> +++ b/drivers/mmc/host/sdhci-pci.h
> @@ -55,6 +55,9 @@
>  
>  #define PCI_SUBDEVICE_ID_NI_7884	0x7884
>  
> +#define PCI_VENDOR_ID_ARASAN		0x16e6
> +#define PCI_DEVICE_ID_ARASAN_PHY_EMMC	0x0670
> +
>  /*
>   * PCI device class and mask
>   */
> @@ -170,11 +173,13 @@ static inline void *sdhci_pci_priv(struct sdhci_pci_slot *slot)
>  #ifdef CONFIG_PM_SLEEP
>  int sdhci_pci_resume_host(struct sdhci_pci_chip *chip);
>  #endif
> -
> +int sdhci_pci_enable_dma(struct sdhci_host *host);
>  int sdhci_pci_o2_probe_slot(struct sdhci_pci_slot *slot);
>  int sdhci_pci_o2_probe(struct sdhci_pci_chip *chip);
>  #ifdef CONFIG_PM_SLEEP
>  int sdhci_pci_o2_resume(struct sdhci_pci_chip *chip);
>  #endif
>  
> +extern const struct sdhci_pci_fixes sdhci_arasan;
> +
>  #endif /* __SDHCI_PCI_H */
> 

