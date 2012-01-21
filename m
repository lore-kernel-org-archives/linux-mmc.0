From: Srinidhi KASAGAR <srinidhi.kasagar@stericsson.com>
Subject: Re: [PATCH 07/31] ARM: amba: ux500: get rid of NO_IRQ
Date: Sat, 21 Jan 2012 21:49:55 +0530
Message-ID: <20120121161954.GA26323@bnru02>
References: <20120120092207.GD1068@n2100.arm.linux.org.uk>
 <E1RoAiE-0005Eh-7i@rmk-PC.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-omap-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E1RoAiE-0005Eh-7i@rmk-PC.arm.linux.org.uk>
Sender: linux-omap-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org, devicetree-discuss@lists.ozlabs.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-samsung-soc@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@stericsson.com
List-Id: linux-mmc@vger.kernel.org

On Fri, Jan 20, 2012 at 10:24:46 +0100, Russell King - ARM Linux wrote:
> irq 0 now means no irq, so get rid of this unnecessary initializer.
> 
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
>  arch/arm/mach-ux500/devices-common.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/arm/mach-ux500/devices-common.c b/arch/arm/mach-ux500/devices-common.c
> index e8c34fa..898a645 100644
> --- a/arch/arm/mach-ux500/devices-common.c
> +++ b/arch/arm/mach-ux500/devices-common.c
> @@ -34,7 +34,6 @@ dbx500_add_amba_device(const char *name, resource_size_t base,
>  	dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
>  
>  	dev->irq[0] = irq;
> -	dev->irq[1] = NO_IRQ;

Acked-by: srinidhi kasagar <srinidhi.kasagar@stericsson.com> 
