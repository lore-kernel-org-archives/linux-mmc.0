From: Andreas Feuersinger <andreas.feuersinger-hXo6KucIgXUUUhehCU7+QA@public.gmane.org>
Subject: Re: MX27 libertas_sdio SDIO Interrupts vs available bitrate
Date: Mon, 2 Aug 2010 08:40:55 +0200
Message-ID: <20100802084055.096a0059@speedy>
References: <20100729124604.79f88553@speedy>
	<676FD6AA0F002F49B89E70F0C5EFD22C1311499C43@dlee04.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <676FD6AA0F002F49B89E70F0C5EFD22C1311499C43-f/0pxbFS9PCIQmiDNMet8wC/G2K4zDHf@public.gmane.org>
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Gabay, Benzy" <benzyg-l0cyMroinI0@public.gmane.org>
Cc: "libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <libertas-dev-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org


Hi Benzy Gabay,

On Fri, 30 Jul 2010 15:08:06 -0500
"Gabay, Benzy" <benzyg-l0cyMroinI0@public.gmane.org> wrote:
> > I figured, it does not make any difference wheter I use DMA for data
> > transfer or not (odd?)
> If interrupts are not handled in MMC level and you are disabling DMA
> operation how then will the transfer completion is handled in that
> case?
> 

PIO transfer is used in function mxcmci_cmd_done. A while loop cycles
and calls readl until the buffer is read.
Afterwards CRC checks and stuff is done.

Enabling DMA exits prior that code section calling mxc_dma_enable.
--
To unsubscribe from this list: send the line "unsubscribe linux-wireless" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
