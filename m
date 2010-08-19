From: =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
Subject: Re: [PATCH] mmc: avoid getting CID on SDIO-only cards
Date: Thu, 19 Aug 2010 14:07:34 +0200
Message-ID: <20100819120734.GA17751@rere.qmqm.pl>
References: <1282152544-21275-1-git-send-email-david.vrabel@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from rere.qmqm.pl ([89.167.52.164]:43989 "EHLO rere.qmqm.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab0HSMRE (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 19 Aug 2010 08:17:04 -0400
Content-Disposition: inline
In-Reply-To: <1282152544-21275-1-git-send-email-david.vrabel@csr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: David Vrabel <david.vrabel@csr.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mmc@vger.kernel.org

On Wed, Aug 18, 2010 at 05:29:04PM +0000, David Vrabel wrote:
> The introduction of support for SD combo cards breaks the initializat=
ion
> of all CSR SDIO chips. The GO_IDLE (CMD0) in mmc_sd_get_cid() causes
> CSR chips to be reset (this is non-standard behavior).
>=20
> When initializing an SDIO card check for a combo card by using the
> memory present bit in the R4 response to IO_SEND_OP_COND (CMD5).  Thi=
s
> avoids the call to mmc_sd_get_cid() on an SDIO-only card.
>=20
> Cc: Micha=B3 Miros=B3aw <mirq-linux@rere.qmqm.pl>
> Signed-off-by: David Vrabel <david.vrabel@csr.com>
> ---
> Andrew, this is a regression in 2.6.36-rc1.  Please queue for 2.6.36 =
if
> Micha=B3 acks it.
> ---
>  drivers/mmc/core/sdio.c  |    8 +++++---
>  include/linux/mmc/sdio.h |    2 ++
>  2 files changed, 7 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index bd2755e..cc34523 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -362,11 +362,13 @@ static int mmc_sdio_init_card(struct mmc_host *=
host, u32 ocr,
>  		goto err;
>  	}
> =20
> -	err =3D mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid);
> -
> -	if (!err) {
> +	if (ocr & R4_MEMORY_PRESENT) {
>  		card->type =3D MMC_TYPE_SD_COMBO;
> =20
> +		err =3D mmc_sd_get_cid(host, host->ocr & ocr, card->raw_cid);
> +		if (err)
> +			goto remove;
> +

In case of memory part init failure, SDIO part will not be initialized =
with your
patch. This, too, is nonstandard, but SDIO might actually work even if =
memory part
is broken.

You can change the condition to:

if ((ocr & R4_MEMORY_PRESENT) && !(err =3D mmc_sd_get_cid(host, host->o=
cr & ocr, card->raw_cid)))

(or something better following kernel coding style).

With that change you have my Acked-by.

>  		if (oldcard && (oldcard->type !=3D MMC_TYPE_SD_COMBO ||
>  		    memcmp(card->raw_cid, oldcard->raw_cid, sizeof(card->raw_cid))=
 !=3D 0)) {
>  			mmc_remove_card(card);
> diff --git a/include/linux/mmc/sdio.h b/include/linux/mmc/sdio.h
> index 329a8fa..245cdac 100644
> --- a/include/linux/mmc/sdio.h
> +++ b/include/linux/mmc/sdio.h
> @@ -38,6 +38,8 @@
>   *      [8:0] Byte/block count
>   */
> =20
> +#define R4_MEMORY_PRESENT (1 << 27)
> +
>  /*
>    SDIO status in R5
>    Type
> --=20
> 1.6.3.3

Best Regards,
Micha=B3 Miros=B3aw
