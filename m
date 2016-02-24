From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH] mmc: sdhci-tegra: Set DMA mask
Date: Wed, 24 Feb 2016 13:37:30 +0100
Message-ID: <2393024.oLdk3CGNWo@wuerfel>
References: <1456305079-27779-1-git-send-email-acourbot@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456305079-27779-1-git-send-email-acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Wednesday 24 February 2016 18:11:19 Alexandre Courbot wrote:
> On T210, the sdhci controller can address more than 32 bits of address
> space. Failing to express this fact results in the use of bounce
> buffers and affects performance.
> 
> Signed-off-by: Alexandre Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> I am pretty sure this one is wrong in some way, but just to get the ball
> rolling as the use of bounce buffers is currently quite heavy on Jetson TX1.
> 
> Thierry, Stephen, could you confirm that I got the DMA masks correctly? I
> am not sure about the actual addressable size on TX1, and also suspect TK1 can
> also address more than 32 bits.
> 
> Also, I noticed that sdhci_host has a dma_mask member which I thought would do
> the trick but actually doesn't seem to be used for anything useful. Could the
> MMC maintainers comment on this and let me know if the DMA mask setting should
> be moved at the core level instead of being done per-driver?

So the question is what the DMA capabilities of the sdhci device are.

Usually I think SDHCI should just support a 64-bit mask, and you can
request that in the driver, but the platform might reject it, e.g.
if the parent bus is lacking a dma-ranges property.

On 32-bit platforms with no RAM above the 4GB boundary, setting a 64-bit
mask typically succeeds, because there is no harm in using it.

You should only set a 34-bit mask in the specific case that:

* SDHCI reports that it supports 64-bit addressing
* The parent bus supports 64-bit addressing and correctly sets up
  its dma-ranges property
* The device is connected incorrectly to the parent bus and
  any access above 0x400000000ull fail to end up in the correct
  memory for this particular device, but not other devices on the
  same bus.

	Arnd
