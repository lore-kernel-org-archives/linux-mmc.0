From: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
Subject: Re: [PATCH v2 03/11] mmc: provide a standard MMC device-tree binding
 parser centrally
Date: Fri, 25 Jan 2013 08:55:54 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301250848560.17518@axis700.grange>
References: <1359095537.25175.32.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1359095537.25175.32.camel-yx3yKKdKkHfc7b1ADBJPm0n48jw8i0AO@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi Joseph

On Fri, 25 Jan 2013, Joseph Lo wrote:

> Hi Guennadi,
> 
> > MMC defines a number of standard DT bindings. Having each driver parse
> > them individually adds code redundancy and is error prone. Provide a
> > standard function to unify the parsing. After all drivers are
> converted
> > to using it instead of their own parsers, this function can be
> integrated
> > into mmc_alloc_host().
> >
> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>
> 
> I saw you introducing the "mmc_of_parse" API here. It looks pretty
> similar to the "sdhci_get_of_property" that under
> "drivers/mmc/host/sdhci-pltfm.c".

Yes, several drivers have their own functions to parse MMC DT bindings, 
whereas, I think, a common helper function can be used to parse generic 
MMC bindings.

> Does this function can be enhanced in
> "sdhci_get_of_property" or replaced it?

The goal is to make all MMC host drivers, running on DT-enabled systems, 
use the new mmc_of_parse() function and, additionally, their own parser 
for any their host-specific properties. As I wrote in the patch commit 
message, if we get all drivers converted to use it, it can be later 
integrated into mmc_alloc_host().

> Or its use for different DT
> property bindings, one is for mmc (you introduced here), the other is
> for sdhci. Just curious, how do I determine which one should I use in
> the sdhci/mmc host driver?

The best would be to (1) convert SDHCI core to use mmc_of_parse(), (2) 
have all SDHCI implementations use that feature either implicitly, having 
SDHCI core call it automatically during its initialisation, or explicitly, 
during their own probing.

> And after this one "[PATCH/RFC] mmc: add DT bindings for more MMC
> capability flags", some of the properties parsing were overlap and some
> were not. If the host driver uses the standard property but it was being
> separated to these two different of_parse function, I need to call both
> of them. Sorry, I am not sure the sdhci and mmc do have different
> specific properties and should separate to two different functions.

As I said, SDHCI (and other host drivers) should be converted to use 
mmc_of_parse() in addition to their own vendor-specific DT property 
parsing.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
