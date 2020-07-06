Return-Path: <SRS0=mNiq=AR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3B6EC433DF
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1FFD2070C
	for <linux-mmc@archiver.kernel.org>; Mon,  6 Jul 2020 14:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PRNfggp4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbgGFOtr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 6 Jul 2020 10:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729424AbgGFOtm (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 6 Jul 2020 10:49:42 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1113C061755
        for <linux-mmc@vger.kernel.org>; Mon,  6 Jul 2020 07:49:41 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id h18so6163609uao.6
        for <linux-mmc@vger.kernel.org>; Mon, 06 Jul 2020 07:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=wpTg6y7XPvuv4TwyqZ4SFhbawANaMUSH8IVFuijkNXA=;
        b=PRNfggp49kSU50tHvcwTjKRkpbm8FZpDizi6CBsO+Zdf6h8sUW3gHJWJfB9kVttebR
         jpbHocobnab1HVKS1w+JarNzomf8jlZDNkl325Yj4QepUHPM2NfxxlOFmTv/uOs9DwLu
         Vy2snofrIDdfN3/I0P5OKaXjGMHKxezmaYzb7kD3PYbcKSVTMJOaBAnzAqfElkKk8I5K
         3v3636g93lmj8z72c9T+Zr2M1DCAAlzfMlmd9rKxYDHRwkr0YXSVIIWnPOedQ24fKdnd
         g+373DjK7GiyA5ClktkLGcYUpSsJiBzjkhFR4qKvyyoJe1Rt1HqCV5hQpvG2u6tn9D6R
         MmbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=wpTg6y7XPvuv4TwyqZ4SFhbawANaMUSH8IVFuijkNXA=;
        b=RyH7lMGS36dPcdaiDOS6HhS3mMw+5x1hYoPeW72Dp6DSNdF/93PR5Y5sGmn+PBbUQw
         XKYl5s1Sp/zGqTZWWgHDE7mP84ujLMKUiDwAuCtshxYdFBF/hHFyVSV2ikDoJ6GpoDZR
         sbuWKA4dJrSdiOkQsZ6i5kJ4Ya6YJgUAYFRmR0DPtc7HWCI7dP3QdRwqBSliEipZAsag
         zJdToyS1FvsJnK2mnQ7+ijVCW0AHF7Uo/cDItxt6qi3pEn/QNYlpVNDZFQeUEb+aEyMG
         yL2MfUdzGkKoLdBN/3piUwPiFPSKaS8mIY2mrZIMorYkIV2+3cmZ0dzUv+mMfvjpV5Ol
         oU3Q==
X-Gm-Message-State: AOAM531TZC6fGKINX5hOUO6ZzUsir0pWdu/Pbiey8kvJQUdqo50EbocZ
        6hzqzYprQLFhlHjTsKD9Ugbl/vqyDe/V9nejWnaxTw==
X-Google-Smtp-Source: ABdhPJxBsjYchuuczn4QYYgrBFsVWRmvH+lVKRMUYHQvLuUgMBp/z//bn1pjDLM1A4mvKJg4nX5uqapZQKsQ+K38a5U=
X-Received: by 2002:a9f:2338:: with SMTP id 53mr33202592uae.129.1594046981028;
 Mon, 06 Jul 2020 07:49:41 -0700 (PDT)
MIME-Version: 1.0
References: <1592813959-5914-1-git-send-email-haibo.chen@nxp.com>
In-Reply-To: <1592813959-5914-1-git-send-email-haibo.chen@nxp.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 6 Jul 2020 16:49:04 +0200
Message-ID: <CAPDyKFphkPAgcOEd=j8EUoFyAz7Oj8DEXbgK=k7R15rizWWcTw@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdio: fix clock rate setting for SDR12/SDR25 mode
To:     Haibo Chen <haibo.chen@nxp.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>, fugang.duan@nxp.com,
        Doug Anderson <dianders@chromium.org>, huyue2@yulong.com,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 22 Jun 2020 at 10:30, <haibo.chen@nxp.com> wrote:
>
> From: Haibo Chen <haibo.chen@nxp.com>
>
> In current code logic, when work in SDR12/SDR25 mode, the final clock
> rate is incorrect, just the legancy 400KHz, because the
> card->sw_caps.sd3_bus_mode do not has the flag SD_MODE_UHS_SDR12 or
> SD_MODE_UHS_SDR25. Besides, SDIO_SPEED_SDR12 is actually value 0, and
> every mode need to config the timing and clock rate, so remove the
> =E2=80=98if=E2=80=99 operator.
>
> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>

This looks like a rather serious error, should we tag this for stable?

In the meantime, I have applied this for next to get it tested, thanks!

Kind regards
Uffe



> ---
>  drivers/mmc/core/sdio.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio.c b/drivers/mmc/core/sdio.c
> index 0e32ca7b9488..7b40553d3934 100644
> --- a/drivers/mmc/core/sdio.c
> +++ b/drivers/mmc/core/sdio.c
> @@ -176,15 +176,18 @@ static int sdio_read_cccr(struct mmc_card *card, u3=
2 ocr)
>                         if (mmc_host_uhs(card->host)) {
>                                 if (data & SDIO_UHS_DDR50)
>                                         card->sw_caps.sd3_bus_mode
> -                                               |=3D SD_MODE_UHS_DDR50;
> +                                               |=3D SD_MODE_UHS_DDR50 | =
SD_MODE_UHS_SDR50
> +                                                       | SD_MODE_UHS_SDR=
25 | SD_MODE_UHS_SDR12;
>
>                                 if (data & SDIO_UHS_SDR50)
>                                         card->sw_caps.sd3_bus_mode
> -                                               |=3D SD_MODE_UHS_SDR50;
> +                                               |=3D SD_MODE_UHS_SDR50 | =
SD_MODE_UHS_SDR25
> +                                                       | SD_MODE_UHS_SDR=
12;
>
>                                 if (data & SDIO_UHS_SDR104)
>                                         card->sw_caps.sd3_bus_mode
> -                                               |=3D SD_MODE_UHS_SDR104;
> +                                               |=3D SD_MODE_UHS_SDR104 |=
 SD_MODE_UHS_SDR50
> +                                                       | SD_MODE_UHS_SDR=
25 | SD_MODE_UHS_SDR12;
>                         }
>
>                         ret =3D mmc_io_rw_direct(card, 0, 0,
> @@ -537,10 +540,8 @@ static int sdio_set_bus_speed_mode(struct mmc_card *=
card)
>         max_rate =3D min_not_zero(card->quirk_max_rate,
>                                 card->sw_caps.uhs_max_dtr);
>
> -       if (bus_speed) {
> -               mmc_set_timing(card->host, timing);
> -               mmc_set_clock(card->host, max_rate);
> -       }
> +       mmc_set_timing(card->host, timing);
> +       mmc_set_clock(card->host, max_rate);
>
>         return 0;
>  }
> --
> 2.17.1
>
