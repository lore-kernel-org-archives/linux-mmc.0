From: Raul Rangel <rrangel@chromium.org>
Subject: Re: [RFC PATCH 2/2] mmc: sdhci: Quirk for AMD SDHC Device 0x7906
Date: Thu, 2 May 2019 09:42:49 -0600
Message-ID: <20190502154249.GA25027@google.com>
References: <20190501175457.195855-1-rrangel@chromium.org>
 <20190501175457.195855-2-rrangel@chromium.org>
 <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <08c3dc49-f5cb-401d-b900-12879f469728@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, "Agrawal, Nitesh-kumar" <Nitesh-kumar.Agrawal@amd.com>, djkurtz@chromium.org, linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, "Sen, Pankaj" <Pankaj.Sen@amd.com>, "Shah, Nehal-bakulchandra" <Nehal-bakulchandra.Shah@amd.com>, Avri Altman <avri.altman@wdc.com>, gene.chen@amd.com, Chris.Wang@amd.com
List-Id: linux-mmc@vger.kernel.org

Ou Thu, May 02, 2019 at 09:32:16AM +0300, Adrian Hunter wrote:

Gene or Chris,
Can you sign off on the patch.

Thanks,
Raul
> Cc: some AMD people
> 
> On 1/05/19 8:54 PM, Raul E Rangel wrote:
> > AMD SDHC 0x7906 requires a hard reset to clear all internal state.
> > Otherwise it can get into a bad state where the DATA lines are always
> > read as zeros.
> > 
> > This change requires firmware that can transition the device into
> > D3Cold for it to work correctly. If the firmware does not support
> > transitioning to D3Cold then the power state transitions are a no-op.
> > 
> > Signed-off-by: Raul E Rangel <rrangel@chromium.org>
> > ---
> > 
> >  drivers/mmc/host/sdhci-pci-core.c | 51 ++++++++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/mmc/host/sdhci-pci-core.c b/drivers/mmc/host/sdhci-pci-core.c
> > index 99b0fec2836b..532fbcbd373b 100644
> > --- a/drivers/mmc/host/sdhci-pci-core.c
> > +++ b/drivers/mmc/host/sdhci-pci-core.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/mmc/mmc.h>
> >  #include <linux/scatterlist.h>
> >  #include <linux/io.h>
> > +#include <linux/iopoll.h>
> >  #include <linux/gpio.h>
> >  #include <linux/pm_runtime.h>
> >  #include <linux/mmc/slot-gpio.h>
> > @@ -1498,11 +1499,59 @@ static int amd_probe(struct sdhci_pci_chip *chip)
> >  	return 0;
> >  }
> >  
> > +static u32 sdhci_read_present_state(struct sdhci_host *host)
> > +{
> > +	return sdhci_readl(host, SDHCI_PRESENT_STATE);
> > +}
> > +
> > +void amd_sdhci_reset(struct sdhci_host *host, u8 mask)
> > +{
> > +	struct sdhci_pci_slot *slot = sdhci_priv(host);
> > +	struct pci_dev *pdev = slot->chip->pdev;
> > +	u32 present_state;
> > +
> > +	/*
> > +	 * SDHC 0x7906 requires a hard reset to clear all internal state.
> > +	 * Otherwise it can get into a bad state where the DATA lines are always
> > +	 * read as zeros.
> > +	 */
> > +	if (pdev->device == 0x7906 && (mask & SDHCI_RESET_ALL)) {
> > +		pci_clear_master(pdev);
> > +
> > +		pci_save_state(pdev);
> > +
> > +		pci_set_power_state(pdev, PCI_D3cold);
> > +		pr_debug("%s: power_state=%u\n", mmc_hostname(host->mmc),
> > +			pdev->current_state);
> > +		pci_set_power_state(pdev, PCI_D0);
> > +
> > +		pci_restore_state(pdev);
> > +
> > +		/*
> > +		 * SDHCI_RESET_ALL says the card detect logic should not be
> > +		 * reset, but since we need to reset the entire controller
> > +		 * we should wait until the card detect logic has stabilized.
> > +		 *
> > +		 * This normally takes about 40ms.
> > +		 */
> > +		readx_poll_timeout(
> > +			sdhci_read_present_state,
> > +			host,
> > +			present_state,
> > +			present_state & SDHCI_CD_STABLE,
> > +			10000,
> > +			100000
> > +		);
> > +	}
> > +
> > +	return sdhci_reset(host, mask);
> > +}
> > +
> >  static const struct sdhci_ops amd_sdhci_pci_ops = {
> >  	.set_clock			= sdhci_set_clock,
> >  	.enable_dma			= sdhci_pci_enable_dma,
> >  	.set_bus_width			= sdhci_set_bus_width,
> > -	.reset				= sdhci_reset,
> > +	.reset				= amd_sdhci_reset,
> >  	.set_uhs_signaling		= sdhci_set_uhs_signaling,
> >  };
> >  
> > 
> 
