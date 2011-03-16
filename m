From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 1/6] mmc: tmio: split core functionality, DMA and MFD glue
Date: Wed, 16 Mar 2011 21:37:49 +0900
Message-ID: <AANLkTiksL=M0GOUy4-g7wiA6dj5TdW3atLNJiQ3zgien@mail.gmail.com>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
	<Pine.LNX.4.64.1103110844080.23675@axis700.grange>
	<AANLkTinQB2NB---0o65Uy-axApw9DwPZoMeMBc=qmvSC@mail.gmail.com>
	<Pine.LNX.4.64.1103122347270.28741@axis700.grange>
	<AANLkTi=YAcSOBUyWa-OpD0fL-nr-_i=On8ssN0TXZTqJ@mail.gmail.com>
	<Pine.LNX.4.64.1103132349140.23221@axis700.grange>
	<AANLkTinDSfn-QTNdmU6gGnZ0fY0U-wnpbO3-aTxE3GBz@mail.gmail.com>
	<AANLkTim_-MLJaWtnJN2jJjiXQdChfzi6yNkX8hSy8sgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <AANLkTim_-MLJaWtnJN2jJjiXQdChfzi6yNkX8hSy8sgg@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Ian Molton <ian@mnementh.co.uk>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

>>>> >> On Fri, Mar 11, 2011 at 4:51 PM, Guennadi Liakhovetski
>>>> >> <g.liakhovetski@gmx.de> wrote:
>>>> >> > TMIO MMC chips contain an SD / SDIO IP core from Panasonic, similar to
>>>> >> > the one, used in MN5774 and other MN57xx controllers. These IP cores are
>>>> >> > included in many multifunction devices, in sh-mobile chips from Renesas,
>>>> >> > in the latter case they can also use DMA. Some sh-mobile implementations
>>>> >> > also have some other specialities, that MFD-based solutions don't have.
>>>> >> > This makes supporting all these features in a monolithic driver inconveniet
>>>> >> > and error-prone. This patch splits the driver into 3 parts: the core,
>>>> >> > the MFD glue and the DMA support. In case of a modular build, two modules
>>>> >> > will be built: mmc_tmio_core and mmc_tmio.
>>>> >> >
>>>> >> > Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

On Wed, Mar 16, 2011 at 8:09 PM, Ian Molton <ian@mnementh.co.uk> wrote:
> Im fine with it as long as it doesnt complicate my plan to add PXA DMA
> to the driver.

Hi Ian,

Thanks for your email. I'm glad to hear that you have no objections to
this patch series.

Regarding PXA DMA, without knowing the PXA DMA hardware that well
(never recall using DMA on that platform), from a code reuse point of
view it would be absolutely best to share the DMA Engine interface in
the tmio mmc driver with the SDHI. But I'm not sure if any DMA Engine
driver exists for the PXA though.

Thanks,

/ magnus
