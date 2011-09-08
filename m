From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: [PATCH] mmc: core: Fix the incorrect calculation for erase unit size.
Date: Thu, 8 Sep 2011 15:39:34 +0900
Message-ID: <CAH9JG2VomQYWfBbPdxjG2kvrRM8nt8bMm-LC_OYeNLbiBDJcnA@mail.gmail.com>
References: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1315461565-16009-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

Acked-by: Kyungmin Park <kyungmin.park@samsung.com>

On Thu, Sep 8, 2011 at 2:59 PM, Seungwon Jeon <tgih.jun@samsung.com> wr=
ote:
> Erase unit size of high capacity is multiple of 512KiB not 1024KiB.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/core/mmc.c | =A0 =A02 +-
> =A01 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index b148bb1..7991ecf 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -332,7 +332,7 @@ static int mmc_read_ext_csd(struct mmc_card *card=
, u8 *ext_csd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.hc_erase_timeout =3D 300=
 *
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ext_csd[EXT_CSD_ERASE_=
TIMEOUT_MULT];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.hc_erase_size =3D
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_HC_ERAS=
E_GRP_SIZE] << 10;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ext_csd[EXT_CSD_HC_ERAS=
E_GRP_SIZE] << 9;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.rel_sectors =3D ext_csd[=
EXT_CSD_REL_WR_SEC_C];
>
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsu=
ng-soc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
