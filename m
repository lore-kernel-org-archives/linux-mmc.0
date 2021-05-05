Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DFAC433B4
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 10:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6306D611EE
	for <linux-mmc@archiver.kernel.org>; Wed,  5 May 2021 10:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbhEEKLX (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 5 May 2021 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbhEEKLV (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 5 May 2021 06:11:21 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063EDC06174A
        for <linux-mmc@vger.kernel.org>; Wed,  5 May 2021 03:10:24 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id o192so808407vsd.7
        for <linux-mmc@vger.kernel.org>; Wed, 05 May 2021 03:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=v7hWLfiP4L8kd/8OkP5+NXOkybUNAwrKCRGGcgcoAgY=;
        b=vn0pSNH+j1spd4Zd9WBHRblPehcqOgqRSDTd6kMUOpLQNoYKf19jGW34SPWIPuYuwd
         Ja/LVFH2ljf2NCEq1Z0t/0yOUv61cbqLuVDlU7msNwlk9IVT09saoM+tAHj1tTRx/Vq+
         iUdGFAjHIQbIY8b3IGr18nWOzPK4Y2KFnHg+R2iXUgjBn59lz9q3jTXziCGQhM6ecVJK
         seIwhANuZLFxLlYsRn7WbieqrgIzZZ2Bve6qGvobN8frdhfEqQbNaoJcVQ1eds/vfSOj
         mvbl0QmQlhb1D2kWmrWbBUqiL43c5aNFH9jK5xuxWWk9SWGjFwkFql0P5+7vM96angpn
         KF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=v7hWLfiP4L8kd/8OkP5+NXOkybUNAwrKCRGGcgcoAgY=;
        b=OUluFOCXHc/Bo7wok2b82Kp4sGS8LEazOnZQBCQjCyTsdj76oXciWq0i7hQhuZN4ZC
         c19sAZbP98gOqF6Wo2Nj+LOEl9xjZ7q24Eoinov/HhpBFX+TFqO2ntjN++RsUehpjjmQ
         XhR/YMM35lktQd+a8R3xW/hWe6siHcha5H1XAACEtl/lmqjquMeDGRYLgByE4tIHDELt
         LMhMc6qX2mowROTv/zrE6nmowCKiE12VXjzlVqvgTCtUQyDOZD5T+c7QyLci4TEosY8v
         VfnavTdV2yYfzODLajGxWCCEap7w1TkAiku0JovXlei7uE+9hi3a1xigfNgNj9g4CS8b
         sNMQ==
X-Gm-Message-State: AOAM530rZCExREHe+1GBUQV9+tFU3eZz6EWaxs/4NOKgRZqoEYmSZKnl
        vunx3urUs9Rnh/dRkcdiyIXSa0VTyDrU7E18UuF7pnjoW8L+Thsy
X-Google-Smtp-Source: ABdhPJyLNbY7Hr5i/okzHjDMncajNnfX3gDt1hipCJXizf2/YZCQOO0omBnqbNTE17OPjgeF1pcT2RClqXksMGdAAks=
X-Received: by 2002:a67:2c03:: with SMTP id s3mr15767861vss.42.1620209423138;
 Wed, 05 May 2021 03:10:23 -0700 (PDT)
MIME-Version: 1.0
References: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP265MB2680766F673A99D2F296B878C4469@CWXP265MB2680.GBRP265.PROD.OUTLOOK.COM>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 5 May 2021 12:09:47 +0200
Message-ID: <CAPDyKFqvTgRZ0QEgBXJgbhbEmQvxBqzZuGh2MrZGS1mRyYz9mg@mail.gmail.com>
Subject: Re: [PATCH] mmc: enable UHS voltage switch for SDSC if supported
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

On Thu, 22 Apr 2021 at 15:18, Christian L=C3=B6hle <CLoehle@hyperstone.com>=
 wrote:
>
> Ignore the reported capacity if the card otherwise reports UHS support.
>
> Currently SDSC cards reporting UHS support except for the CCS do not run
> through the voltage switch.
> While strictly speaking a SDSC card cannot support UHS in compliance
> with the standard, there is no good reason to throttle them that way.

Maybe not, but I think the code just tries to conform to the SD spec.

> Especially for pSLCs in practice such cards benefit greatly by this patch=
,
> as they can be new and UHS supporting, but must not lie about their CCS.

Can you provide some concrete examples of SDSC cards that support UHS-I?

> The behaviour of linux-mmc for SDSC is deviating from the standard anyway
> in such a case, as the card is treated as UHS card not supporting the
> voltage switch in general.
> Such a card will come up as
> mmc0: new ultra high speed SDR25 SD card at address 0001.
> Thus the subsystem will support CMD23 and others to the card.
> But if we deviate from the standard anyway, then we might as well
> not throttle SDSC to 25MB/s.

Not sure I understand this correctly? Can you elaborate a bit more, so
I understand how we deviate from the SD spec here?

As far as I understand the spec, SDSC cards shouldn't support UHS-I.
If we decide to deviate from the spec to support this anyway, at least
we need to know about a couple of cards that actually supports this.

Kind regards
Uffe

>
> Signed-off-by: Christian Loehle <cloehle@hyperstone.com>
> ---
>  drivers/mmc/core/sd.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
> index 6fa51a6ed058..281ca2da8e0b 100644
> --- a/drivers/mmc/core/sd.c
> +++ b/drivers/mmc/core/sd.c
> @@ -841,11 +841,10 @@ int mmc_sd_get_cid(struct mmc_host *host, u32 ocr, =
u32 *cid, u32 *rocr)
>                 return err;
>
>         /*
> -        * In case CCS and S18A in the response is set, start Signal Volt=
age
> -        * Switch procedure. SPI mode doesn't support CMD11.
> +        * In case S18A in the response is set, start Signal Voltage Swit=
ch
> +        * procedure. SPI mode doesn't support CMD11.
>          */
> -       if (!mmc_host_is_spi(host) && rocr &&
> -          ((*rocr & 0x41000000) =3D=3D 0x41000000)) {
> +       if (!mmc_host_is_spi(host) && rocr && (*rocr & 0x01000000)) {
>                 err =3D mmc_set_uhs_voltage(host, pocr);
>                 if (err =3D=3D -EAGAIN) {
>                         retries--;
> --
> 2.31.1
>
> Hyperstone GmbH | Line-Eid-Strasse 3 | 78467 Konstanz
> Managing Directors: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
