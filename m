From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/6] mmc: tmio: split core functionality, DMA and MFD glue
Date: Sun, 13 Mar 2011 12:57:36 +0900
Message-ID: <AANLkTi=YAcSOBUyWa-OpD0fL-nr-_i=On8ssN0TXZTqJ@mail.gmail.com>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
	<Pine.LNX.4.64.1103110844080.23675@axis700.grange>
	<AANLkTinQB2NB---0o65Uy-axApw9DwPZoMeMBc=qmvSC@mail.gmail.com>
	<Pine.LNX.4.64.1103122347270.28741@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103122347270.28741@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Sun, Mar 13, 2011 at 7:48 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On Sun, 13 Mar 2011, Magnus Damm wrote:
>
>> On Fri, Mar 11, 2011 at 4:51 PM, Guennadi Liakhovetski
>> <g.liakhovetski@gmx.de> wrote:
>> > TMIO MMC chips contain an SD / SDIO IP core from Panasonic, simila=
r to
>> > the one, used in MN5774 and other MN57xx controllers. These IP cor=
es are
>> > included in many multifunction devices, in sh-mobile chips from Re=
nesas,
>> > in the latter case they can also use DMA. Some sh-mobile implement=
ations
>> > also have some other specialities, that MFD-based solutions don't =
have.
>> > This makes supporting all these features in a monolithic driver in=
conveniet
>> > and error-prone. This patch splits the driver into 3 parts: the co=
re,
>> > the MFD glue and the DMA support. In case of a modular build, two =
modules
>> > will be built: mmc_tmio_core and mmc_tmio.
>> >
>> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
>> > ---
>>
>> Thanks for your work on this, I'm happy to see these patches because
>> they make it easier for me to add multi-interrupt source to the SDHI
>> portion - something that is needed for sh73a0.
>>
>> > =A0drivers/mmc/host/Kconfig =A0 =A0 =A0 =A0| =A0 =A04 +
>> > =A0drivers/mmc/host/Makefile =A0 =A0 =A0 | =A0 =A03 +
>> > =A0drivers/mmc/host/tmio_mmc.c =A0 =A0 | 1303 +-------------------=
-------------------
>> > =A0drivers/mmc/host/tmio_mmc.h =A0 =A0 | =A0152 +++++
>> > =A0drivers/mmc/host/tmio_mmc_dma.c | =A0302 +++++++++
>> > =A0drivers/mmc/host/tmio_mmc_pio.c | =A0923 ++++++++++++++++++++++=
+++++
>> > =A06 files changed, 1402 insertions(+), 1285 deletions(-)
>> > =A0create mode 100644 drivers/mmc/host/tmio_mmc.h
>> > =A0create mode 100644 drivers/mmc/host/tmio_mmc_dma.c
>> > =A0create mode 100644 drivers/mmc/host/tmio_mmc_pio.c
>>
>> Something is wrong with this patch. The Makefile adds tmio_mmc_core.=
c
>> but it's not part of the diffstat above. Perhaps you're posting an
>> older version of the patch?
>
> No, the Makefile is adding tmio_mmc_core.o:
>
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index 30aa686..79c42dd 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -29,6 +29,9 @@ endif
> =A0obj-$(CONFIG_MMC_S3C) =A0 =A0 =A0 =A0 =A0+=3D s3cmci.o
> =A0obj-$(CONFIG_MMC_SDRICOH_CS) =A0 +=3D sdricoh_cs.o
> =A0obj-$(CONFIG_MMC_TMIO) =A0 =A0 =A0 =A0 +=3D tmio_mmc.o
> +obj-$(CONFIG_MMC_TMIO_CORE) =A0 =A0+=3D tmio_mmc_core.o
> +tmio_mmc_core-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0:=3D =
tmio_mmc_pio.o
> +tmio_mmc_core-$(CONFIG_TMIO_MMC_DMA) =A0 +=3D tmio_mmc_dma.o
> =A0obj-$(CONFIG_MMC_CB710) =A0 =A0 =A0 =A0+=3D cb710-mmc.o
> =A0obj-$(CONFIG_MMC_VIA_SDMMC) =A0 =A0+=3D via-sdmmc.o
> =A0obj-$(CONFIG_SDH_BFIN) =A0 =A0 =A0 =A0 +=3D bfin_sdh.o
>
> which is linked from two source files. Looks correct to me.

Ok, sorry, my mistake.

What's the reason behind creating tmio_mmc_core.o instead of simply
having tmio_mmc_pio.o + tmio_mmc_dma.o? That must be the most
straightforward solution, no?

Thanks,

/ magnus
