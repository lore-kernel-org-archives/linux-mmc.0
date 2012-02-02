From: Namjae Jeon <linkinjeon@gmail.com>
Subject: Re: [PATCH V2] mmc: core: Detect card removal on I/O error
Date: Thu, 2 Feb 2012 09:34:28 +0900
Message-ID: <CAKYAXd9KtQe3HWg1M3B4CPFzJiuC-Vwpx3wOgG4_zMUA7V=6GA@mail.gmail.com>
References: <1328104100-1880-1-git-send-email-ulf.hansson@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:60049 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635Ab2BBAea convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Feb 2012 19:34:30 -0500
Received: by bkcjm19 with SMTP id jm19so1559626bkc.19
        for <linux-mmc@vger.kernel.org>; Wed, 01 Feb 2012 16:34:29 -0800 (PST)
In-Reply-To: <1328104100-1880-1-git-send-email-ulf.hansson@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@stericsson.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Adrian Hunter <adrian.hunter@intel.com>, Per Forlin <per.forlin@stericsson.com>, Johan Rudholm <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

2012/2/1 Ulf Hansson <ulf.hansson@stericsson.com>:
> To prevent I/O as soon as possible at card removal, a new
> detect work is re-scheduled without a delay to let a rescan
> remove the card device as soon a possible.
>
> Additionally, MMC_CAP2_DETECT_ON_ERR can now be used to handle
> "slowly" removed cards that a scheduled detect work did not
> detect as removed. To prevent further I/O requests for these
> lingering removed cards, check if card has been removed and then
> schedule a detect work to properly remove it.
>
> Signed-off-by: Ulf Hansson <ulf.hansson@stericsson.com>
> ---
>
> Changes in v2:
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Updated according to review comments.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0- Merging two patches for this feature int=
o one.
>
> ---
> =C2=A0drivers/mmc/core/core.c =C2=A0| =C2=A0 19 +++++++++++++++++--
> =C2=A0include/linux/mmc/host.h | =C2=A0 =C2=A01 +
> =C2=A02 files changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
> index bec0bf2..26d3a66 100644
> --- a/drivers/mmc/core/core.c
> +++ b/drivers/mmc/core/core.c
> @@ -2077,18 +2077,33 @@ int _mmc_detect_card_removed(struct mmc_host =
*host)
> =C2=A0int mmc_detect_card_removed(struct mmc_host *host)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct mmc_card *card =3D host->card;
> + =C2=A0 =C2=A0 =C2=A0 int ret;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0WARN_ON(!host->claimed);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/*
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The card will be considered unchanged u=
nless we have been asked to
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 * detect a change or host requires pollin=
g to provide card detection.
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 */
> - =C2=A0 =C2=A0 =C2=A0 if (card && !host->detect_change && !(host->ca=
ps & MMC_CAP_NEEDS_POLL))
> + =C2=A0 =C2=A0 =C2=A0 if (card && !host->detect_change && !(host->ca=
ps & MMC_CAP_NEEDS_POLL)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 && !(host->caps2 & MMC_CAP2_DETE=
CT_ON_ERR))
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return mmc_car=
d_removed(card);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0host->detect_change =3D 0;
>
> - =C2=A0 =C2=A0 =C2=A0 return _mmc_detect_card_removed(host);
> + =C2=A0 =C2=A0 =C2=A0 ret =3D mmc_card_removed(card);
Hi. Ulf.
1. Is there no case that card is null ?
2. and Eventually mmc_card_removed is once called in any case. can we
change it like this ?

if (card)
   ret =3D mmc_card_removed(card);

   if(!host->detect_change && !(host->caps & MMC_CAP_NEEDS_POLL)
           && !(host->caps2 & MMC_CAP2_DETECT_ON_ERR))
                  return ret;

> + =C2=A0 =C2=A0 =C2=A0 if (!ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D _mmc_detec=
t_card_removed(host);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ret) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /*
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* Schedule a detect work as soon as possible to let a
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* rescan handle the card removal.
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0*/
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 cancel_delayed_work(&host->detect);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 mmc_detect_change(host, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return ret;
> =C2=A0}
> =C2=A0EXPORT_SYMBOL(mmc_detect_card_removed);
>
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index dd13e05..368a2b9 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -257,6 +257,7 @@ struct mmc_host {
> =C2=A0#define MMC_CAP2_HS200_1_2V_SDR =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 <=
< 6) =C2=A0 =C2=A0 =C2=A0 =C2=A0/* can support */
> =C2=A0#define MMC_CAP2_HS200 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (MMC_CAP2_HS=
200_1_8V_SDR | \
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 MMC_CAP2_HS200_1_2V_SDR)
> +#define MMC_CAP2_DETECT_ON_ERR (1 << 7) =C2=A0 =C2=A0 =C2=A0 =C2=A0/=
* On I/O err check card removal */
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0mmc_pm_flag_t =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 pm_caps; =C2=A0 =C2=A0 =C2=A0 =C2=A0/* supported pm features */
> =C2=A0 =C2=A0 =C2=A0 =C2=A0unsigned int =C2=A0 =C2=A0 =C2=A0 =C2=A0po=
wer_notify_type;
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.ht=
ml
