From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC v02 04/15] dmaengine: edma: Add support for DMA filter mapping to slave devices
Date: Mon, 30 Nov 2015 15:11:49 +0100
Message-ID: <7490116.jHcmUxB3Rf@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com> <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1448891145-10766-5-git-send-email-peter.ujfalusi@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: vinod.koul@intel.com, andy.shevchenko@gmail.com, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, nsekhar@ti.com, linux-spi@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Monday 30 November 2015 15:45:34 Peter Ujfalusi wrote:
> @@ -2428,6 +2436,22 @@ bool edma_filter_fn(struct dma_chan *chan, void *param)
>  }
>  EXPORT_SYMBOL(edma_filter_fn);
>  
> +static bool edma_filter_for_map(struct dma_chan *chan, void *param)
> +{
> +       bool match = false;
> +
> +       if (chan->device->dev->driver == &edma_driver.driver) {
> +               struct edma_chan *echan = to_edma_chan(chan);
> +               unsigned ch_req = (unsigned)param;
> +               if (ch_req == echan->ch_num) {
> +                       /* The channel is going to be used as HW synchronized */
> +                       echan->hw_triggered = true;
> +                       match = true;
> +               }
> +       }
> +       return match;
> +}
> +
>  static int edma_init(void)
> 

I don't see the difference between edma_filter_fn and edma_filter_for_map.
Why do you need both?

	Arnd
