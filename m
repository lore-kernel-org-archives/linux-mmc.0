Return-Path: <SRS0=ylMS=7J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C384C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 07:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E648F20EDD
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 07:40:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Si4JZhki"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387631AbgE0Hk2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 May 2020 03:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387444AbgE0Hk1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 May 2020 03:40:27 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9AAC061A0F
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2020 00:40:27 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id a68so2406877vsd.8
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2020 00:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kbqsurmeGLoVyf5mF7tu7XoYvXzvCVwzyWVmHlzPe4E=;
        b=Si4JZhkimRq0tm+S0xBFFj9UQR6H01BCBFEX58SlSkt5NhQYq8WpbbQ90ZS7sRbvdt
         UYnqEkjXiB6si4N9NAzLEMhzZyuVY7gvJeAt7d+DjGLHfv1NhV9Upw+h7FjdRkO2Beff
         7p5n177dMKgrOdFHMhvbTEWdJkrGdALSltOsLOhB4HjGcvk7I9jiSFIayoAvpDguYPp0
         NbvXfL0oDukqvn/TZCrF3Nzqs7hr1e25krg9N9OnWi3Ca9Hb3lX3Sq8HzOlYXMQ29u/a
         mLlihKNHaG+an3SMm8nZXq48K/CffY1MuI5fiUcM6atA6uenVJ0qKPiHl5yE/YMfJKq7
         dxjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kbqsurmeGLoVyf5mF7tu7XoYvXzvCVwzyWVmHlzPe4E=;
        b=fVeMu7X4jYgfBMbnJV59dTD1iRfAt+X+Q+jVr0PIuhvuPt09APljXibEW72x5J9h7L
         6N9craMufhWlBwpUXhgbbEGeK/1E4TjcMMzZtHeq1oy0v52VUvqu4KldP8hm+R35JCM9
         +AJopGUyzL9Zy/Q+1MdMetggv/B3vv+rwGT03kiIt15AsgtcD8AOjR4BE24dARPH8kwo
         ESF58SxyIyuRDCLJXQAenCQA6ST8FFlJ+1wFontOMcj7U4JAM7KsZoN8CTt+eHpp7Byz
         +zkxz5O8rKWKC5Ms3l/5d8dSbIuCRzzBGhep/RodOOcxdbIfRmmni14OUvUL9zhrpirD
         /vEg==
X-Gm-Message-State: AOAM532og6hs7vSfehylTaJI9mHXW+Hm+Jmuf5FloZTjEeEBuIsPg+Lp
        aN0rCCUWpahzslLfFaki1bHbvUPe7Pg8Hv4SV7Xn7g==
X-Google-Smtp-Source: ABdhPJyYrXJaC6POxy5xkphIQg0LBSVr4X8J7p+I+CM9XauuFUaPtouHy9vmThZMgRn/CIU3XZZNYGTGnswZvhTDLCY=
X-Received: by 2002:a67:690e:: with SMTP id e14mr3917779vsc.34.1590565226286;
 Wed, 27 May 2020 00:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200526154334.21222-1-pali@kernel.org> <20200526154334.21222-2-pali@kernel.org>
In-Reply-To: <20200526154334.21222-2-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 May 2020 09:39:50 +0200
Message-ID: <CAPDyKFq4KxT+m6nZbi9fM0Pf=JYkT7TTfERDxtUVX5qAiLAQBQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: core: Export device/vendor ids from Common CIS
 for SDIO cards
To:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <marek.behun@nic.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 26 May 2020 at 17:43, Pali Roh=C3=A1r <pali@kernel.org> wrote:
>
> Device/vendor ids from Common CIS (Card Information Structure) may be
> different as device/vendor ids from CIS on particular SDIO function.
>
> Export these "main" device/vendor ids for SDIO and SD combo cards at top
> level mmc device in sysfs so userspace can do better identification of
> connected SDIO and SD combo cards.

What would userspace do with this information, more exactly?

Isn't it just sufficient to give events per SDIO func, as we already
do in sdio_bus_uevent()?

Kind regards
Uffe

>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> ---
>  drivers/mmc/core/bus.c  |  7 +++++++
>  drivers/mmc/core/sd.c   | 26 +++++++++++++++++++++++++-
>  drivers/mmc/core/sdio.c | 20 +++++++++++++++++++-
>  3 files changed, 51 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 103eea7cd..5d4b28b29 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -93,6 +93,13 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent_=
env *env)
>                         return retval;
>         }
>
> +       if (card->type =3D=3D MMC_TYPE_SDIO || card->type =3D=3D MMC_TYPE=
_SD_COMBO) {
> +               retval =3D add_uevent_var(env, "SDIO_ID=3D%04X:%04X",
> +                                       card->cis.vendor, card->cis.devic=
e);
> +               if (retval)
> +                       return retval;
> +       }
> +
>         if (card->type !=3D MMC_TYPE_SDIO) {
>                 retval =3D add_uevent_var(env, "MMC_NAME=3D%s", mmc_card_=
name(card));
>                 if (retval)
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 76c7add36..ee1a51ff6 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -707,7 +707,12 @@ static ssize_t mmc_dsr_show(struct device *dev,
>
>  static DEVICE_ATTR(dsr, S_IRUGO, mmc_dsr_show, NULL);
>
> +MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
> +MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> +
>  static struct attribute *sd_std_attrs[] =3D {
> +       &dev_attr_vendor.attr,
> +       &dev_attr_device.attr,
>         &dev_attr_cid.attr,
>         &dev_attr_csd.attr,
>         &dev_attr_scr.attr,
> @@ -726,7 +731,26 @@ static struct attribute *sd_std_attrs[] =3D {
>         &dev_attr_dsr.attr,
>         NULL,
>  };
> -ATTRIBUTE_GROUPS(sd_std);
> +
> +static umode_t sd_std_is_visible(struct kobject *kobj, struct attribute =
*attr,
> +                                int index)
> +{
> +       struct device *dev =3D container_of(kobj, struct device, kobj);
> +       struct mmc_card *card =3D mmc_dev_to_card(dev);
> +
> +       /* CIS vendor and device ids are available only for Combo cards *=
/
> +       if ((attr =3D=3D &dev_attr_vendor.attr || attr =3D=3D &dev_attr_d=
evice.attr) &&
> +           card->type !=3D MMC_TYPE_SD_COMBO)
> +               return 0;
> +
> +       return attr->mode;
> +}
> +
> +static const struct attribute_group sd_std_group =3D {
> +       .attrs =3D sd_std_attrs,
> +       .is_visible =3D sd_std_is_visible,
> +};
> +__ATTRIBUTE_GROUPS(sd_std);
>
>  struct device_type sd_type =3D {
>         .groups =3D sd_std_groups,
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index ebb387aa5..d708e0fbc 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -27,6 +27,24 @@
>  #include "sdio_ops.h"
>  #include "sdio_cis.h"
>
> +MMC_DEV_ATTR(vendor, "0x%04x\n", card->cis.vendor);
> +MMC_DEV_ATTR(device, "0x%04x\n", card->cis.device);
> +MMC_DEV_ATTR(ocr, "0x%08x\n", card->ocr);
> +MMC_DEV_ATTR(rca, "0x%04x\n", card->rca);
> +
> +static struct attribute *sdio_std_attrs[] =3D {
> +       &dev_attr_vendor.attr,
> +       &dev_attr_device.attr,
> +       &dev_attr_ocr.attr,
> +       &dev_attr_rca.attr,
> +       NULL,
> +};
> +ATTRIBUTE_GROUPS(sdio_std);
> +
> +struct device_type sdio_type =3D {
> +       .groups =3D sdio_std_groups,
> +};
> +
>  static int sdio_read_fbr(struct sdio_func *func)
>  {
>         int ret;
> @@ -598,7 +616,7 @@ static int mmc_sdio_init_card(struct mmc_host *host, =
u32 ocr,
>         /*
>          * Allocate card structure.
>          */
> -       card =3D mmc_alloc_card(host, NULL);
> +       card =3D mmc_alloc_card(host, &sdio_type);
>         if (IS_ERR(card)) {
>                 err =3D PTR_ERR(card);
>                 goto err;
> --
> 2.20.1
>
