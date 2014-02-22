From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/2] mmc: mxcmmc: Convert to devm-* API
Date: Sat, 22 Feb 2014 16:37:53 +0100
Message-ID: <2376908.tRC2oWmiYE@wuerfel>
References: <1393080372-6760-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.187]:64451 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751142AbaBVPiA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 22 Feb 2014 10:38:00 -0500
In-Reply-To: <1393080372-6760-1-git-send-email-shc_work@mail.ru>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: linux-mmc@vger.kernel.org, Chris Ball <chris@printf.net>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <kernel@pengutronix.de>

On Saturday 22 February 2014 18:46:11 Alexander Shiyan wrote:
> Replace existing resource handling in the driver with managed
> device resource, this ensures more consistent error values and
> simplifies error paths.
> 
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

Nice cleanup!

>  drivers/mmc/host/mxcmmc.c | 101 +++++++++++++++++-----------------------------
>  1 file changed, 38 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/mmc/host/mxcmmc.c b/drivers/mmc/host/mxcmmc.c
> index f7199c8..84d630e 100644
> --- a/drivers/mmc/host/mxcmmc.c
> +++ b/drivers/mmc/host/mxcmmc.c
> @@ -124,9 +124,8 @@ enum mxcmci_type {
>  
>  struct mxcmci_host {
>         struct mmc_host         *mmc;
> -       struct resource         *res;
>         void __iomem            *base;
> -       int                     irq;
> +       dma_addr_t              phys_base;
>         int                     detect_irq;
>         struct dma_chan         *dma;
>         struct dma_async_tx_descriptor *desc;

Just nitpicking, but I think phys_base should be either phys_addr_t or
resource_size_t. dma_addr_t is what you get out of the dma-mapping API,
not what you use for ioremap. In theory they may be different, but I
don't know how we'd handle that case for the dmaengine API, since we
don't currently have a way to convert between the two, other than for
doing DMA on memory pages.

	Arnd
