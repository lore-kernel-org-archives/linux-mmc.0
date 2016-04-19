From: Prabu Thangamuthu <Prabu.T@synopsys.com>
Subject: RE: [PATCH v2] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Tue, 19 Apr 2016 10:16:30 +0000
Message-ID: <705D14B1C7978B40A723277C067CEDE2010A4B1062@IN01WEMBXB.internal.synopsys.com>
References: <705D14B1C7978B40A723277C067CEDE2010A4B0FD7@IN01WEMBXB.internal.synopsys.com>
 <20160419073335.GJ7225@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160419073335.GJ7225@odux.rfo.atmel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>, Prabu Thangamuthu <Prabu.T@synopsys.com>
Cc: "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Hi Ludovic,

Thank you for review comments.

On Tue, April 19, 2016 1:04 PM, Ludovic Desroches wrote:
> Hi Prabu,
> 
> On Tue, Apr 19, 2016 at 07:18:36AM +0000, Prabu Thangamuthu wrote:
> > Synopsys DWC_MSHC is compliant with SD Host Specifications. This patch
> > is to support DWC_MSHC controller on PCI interface.
> >
> > +static void sdhci_set_clock_snps(struct sdhci_host *host,
> > +						unsigned int clock)
> > +{
> > +	int div = 0;
> > +	int mul = 0;
> > +	int div_val = 0;
> > +	int mul_val = 0;
> > +	int mul_div_val = 0;
> > +	int reg = 0;
> > +	u16 clk = 0;
> > +	u32 vendor_ptr;
> > +	unsigned long timeout;
> > +	u32 tx_clk_phase_val = SDHC_DEF_TX_CLK_PH_VAL;
> > +	u32 rx_clk_phase_val = SDHC_DEF_RX_CLK_PH_VAL;
> > +
> > +	/* DWC MSHC Specific clock settings */
> > +
> > +	/* if clock is less than 25MHz, divided clock is used.
> 
> For multilines comments:
> 	/*
> 	 * If clock...
>

Unfortunately, I didn't get any Warning/Error when I ran "scripts/checkpatch.pl" 
against this Patch.
 
I will update the Patch accordingly.
 
> > +	 * For divided clock, we can use the standard sdhci_set_clock().
> > +	 * For clock above 25MHz, DRP clock is used
> > +	 * Here, we cannot use sdhci_set_clock(), we need to program
> > +	 * TX RX CLOCK DCM DRP for appropriate clock
> > +	 */
> > +
> > +	vendor_ptr = sdhci_readw(host, SDHCI_UHS2_VENDOR);
> > +
> > +	if (clock <= 25000000) {
> > +		/* Then call generic set_clock */
> > +		sdhci_ops->set_clock(host, clock);
> > +	} else {
> > +
> > +		host->mmc->actual_clock = 0;
> > +
> > +		/* Select un-phase shifted clock before reset Tx Tuning
> DCM*/
> > +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> > +		reg &= ~SDHC_TX_CLK_SEL_TUNED;
> > +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> > +		mdelay(10);
> > +
> > +		sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
> > +
> > +		if (clock == 0)
> > +			return;
> > +
> > +		/* Lets chose the Mulitplier value to be 0x2 */
> > +		mul = 0x2;
> > +		for (div = 1; div <= 32; div++) {
> > +			if (((host->max_clk * mul) / div)
> > +					<= clock)
> > +				break;
> > +		}
> > +		/*
> > +		 * Set Programmable Clock Mode in the Clock
> > +		 * Control register.
> > +		 */
> > +		div_val = div - 1;
> > +		mul_val = mul - 1;
> > +
> > +		host->mmc->actual_clock = (host->max_clk * mul) / div;
> > +		/* Program the DCM DRP */
> > +		/* Step 1: Assert DCM Reset */
> > +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> > +		reg = reg | SDHC_CARD_TX_CLK_DCM_RST;
> > +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> > +
> > +		/* Step 2: Program the mul and div values in DRP */
> > +		mul_div_val = (mul_val << 8) | div_val;
> > +		sdhci_writew(host, mul_div_val,
> TXRX_CLK_DCM_MUL_DIV_DRP);
> > +
> > +		/* Step 3: issue a dummy read from DRP base 0x00 as per
> > +		 *
> www.xilinx.com/support/documentation/user_guides/ug191.pdf
> > +		 */
> > +		reg = sdhci_readw(host, TXRX_CLK_DCM_DRP_BASE_51);
> > +
> > +		/* Step 4: De-Assert reset to DCM  */
> > +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> > +		reg &= ~SDHC_CARD_TX_CLK_DCM_RST;
> > +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> > +
> > +		clk |= SDHCI_PROG_CLOCK_MODE | SDHCI_CLOCK_INT_EN;
> > +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +		/* Wait max 20 ms */
> > +		timeout = 20;
> > +		while (!((clk = sdhci_readw(host, SDHCI_CLOCK_CONTROL))
> > +					& SDHCI_CLOCK_INT_STABLE)) {
> > +			if (timeout == 0) {
> > +				pr_err("%s: Internal clock never stabilised\n",
> > +					mmc_hostname(host->mmc));
> > +				return;
> > +			}
> > +			timeout--;
> > +			mdelay(1);
> > +		}
> > +
> > +		clk |= SDHCI_CLOCK_CARD_EN;
> > +		sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
> > +
> > +		/* For some bit-files we may have to do phase shifting for
> > +		 * Tx Clock; Let's do it here
> > +		 */
> > +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> > +		reg = reg | SDHC_TUNING_TX_CLK_DCM_RST;
> > +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> > +		mdelay(10);
> > +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> > +		reg &= ~SDHC_TUNING_TX_CLK_DCM_RST;
> > +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> > +
> > +		/* Select working phase value if clock is <= 50MHz */
> > +		if (clock <= 50000000) {
> > +			/*Change the Phase value here */
> > +			reg = sdhci_readl(host, (SDHC_GPIO_OUT +
> vendor_ptr));
> > +			reg = reg | (SDHC_TUNING_TX_CLK_SEL_MASK &
> > +			   (tx_clk_phase_val <<
> SDHC_TUNING_TX_CLK_SEL_SHIFT));
> > +			sdhci_writew(host, reg, (SDHC_GPIO_OUT +
> vendor_ptr));
> > +			mdelay(10);
> > +
> > +			/* Program to select phase shifted clock */
> > +			reg = sdhci_readl(host, (SDHC_GPIO_OUT +
> vendor_ptr));
> > +			reg = reg | SDHC_TX_CLK_SEL_TUNED;
> > +			sdhci_writew(host, reg, (SDHC_GPIO_OUT +
> vendor_ptr));
> > +			mdelay(10);
> > +		}
> > +
> > +		/* This Clock might have affected the RX CLOCK DCM
> > +		 * used for Phase control; Reset this DCM for proper clock
> > +		 */
> > +
> > +		/* Program the DCM DRP */
> > +		/* Step 1: Reset the DCM */
> > +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> > +		reg = reg | SDHC_TUNING_RX_CLK_DCM_RST;
> > +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> > +		mdelay(10);
> > +		/* Step 2: De-Assert reset to DCM  */
> > +		reg = sdhci_readl(host, (SDHC_GPIO_OUT + vendor_ptr));
> > +		reg &= ~SDHC_TUNING_RX_CLK_DCM_RST;
> > +		sdhci_writew(host, reg, (SDHC_GPIO_OUT + vendor_ptr));
> > +
> > +		/* For 50Mhz, tuning is not possible.. Lets fix the sampling
> > +		 * Phase of Rx Clock here
> > +		 */
> > +		if (clock <= 50000000) {
> > +			/*Change the Phase value here */
> > +			reg = sdhci_readl(host, (SDHC_DBOUNCE +
> vendor_ptr));
> > +			reg &= ~SDHC_TUNING_RX_CLK_SEL_MASK;
> > +			reg = reg | (SDHC_TUNING_RX_CLK_SEL_MASK &
> > +					rx_clk_phase_val);
> > +			sdhci_writew(host, reg, (SDHC_DBOUNCE +
> vendor_ptr));
> > +		}
> > +		mdelay(10);
> > +	}
> > +}
> > +
> > +static int sdhci_pci_enable_dma_snps(struct sdhci_host *host) {
> > +	/* DWC MSHC Specific Dma Enabling */
> > +
> > +	/* Call generic emable_dma */
> > +	return sdhci_ops->enable_dma(host);
> > +}
> 
> Why doing this is if currently there is nothing specific? The same for other
> sdhci ops.

As we have Synopsys specific clocking module, we have to register "sdhci_set_clock_snps" 
with host->ops. For other functions, we registered our API's for future use only.

I will revert these API's to optimize the code.


Thanks & Regards,
Prabu Thangamuthu.
