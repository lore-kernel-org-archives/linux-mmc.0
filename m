From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v2] ARM: EDMA: Fix clearing of unused list for DT DMA
 resources
Date: Mon, 29 Jul 2013 12:31:45 +0530
Message-ID: <51F61359.1090309@ti.com>
References: <1374515989-7391-1-git-send-email-joelf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:43904 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754633Ab3G2HCK (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 29 Jul 2013 03:02:10 -0400
In-Reply-To: <1374515989-7391-1-git-send-email-joelf@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joel Fernandes <joelf@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, Vinod Koul <vinod.koul@intel.com>, Benoit Cousson <benoit.cousson@linaro.org>, Balaji TK <balajitk@ti.com>, Arnd Bergmann <arnd@arndb.de>, Jason Kridner <jkridner@beagleboard.org>, Mark Jackson <mpfj-list@newflow.co.uk>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Pantel Antoniou <panto@antoniou-consulting.com>

On Monday 22 July 2013 11:29 PM, Joel Fernandes wrote:
> HWMOD removal for MMC is breaking edma_start as the events are being =
manually
> triggered due to unused channel list not being clear, Thanks to Balaj=
i TK for
> finding this issue.

So, Reported-by: Balaji T K <balajitk@ti.com>

?

>=20
> This patch fixes the issue, by reading the "dmas" property from the D=
T node if
> it exists and clearing the bits in the unused channel list.
>=20
> Cc: Balaji T K <balajitk@ti.com>
> Cc: Pantel Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Joel Fernandes <joelf@ti.com>
> ---
> v2 changes: Fixed compiler warning
>=20
>  arch/arm/common/edma.c |   31 +++++++++++++++++++++++--------
>  1 file changed, 23 insertions(+), 8 deletions(-)
>=20
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index a432e6c..765d578 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -561,14 +561,29 @@ static int reserve_contiguous_slots(int ctlr, u=
nsigned int id,
>  static int prepare_unused_channel_list(struct device *dev, void *dat=
a)
>  {
>  	struct platform_device *pdev =3D to_platform_device(dev);
> -	int i, ctlr;
> -
> -	for (i =3D 0; i < pdev->num_resources; i++) {
> -		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
> -				(int)pdev->resource[i].start >=3D 0) {
> -			ctlr =3D EDMA_CTLR(pdev->resource[i].start);
> -			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
> -					edma_cc[ctlr]->edma_unused);
> +	int i =3D 0, ctlr;
> +	u32 dma_chan;
> +	const __be32 *dma_chan_p;
> +	struct property *prop;
> +
> +	if (dev->of_node) {
> +		of_property_for_each_u32(dev->of_node, "dmas", prop, \
> +					 dma_chan_p, dma_chan) {
> +			if (i++ & 1) {
> +				ctlr =3D EDMA_CTLR(dma_chan);
> +				clear_bit(EDMA_CHAN_SLOT(dma_chan),
> +						edma_cc[ctlr]->edma_unused);
> +			}

I think it will be cleaner if you use of_property_count_strings() on
dma-names to get the count of DMA channels for this device and then use
of_parse_phandle_with_args() to get access to the args. Honestly, I hav=
e
not used these APIs myself, so if this doesn=92t work the way I think i=
t
should then let me know and I will try to do some experiments myself.

The current way of skipping over even fields really depends on
#dma-cells for EDMA to be 1. That in itself is not such a bad
assumption, but if you have APIs which already take care of this for
you, why not use them?

> +		}
> +	} else {
> +		for (; i < pdev->num_resources; i++) {
> +			if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
> +			    (int)pdev->resource[i].start >=3D 0) {
> +				ctlr =3D EDMA_CTLR(pdev->resource[i].start);
> +				clear_bit(EDMA_CHAN_SLOT(
> +					  pdev->resource[i].start),
> +					  edma_cc[ctlr]->edma_unused);
> +			}

So there is very little in common between OF and non-OF versions of thi=
s
function. Why not have two different versions of this function for the
two cases? The OF version can reside under the CONFIG_OF conditional
already in use in the file. This will also save you the ugly line break=
s
you had to resort to due to too deep indentation.

Thanks,
Sekhar
