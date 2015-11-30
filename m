From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC v02 01/15] dmaengine: core: Allow NULL mask pointer in __dma_device_satisfies_mask()
Date: Mon, 30 Nov 2015 16:35:31 +0200
Message-ID: <CAHp75VfY=NU4MG7q1w=oYdTiTr0dqtNTQU3UkEaL=tXPJADH5Q@mail.gmail.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
	<1448891145-10766-2-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448891145-10766-2-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dmaengine <dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux OMAP Mailing List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-arm Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, linux-spi <linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Mon, Nov 30, 2015 at 3:45 PM, Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org> wrote:
> Treat as true condition the case when the mask is NULL.

What do you think about setting some default (all "on") mask when mask
is not supplied?

I don't know for sure but there might be cases when you don't want
literally *any* channel to satisfy.

>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
> ---
>  drivers/dma/dmaengine.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
> index daf54a39bcc7..52c3eee48e2e 100644
> --- a/drivers/dma/dmaengine.c
> +++ b/drivers/dma/dmaengine.c
> @@ -184,6 +184,9 @@ __dma_device_satisfies_mask(struct dma_device *device,
>  {
>         dma_cap_mask_t has;
>
> +       if (!want)
> +               return true;
> +
>         bitmap_and(has.bits, want->bits, device->cap_mask.bits,
>                 DMA_TX_TYPE_END);
>         return bitmap_equal(want->bits, has.bits, DMA_TX_TYPE_END);
> --
> 2.6.3
>



-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
