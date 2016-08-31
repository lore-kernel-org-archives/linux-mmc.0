From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] mmc: tegra: Mark 64-bit DMA broken on Tegra124
Date: Wed, 31 Aug 2016 21:35:33 +0200
Message-ID: <4919213.objGDYOn8F@wuerfel>
References: <20160831162324.15480-1-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160831162324.15480-1-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday, August 31, 2016 6:23:24 PM CEST Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> According to the TRM, the SD/MMC controller on Tegra124 supports 34-bit
> addressing, but testing shows that this doesn't work. On a device which
> has more than 2 GiB of RAM and LPAE enabled, buffer allocations can use
> addresses above the 32-bit boundary.
> 
> One way to work around this would be to enable IOMMU physical to virtual
> address translations for the SD/MMC controllers, but that's not easy to
> implement without breaking existing use-cases. It's also not obvious why
> 34-bit addressing doesn't work as advertised. In order to fix this for
> existing users, add the SDHCI_QUIRK2_BROKEN_64_BIT_DMA quirk for now.
> 
> Reported-by: Paul Kocialkowski <contact-W9ppeneeCTY@public.gmane.org>
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---

Acked-by: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>

I also tried to find the code that handles bounce buffers for the attached
devices in the absence of SWIOTLB (which ARM does not use). The mmc block
driver handles this correctly with the blk_queue_bounce_limit() call,
and any SDIO network devices will work as long as they

a) don't advertize NETIF_F_HIGHDMA, and
b) all memory that is out of reach of the SDHCI device is also
   beyond the highmem boundary (this might not be true with
   CONFIG_VMSPLIT_1G)

All other SDIO devices (camera, DVB, bluetooth) might need driver
changes or SWIOTLB support here, but those devices are fairly rare,
and it's possible that all upstream drivers are actually ok.

	Arnd
