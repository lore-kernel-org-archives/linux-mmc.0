From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: RE: [PATCH v3] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Wed, 27 Apr 2016 06:34:54 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A4B4CF2@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2010A4B12F8@IN01WEMBXB.internal.synopsys.com>
 <20160426085845.GA8756@odux.rfo.atmel.com> <571F46C9.9050905@samsung.com>
 <705D14B1C7978B40A723277C067CEDE2010A4B4B87@IN01WEMBXB.internal.synopsys.com>
 <20160426132922.GE8756@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtprelay.synopsys.com ([198.182.47.9]:49867 "EHLO
	smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752049AbcD0GfE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 27 Apr 2016 02:35:04 -0400
In-Reply-To: <20160426132922.GE8756@odux.rfo.atmel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, CPGS <cpgs@samsung.com>

Hi Ludovic,

On 04/26/2016 06:59 PM, Ludovic Desroches wrote:
> 
> On Tue, Apr 26, 2016 at 12:31:50PM +0000, Prabu Thangamuthu wrote:
> > Hi Ludovic, Jaehoon Chung,
> >
> > Thank you for your review comments,
> >
> > On 04/26/2016 04:15 PM, Jaehoon Chung wrote:
> > >
> > > On 04/26/2016 05:58 PM, Ludovic Desroches wrote:
> > > > On Wed, Apr 20, 2016 at 12:22:59PM +0000, Prabu Thangamuthu wrote:
> > > >> Patch for Standard SD Host Controller Interface compliant
> > > >> Synopsys sdhci-dwc controller driver. This code supports PCI based
> interface.
> > > >>
> > > >> Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
> > > >> ---
> > > >> Change log v3:
> > > >> 	-Removed unused code.
> > > >> 	-Updated review comments.
> > > >>
> > > >> Change log v2:
> > > >> 	-Removed Synopsys specific PCI device ID's from pci_ids.h.
> > > >> 	-Updated the PCI device ID's in sdhci-pci-core.c.
> > > >>
> > > >>  MAINTAINERS                       |   7 +
> > > >>  drivers/mmc/host/Makefile         |   3 +-
> > > >>  drivers/mmc/host/sdhci-pci-core.c |  14 ++
> > > >> drivers/mmc/host/sdhci-pci-dwc.c  | 260
> > > >> ++++++++++++++++++++++++++++++++++++++
> > > >>  drivers/mmc/host/sdhci-pci-dwc.h  |  55 ++++++++
> > > >>  5 files changed, 338 insertions(+), 1 deletion(-)  create mode
> > > >> 100644 drivers/mmc/host/sdhci-pci-dwc.c  create mode 100644
> > > >> drivers/mmc/host/sdhci-pci-dwc.h
> > > >>
> 
> [snip]
> 
> > > >> diff --git a/drivers/mmc/host/sdhci-pci-dwc.c
> > > >> b/drivers/mmc/host/sdhci-pci-dwc.c
> > > >> new file mode 100644
> > > >> index 0000000..3490af8
> > > >> --- /dev/null
> > > >> +++ b/drivers/mmc/host/sdhci-pci-dwc.c
> > > >> @@ -0,0 +1,260 @@
> > > >> +/*
> > > >> + * Copyright (C) 2016 Synopsys, Inc.
> > > >> + *
> > > >> + * Author: Manjunath M B <manjumb@synopsys.com>
> > > >> + *
> > > >> + * This software is licensed under the terms of the GNU General
> > > >> +Public
> > > >> + * License version 2, as published by the Free Software
> > > >> +Foundation, and
> > > >> + * may be copied, distributed, and modified under those terms.
> > > >> + *
> > > >> + * This program is distributed in the hope that it will be
> > > >> +useful,
> > > >> + * but WITHOUT ANY WARRANTY; without even the implied warranty
> > > >> +of
> > > >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> the
> > > >> + * GNU General Public License for more details.
> > > >> + *
> > > >> + */
> > > >> +
> > > >> +#include <linux/pci.h>
> > > >> +#include <linux/delay.h>
> > > >> +#include <linux/module.h>
> > > >> +#include <linux/moduleparam.h>
> > > >> +
> > > >> +#include "sdhci.h"
> > > >> +#include "sdhci-pci.h"
> > > >> +#include "sdhci-pci-dwc.h"
> > > >> +
> > > >>
> > >
> +/*********************************************************
> > > ********************\
> > > >> + *                                                                           *
> > > >> + * Hardware specific clock handling                                          *
> > > >> + *                                                                           *
> > > >>
> > >
> +\*********************************************************
> > > ********************/
> > > >> +static const struct sdhci_ops *sdhci_ops;	/* Low level hw
> interface */
> > > >> +
> 
> [snip]
> 
> > > >> +static void sdhci_set_clock_snps(struct sdhci_host *host,
> > > >> +						unsigned int clock)
> > > >> +{
> > > >> +	int div = 0;
> > > >> +	int mul = 0;
> > > >> +	int div_val = 0;
> > > >> +	int mul_val = 0;
> > > >> +	int mul_div_val = 0;
> > > >> +	u32 reg = 0;
> > > >> +	u16 clk = 0;
> > > >> +	u16 vendor_ptr = 0;
> > > >> +	u32 mask = 0;
> > > >> +	unsigned long timeout;
> > > >> +	u32 tx_clk_phase_val = SDHC_DEF_TX_CLK_PH_VAL;
> > > >> +	u32 rx_clk_phase_val = SDHC_DEF_RX_CLK_PH_VAL;
> > > >> +
> > > >
> > > > Some variables don't need to be initialized here.
> > >
> > > tx/rx_clk_phase_val don't need?
> > > i didn't see any modifying these vales.
> > >
> > > And some variables don't need to define..can be reused.
> > >
> > OK, We will update it accordingly.
> >
> > > >
> > > >> +	/*
> > > >> +	 * if clock is less than 25MHz, divided clock is used.
> > > >> +	 * For divided clock, we can use the standard
> sdhci_set_clock().
> > > >> +	 * For clock above 25MHz, DRP clock is used
> > > >> +	 * Here, we cannot use sdhci_set_clock(), we need to
> program
> > > >> +	 * TX RX CLOCK DCM DRP for appropriate clock
> > > >> +	 */
> > > >> +
> > > >> +	if (clock <= 25000000) {
> > > >> +		/* Then call generic set_clock */
> > > >> +		if (sdhci_ops->set_clock)
> > > >> +			sdhci_ops->set_clock(host, clock);
> > > >
> > > > I am not sure about this part. You may simply call
> > > > sdhci_set_clock() instead of sdhci_ops->set_clock(). See my latest
> > > > comment, it is not clear what is behind set_clock().
> > > >
> >
> > As we have built our own clocking logic using DCM, we want to use our
> > own set_clock function for the frequency above 25MHz.
> > For lower frequencies, our clocking module program is same as
> sdhci_set_clock().
> > So we are calling sdhci_ops->set_clock() which is same as
> sdhci_set_clock().
> >
> > > >> +	} else {
> > > >> +
> > > >> +		host->mmc->actual_clock = 0;
> > > >> +		vendor_ptr = sdhci_readw(host,
> SDHCI_UHS2_VENDOR);
> > > >> +
> > > >> +		/* Select un-phase shifted clock before reset Tx
> Tuning
> > > DCM*/
> > > >> +		reg = sdhci_readl(host, (SDHC_GPIO_OUT +
> vendor_ptr));
> > > >> +		reg &= ~SDHC_TX_CLK_SEL_TUNED;
> > > >> +		sdhci_writel(host, reg, (SDHC_GPIO_OUT +
> vendor_ptr));
> > > >> +		mdelay(10);
> > > >> +
> > > >> +		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > > >> +
> > > >> +		/* Lets chose the Mulitplier value to be 0x2 */
> > > >> +		mul = 0x2;
> > > >> +		for (div = 1; div <= 32; div++) {
> > > >> +			if (((host->max_clk * mul) / div)
> > > >> +					<= clock)
> > > >> +				break;
> > > >> +		}
> > > >> +		/*
> > > >> +		 * Set Programmable Clock Mode in the Clock
> > > >> +		 * Control register.
> > > >> +		 */
> > > >> +		div_val = div - 1;
> > > >> +		mul_val = mul - 1;
> > > >> +
> > > >> +		host->mmc->actual_clock = (host->max_clk * mul) /
> div;
> > > >> +		/*
> > > >> +		 * Program the DCM DRP
> > > >> +		 * Step 1: Assert DCM Reset
> > > >> +		 * Step 2: Program the mul and div values in DRP
> > > >> +		 * Step 3: Read from DRP base 0x00 to restore DCM
> output as
> > > per
> > > >> +		 *
> > > www.xilinx.com/support/documentation/user_guides/ug191.pdf
> > > >> +		 * Step 4: De-Assert reset to DCM
> > > >> +		 */
> > > >> +
> > > >> +		mask = SDHC_CARD_TX_CLK_DCM_RST;
> > > >> +		snps_reset_dcm(host, mask, 1);
> > > >> +
> > > >> +		mul_div_val = (mul_val << 8) | div_val;
> > > >> +		sdhci_writew(host, mul_div_val,
> > > TXRX_CLK_DCM_MUL_DIV_DRP);
> > > >> +
> > > >> +		reg = sdhci_readl(host,
> TXRX_CLK_DCM_DRP_BASE_51);
> > > >> +
> > > >> +		snps_reset_dcm(host, mask, 0);
> > > >> +
> > > >> +		clk |= SDHCI_PROG_CLOCK_MODE |
> SDHCI_CLOCK_INT_EN;
> > > >> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > >> +
> > > >> +		/* Wait max 20 ms */
> > > >> +		timeout = 20;
> > > >> +		while (!((clk = sdhci_readw(host,
> SDHCI_CLOCK_CONTROL))
> > > >> +					&
> SDHCI_CLOCK_INT_STABLE)) {
> > > >> +			if (timeout == 0) {
> > > >> +				pr_err("%s: Internal clock never
> stabilised\n",
> > > >> +
> 	mmc_hostname(host-
> > > >mmc));
> > > >> +				return;
> > > >> +			}
> > > >> +			timeout--;
> > > >> +			mdelay(1);
> > > >> +		}
> > > >> +
> > > >> +		clk |= SDHCI_CLOCK_CARD_EN;
> > > >> +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > > >> +
> > > >> +		/*
> > > >> +		 * This Clock might have affected the TX CLOCK DCM
> and RX
> > > CLOCK
> > > >> +		 * DCM which are used for Phase control; Reset these
> DCM's
> > > >> +		 * for proper clock output
> > > >> +		 *
> > > >> +		 * Step 1: Reset the DCM
> > > >> +		 * Step 2: De-Assert reset to DCM
> > > >> +		 */
> > > >> +
> > > >> +		mask = SDHC_TUNING_TX_CLK_DCM_RST |
> > > SDHC_TUNING_RX_CLK_DCM_RST;
> > > >> +		snps_reset_dcm(host, mask, 1);
> > > >> +		mdelay(10);
> > > >> +		snps_reset_dcm(host, mask, 0);
> > > >> +
> > > >> +		/* Select working phase value if clock is <= 50MHz */
> > > >> +		if (clock <= 50000000) {
> > > >> +			/*Change the Tx Phase value here */
> > > >> +			reg = sdhci_readl(host, (SDHC_GPIO_OUT +
> > > vendor_ptr));
> > > >> +			reg |= (SDHC_TUNING_TX_CLK_SEL_MASK &
> > > >> +			   (tx_clk_phase_val <<
> > > SDHC_TUNING_TX_CLK_SEL_SHIFT));
> > > >> +
> > > >> +			sdhci_writel(host, reg, (SDHC_GPIO_OUT +
> > > vendor_ptr));
> > > >> +			mdelay(10);
> > > >> +
> > > >> +			/* Program to select phase shifted clock */
> > > >> +			reg |= SDHC_TX_CLK_SEL_TUNED;
> > > >> +			sdhci_writel(host, reg, (SDHC_GPIO_OUT +
> > > vendor_ptr));
> > > >> +
> > > >> +			/*
> > > >> +			 * For 50Mhz, tuning is not possible.
> > > >> +			 * Lets fix the sampling Phase of Rx Clock
> here.
> > > >> +			 */
> > > >> +			reg = sdhci_readl(host, (SDHC_DBOUNCE +
> > > vendor_ptr));
> > > >> +			reg &= ~SDHC_TUNING_RX_CLK_SEL_MASK;
> > > >> +			reg |= (SDHC_TUNING_RX_CLK_SEL_MASK &
> > > >> +					rx_clk_phase_val);
> > > >> +			sdhci_writel(host, reg, (SDHC_DBOUNCE +
> > > vendor_ptr));
> > > >> +		}
> > > >> +		mdelay(10);
> > > >> +	}
> > > >> +}
> 
> [snip]
> 
> > > >> +static struct sdhci_ops sdhci_pci_ops_snps = {
> > > >> +	.set_clock	= sdhci_set_clock_snps,
> > > >> +};
> > > >> +
> > > >> +int sdhci_pci_probe_slot_snps(struct sdhci_pci_slot *slot) {
> > > >> +	int ret = 0;
> > > >> +	struct sdhci_host *host;
> > > >> +
> > > >> +	host = slot->host;
> > > >> +	sdhci_ops = host->ops;
> > > >> +
> > > >> +	sdhci_pci_ops_snps.enable_dma		= sdhci_ops-
> > > >enable_dma;
> > > >> +	sdhci_pci_ops_snps.set_bus_width	= sdhci_ops-
> >set_bus_width;
> > > >> +	sdhci_pci_ops_snps.reset		= sdhci_ops->reset;
> > > >> +	sdhci_pci_ops_snps.set_uhs_signaling	= sdhci_ops-
> > > >set_uhs_signaling;
> > > >> +	sdhci_pci_ops_snps.hw_reset		= sdhci_ops-
> >hw_reset;
> > > >> +
> > > >> +	host->ops = &sdhci_pci_ops_snps;
> > > >
> > > > I am lost. sdhci_ops is a kind of backup of the original ops from
> > > > pci core. Your sdhci_pci_ops_snps is a copy of ops from pci core
> > > > excepting set_clock and finally you update pci core ops with
> sdhci_pci_ops_snps.
> > > >
> > > > It seems a bit complex. At the end, unless I have missed
> > > > something, you have only changed set_clock from pci ops.
> > > >
> >
> > You are correct, sdhci_pci_ops_snps is using pci core ops except set_clock.
> > As I mentioned at the top, We have built our own clocking logic using DCM.
> > So, we have to use our own set_clock function and We are reusing the
> > pci core ops for the reaming ops.
> 
> Ok so I have well understood. Any reason to not do it this way:
> 
> 
> -static const struct sdhci_ops *sdhci_ops;
> 
> -static struct sdhci_ops sdhci_pci_ops_snps = {
> -        .set_clock      = sdhci_set_clock_snps,
> -};
> 
> +int sdhci_pci_probe_slot_snps(struct sdhci_pci_slot *slot) {
> +        int ret = 0;
> +        struct sdhci_host *host;
> +
> +        host = slot->host;
> +        host->ops->set_clock = &sdhci_set_clock_snps;

Sorry, this code won't work. Because, host->ops is a pointer to constant. 
So, we will get following compilation error,

drivers/mmc/host/sdhci-pci-dwc.c: In function 'sdhci_pci_probe_slot_snps':
drivers/mmc/host/sdhci-pci-dwc.c:245:23: error: assignment of member 'set_clock' in read-only object
  host->ops->set_clock = &sdhci_set_clock_snps;

To solve this issue, we took the different approach as programmed in this patch.
 
> 
> And use sdhci_set_clock() instead of sdhci_ops->set_clock. At the first read,
> I thought you are not calling sdhci_set_clock() but sdhci_set_clock_snps()
> but I understood later that sdhci_ops is different from host->ops which is a
> bit confusing.

We understood your point, we will use sdhci_set_clock() instead of sdhci_ops->set_clock().


Thanks & Regards,
Prabu Thangamuthu.

