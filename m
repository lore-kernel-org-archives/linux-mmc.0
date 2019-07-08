From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] dma-mapping: remove dma_max_pfn
Date: Mon, 8 Jul 2019 13:55:52 +0200
Message-ID: <CAPDyKFr=skv_109JfYQgZrzrEox_CdSmpO_9iU10OC+sGTz1wQ@mail.gmail.com>
References: <20190625092042.19320-1-hch@lst.de> <20190625092042.19320-3-hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190625092042.19320-3-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Christoph Hellwig <hch@lst.de>, Marc Gonzalez <marc.w.gonzalez@free.fr>
Cc: Russell King <linux@armlinux.org.uk>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 25 Jun 2019 at 11:21, Christoph Hellwig <hch@lst.de> wrote:
>
> These days the DMA mapping code must bounce buffer for any not supported
> address, and if they driver needs to optimize for natively supported
> ranged it should use dma_get_required_mask.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied for next, by amending the changelog according to suggestions
from Marc, thanks!

I also decided to consider to the reply from Marc (with the changes
made) as an ack, so added a tag for that.

If there are any objections, from anyone, please tell now.

Kind regards
Uffe


> ---
>  arch/arm/include/asm/dma-mapping.h | 7 -------
>  include/linux/dma-mapping.h        | 7 -------
>  2 files changed, 14 deletions(-)
>
> diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
> index 03ba90ffc0f8..7e0486ad1318 100644
> --- a/arch/arm/include/asm/dma-mapping.h
> +++ b/arch/arm/include/asm/dma-mapping.h
> @@ -89,13 +89,6 @@ static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
>  }
>  #endif
>
> -/* The ARM override for dma_max_pfn() */
> -static inline unsigned long dma_max_pfn(struct device *dev)
> -{
> -       return dma_to_pfn(dev, *dev->dma_mask);
> -}
> -#define dma_max_pfn(dev) dma_max_pfn(dev)
> -
>  /* do not use this function in a driver */
>  static inline bool is_device_dma_coherent(struct device *dev)
>  {
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 6309a721394b..8d13e28a8e07 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -729,13 +729,6 @@ static inline int dma_set_seg_boundary(struct device *dev, unsigned long mask)
>         return -EIO;
>  }
>
> -#ifndef dma_max_pfn
> -static inline unsigned long dma_max_pfn(struct device *dev)
> -{
> -       return (*dev->dma_mask >> PAGE_SHIFT) + dev->dma_pfn_offset;
> -}
> -#endif
> -
>  static inline int dma_get_cache_alignment(void)
>  {
>  #ifdef ARCH_DMA_MINALIGN
> --
> 2.20.1
>
