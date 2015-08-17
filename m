From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: dw_mmc: fix pio mode when internal dmac is enabled
Date: Mon, 17 Aug 2015 12:16:00 +0200
Message-ID: <CAPDyKFoCt=-PBWc+HPaF7Qe3DjgaiBo+-1GWYFvtZhgEsTPkMw@mail.gmail.com>
References: <3018549.c8iX1Dbrhm@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f169.google.com ([209.85.213.169]:36713 "EHLO
	mail-ig0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbbHQKQB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 17 Aug 2015 06:16:01 -0400
Received: by igxp17 with SMTP id p17so52151694igx.1
        for <linux-mmc@vger.kernel.org>; Mon, 17 Aug 2015 03:16:00 -0700 (PDT)
In-Reply-To: <3018549.c8iX1Dbrhm@diego>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, Jaehoon Chung <jh80.chung@samsung.com>
Cc: Seungwon Jeon <tgih.jun@samsung.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On 3 August 2015 at 17:04, Heiko St=C3=BCbner <heiko@sntech.de> wrote:
> The dw_mci_init_dma() may decide to not use dma, but pio instead, cau=
sed
> by things like wrong dma settings in the system.
>
> Till now the code dw_mci_init_slot() always assumed that dma is avail=
able
> when CONFIG_MMC_DW_IDMAC was defined, ignoring the host->use_dma var
> set during dma init.
>
> So when now the dma init failed for whatever reason, the transfer siz=
es
> would still be set for dma transfers, especially including the maximu=
m
> block-count calculated from host->ring_size and resulting in a
>
> [    4.991109] ------------[ cut here ]------------
> [    4.991111] kernel BUG at drivers/mmc/core/core.c:256!
> [    4.991113] Internal error: Oops - BUG: 0 [#1] SMP ARM
>
> because host->ring_size is 0 in this case and the slot init code uses
> the wrong code to calculate the values.
>
> Fix this by selecting the correct calculations using the host->use_dm=
a
> variable instead of the CONFIG_MMC_DW_IDMAC config option.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> ---
>  drivers/mmc/host/dw_mmc.c | 27 ++++++++++++++-------------
>  1 file changed, 14 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 40e9d8e..9ec3521 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -2391,19 +2391,20 @@ static int dw_mci_init_slot(struct dw_mci *ho=
st, unsigned int id)
>                 mmc->max_seg_size =3D host->pdata->blk_settings->max_=
seg_size;
>         } else {
>                 /* Useful defaults if platform data is unset. */
> -#ifdef CONFIG_MMC_DW_IDMAC
> -               mmc->max_segs =3D host->ring_size;
> -               mmc->max_blk_size =3D 65536;
> -               mmc->max_seg_size =3D 0x1000;
> -               mmc->max_req_size =3D mmc->max_seg_size * host->ring_=
size;
> -               mmc->max_blk_count =3D mmc->max_req_size / 512;
> -#else
> -               mmc->max_segs =3D 64;
> -               mmc->max_blk_size =3D 65536; /* BLKSIZ is 16 bits */
> -               mmc->max_blk_count =3D 512;
> -               mmc->max_req_size =3D mmc->max_blk_size * mmc->max_bl=
k_count;
> -               mmc->max_seg_size =3D mmc->max_req_size;
> -#endif /* CONFIG_MMC_DW_IDMAC */
> +               if (host->use_dma) {
> +                       mmc->max_segs =3D host->ring_size;

I expect this may cause a compiler error since host->ring_size is only
available in the struct dw_mci *host when CONFIG_MMC_DW_IDMAC is set.

I have already pulled in this patch from Jaehoon's pull request.
Perhaps I should only amend the patch and change the host->ring_size
to be always available no matter if CONFIG_MMC_DW_IDMAC is set or not?

> +                       mmc->max_blk_size =3D 65536;
> +                       mmc->max_seg_size =3D 0x1000;
> +                       mmc->max_req_size =3D mmc->max_seg_size * hos=
t->ring_size;
> +                       mmc->max_blk_count =3D mmc->max_req_size / 51=
2;
> +               } else {
> +                       mmc->max_segs =3D 64;
> +                       mmc->max_blk_size =3D 65536; /* BLKSIZ is 16 =
bits */
> +                       mmc->max_blk_count =3D 512;
> +                       mmc->max_req_size =3D mmc->max_blk_size *
> +                                           mmc->max_blk_count;
> +                       mmc->max_seg_size =3D mmc->max_req_size;
> +               }
>         }
>
>         if (dw_mci_get_cd(mmc))
> --
> 2.1.4
>
>

Kind regards
Uffe
