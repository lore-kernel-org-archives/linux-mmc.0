From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/6] mmc: tmio: split core functionality, DMA and MFD glue
Date: Tue, 15 Mar 2011 18:01:36 +0900
Message-ID: <AANLkTinDSfn-QTNdmU6gGnZ0fY0U-wnpbO3-aTxE3GBz@mail.gmail.com>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
	<Pine.LNX.4.64.1103110844080.23675@axis700.grange>
	<AANLkTinQB2NB---0o65Uy-axApw9DwPZoMeMBc=qmvSC@mail.gmail.com>
	<Pine.LNX.4.64.1103122347270.28741@axis700.grange>
	<AANLkTi=YAcSOBUyWa-OpD0fL-nr-_i=On8ssN0TXZTqJ@mail.gmail.com>
	<Pine.LNX.4.64.1103132349140.23221@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103132349140.23221@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Mon, Mar 14, 2011 at 7:51 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sun, 13 Mar 2011, Magnus Damm wrote:
>> On Sun, Mar 13, 2011 at 7:48 AM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > On Sun, 13 Mar 2011, Magnus Damm wrote:
>> >> On Fri, Mar 11, 2011 at 4:51 PM, Guennadi Liakhovetski
>> >> <g.liakhovetski@gmx.de> wrote:
>> >> > TMIO MMC chips contain an SD / SDIO IP core from Panasonic, similar to
>> >> > the one, used in MN5774 and other MN57xx controllers. These IP cores are
>> >> > included in many multifunction devices, in sh-mobile chips from Renesas,
>> >> > in the latter case they can also use DMA. Some sh-mobile implementations
>> >> > also have some other specialities, that MFD-based solutions don't have.
>> >> > This makes supporting all these features in a monolithic driver inconveniet
>> >> > and error-prone. This patch splits the driver into 3 parts: the core,
>> >> > the MFD glue and the DMA support. In case of a modular build, two modules
>> >> > will be built: mmc_tmio_core and mmc_tmio.
>> >> >
>> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> >> > ---

>> What's the reason behind creating tmio_mmc_core.o instead of simply
>> having tmio_mmc_pio.o + tmio_mmc_dma.o? That must be the most
>> straightforward solution, no?
>
> You mean two kernel modules ..._pio.ko and ..._dma.ko? but why?... I don't
> see any advantages in such a split, besides, they are calling into each
> other ATM.

Yeah, two kernel modules. That would be the cleanest IMO. But it's not
such a big deal though, if you think this split is the best and
everyone else is happy then I'm fine as well.

Thanks,

/ magnus
