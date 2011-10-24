From: Girish K S <girish.shivananjappa@linaro.org>
Subject: Re: [PATCH] mmc: core: Separate the timeout value for cache-ctrl
Date: Mon, 24 Oct 2011 16:25:01 +0530
Message-ID: <CAGxe1ZG3LBk5uyJjKDRbbv0rFbJQeXYEd04EaKwY9Yfuekg_YA@mail.gmail.com>
References: <001a01cc9235$2f626000$8e272000$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <001a01cc9235$2f626000$8e272000$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, dh.han@samsung.com
List-Id: linux-mmc@vger.kernel.org

On 24 October 2011 15:40, Seungwon Jeon <tgih.jun@samsung.com> wrote:
> Turning the cache off implies flushing cache which doesn't define
> maximum timeout unlike cache-on. This patch will apply the generic
> CMD6 timeout only for cache-on. Additionally the kernel message is
> added for checking failure case of cache-on.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/core/core.c | =A0 22 +++++++++++++---------
> =A0drivers/mmc/core/mmc.c =A0| =A0 10 ++++++++--
> =A02 files changed, 21 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index 5278ffb..65b5643 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2248,6 +2248,7 @@ EXPORT_SYMBOL(mmc_flush_cache);
> =A0int mmc_cache_ctrl(struct mmc_host *host, u8 enable)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_card *card =3D host->card;
> + =A0 =A0 =A0 unsigned int timeout;
> =A0 =A0 =A0 =A0int err =3D 0;
>
> =A0 =A0 =A0 =A0if (!(host->caps2 & MMC_CAP2_CACHE_CTRL) ||
> @@ -2258,16 +2259,19 @@ int mmc_cache_ctrl(struct mmc_host *host, u8 =
enable)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(card->ext_csd.cache_s=
ize > 0)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enable =3D !!enable;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.cache_ctrl ^ enable)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (card->ext_csd.cache_ctrl ^ enable) =
{
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 timeout =3D enable ? ca=
rd->ext_csd.generic_cmd6_time : 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(car=
d, EXT_CSD_CMD_SET_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_CACHE_CTRL, enable, 0);
Here timeout value used is 0. If it has to be 0 then why should you che=
ck
timeout =3D enable ? card->ext_csd.generic_cmd6_time : 0;
I think it should be card->ext_csd.generic_cmd6_time instead of 0
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: cache %s er=
ror %d\n",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(card->host),
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 enable ? "on" : "off",
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 err);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cache_ctr=
l =3D enable;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 EXT_CSD_CACHE_CTRL, enable, timeout);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err(=
"%s: cache %s error %d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostname(card->host),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 enable ? "on" : "off",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 err);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.cache_ctrl =3D enable;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return err;
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index fb5bf01..6354eb3 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1064,14 +1064,20 @@ static int mmc_init_card(struct mmc_host *hos=
t, u32 ocr,
> =A0 =A0 =A0 =A0if ((host->caps2 & MMC_CAP2_CACHE_CTRL) &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0card->ext_csd.cache_si=
ze > 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0err =3D mmc_switch(card, EXT_CSD_CMD_S=
ET_NORMAL,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_CACHE_CTRL, 1, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 EXT_CSD=
_CACHE_CTRL, 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->e=
xt_csd.generic_cmd6_time);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (err && err !=3D -EBADMSG)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto free_card;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Only if no error, cache is turned o=
n successfully.
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cache_ctrl =3D err ? 0 : =
1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("%s: Cache i=
s supported, but enabling failed\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 mmc_hostname(card->host));
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 card->ext_csd.cache_ctr=
l =3D 1;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0if (!oldcard)
> --
> 1.7.0.4
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
