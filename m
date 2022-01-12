Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361AAC433FE
	for <linux-mmc@archiver.kernel.org>; Wed, 12 Jan 2022 10:59:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352674AbiALK7J (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 12 Jan 2022 05:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352659AbiALK7F (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Jan 2022 05:59:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F55FC061756
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jan 2022 02:59:05 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id k21so6904628lfu.0
        for <linux-mmc@vger.kernel.org>; Wed, 12 Jan 2022 02:59:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Ta6ODObyOiMhXWrgcht8G/JgiWdlBGIHtYr4lKWAQ9M=;
        b=BLbAZQtKGtqF+zy96gp5LzRCqsWIItalMJ4kGRbehJDSbZ/Eul10rVy6sdNIbszotc
         6rznJ2SnDpQNHquNAxSaKzZqZcQiOIVhwQ8N7jTltty2b/er1+MYVBff0z7fCls6xwoA
         5QzwnycdmWr+7RSxV8w+uGRyXLcjMjozd0x28dBmu2VSrgKcJ8hCZNn1rMZFXYdHA0XC
         A5VxQpibApIhGypxA+lNF8QmOsIcNLbB9GdMvvXtiI7txzldUM8qHkium288a+6h/4l2
         XvNZq3N1dX0sgdt+YO5pOXvBKn950aiATul2/kKt7N+unYai8B4J+U27tLDUtt9kGDrs
         5wDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Ta6ODObyOiMhXWrgcht8G/JgiWdlBGIHtYr4lKWAQ9M=;
        b=iBIHWu1VfsOgOtw7Wvkc5ojbrM6Fc3AIinhVtQQvlPaEcht5/T5olF68qiXNv+kJX9
         y56pLNiKmZciWfGzNAZgZIHlpfaV0GYpJp+9vNQXXoh6D9eW/wggqnksc0jTSFJjjLYP
         ssZXEBYndfRsOD/mOwQyI58tj1iUH6hYKewbB+nX5rkmmbayD8unJp+NyoZAjSuKp4Oc
         WdYOWv2tMTT1Jka8vUaYLxLC9WodjRuE1PdTT0czUu3VB3WmUvMNokkCln+CTCoyPh1E
         WXmnmFCrZQFaYnMjo4YPI9R1YcThxEQiUBTwGg2B4J/+uxPdtGoK6KG3DD620L9D3bi5
         k38g==
X-Gm-Message-State: AOAM532Gid2AIr7m1Jkb7X3d5PtS26hk5yyj95XjI8+kWtF6womtC1Es
        ki7v0vFkOsRG8kDQl9VuFoHGYtaR9OKT0k18VuMQTw==
X-Google-Smtp-Source: ABdhPJzJQLmVykeupfj37OdIu6CZc7g37pbh2/7aAyQvEwm26I/yvAuuq8tLAsPvTPdp41l0BuOYixdrz6aPkyrD8i4=
X-Received: by 2002:a05:6512:3da7:: with SMTP id k39mr3455971lfv.184.1641985143527;
 Wed, 12 Jan 2022 02:59:03 -0800 (PST)
MIME-Version: 1.0
References: <20220111171424.862764-1-Jerome.Pouiller@silabs.com> <20220111171424.862764-2-Jerome.Pouiller@silabs.com>
In-Reply-To: <20220111171424.862764-2-Jerome.Pouiller@silabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 12 Jan 2022 11:58:27 +0100
Message-ID: <CAPDyKFreu2S3Okc9pXckDjUQ2ieb-urSM0riysFnEHRhEqXBKg@mail.gmail.com>
Subject: Re: [PATCH v9 01/24] mmc: sdio: add SDIO IDs for Silabs WF200 chip
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-mmc@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 11 Jan 2022 at 18:14, Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
>
> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> Note that the values used by Silabs are uncommon. A driver cannot fully
> rely on the SDIO PnP. It should also check if the device is declared in
> the DT.
>
> So, to apply the quirks necessary for the Silabs WF200, we rely on the
> DT rather than on the SDIO VID/PID.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

I guess the series is getting close to getting queued up?

As an option to make sure $subject patch doesn't cause a problem for
that, I can queue it up and send it for the 5.17-rcs or if Kalle
prefer to carry this in this tree with my ack?

Kalle?

Kind regards
Uffe

> ---
>  drivers/mmc/core/quirks.h    | 5 +++++
>  include/linux/mmc/sdio_ids.h | 7 +++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
> index 20f568727277..f879dc63d936 100644
> --- a/drivers/mmc/core/quirks.h
> +++ b/drivers/mmc/core/quirks.h
> @@ -149,6 +149,11 @@ static const struct mmc_fixup __maybe_unused sdio_fi=
xup_methods[] =3D {
>  static const struct mmc_fixup __maybe_unused sdio_card_init_methods[] =
=3D {
>         SDIO_FIXUP_COMPATIBLE("ti,wl1251", wl1251_quirk, 0),
>
> +       SDIO_FIXUP_COMPATIBLE("silabs,wf200", add_quirk,
> +                             MMC_QUIRK_BROKEN_BYTE_MODE_512 |
> +                             MMC_QUIRK_LENIENT_FN0 |
> +                             MMC_QUIRK_BLKSZ_FOR_BYTE_MODE),
> +
>         END_FIXUP
>  };
>
> diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
> index a85c9f0bd470..483692f3002a 100644
> --- a/include/linux/mmc/sdio_ids.h
> +++ b/include/linux/mmc/sdio_ids.h
> @@ -25,6 +25,13 @@
>   * Vendors and devices.  Sort key: vendor first, device next.
>   */
>
> +/*
> + * Silabs does not use a reliable vendor ID. To avoid conflicts, the dri=
ver
> + * won't probe the device if it is not also declared in the DT.
> + */
> +#define SDIO_VENDOR_ID_SILABS                  0x0000
> +#define SDIO_DEVICE_ID_SILABS_WF200            0x1000
> +
>  #define SDIO_VENDOR_ID_STE                     0x0020
>  #define SDIO_DEVICE_ID_STE_CW1200              0x2280
>
> --
> 2.34.1
>
