From: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
Date: Tue, 1 Dec 2015 12:12:47 +0200
Message-ID: <565D729F.2000104@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <13562653.8QgTG33tZS@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <13562653.8QgTG33tZS@wuerfel>
Sender: linux-spi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-spi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 11/30/2015 04:18 PM, Arnd Bergmann wrote:
> On Monday 30 November 2015 15:45:30 Peter Ujfalusi wrote:
>> Changes since RFC v01:
>> - dma_request_chan(); lost the mask parameter
>> - The new API does not rely on RESOURCE_DMA, instead the dma_filter_=
map table
>>  will be used to provide the needed information to the filter functi=
on in
>>  legacy mode
>> - Extended the example patches to convert most of daVinci to use the=
 new API to
>>  request the DMA channels.
>=20
> Very nice overall. Just a few minor comments.
>=20
>> static struct dma_filter_map da830_edma_map[] =3D {
>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, =
0)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, =
1)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, =
2)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0, =
3)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0, =
4)),
>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0, =
5)),
>>         DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, 14=
)),
>>         DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, 15=
)),
>>         DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16))=
,
>>         DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17))=
,
>>         DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, 18=
)),
>>         DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, 19=
)),
>> };
>=20
> I wonder if we should mandate that the lookup table is 'const'.

I had been wondering the same, I'll make it const for the next round.

> We could also drop the DMA_FILTER_ENTRY() macro above, and open-code =
the
> table like
>=20
> static struct dma_filter_map da830_edma_map[] =3D {
>          { "davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0, 0)},
>          { "davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0, 1)},
>          { "davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0, 2)},
> 	 ...
> };
>=20
> which is a little more compact and more obvious, but loses the
> named initializers.

We would need:
	{ "da830-mmc.0", "rx", (void*)EDMA_CTLR_CHAN(0, 16) },
	{ "da830-mmc.0", "tx", (void*)EDMA_CTLR_CHAN(0, 17) },

as we need to cast the param.
It is still compact, but having to add the (void*) casting makes it a b=
it ugly.

--=20
P=E9ter
--
To unsubscribe from this list: send the line "unsubscribe linux-spi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
