From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH 4/8] MMC: add DMA support to tmio_mmc driver, when used on
	SuperH
Date: Wed, 21 Apr 2010 20:12:52 -0400
Message-ID: <n2saec7e5c31004211712t9441f0r50950ec918bea2e3@mail.gmail.com>
References: <Pine.LNX.4.64.1004211715050.5292@axis700.grange>
	 <Pine.LNX.4.64.1004211733400.5292@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.1004211733400.5292@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, linux-mmc@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>, Ian Molton <ian@mnementh.co.uk>
List-Id: linux-mmc@vger.kernel.org

Hi Guennadi,

On Wed, Apr 21, 2010 at 11:37 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> SDHI controllers on SuperH, served by the tmio_mmc driver, can use sl=
ave DMA
> for data transfer. This patch adds support for the dmaengine API to t=
mio_mmc
> and the necessary interfacing to the sh_mobile_sdhi MFD driver.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
>
> It could be further broken down into MMC and MFD parts if required, I
> think.
>
> =A0drivers/mfd/sh_mobile_sdhi.c =A0 =A0 =A0 | =A0 25 +++-
> =A0drivers/mmc/host/tmio_mmc.c =A0 =A0 =A0 =A0| =A0346 ++++++++++++++=
++++++++++++++++++----
> =A0drivers/mmc/host/tmio_mmc.h =A0 =A0 =A0 =A0| =A0 11 ++
> =A0include/linux/mfd/sh_mobile_sdhi.h | =A0 =A03 +
> =A0include/linux/mfd/tmio.h =A0 =A0 =A0 =A0 =A0 | =A0 10 +
> =A05 files changed, 359 insertions(+), 36 deletions(-)

[snip]

> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.=
c
> index b2b577f..fafd8c9 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -29,12 +29,21 @@
> =A0#include <linux/irq.h>
> =A0#include <linux/device.h>
> =A0#include <linux/delay.h>
> +#include <linux/dmaengine.h>
> =A0#include <linux/mmc/host.h>
> =A0#include <linux/mfd/core.h>
> =A0#include <linux/mfd/tmio.h>
>
> =A0#include "tmio_mmc.h"
>
> +static void tmio_mmc_enable_dma(struct tmio_mmc_host *host, bool ena=
ble)
> +{
> +#if defined(CONFIG_SUPERH) || defined(CONFIG_ARCH_SHMOBILE)
> + =A0 =A0 =A0 /* Switch DMA mode on or off - SuperH specific? */
> + =A0 =A0 =A0 sd_ctrl_write16(host, 0xd8, enable ? 2 : 0);
> +#endif
> +}
> +

Uhh.. #ifdefs. =3D)

Can't this register setting be implented in the SDHI driver?

In general I realize that you need to extend the logic in the tmio_mmc
driver quite a bit to implement DMA support, but I wonder if it is
possible to extend the tmio_mmc driver with callbacks and use them to
hook in the DMA code?

Thanks!

/ magnus
