From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH v4] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Wed, 27 Apr 2016 16:39:21 +0300
Message-ID: <CAHp75VfHrX-mH=edkuj-Vvq_=-hFgA2Kay79e9h4P9ew-KNqAg@mail.gmail.com>
References: <705D14B1C7978B40A723277C067CEDE2010A4B4DB3@IN01WEMBXB.internal.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ob0-f169.google.com ([209.85.214.169]:35357 "EHLO
	mail-ob0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752324AbcD0NjX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2016 09:39:23 -0400
In-Reply-To: <705D14B1C7978B40A723277C067CEDE2010A4B4DB3@IN01WEMBXB.internal.synopsys.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Apr 27, 2016 at 2:51 PM, Prabu Thangamuthu <Prabu.T@synopsys.com> wrote:
> Patch for Standard SD Host Controller Interface compliant Synopsys
> sdhci-dwc controller driver. This code supports PCI based interface.

> @@ -0,0 +1,244 @@
> +/*
> + * Copyright (C) 2016 Synopsys, Inc.
> + *
> + * Author: Manjunath M B <manjumb@synopsys.com>

Authors

> + *        Prabu Thangamuthu <prabu.t@synopsys.com>
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


> +/*****************************************************************************\
> + *                                                                           *
> + * Hardware specific clock handling                                          *
> + *                                                                           *
> +\*****************************************************************************/

Most of the lines are non-informative.

> +static void snps_reset_dcm(struct sdhci_host *host, u32 mask, u8 reset)
> +{
> +       u16 vendor_ptr;
> +       u32 reg;
> +
> +       vendor_ptr = sdhci_readw(host, SDHCI_UHS2_VENDOR);
> +
> +       reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +       if (reset == 1)
> +               reg |= mask;
> +       else
> +               reg &= ~mask;
> +
> +       sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +}
> +
> +static void sdhci_set_clock_snps(struct sdhci_host *host, u32 clock)
> +{
> +       u8 div;
> +       u8 mul;

I understand that CodingStyle recommends to keep one variable by line,
but here might be useful to combine related variables

u8 mul, div;

> +       u8 div_val;
> +       u8 mul_val;

u8 mul_val, div_val;

Up to you and to maintainers.

> +       u8 timeout;
> +       u16 clk;
> +       u16 vendor_ptr;
> +       u16 mul_div_val;
> +       u32 reg;
> +
> +       /*
> +        * if clock is less than 25MHz, divided clock is used.

if -> If

> +        * For divided clock, we can use the standard sdhci_set_clock().
> +        * For clock above 25MHz, DRP clock is used

Dot.

> +        * Here, we cannot use sdhci_set_clock(), we need to program
> +        * TX RX CLOCK DCM DRP for appropriate clock

Ditto.

> +        */

> +

Redundant.

> +       if (clock <= 25000000) {
> +               /* Then call standard set_clock */
> +               sdhci_set_clock(host, clock);

> +       } else {

You may save indentation if you return directly in positive branch.

> +
> +               host->mmc->actual_clock = 0;
> +               vendor_ptr = sdhci_readw(host, SDHCI_UHS2_VENDOR);
> +
> +               /* Select un-phase shifted clock before reset Tx Tuning DCM*/

Space is missed

> +               reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +               reg &= ~SDHC_TX_CLK_SEL_TUNED;
> +               sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));

> +               mdelay(10);

Why?! Explanation is needed.

> +
> +               sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> +
> +               /* Lets chose the Mulitplier value to be 0x2 */

Lets -> Let's

No explanation why so?

> +               mul = 0x2;
> +               for (div = 1; div <= 32; div++) {
> +                       if (((host->max_clk * mul) / div)
> +                                       <= clock)

Too many parens.

> +                               break;
> +               }

So, you would like to find a minimum divider that guarantees the
 clock > max_clk * mul / div.

This is completely long way to achieve.

What about
div = DIV_ROUND_UP(max_clk * mul / clock)

div_val = max(div, 32);


> +               /*
> +                * Set Programmable Clock Mode in the Clock
> +                * Control register.
> +                */

I suppose one line after fixing indentation.

> +               div_val = div - 1;
> +               mul_val = mul - 1;
> +
> +               host->mmc->actual_clock = (host->max_clk * mul) / div;
> +               /*
> +                * Program the DCM DRP
> +                * Step 1: Assert DCM Reset
> +                * Step 2: Program the mul and div values in DRP
> +                * Step 3: Read from DRP base 0x00 to restore DCM output as per
> +                * www.xilinx.com/support/documentation/user_guides/ug191.pdf
> +                * Step 4: De-Assert reset to DCM
> +                */
> +
> +               snps_reset_dcm(host, SDHC_CARD_TX_CLK_DCM_RST, 1);
> +
> +               mul_div_val = (mul_val << 8) | div_val;
> +               sdhci_writew(host, mul_div_val, TXRX_CLK_DCM_MUL_DIV_DRP);
> +               sdhci_readl(host, TXRX_CLK_DCM_DRP_BASE_51);
> +
> +               snps_reset_dcm(host, SDHC_CARD_TX_CLK_DCM_RST, 0);
> +
> +               clk = SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN;
> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +               /* Wait max 20 ms */
> +               timeout = 20;
> +               while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> +                                       & SDHCI_CLOCK_INT_STABLE)) {
> +                       if (timeout == 0) {

This is invariant to the loop. Check how it's done in other drivers.

Something like

while (condition && --timeout) {
...
}
if (!timeout) {
...
}

> +                               pr_err("%s: Internal clock never stabilised\n",
> +                                               mmc_hostname(host->mmc));

dev_err() ?

> +                               return;
> +                       }
> +                       timeout--;
> +                       mdelay(1);
> +               }
> +
> +               clk |= SDHCI_CLOCK_CARD_EN;
> +               sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> +
> +               /*
> +                * This Clock might have affected the TX CLOCK DCM and RX CLOCK
> +                * DCM which are used for Phase control; Reset these DCM's
> +                * for proper clock output
> +                *
> +                * Step 1: Reset the DCM
> +                * Step 2: De-Assert reset to DCM
> +                */
> +
> +               snps_reset_dcm(host, SDHC_TUNING_TX_CLK_DCM_RST |
> +                                       SDHC_TUNING_RX_CLK_DCM_RST, 1);
> +               mdelay(10);
> +               snps_reset_dcm(host, SDHC_TUNING_TX_CLK_DCM_RST |
> +                                       SDHC_TUNING_RX_CLK_DCM_RST, 0);
> +
> +               /* Select working phase value if clock is <= 50MHz */
> +               if (clock <= 50000000) {
> +                       /*Change the Tx Phase value here */

Space

> +                       reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> +                       reg |= (SDHC_TUNING_TX_CLK_SEL_MASK &
> +                                       (SDHC_DEF_TX_CLK_PH_VAL <<
> +                                               SDHC_TUNING_TX_CLK_SEL_SHIFT));
> +
> +                       sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));

> +                       mdelay(10);

Why?!

> +
> +                       /* Program to select phase shifted clock */
> +                       reg |= SDHC_TX_CLK_SEL_TUNED;
> +                       sdhci_writel(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> +
> +                       /*
> +                        * For 50Mhz, tuning is not possible.
> +                        * Lets fix the sampling Phase of Rx Clock here.
> +                        */
> +                       reg = sdhci_readl(host, (SDHC_DBOUNCE + vendor_ptr));
> +                       reg &= ~SDHC_TUNING_RX_CLK_SEL_MASK;
> +                       reg |= (SDHC_TUNING_RX_CLK_SEL_MASK &
> +                                       SDHC_DEF_RX_CLK_PH_VAL);
> +                       sdhci_writel(host, reg, (SDHC_DBOUNCE + vendor_ptr));
> +               }
> +               mdelay(10);

Ditto.

> +       }
> +}

Don't have time to go further. Check your code fully and carefully.

> +
> +static int snps_init_clock(struct sdhci_host *host)
> +{
> +       u16 mul_div_val;
> +
> +       /*
> +        * Configure the BCLK DRP to get 100 MHZ Clock
> +        * To get 100MHz from 100MHz input freq,
> +        * mul=1 and div=1
> +        * Formula: output_clock = (input clock * mul) / div
> +        *
> +        * Program the DCM DRP
> +        * Step 1: Assert DCM Reset
> +        * Step 2: Program the mul and div values in DRP
> +        * Step 3: Read from DRP base 0x00 to restore DCM output as per
> +        * www.xilinx.com/support/documentation/user_guides/ug191.pdf
> +        * Step 4: De-Assert reset to DCM
> +        */
> +       snps_reset_dcm(host, SDHC_BCLK_DCM_RST, 1);
> +
> +       mul_div_val = 0x0101;
> +       sdhci_writew(host, mul_div_val, BCLK_DCM_MUL_DIV_DRP);
> +       sdhci_readl(host, BCLK_DCM_DRP_BASE_51);
> +
> +       snps_reset_dcm(host, SDHC_BCLK_DCM_RST, 0);
> +
> +       /*
> +        * By Default Clocks to Controller are OFF.
> +        * Before stack applies reset; we need to turn on the clock
> +        */
> +       sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> +
> +       return 0;
> +
> +}
> +static struct sdhci_ops sdhci_pci_ops_snps = {
> +       .set_clock      = sdhci_set_clock_snps,
> +};
> +
> +int sdhci_pci_probe_slot_snps(struct sdhci_pci_slot *slot)
> +{
> +       int ret = 0;
> +       struct sdhci_host *host;
> +       const struct sdhci_ops *sdhci_pci_ops;  /* Low level hw interface */
> +
> +       host = slot->host;
> +       sdhci_pci_ops = host->ops;
> +
> +       sdhci_pci_ops_snps.enable_dma           = sdhci_pci_ops->enable_dma;
> +       sdhci_pci_ops_snps.set_bus_width        = sdhci_pci_ops->set_bus_width;
> +       sdhci_pci_ops_snps.reset                = sdhci_pci_ops->reset;
> +       sdhci_pci_ops_snps.set_uhs_signaling    =
> +                                       sdhci_pci_ops->set_uhs_signaling;
> +       sdhci_pci_ops_snps.hw_reset             = sdhci_pci_ops->hw_reset;
> +       sdhci_pci_ops_snps.select_drive_strength =
> +                                       sdhci_pci_ops->select_drive_strength;
> +
> +       host->ops = &sdhci_pci_ops_snps;
> +
> +       /* Board specific clock initialization */
> +       ret = snps_init_clock(host);
> +
> +       return ret;
> +}
> +EXPORT_SYMBOL_GPL(sdhci_pci_probe_slot_snps);
> diff --git a/drivers/mmc/host/sdhci-pci-dwc.h b/drivers/mmc/host/sdhci-pci-dwc.h
> new file mode 100644
> index 0000000..02e2213
> --- /dev/null
> +++ b/drivers/mmc/host/sdhci-pci-dwc.h
> @@ -0,0 +1,55 @@
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
> +#define SDHCI_UHS2_VENDOR      0xE8
> +
> +#define DRIVER_NAME "sdhci-pci-dwc"
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
> +int sdhci_pci_probe_slot_snps(struct sdhci_pci_slot *slot);
> +
> +#endif
> --
> 1.9.1
>



-- 
With Best Regards,
Andy Shevchenko
