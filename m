From: Zach Brown <zach.brown@ni.com>
Subject: Re: [RFC v2 2/2] mmc: sdhci: Ignore capability register when it
 comes to speeds and use DT binding instead when sdhci-cap-speed-modes-broken
 is set.
Date: Wed, 26 Oct 2016 17:28:12 -0500
Message-ID: <20161026222811.GA24391@zach-desktop>
References: <1477085715-30213-1-git-send-email-zach.brown@ni.com>
 <1477085715-30213-3-git-send-email-zach.brown@ni.com>
 <d4547457-036a-dbb7-ddb8-b839e04949b7@intel.com>
 <20161024154820.GA16144@zach-desktop>
 <d65f018e-b20e-9e87-fc07-eb2fb4b5079e@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <d65f018e-b20e-9e87-fc07-eb2fb4b5079e@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Tue, Oct 25, 2016 at 02:30:25PM +0300, Adrian Hunter wrote:
> On 24/10/16 18:48, Zach Brown wrote:
> > On Mon, Oct 24, 2016 at 10:34:46AM +0300, Adrian Hunter wrote:
> >> On 22/10/16 00:35, Zach Brown wrote:
> >>> When the sdhci-cap-speed-modes-broken DT property is set, the driver
> >>> will ignore the bits of the capability registers that correspond to
> >>> speed modes.
> >>>
> >>> Signed-off-by: Zach Brown <zach.brown@ni.com>
> >>> ---
> >>>  drivers/mmc/host/sdhci.c | 10 ++++++++++
> >>>  1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> >>> index 1e25b01..59c62d3 100644
> >>> --- a/drivers/mmc/host/sdhci.c
> >>> +++ b/drivers/mmc/host/sdhci.c
> >>> @@ -22,6 +22,7 @@
> >>>  #include <linux/scatterlist.h>
> >>>  #include <linux/regulator/consumer.h>
> >>>  #include <linux/pm_runtime.h>
> >>> +#include <linux/of.h>
> >>>
> >>>  #include <linux/leds.h>
> >>>
> >>> @@ -3013,10 +3014,19 @@ void __sdhci_read_caps(struct sdhci_host *host, u16 *ver, u32 *caps, u32 *caps1)
> >>>
> >>>  	host->caps = caps ? *caps : sdhci_readl(host, SDHCI_CAPABILITIES);
> >>>
> >>> +	if (of_property_read_bool(mmc_dev(host->mmc)->of_node,
> >>> +				  "sdhci-cap-speed-modes-broken"))
> >>
> >> It rather begs the question: if you are going to do something sdhci
> >> specific, why not just read the whole of the caps register from DT?
> >>
> > 
> > Throwing out the whole of the caps register seems like overkill. Also
> 
> What about 2 values: one for the 64-bit caps register and one for a 64-bit
> mask of bits to override.  That way you can select which bits to override
> and what to override them to.
> 

I like this idea. I sent a RFC of it. 

> > there are some things set by the caps that are not available in the DT.
> > For example, SDHCI_CAN_64BIT is set by the cap register and is used in
> > sdhci_setup_host to set host->flags SDHCI_USE_64_BIT_DMA.
> 
> Not sure what you mean.
> 

Your suggestion addresses my concern. So it's not an issue. 
