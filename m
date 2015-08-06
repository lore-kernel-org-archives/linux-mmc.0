From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH] mmc: dw_mmc: fix pio mode when internal dmac is enabled
Date: Thu, 06 Aug 2015 10:48:45 +0900
Message-ID: <55C2BCFD.8020905@samsung.com>
References: <3018549.c8iX1Dbrhm@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout4.samsung.com ([203.254.224.34]:41800 "EHLO
	mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbHFBsr (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 5 Aug 2015 21:48:47 -0400
In-reply-to: <3018549.c8iX1Dbrhm@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?windows-1252?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Seungwon Jeon <tgih.jun@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org

Hi, Heiko.

Applied this patch at my dw-mmc tree.
I will request pull on this weekend.
Thanks a lot!

Best Regards,
Jaehoon Chung

On 08/04/2015 12:04 AM, Heiko St=FCbner wrote:
> The dw_mci_init_dma() may decide to not use dma, but pio instead, cau=
sed
> by things like wrong dma settings in the system.
>=20
> Till now the code dw_mci_init_slot() always assumed that dma is avail=
able
> when CONFIG_MMC_DW_IDMAC was defined, ignoring the host->use_dma var
> set during dma init.
>=20
> So when now the dma init failed for whatever reason, the transfer siz=
es
> would still be set for dma transfers, especially including the maximu=
m
> block-count calculated from host->ring_size and resulting in a
>=20
> [    4.991109] ------------[ cut here ]------------
> [    4.991111] kernel BUG at drivers/mmc/core/core.c:256!
> [    4.991113] Internal error: Oops - BUG: 0 [#1] SMP ARM
>=20
> because host->ring_size is 0 in this case and the slot init code uses
> the wrong code to calculate the values.
>=20
> Fix this by selecting the correct calculations using the host->use_dm=
a
> variable instead of the CONFIG_MMC_DW_IDMAC config option.
>=20
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/host/dw_mmc.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 40e9d8e..9ec3521 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2391,19 +2391,20 @@ static int dw_mci_init_slot(struct dw_mci *ho=
st, unsigned int id)
>  		mmc->max_seg_size =3D host->pdata->blk_settings->max_seg_size;
>  	} else {
>  		/* Useful defaults if platform data is unset. */
> -#ifdef CONFIG_MMC_DW_IDMAC
> -		mmc->max_segs =3D host->ring_size;
> -		mmc->max_blk_size =3D 65536;
> -		mmc->max_seg_size =3D 0x1000;
> -		mmc->max_req_size =3D mmc->max_seg_size * host->ring_size;
> -		mmc->max_blk_count =3D mmc->max_req_size / 512;
> -#else
> -		mmc->max_segs =3D 64;
> -		mmc->max_blk_size =3D 65536; /* BLKSIZ is 16 bits */
> -		mmc->max_blk_count =3D 512;
> -		mmc->max_req_size =3D mmc->max_blk_size * mmc->max_blk_count;
> -		mmc->max_seg_size =3D mmc->max_req_size;
> -#endif /* CONFIG_MMC_DW_IDMAC */
> +		if (host->use_dma) {
> +			mmc->max_segs =3D host->ring_size;
> +			mmc->max_blk_size =3D 65536;
> +			mmc->max_seg_size =3D 0x1000;
> +			mmc->max_req_size =3D mmc->max_seg_size * host->ring_size;
> +			mmc->max_blk_count =3D mmc->max_req_size / 512;
> +		} else {
> +			mmc->max_segs =3D 64;
> +			mmc->max_blk_size =3D 65536; /* BLKSIZ is 16 bits */
> +			mmc->max_blk_count =3D 512;
> +			mmc->max_req_size =3D mmc->max_blk_size *
> +					    mmc->max_blk_count;
> +			mmc->max_seg_size =3D mmc->max_req_size;
> +		}
>  	}
> =20
>  	if (dw_mci_get_cd(mmc))
>=20

