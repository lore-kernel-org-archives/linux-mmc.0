From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [RFC v02 00/15] dmaengine: New 'universal' API for requesting
 channel
Date: Tue, 1 Dec 2015 15:45:32 +0200
Message-ID: <565DA47C.4000308@ti.com>
References: <1448891145-10766-1-git-send-email-peter.ujfalusi@ti.com>
 <CAHp75VcC5uwGTp_N13q5P8MPtkhy0DFytDaXGrnoiHfnoEo8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAHp75VcC5uwGTp_N13q5P8MPtkhy0DFytDaXGrnoiHfnoEo8ng@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Vinod Koul <vinod.koul@intel.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, dmaengine <dmaengine@vger.kernel.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, linux-spi <linux-spi@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 11/30/2015 04:32 PM, Andy Shevchenko wrote:
>> Andy: I did looked at the unified device properties, but I decided t=
o not to use
>> it as I don't see it to fit well and most of the legacy board files =
are using
>> resources to specify at least their memory regions so adding the DMA=
 resource
>> to them would be more inline with the rest of the code.
>=20
> We could return back to this in the future, still we have to amend
> built-in device properties (there is a patch series already in the
> wild).

I believe we could have similar dmaengine 'infra' for the built-in devi=
ce
properties as we have now for DT and ACPI. I need to dig deeper to get =
full
understanding on the device properties, but from a quick view it looks =
to me
that it could replace the direct OF and ACPI property handing in a unif=
ied
API. I might be totally mistaken here ;)

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
>=20
> Does this ".2" and so prevent driver to use auto ID for platform devi=
ces?

Yes, as all the infra around the traditional board files with platform_=
device
creation does. Ideally we could have 'phandle' pointing from this table=
 to the
device in question (or other way around), but I'm not aware of anything=
 we can
use.
Auto ID did not really worked for us since the driver does need to know=
 their
ID in some cases, or we need to be able to be sure that for example McA=
SP1 is
handled as davinci-mcasp.1
We have clocks and other dependencies where the device name or device I=
D need
to be predictable.
It is different in DT cases, but we are talking about legacy things.

--=20
P=C3=A9ter
