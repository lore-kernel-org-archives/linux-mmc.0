From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 3/6] mmc: tmio: convert the SDHI MMC driver from MFD to a
 standard platform driver
Date: Sun, 13 Mar 2011 13:14:27 +0900
Message-ID: <AANLkTi=ywRE0omJ1t0yxqzMS4k+PpjfFH7aLtWMW7C=3@mail.gmail.com>
References: <Pine.LNX.4.64.1103110831510.23675@axis700.grange>
	<Pine.LNX.4.64.1103110846000.23675@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1103110846000.23675@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

On Fri, Mar 11, 2011 at 4:52 PM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> On sh-mobile platforms the SDHI driver was using the tmio_mmc SD/SDIO
> MFD cell driver. Now that the tmio_mmc driver has been split into a
> core and a separate MFD glue, we can support SDHI natively without th=
e
> need to emulate an MFD controller. This also allows to support system=
s
> with an on-SoC SDHI controller and a separate MFD with a TMIO core.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---

Nice, I believe this is the right direction..

> --- a/drivers/mmc/host/tmio_mmc.h
> +++ b/drivers/mmc/host/tmio_mmc.h
> @@ -92,7 +92,7 @@ struct tmio_mmc_host {
> =A0 =A0 =A0 =A0struct tasklet_struct =A0 dma_complete;
> =A0 =A0 =A0 =A0struct tasklet_struct =A0 dma_issue;
> =A0 =A0 =A0 =A0struct scatterlist =A0 =A0 =A0bounce_sg;
> -#ifdef CONFIG_TMIO_MMC_DMA
> +#if defined(CONFIG_MMC_SDHI) || defined(CONFIG_MMC_SDHI_MODULE)
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bounce_b=
uf[PAGE_CACHE_SIZE] __attribute__((aligned(TMIO_MAX_ALIGN)));
> =A0#else
> =A0 =A0 =A0 =A0u8 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bounce_b=
uf[1]; =A0/* A dummy in no-DMA case */

=2E.. but it would be nice if all this #ifdeffery could be avoided some=
how.

Is it possible to use devres to allocate the bounce buffer dynamically
in the dma portion of the code?

/ magnus
