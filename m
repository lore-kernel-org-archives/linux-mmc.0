From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting channel
Date: Tue, 01 Dec 2015 11:15:38 +0100
Message-ID: <2237139.FINhECNDsD@wuerfel>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com> <13562653.8QgTG33tZS@wuerfel> <565D729F.2000104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <565D729F.2000104-l0cyMroinI0@public.gmane.org>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On Tuesday 01 December 2015 12:12:47 Peter Ujfalusi wrote:
> 
> We would need:
>         { "da830-mmc.0", "rx", (void*)EDMA_CTLR_CHAN(0, 16) },
>         { "da830-mmc.0", "tx", (void*)EDMA_CTLR_CHAN(0, 17) },
> 
> as we need to cast the param.
> It is still compact, but having to add the (void*) casting makes it a bit ugly.

Right, I forgot that, but the cast could also be part of EDMA_CTLR_CHAN(),
and with the version I just posted in my other reply that part is solved
as well.

	Arnd
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
