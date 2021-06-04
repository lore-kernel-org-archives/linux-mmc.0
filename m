Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CF4C07E94
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Jun 2021 12:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9533C6141A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Jun 2021 12:12:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbhFDMOH (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Jun 2021 08:14:07 -0400
Received: from mail-vs1-f45.google.com ([209.85.217.45]:42938 "EHLO
        mail-vs1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbhFDMOH (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Jun 2021 08:14:07 -0400
Received: by mail-vs1-f45.google.com with SMTP id l25so4676438vsb.9
        for <linux-mmc@vger.kernel.org>; Fri, 04 Jun 2021 05:12:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KQXWWLT5RQ01iYXrL3I6svphgBdijbU/3J0LL0eegpg=;
        b=y7LP51U0YcEky4gv642q0QUU2JYMNeoO4KxLeBONC9s1eHDOsXIBjajOKgug9Xu/GU
         4B+dQMFcYSCjV+dKFqYuzNMqbFVHO8a9sSeQ9BojpOYZOdhzZVB7K2+PMgq+NcRWYCsf
         eWxAKCrop5AfOKLqtygq8mRWCapXlH4YALzhlLGMANuUsC1dJcAnFOn6qcQYML3HbpHI
         KDwqq04OGSeM0jZum8P6TJ6S9dxZM2kEqvdPB5SKmsrHTw50d87WOM2GYI6Zi9M8qjpy
         z20H+JZvWXafVHsSe2mvuyyzskXFluGFlkhrPkMg7S8FPDpBsxg2QLG54scRSaxlNUPz
         Jggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KQXWWLT5RQ01iYXrL3I6svphgBdijbU/3J0LL0eegpg=;
        b=SDo5j5Qa09z4zpoyEocpyR+PphXqtlKe1Pi2DddwTOKIAwn/v1AnEA8zU2JavBnS+c
         Mg58yZdGWdFJzAuZgUV6eOE7MvfPfxYNorTJk4T69IoKQIygGMDlVxv15XvyPkis5V9W
         TqbAX3BYUrN47vahvS/S91ZJko/HaYhWf7+ppx0SpJyFma60XR0DkVTeVcnRP6VAqZzy
         icoG8fq7xwfrVn0UuVwfwIkmymZe62kE6whF0S7tw++qCG+qbHW7tRB+N7hZ63W4Z9v8
         RidtsSfwzG6VjbD3guwLZ6WlRkLEoZYvTODAcQ7gBCwJ5NksELE3QqUponO5+RmcHaQd
         CMYw==
X-Gm-Message-State: AOAM533YNcMi13GwFR14B8Z82sKWDH/W3+6L+JexDa+DKB0zBPGvEzy1
        ZE3x0uzIY4OhrXRm6PD6RPYGQcK9EKSjDF80E8lY6Q==
X-Google-Smtp-Source: ABdhPJyKQ0RL5S/5QNho2NFAvPLDRm/Kgm6BnWjs1SAGW8VTZ/Lmltet/mkhoUZci+3FgXaz7bPQnfLBNpUTPWTyxA0=
X-Received: by 2002:a05:6102:3023:: with SMTP id v3mr1834711vsa.19.1622808672999;
 Fri, 04 Jun 2021 05:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
 <CWXP265MB26803AE79E0AD5ED083BF2A6C4529@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB26803AE79E0AD5ED083BF2A6C4529@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Jun 2021 14:10:36 +0200
Message-ID: <CAPDyKFq_eM0EvLk_M2nGhJMv4nouZLKnhowtyHbH-MM8U5Awpw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: enable UHS voltage switch for SDSC if supported
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "pali@kernel.org" <pali@kernel.org>,
        "huyue2@yulong.com" <huyue2@yulong.com>,
        "tiantao6@hisilicon.com" <tiantao6@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, 12 May 2021 at 18:03, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Ignore the reported capacity if the card otherwise reports UHS support.
>
> Let SDSC cards reporting UHS support (except for the CCS) attempt the
> voltage switch.
> Up until now such cards would be initialized as UHS,
> supporting UHS features SDSC cards are otherwise barred from,
> but skip the voltage switch.
> While strictly speaking a SDSC card cannot support UHS in compliance
> with the standard, there is no good reason to throttle them that way.
> Especially for pSLCs in practice such cards benefit greatly,
> as they can be new and UHS supporting, but must not lie about their CCS.
>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>

Apologize for the delay. I have tested a bunch of my old (and new)
SD/uSD cards, this seems to work fine.

I have applied this for next, but I think this actually should be
considered as bug fix. I let it cook in linux-next for a while, then I
will probably add a stable tag for it.

Thanks and kind regards
Uffe

> ---
>  drivers/mmc/core/sd.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 2c48d6504101..62d02f1dc924 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -847,11 +847,17 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, =
u32 *cid, u32 *rocr)
>                 return err;
>
>         /*
> -        * In case CCS and S18A in the response is set, start Signal Volt=
age
> +        * In case S18A in the response is set, start Signal Voltage
>          * Switch procedure. SPI mode doesn't support CMD11.
> +        * Strictly speaking, S18A is not valid if CCS is not set (=3D no=
t SDSC),
> +        * so one would have to OCR for 0x41000000.
> +        * We choose to ignore this as SDSC cards that report UHS voltage
> +        * support should not be throttled artificially by the standard t=
his
> +        * way.
> +        * SDSC cards that 'accidentally' reporting UHS support by settin=
g the
> +        * reserved bits don't seem to be an issue in practice.
>          */
> -       if (!mmc_host_is_spi(host) && rocr &&
> -          ((*rocr & 0x41000000) =3D=3D 0x41000000)) {
> +       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
>                 err =3D mmc_set_uhs_voltage(host, pocr);
>                 if (err =3D=3D -EAGAIN) {
>                         retries--;
> @@ -1109,7 +1115,14 @@ static int mmc_sd_init_card(struct mmc_host *host,=
 u32 ocr,
>                 }
>         }
>
> -       /* Initialization sequence for UHS-I cards */
> +       /* Initialization sequence for UHS-I cards
> +        * Strictly speaking, S18A in the OCR is only valid if CCS is set=
, too.
> +        * So SDSC cards should be excluded. We choose to deviate from th=
e
> +        * standard here to allow SDSC cards to utilize UHS if they repor=
t
> +        * supporting it.
> +        * Fortunately, SDSC cards reporting S18A and the related bus spe=
ed
> +        * modes on accident, by setting reserved bits, don't seem to exi=
st.
> +        */
>         if (rocr & SD_ROCR_S18A && mmc_host_uhs(host)) {
>                 err =3D mmc_sd_init_uhs_card(card);
>                 if (err)
> --
> 2.31.1
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
