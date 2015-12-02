From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
Date: Wed, 2 Dec 2015 12:51:43 +0200
Message-ID: <565ECD3F.3070500@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <CAHp75VcC5uwGTp_N13q5P8MPtkhy0DFytDaXGrnoiHfnoEo8ng@mail.gmail.com>
 <565DA47C.4000308@ti.com> <103520159.g0xhtFsXUi@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:56332 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbbLBKwQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Dec 2015 05:52:16 -0500
In-Reply-To: <103520159.g0xhtFsXUi@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Vinod Koul <vinod.koul@intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-spi <linux-spi@vger.kernel.org>

On 12/01/2015 04:24 PM, Arnd Bergmann wrote:
> On Tuesday 01 December 2015 15:45:32 Peter Ujfalusi wrote:
>>>> static struct dma_filter_map da830_edma_map[] =3D {
>>>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "rx", EDMA_CTLR_CHAN(0=
, 0)),
>>>>         DMA_FILTER_ENTRY("davinci-mcasp.0", "tx", EDMA_CTLR_CHAN(0=
, 1)),
>>>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "rx", EDMA_CTLR_CHAN(0=
, 2)),
>>>>         DMA_FILTER_ENTRY("davinci-mcasp.1", "tx", EDMA_CTLR_CHAN(0=
, 3)),
>>>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "rx", EDMA_CTLR_CHAN(0=
, 4)),
>>>>         DMA_FILTER_ENTRY("davinci-mcasp.2", "tx", EDMA_CTLR_CHAN(0=
, 5)),
>>>>         DMA_FILTER_ENTRY("spi_davinci.0", "rx", EDMA_CTLR_CHAN(0, =
14)),
>>>>         DMA_FILTER_ENTRY("spi_davinci.0", "tx", EDMA_CTLR_CHAN(0, =
15)),
>>>>         DMA_FILTER_ENTRY("da830-mmc.0", "rx", EDMA_CTLR_CHAN(0, 16=
)),
>>>>         DMA_FILTER_ENTRY("da830-mmc.0", "tx", EDMA_CTLR_CHAN(0, 17=
)),
>>>>         DMA_FILTER_ENTRY("spi_davinci.1", "rx", EDMA_CTLR_CHAN(0, =
18)),
>>>>         DMA_FILTER_ENTRY("spi_davinci.1", "tx", EDMA_CTLR_CHAN(0, =
19)),
>>>
>>> Does this ".2" and so prevent driver to use auto ID for platform de=
vices?
>>
>> Yes, as all the infra around the traditional board files with platfo=
rm_device
>> creation does. Ideally we could have 'phandle' pointing from this ta=
ble to the
>> device in question (or other way around), but I'm not aware of anyth=
ing we can
>> use.
>=20
> I was thinking that we could use a pointer to the device structure, b=
ut
> if you have that, you can also just read the name from it.

Hrm to have pdev pointer instead of the devname string? In the core we =
could
get the pdev from the caller's device with to_platform_device(dev) and =
simply
compare the pointers...

One of the issue I see (in mach-davinci and mach-omap1/2) is that the p=
devs
are scattered around in the c files so gathering the pointers to a plac=
e where
we can see them to be able to use it in the dma_filter_map is not going=
 to be
light weight task.
=46urthermore we have the omap_hwmod for OMAP2+ which creates the actua=
l pdevs
and resources from the omap_hwmod data structures so getting out the DM=
A event
numbers there is not going to be easy either...

I'll hold back the RFC v3 to see if we should switch to pdev pointer or=
 stay
with the devname strings here.

--=20
P=E9ter
