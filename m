From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Tue, 19 Apr 2016 20:00:54 +0900
Message-ID: <57160FE6.8040401@samsung.com>
References: <705D14B1C7978B40A723277C067CEDE2010A4B0FD7@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:59674 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbcDSLA6 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 19 Apr 2016 07:00:58 -0400
In-reply-to: <705D14B1C7978B40A723277C067CEDE2010A4B0FD7@IN01WEMBXB.internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>, "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, CPGS <cpgs@samsung.com>

On 04/19/2016 04:18 PM, Prabu Thangamuthu wrote:
> Synopsys DWC_MSHC is compliant with SD Host Specifications. This patch
> is to support DWC_MSHC controller on PCI interface.

There is dwmmc controller for Synopsys DWC_MSHC.
According to commit message, dwmmc controller also is compliant with SD host specifications.

I think it's enough to use "sdhci-dwc".(To prevent confusion.)

> 
> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
> ---
> Change log v2:
> 	-Removed Synopsys specific PCI device ID's from pci_ids.h.
> 	-Updated the PCI device ID's in sdhci-pci-core.c.
> 
>  MAINTAINERS                           |   7 +
>  drivers/mmc/host/Makefile             |   3 +-
>  drivers/mmc/host/sdhci-dwc-mshc-pci.c | 298 ++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/sdhci-dwc-mshc-pci.h |  58 +++++++
>  drivers/mmc/host/sdhci-pci-core.c     |  14 ++
>  5 files changed, 379 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/mmc/host/sdhci-dwc-mshc-pci.c
>  create mode 100644 drivers/mmc/host/sdhci-dwc-mshc-pci.h
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d5b4be..b260b97 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9751,6 +9751,13 @@ S:	Maintained
>  F:	include/linux/mmc/dw_mmc.h
>  F:	drivers/mmc/host/dw_mmc*
>  
> +SYNOPSYS SDHCI COMPLIANT DWC MSHC DRIVER
> +M:	Prabu Thangamuthu <prabu.t@synopsys.com>
> +M:	Manjunath M B <manjumb@synopsys.com>
> +L:	linux-mmc@vger.kernel.org
> +S:	Maintained
> +F:	drivers/mmc/host/sdhci-dwc-mshc*
> +
>  SYSTEM TRACE MODULE CLASS
>  M:	Alexander Shishkin <alexander.shishkin@linux.intel.com>
>  S:	Maintained
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index af918d2..1d2a3cf 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -9,7 +9,8 @@ obj-$(CONFIG_MMC_MXC)		+= mxcmmc.o
>  obj-$(CONFIG_MMC_MXS)		+= mxs-mmc.o
>  obj-$(CONFIG_MMC_SDHCI)		+= sdhci.o
>  obj-$(CONFIG_MMC_SDHCI_PCI)	+= sdhci-pci.o
> -sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o
> +sdhci-pci-y			+= sdhci-pci-core.o sdhci-pci-o2micro.o \
> +				   sdhci-dwc-mshc-pci.o

how about using sdhci-pci-XXX?

>  obj-$(subst m,y,$(CONFIG_MMC_SDHCI_PCI))	+= sdhci-pci-data.o
>  obj-$(CONFIG_MMC_SDHCI_ACPI)	+= sdhci-acpi.o
>  obj-$(CONFIG_MMC_SDHCI_PXAV3)	+= sdhci-pxav3.o
> diff --git a/drivers/mmc/host/sdhci-dwc-mshc-pci.c b/drivers/mmc/host/sdhci-dwc-mshc-pci.c
> new file mode 100644
> index 0000000..e934af4
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-dwc-mshc-pci.c
> @@ -0,0 +1,298 @@
> +/*
> + * Copyright (C) 2016 Synopsys, Inc.
> + *
> + * Author: Manjunath M B <manjumb@synopsys.com>
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
> +#include <linux/module.h>
> +#include <linux/moduleparam.h>
> +
> +#include "sdhci.h"
> +#include "sdhci-pci.h"
> +#include "sdhci-dwc-mshc-pci.h"
> +
> +/*****************************************************************************\
> + *                                                                           *
> + * Hardware specific clock handling                                          *
> + *                                                                           *
> +\*****************************************************************************/
> +static const struct sdhci_ops *sdhci_ops;	/* Low level hw interface */
> +
> +static void sdhci_set_clock_snps(struct sdhci_host *host,
> +						unsigned int clock)
> +{
> +	int div = 0;
> +	int mul = 0;
> +	int div_val = 0;
> +	int mul_val = 0;
> +	int mul_div_val = 0;
> +	int reg = 0;
> +	u16 clk = 0;
> +	u32 vendor_ptr;
> +	unsigned long timeout;
> +	u32 tx_clk_phase_val = SDHC_DEF_TX_CLK_PH_VAL;
> +	u32 rx_clk_phase_val = SDHC_DEF_RX_CLK_PH_VAL;
> +
> +	/* DWC MSHC Specific clock settings */

I think this comment don't need..because this file already is IP specific.

> +
> +	/* if clock is less than 25MHz, divided clock is used.
> +	 * For divided clock, we can use the standard sdhci_set_clock().
> +	 * For clock above 25MHz, DRP clock is used
> +	 * Here, we cannot use sdhci_set_clock(), we need to program
> +	 * TX RX CLOCK DCM DRP for appropriate clock
> +	 */
> +
> +	vendor_ptr = sdhci_readw(host, SDHCI_UHS2_VENDOR);
> +
> +	if (clock <= 25000000) {
> +		/* Then call generic set_clock */
> +		sdhci_ops->set_clock(host, clock);
> +	} else {
> +
> +		host->mmc->actual_clock = 0;
> +
> +		/* Select un-phase shifted clock before reset Tx Tuning DCM*/
> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg &= ~SDHC_TX_CLK_SEL_TUNED;
> +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +		mdelay(10);
> +
> +		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +		if (clock == 0)
> +			return;

Why return here? Can this locate above?

> +
> +		/* Lets chose the Mulitplier value to be 0x2 */
> +		mul = 0x2;
> +		for (div = 1; div <= 32; div++) {
> +			if (((host->max_clk * mul) / div)
> +					<= clock)
> +				break;
> +		}
> +		/*
> +		 * Set Programmable Clock Mode in the Clock
> +		 * Control register.
> +		 */
> +		div_val = div - 1;
> +		mul_val = mul - 1;
> +
> +		host->mmc->actual_clock = (host->max_clk * mul) / div;
> +		/* Program the DCM DRP */
> +		/* Step 1: Assert DCM Reset */

I think more readable that you write the all steps on here.
		/*
		 * Step1 :...
		 * Step2 :...

> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg = reg | SDHC_CARD_TX_CLK_DCM_RST;

reg |= SDHC_CARD_...

> +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +		/* Step 2: Program the mul and div values in DRP */
> +		mul_div_val = (mul_val << 8) | div_val;
> +		sdhci_writew(host, mul_div_val, TXRX_CLK_DCM_MUL_DIV_DRP);
> +
> +		/* Step 3: issue a dummy read from DRP base 0x00 as per
> +		 * www.xilinx.com/support/documentation/user_guides/ug191.pdf
> +		 */
> +		reg = sdhci_readw(host, TXRX_CLK_DCM_DRP_BASE_51);

This code is workaroud for issue?

> +
> +		/* Step 4: De-Assert reset to DCM  */
> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg &= ~SDHC_CARD_TX_CLK_DCM_RST;
> +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +		clk |= SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +		/* Wait max 20 ms */
> +		timeout = 20;
> +		while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +					& SDHCI_CLOCK_INT_STABLE)) {
> +			if (timeout == 0) {
> +				pr_err("%s: Internal clock never stabilised\n",
> +					mmc_hostname(host->mmc));
> +				return;
> +			}
> +			timeout--;
> +			mdelay(1);
> +		}
> +
> +		clk |= SDHCI_CLOCK_CARD_EN;
> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +		/* For some bit-files we may have to do phase shifting for
> +		 * Tx Clock; Let's do it here
> +		 */
> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg = reg | SDHC_TUNING_TX_CLK_DCM_RST;

Ditto.

> +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +		mdelay(10);
> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg &= ~SDHC_TUNING_TX_CLK_DCM_RST;
> +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +		/* Select working phase value if clock is <= 50MHz */
> +		if (clock <= 50000000) {
> +			/*Change the Phase value here */
> +			reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +			reg = reg | (SDHC_TUNING_TX_CLK_SEL_MASK &
> +			   (tx_clk_phase_val << SDHC_TUNING_TX_CLK_SEL_SHIFT));
> +			sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +			mdelay(10);
> +
> +			/* Program to select phase shifted clock */
> +			reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +			reg = reg | SDHC_TX_CLK_SEL_TUNED;
> +			sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +			mdelay(10);
> +		}
> +
> +		/* This Clock might have affected the RX CLOCK DCM
> +		 * used for Phase control; Reset this DCM for proper clock
> +		 */
> +
> +		/* Program the DCM DRP */
> +		/* Step 1: Reset the DCM */
> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg = reg | SDHC_TUNING_RX_CLK_DCM_RST;
> +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +		mdelay(10);
> +		/* Step 2: De-Assert reset to DCM  */
> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +		reg &= ~SDHC_TUNING_RX_CLK_DCM_RST;
> +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));

Can these codes reuse?
If clock is upper than 50MHz, then only this code is running twice..is it correct?

> +
> +		/* For 50Mhz, tuning is not possible.. Lets fix the sampling
> +		 * Phase of Rx Clock here
> +		 */
> +		if (clock <= 50000000) {
> +			/*Change the Phase value here */
> +			reg = sdhci_readl(host, (SDHC_DBOUNCE + vendor_ptr));
> +			reg &= ~SDHC_TUNING_RX_CLK_SEL_MASK;
> +			reg = reg | (SDHC_TUNING_RX_CLK_SEL_MASK &
> +					rx_clk_phase_val);
> +			sdhci_writew(host, reg, (SDHC_DBOUNCE + vendor_ptr));
> +		}
> +		mdelay(10);
> +	}
> +}
> +
> +static int sdhci_pci_enable_dma_snps(struct sdhci_host *host)
> +{
> +	/* DWC MSHC Specific Dma Enabling */

Ditto.. this file is already DWC specific.

> +
> +	/* Call generic emable_dma */
> +	return sdhci_ops->enable_dma(host);
> +}
> +
> +static void sdhci_pci_set_bus_width_snps(struct sdhci_host *host, int width)
> +{
> +	/* DWC MSHC Specific Bus Width Setting */

Ditto.

> +
> +	/* Call generic set_bus_width */
> +	sdhci_ops->set_bus_width(host, width);
> +}
> +
> +static void sdhci_reset_snps(struct sdhci_host *host, u8 mask)
> +{
> +	/* DWC MSHC Specific hci reset */
> +
> +	/* Call generic reset */
> +	sdhci_ops->reset(host, mask);
> +}
> +static void sdhci_set_uhs_signaling_snps(struct sdhci_host *host,
> +	unsigned int timing)
> +{
> +	/* DWC MSHC Specific UHS-I Signaling */
> +
> +	/* Call generic UHS-I signaling */
> +	sdhci_ops->set_uhs_signaling(host, timing);
> +}
> +static void sdhci_pci_hw_reset_snps(struct sdhci_host *host)
> +{
> +	/* DWC MSHC Specific hw reset */
> +
> +	/* Call generic hw_reset */
> +	if (host->ops && host->ops->hw_reset)

Above other host->ops-> didn't check..do you think what's correct?

> +		sdhci_ops->hw_reset(host);
> +}
> +static const struct sdhci_ops sdhci_pci_ops_snps = {
> +	.set_clock	= sdhci_set_clock_snps,
> +	.enable_dma	= sdhci_pci_enable_dma_snps,
> +	.set_bus_width	= sdhci_pci_set_bus_width_snps,
> +	.reset		= sdhci_reset_snps,
> +	.set_uhs_signaling = sdhci_set_uhs_signaling_snps,
> +	.hw_reset	   = sdhci_pci_hw_reset_snps,
> +};
> +
> +static int snps_init_clock(struct sdhci_host *host)
> +{
> +	int div = 0;
> +	int mul = 0;
> +	int div_val = 0;
> +	int mul_val = 0;
> +	int mul_div_val = 0;
> +	int reg = 0;
> +	u32 vendor_ptr;
> +
> +	vendor_ptr = sdhci_readw(host, SDHCI_UHS2_VENDOR);
> +
> +	/* Configure the BCLK DRP to get 100 MHZ Clock */
> +
> +	/* To get 100MHz from 100MHz input freq,
> +	 * mul=2 and div=2
> +	 * Formula: output_clock = (input clock * mul) / div
> +	 */
> +	mul = 2;
> +	div = 2;
> +	mul_val = mul - 1;
> +	div_val = div - 1;
> +	/* Program the DCM DRP */
> +	/* Step 1: Reset the DCM */
> +	reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +	reg = reg | SDHC_BCLK_DCM_RST;
> +	sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +	/* Step 2: Program the mul and div values in DRP */
> +	mul_div_val = (mul_val << 8) | div_val;
> +	sdhci_writew(host, mul_div_val, BCLK_DCM_MUL_DIV_DRP);
> +	/* Step 3: issue a dummy read from DRP base 0x00 as per
> +	 * http://www.xilinx.com/support/documentation/user_guides/ug191.pdf
> +	 */
> +	reg = sdhci_readw(host, BCLK_DCM_DRP_BASE_51);
> +	/* Step 4: De-Assert reset to DCM  */
> +	/* de assert reset*/
> +	reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +	reg &= ~SDHC_BCLK_DCM_RST;
> +	sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));

I'm not sure but it seems these codes are also simliar to above codes.
If i'm correct, you can reduce the code lines.

> +
> +	/* By Default Clocks to MSHC are off..
> +	 * Before stack applies reset; we need to turn on the clock
> +	 */
> +	sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> +
> +	return 0;
> +
> +}
> +
> +int sdhci_pci_probe_slot_snps(struct sdhci_pci_slot *slot)
> +{
> +	int ret = 0;
> +	struct sdhci_host *host;
> +
> +	host = slot->host;
> +	sdhci_ops = host->ops;
> +	host->ops = &sdhci_pci_ops_snps;
> +
> +	/* Board specific clock initialization */
> +	ret = snps_init_clock(host);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_pci_probe_slot_snps);
> diff --git a/drivers/mmc/host/sdhci-dwc-mshc-pci.h b/drivers/mmc/host/sdhci-dwc-mshc-pci.h
> new file mode 100644
> index 0000000..1635bf2
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-dwc-mshc-pci.h
> @@ -0,0 +1,58 @@
> +/*
> + * Copyright (C) 2016 Synopsys, Inc.
> + *
> + * Author: Manjunath M B <manjumb@synopsys.com>
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
> +#ifndef __SDHCI_DWC_MSHC_PCI_H__
> +#define __SDHCI_DWC_MSHC_PCI_H__
> +
> +#include "sdhci-pci.h"
> +
> +#define SDHCI_UHS2_VENDOR	0xE8
> +
> +#define DRIVER_NAME "sdhci_snps"

What do you use .."snps" or "dwc_mshc"?
As i mentioned, i want not to use "*mshc*" in these patches.

Best Regards,
Jaehoon Chung

> +#define SDHC_DEF_TX_CLK_PH_VAL  4
> +#define SDHC_DEF_RX_CLK_PH_VAL  4
> +
> +/* Synopsys Vendor Specific Registers */
> +#define SDHC_DBOUNCE                           0x08
> +#define SDHC_TUNING_RX_CLK_SEL_MASK            0x000000FF
> +#define SDHC_GPIO_OUT                          0x34
> +/* HAPS 51 Based implementation */
> +#define SDHC_BCLK_DCM_RST                      0x00000001
> +#define SDHC_CARD_TX_CLK_DCM_RST               0x00000002
> +#define SDHC_TUNING_RX_CLK_DCM_RST             0x00000004
> +#define SDHC_TUNING_TX_CLK_DCM_RST             0x00000008
> +#define SDHC_TUNING_TX_CLK_SEL_MASK            0x00000070
> +#define SDHC_TUNING_TX_CLK_SEL_SHIFT           4
> +#define SDHC_TX_CLK_SEL_TUNED                  0x00000080
> +
> +/* Offset of BCLK DCM DRP Attributes */
> +/* Every attribute is of 16 bit wide */
> +#define BCLK_DCM_DRP_BASE_51                   0x1000
> +
> +#define BCLK_DCM_MUL_DIV_DRP                   0x1050
> +#define MUL_MASK_DRP                           0xFF00
> +#define DIV_MASK_DRP                           0x00FF
> +
> +/* Offset of TX and RX CLK DCM DRP */
> +#define TXRX_CLK_DCM_DRP_BASE_51               0x2000
> +#define TXRX_CLK_DCM_MUL_DIV_DRP               0x2050
> +
> +int sdhci_pci_probe_snps(struct sdhci_pci_chip *chip);
> +int sdhci_pci_probe_slot_snps(struct sdhci_pci_slot *slot);
> +int sdhci_pci_resume_snps(struct sdhci_pci_chip *chip);
> +int sdhci_pci_suspend_snps(struct sdhci_pci_chip *chip);
> +
> +#endif
> diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> index 79e1901..bfa3b39 100644
> --- a/drivers/mmc/host/sdhci-pci-core.c
> +++ b/drivers/mmc/host/sdhci-pci-core.c
> @@ -31,6 +31,7 @@
>  #include "sdhci.h"
>  #include "sdhci-pci.h"
>  #include "sdhci-pci-o2micro.h"
> +#include "sdhci-dwc-mshc-pci.h"
>  
>  /*****************************************************************************\
>   *                                                                           *
> @@ -70,6 +71,11 @@ static int ricoh_mmc_resume(struct sdhci_pci_chip *chip)
>  	msleep(500);
>  	return 0;
>  }
> +/* Synopsys DWC MSHC Controller based SDHCI-PCI */
> +static const struct sdhci_pci_fixes sdhci_snps = {
> +	.probe_slot	= sdhci_pci_probe_slot_snps,
> +	.quirks2	= SDHCI_QUIRK2_PRESET_VALUE_BROKEN,
> +};
>  
>  static const struct sdhci_pci_fixes sdhci_ricoh = {
>  	.probe		= ricoh_probe,
> @@ -797,6 +803,14 @@ static const struct sdhci_pci_fixes sdhci_amd = {
>  
>  static const struct pci_device_id pci_ids[] = {
>  	{
> +		.vendor		= PCI_VENDOR_ID_SYNOPSYS,
> +		.device		= 0xc201, /* Device ID of MSHC EP on Haps51 */
> +		.subvendor	= PCI_ANY_ID,
> +		.subdevice	= PCI_ANY_ID,
> +		.driver_data	= (kernel_ulong_t)&sdhci_snps,
> +	},
> +
> +	{
>  		.vendor		= PCI_VENDOR_ID_RICOH,
>  		.device		= PCI_DEVICE_ID_RICOH_R5C822,
>  		.subvendor	= PCI_ANY_ID,
> 

