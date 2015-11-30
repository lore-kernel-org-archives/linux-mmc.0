From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC v02 03/15] dmaengine: core: Introduce new, universal API to request a channel
Date: Mon, 30 Nov 2015 15:09:33 +0100
Message-ID: <2436417.uspUkNqtIA@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com> <1448891145-10766-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1448891145-10766-4-git-send-email-peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Monday 30 November 2015 15:45:33 Peter Ujfalusi wrote:
>                                                   const char *name);
>  struct dma_chan *dma_request_slave_channel(struct device *dev, const char *name);
> +
> +struct dma_chan *dma_request_chan(struct device *dev, const char *name);
> +struct dma_chan *dma_request_chan_by_mask(const dma_cap_mask_t *mask);
> +
>  void dma_release_channel(struct dma_chan *chan);
>  int dma_get_slave_caps(struct dma_chan *chan, struct dma_slave_caps *caps);
>  #else
> @@ -1268,6 +1291,14 @@ static inline struct dma_chan *dma_request_slave_channel(struct device *dev,
>  {
>         return NULL;
>  }
> +static inline struct dma_chan *dma_request_chan(struct device *dev)
> +{
> +       return ERR_PTR(-ENODEV);
> +}
> 

The prototypes for dma_request_chan() don't match, otherwise looks good.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
