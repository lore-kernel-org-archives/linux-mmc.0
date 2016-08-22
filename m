From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mmc=3A_sd=3A_Export_SD_Status_via_=E2=80=9Cssr=E2=80=9D_?=
        =?UTF-8?Q?device_attribute?=
Date: Mon, 22 Aug 2016 15:39:49 +0200
Message-ID: <CAPDyKFoJS-darh9D6mhmcOqw7FSMU3f6RJHYO6Z4vqMUqUQUHg@mail.gmail.com>
References: <1471164396-16879-1-git-send-email-uri.yanai@sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:36978 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755464AbcHVNjw (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Aug 2016 09:39:52 -0400
Received: by mail-wm0-f42.google.com with SMTP id i5so145006896wmg.0
        for <linux-mmc@vger.kernel.org>; Mon, 22 Aug 2016 06:39:51 -0700 (PDT)
In-Reply-To: <1471164396-16879-1-git-send-email-uri.yanai@sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <uri.yanai@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>

On 14 August 2016 at 10:46, Uri Yanai <uri.yanai@sandisk.com> wrote:
> The SD Status register contains several important fields related to the
> SD Card proprietary features.
> Those fields may be used by user space applications for vendor specific
> usage.
> None of those fields are exported today by the driver to user space.
> In this patch, we are reading the SD Status register and exporting
> (using MMC_DEV_ATTR) the SD Status register to the user space.
>
> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c    | 37 +++++++++++++++++++------------------
>  include/linux/mmc/card.h |  1 +
>  2 files changed, 20 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index b95bd24..694d70d 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -223,8 +223,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>  static int mmc_read_ssr(struct mmc_card *card)
>  {
>         unsigned int au, es, et, eo;
> -       int err, i;
> -       u32 *ssr;
> +       int i;
>
>         if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
>                 pr_warn("%s: card lacks mandatory SD Status function\n",
> @@ -232,33 +231,27 @@ static int mmc_read_ssr(struct mmc_card *card)
>                 return 0;
>         }
>
> -       ssr = kmalloc(64, GFP_KERNEL);
> -       if (!ssr)
> -               return -ENOMEM;
> -
> -       err = mmc_app_sd_status(card, ssr);
> -       if (err) {
> +       if (mmc_app_sd_status(card, card->raw_ssr)) {
>                 pr_warn("%s: problem reading SD Status register\n",
>                         mmc_hostname(card->host));
> -               err = 0;
> -               goto out;
> +               return 0;
>         }
>
>         for (i = 0; i < 16; i++)
> -               ssr[i] = be32_to_cpu(ssr[i]);
> +               card->raw_ssr[i] = be32_to_cpu(card->raw_ssr[i]);
>
>         /*
>          * UNSTUFF_BITS only works with four u32s so we have to offset the
>          * bitfield positions accordingly.
>          */
> -       au = UNSTUFF_BITS(ssr, 428 - 384, 4);
> +       au = UNSTUFF_BITS(card->raw_ssr, 428 - 384, 4);
>         if (au) {
>                 if (au <= 9 || card->scr.sda_spec3) {
>                         card->ssr.au = sd_au_size[au];
> -                       es = UNSTUFF_BITS(ssr, 408 - 384, 16);
> -                       et = UNSTUFF_BITS(ssr, 402 - 384, 6);
> +                       es = UNSTUFF_BITS(card->raw_ssr, 408 - 384, 16);
> +                       et = UNSTUFF_BITS(card->raw_ssr, 402 - 384, 6);
>                         if (es && et) {
> -                               eo = UNSTUFF_BITS(ssr, 400 - 384, 2);
> +                               eo = UNSTUFF_BITS(card->raw_ssr, 400 - 384, 2);
>                                 card->ssr.erase_timeout = (et * 1000) / es;
>                                 card->ssr.erase_offset = eo * 1000;
>                         }
> @@ -267,9 +260,8 @@ static int mmc_read_ssr(struct mmc_card *card)
>                                 mmc_hostname(card->host));
>                 }
>         }
> -out:
> -       kfree(ssr);
> -       return err;
> +
> +       return 0;
>  }
>
>  /*
> @@ -666,6 +658,14 @@ MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n", card->raw_cid[0], card->raw_cid[1],
>  MMC_DEV_ATTR(csd, "%08x%08x%08x%08x\n", card->raw_csd[0], card->raw_csd[1],
>         card->raw_csd[2], card->raw_csd[3]);
>  MMC_DEV_ATTR(scr, "%08x%08x\n", card->raw_scr[0], card->raw_scr[1]);
> +MMC_DEV_ATTR(ssr,
> +       "%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x\n",
> +               card->raw_ssr[0], card->raw_ssr[1], card->raw_ssr[2],
> +               card->raw_ssr[3], card->raw_ssr[4], card->raw_ssr[5],
> +               card->raw_ssr[6], card->raw_ssr[7], card->raw_ssr[8],
> +               card->raw_ssr[9], card->raw_ssr[10], card->raw_ssr[11],
> +               card->raw_ssr[12], card->raw_ssr[13], card->raw_ssr[14],
> +               card->raw_ssr[15]);
>  MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
>  MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
>  MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9);
> @@ -681,6 +681,7 @@ static struct attribute *sd_std_attrs[] = {
>         &dev_attr_cid.attr,
>         &dev_attr_csd.attr,
>         &dev_attr_scr.attr,
> +       &dev_attr_ssr.attr,
>         &dev_attr_date.attr,
>         &dev_attr_erase_size.attr,
>         &dev_attr_preferred_erase_size.attr,
> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
> index eb0151b..0968109 100644
> --- a/include/linux/mmc/card.h
> +++ b/include/linux/mmc/card.h
> @@ -290,6 +290,7 @@ struct mmc_card {
>         u32                     raw_cid[4];     /* raw card CID */
>         u32                     raw_csd[4];     /* raw card CSD */
>         u32                     raw_scr[2];     /* raw card SCR */
> +       u32                     raw_ssr[16];    /* raw card SSR */
>         struct mmc_cid          cid;            /* card identification */
>         struct mmc_csd          csd;            /* card specific */
>         struct mmc_ext_csd      ext_csd;        /* mmc v4 extended card specific */
> --
> 1.9.1
>
