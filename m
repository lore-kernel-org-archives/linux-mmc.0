From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_mmc=3A_sd=3A_Export_SD_Status_via_=E2=80=9Cssr=E2=80=9D_?=
        =?UTF-8?Q?device_attribute?=
Date: Mon, 7 Nov 2016 08:45:54 +0100
Message-ID: <CAPDyKFqrCjrHTbSrb4L0aoQ6BfDZP=-cw_JVAuoC6g-Bq1ugdQ@mail.gmail.com>
References: <1471164396-16879-1-git-send-email-uri.yanai@sandisk.com>
 <CAPDyKFoJS-darh9D6mhmcOqw7FSMU3f6RJHYO6Z4vqMUqUQUHg@mail.gmail.com> <CY1PR02MB2089BA24853AFFAB693C6D17E2A50@CY1PR02MB2089.namprd02.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:33649 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750764AbcKGHp5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Nov 2016 02:45:57 -0500
Received: by mail-wm0-f41.google.com with SMTP id c184so25906599wmd.0
        for <linux-mmc@vger.kernel.org>; Sun, 06 Nov 2016 23:45:56 -0800 (PST)
In-Reply-To: <CY1PR02MB2089BA24853AFFAB693C6D17E2A50@CY1PR02MB2089.namprd02.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Uri Yanai <Uri.Yanai@sandisk.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <Alex.Lemberg@sandisk.com>

On 5 November 2016 at 16:14, Uri Yanai <Uri.Yanai@sandisk.com> wrote:
> Hi Ulf
> It seems the patch isn't yet merged to kernel mainline.
> Do you know why ?
>
> Thanks
> Uri

It was in my pull request to Linus for 4.9 and I confirmed it's in
there. Please have a second look.

Kind regards
Uffe

>
> -----Original Message-----
> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
> Sent: Monday, August 22, 2016 4:40 PM
> To: Uri Yanai
> Cc: linux-mmc; Alex Lemberg
> Subject: Re: [PATCH] mmc: sd: Export SD Status via =E2=80=9Cssr=E2=80=9D =
device attribute
>
> On 14 August 2016 at 10:46, Uri Yanai <uri.yanai@sandisk.com> wrote:
>> The SD Status register contains several important fields related to
>> the SD Card proprietary features.
>> Those fields may be used by user space applications for vendor
>> specific usage.
>> None of those fields are exported today by the driver to user space.
>> In this patch, we are reading the SD Status register and exporting
>> (using MMC_DEV_ATTR) the SD Status register to the user space.
>>
>> Signed-off-by: Uri Yanai <uri.yanai@sandisk.com>
>
> Thanks, applied for next!
>
> Kind regards
> Uffe
>
>> ---
>>  drivers/mmc/core/sd.c    | 37 +++++++++++++++++++------------------
>>  include/linux/mmc/card.h |  1 +
>>  2 files changed, 20 insertions(+), 18 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c index
>> b95bd24..694d70d 100644
>> --- a/drivers/mmc/core/sd.c
>> +++ b/drivers/mmc/core/sd.c
>> @@ -223,8 +223,7 @@ static int mmc_decode_scr(struct mmc_card *card)
>> static int mmc_read_ssr(struct mmc_card *card)  {
>>         unsigned int au, es, et, eo;
>> -       int err, i;
>> -       u32 *ssr;
>> +       int i;
>>
>>         if (!(card->csd.cmdclass & CCC_APP_SPEC)) {
>>                 pr_warn("%s: card lacks mandatory SD Status
>> function\n", @@ -232,33 +231,27 @@ static int mmc_read_ssr(struct mmc_ca=
rd *card)
>>                 return 0;
>>         }
>>
>> -       ssr =3D kmalloc(64, GFP_KERNEL);
>> -       if (!ssr)
>> -               return -ENOMEM;
>> -
>> -       err =3D mmc_app_sd_status(card, ssr);
>> -       if (err) {
>> +       if (mmc_app_sd_status(card, card->raw_ssr)) {
>>                 pr_warn("%s: problem reading SD Status register\n",
>>                         mmc_hostname(card->host));
>> -               err =3D 0;
>> -               goto out;
>> +               return 0;
>>         }
>>
>>         for (i =3D 0; i < 16; i++)
>> -               ssr[i] =3D be32_to_cpu(ssr[i]);
>> +               card->raw_ssr[i] =3D be32_to_cpu(card->raw_ssr[i]);
>>
>>         /*
>>          * UNSTUFF_BITS only works with four u32s so we have to offset t=
he
>>          * bitfield positions accordingly.
>>          */
>> -       au =3D UNSTUFF_BITS(ssr, 428 - 384, 4);
>> +       au =3D UNSTUFF_BITS(card->raw_ssr, 428 - 384, 4);
>>         if (au) {
>>                 if (au <=3D 9 || card->scr.sda_spec3) {
>>                         card->ssr.au =3D sd_au_size[au];
>> -                       es =3D UNSTUFF_BITS(ssr, 408 - 384, 16);
>> -                       et =3D UNSTUFF_BITS(ssr, 402 - 384, 6);
>> +                       es =3D UNSTUFF_BITS(card->raw_ssr, 408 - 384, 16=
);
>> +                       et =3D UNSTUFF_BITS(card->raw_ssr, 402 - 384,
>> + 6);
>>                         if (es && et) {
>> -                               eo =3D UNSTUFF_BITS(ssr, 400 - 384, 2);
>> +                               eo =3D UNSTUFF_BITS(card->raw_ssr, 400 -
>> + 384, 2);
>>                                 card->ssr.erase_timeout =3D (et * 1000) =
/ es;
>>                                 card->ssr.erase_offset =3D eo * 1000;
>>                         }
>> @@ -267,9 +260,8 @@ static int mmc_read_ssr(struct mmc_card *card)
>>                                 mmc_hostname(card->host));
>>                 }
>>         }
>> -out:
>> -       kfree(ssr);
>> -       return err;
>> +
>> +       return 0;
>>  }
>>
>>  /*
>> @@ -666,6 +658,14 @@ MMC_DEV_ATTR(cid, "%08x%08x%08x%08x\n",
>> card->raw_cid[0], card->raw_cid[1],  MMC_DEV_ATTR(csd, "%08x%08x%08x%08x=
\n", card->raw_csd[0], card->raw_csd[1],
>>         card->raw_csd[2], card->raw_csd[3]);  MMC_DEV_ATTR(scr,
>> "%08x%08x\n", card->raw_scr[0], card->raw_scr[1]);
>> +MMC_DEV_ATTR(ssr,
>> +       "%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08x%08=
x\n",
>> +               card->raw_ssr[0], card->raw_ssr[1], card->raw_ssr[2],
>> +               card->raw_ssr[3], card->raw_ssr[4], card->raw_ssr[5],
>> +               card->raw_ssr[6], card->raw_ssr[7], card->raw_ssr[8],
>> +               card->raw_ssr[9], card->raw_ssr[10], card->raw_ssr[11],
>> +               card->raw_ssr[12], card->raw_ssr[13], card->raw_ssr[14],
>> +               card->raw_ssr[15]);
>>  MMC_DEV_ATTR(date, "%02d/%04d\n", card->cid.month, card->cid.year);
>> MMC_DEV_ATTR(erase_size, "%u\n", card->erase_size << 9);
>> MMC_DEV_ATTR(preferred_erase_size, "%u\n", card->pref_erase << 9); @@
>> -681,6 +681,7 @@ static struct attribute *sd_std_attrs[] =3D {
>>         &dev_attr_cid.attr,
>>         &dev_attr_csd.attr,
>>         &dev_attr_scr.attr,
>> +       &dev_attr_ssr.attr,
>>         &dev_attr_date.attr,
>>         &dev_attr_erase_size.attr,
>>         &dev_attr_preferred_erase_size.attr,
>> diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h index
>> eb0151b..0968109 100644
>> --- a/include/linux/mmc/card.h
>> +++ b/include/linux/mmc/card.h
>> @@ -290,6 +290,7 @@ struct mmc_card {
>>         u32                     raw_cid[4];     /* raw card CID */
>>         u32                     raw_csd[4];     /* raw card CSD */
>>         u32                     raw_scr[2];     /* raw card SCR */
>> +       u32                     raw_ssr[16];    /* raw card SSR */
>>         struct mmc_cid          cid;            /* card identification *=
/
>>         struct mmc_csd          csd;            /* card specific */
>>         struct mmc_ext_csd      ext_csd;        /* mmc v4 extended card =
specific */
>> --
>> 1.9.1
>>
