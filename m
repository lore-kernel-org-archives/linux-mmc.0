From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v3] mmc: sdhci-pci: add Support of Synopsys DWC_MSHC IP
Date: Tue, 26 Apr 2016 11:05:22 +0200
Message-ID: <20160426090522.GB8756@odux.rfo.atmel.com>
References: <705D14B1C7978B40A723277C067CEDE2010A4B12F8@IN01WEMBXB.internal.synopsys.com>
 <20160426085845.GA8756@odux.rfo.atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160426085845.GA8756@odux.rfo.atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prabu Thangamuthu <Prabu.T@synopsys.com>, "Ulf Hansson (ulf.hansson@linaro.org)" <ulf.hansson@linaro.org>, Adrian Hunter <adrian.hunter@intel.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, "David S. Miller" <davem@davemloft.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kalle Valo <kvalo@codeaurora.org>, Mauro Carvalho Chehab <mchehab@osg.samsung.com>, Guenter Roeck <linux@roeck-us.net>, Jiri Slaby <jslaby@suse.com>, Chaotian Jing <chaotian.jing@mediatek.com>, Andrei Pistirica <andrei.pistirica@microchip.com>, Ben Hutchings <ben.hutchings@codethink.co.uk>, Joshua Henderson <joshua.henderson@microchip.com>, Manjunath M Bettegowda <Manjunath.MB@synopsys.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Apr 26, 2016 at 10:58:45AM +0200, Ludovic Desroches wrote:
> On Wed, Apr 20, 2016 at 12:22:59PM +0000, Prabu Thangamuthu wrote:
> > Patch for Standard SD Host Controller Interface compliant Synopsys
> > sdhci-dwc controller driver. This code supports PCI based interface.
> > 
> > Signed-off-by: Prabu Thangamuthu <prabu.t@synopsys.com>
> > ---
> > Change log v3:
> > 	-Removed unused code.
> > 	-Updated review comments.
> > 
> > Change log v2:
> > 	-Removed Synopsys specific PCI device ID's from pci_ids.h.
> > 	-Updated the PCI device ID's in sdhci-pci-core.c.
> > 
> >  MAINTAINERS                       |   7 +
> >  drivers/mmc/host/Makefile         |   3 +-
> >  drivers/mmc/host/sdhci-pci-core.c |  14 ++
> >  drivers/mmc/host/sdhci-pci-dwc.c  | 260 ++++++++++++++++++++++++++++++++++++++
> >  drivers/mmc/host/sdhci-pci-dwc.h  |  55 ++++++++
> >  5 files changed, 338 insertions(+), 1 deletion(-)
> >  create mode 100644 drivers/mmc/host/sdhci-pci-dwc.c
> >  create mode 100644 drivers/mmc/host/sdhci-pci-dwc.h
> > 

[snip]

> > +static int snps_init_clock(struct sdhci_host *host)
> > +{
> > +	int div = 0;
> > +	int mul = 0;
> > +	int div_val = 0;
> > +	int mul_val = 0;
> > +	int mul_div_val = 0;
> > +	int reg = 0;
> > +	u32 mask = 0;
> > +
> 
> Some variables don't need initialization here or you can directly assign
> the right value: int div = 2, mul = 2, etc.

div and mul are even useless, they are const. You can directly declare
mul_val = 1, div_val = 1.

Regards

Ludovic

> 
> > +	/* Configure the BCLK DRP to get 100 MHZ Clock */
> > +
> > +	/*
> > +	 * To get 100MHz from 100MHz input freq,
> > +	 * mul=2 and div=2
> > +	 * Formula: output_clock = (input clock * mul) / div
> > +	 */
> > +	mul = 2;
> > +	div = 2;
> > +	mul_val = mul - 1;
> > +	div_val = div - 1;
> > +	/*
> > +	 * Program the DCM DRP
> > +	 * Step 1: Assert DCM Reset
> > +	 * Step 2: Program the mul and div values in DRP
> > +	 * Step 3: Read from DRP base 0x00 to restore DCM output as per
> > +	 * www.xilinx.com/support/documentation/user_guides/ug191.pdf
> > +	 * Step 4: De-Assert reset to DCM
> > +	 */
> > +	mask = SDHC_BCLK_DCM_RST;
> > +	snps_reset_dcm(host, mask, 1);
> > +
> > +	mul_div_val = (mul_val << 8) | div_val;
> > +	sdhci_writew(host, mul_div_val, BCLK_DCM_MUL_DIV_DRP);
> > +
> > +	reg = sdhci_readl(host, BCLK_DCM_DRP_BASE_51);
> > +
> > +	snps_reset_dcm(host, mask, 0);
> > +
> > +	/*
> > +	 * By Default Clocks to Controller are OFF.
> > +	 * Before stack applies reset; we need to turn on the clock
> > +	 */
> > +	sdhci_writew(host, SDHCI_CLOCK_INT_EN, SDHCI_CLOCK_CONTROL);
> > +
> > +	return 0;
> > +
> > +}
