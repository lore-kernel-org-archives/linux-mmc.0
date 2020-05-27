Return-Path: <SRS0=ylMS=7J=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AD3C433DF
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 07:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4FF2073B
	for <linux-mmc@archiver.kernel.org>; Wed, 27 May 2020 07:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tfge/ggI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387568AbgE0Hfd (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 27 May 2020 03:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387411AbgE0Hfc (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 27 May 2020 03:35:32 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ABF6C061A0F
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2020 00:35:31 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id c15so1339956uar.9
        for <linux-mmc@vger.kernel.org>; Wed, 27 May 2020 00:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QSnTG6l9+S3MPXE+BOOxbCtul1/+rtYSsnYjZX/x7N8=;
        b=tfge/ggIqEgGc6weOqu8HySKTKbo15QktUp2Yj6f2Oz6tuUQrWPuzv0dbLgk4vI4GT
         8PyKWBGYPg4f5CJQH+7j/w2uNCVCKwSmW2DLXTmK5LzNc2j+iSSf4EkiEKnF64wXikHu
         jCUYPv27OY+7h52zyk388RTKWG2OBcmpx/PWBl562aBWPvd/njQfKsVC869LWT5MNK9Q
         7fFERgUBtDu0xZ8QEqNactwfkb+OMIgB3Cvgj4LajcNTjUI0xRYeYM2yzOgkXkE9d+Bn
         mIQXpWrsYfa9U1IwxAGsxQR1mENoFwWt/iq+mfPq7mwC6NyiFubv0i6Keazz3NSHuuWR
         m7jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QSnTG6l9+S3MPXE+BOOxbCtul1/+rtYSsnYjZX/x7N8=;
        b=rtwxPa75w829ecgwdD8yLkb/ny56sgGrod2hrK9dAlz3c+pWe6i3eqvKpJIdAJmawv
         xmAxhcThpcRMrZl6sravv8WBlwTpttt0aPm3noR6FyiM/SRpaYGcTZ22z+wkkHeYT6ja
         jvDOQpsCLm3AUlcjrihr4EnJpP9nlQguzMIyHsaxo+26TzTu0FbSTM4MCKmDHMXzs35e
         NILe9S+S5SLeAjMmoDISr4NZdTxM7owTDKzJqa+1uKWFrouJy1+omAJBVl/ZN/PdX0yJ
         ROHVg0IKrrGmGAa4Y9Hrs3WW654pU4L/8F7O5Y+sFVHo3toJEUXKl/thDfWUjsKdkKQz
         hV5w==
X-Gm-Message-State: AOAM533Nq5KaUoBkM+cw0PKVWxSb3w63kXvi4+fNDBBF+kUa81O0u/cq
        8vWHwqz5xQmSDVrVJltim766bG0H5Z+ToT9FYw0J+A==
X-Google-Smtp-Source: ABdhPJxrali/w28V9SLfP9NXA5y8HfwWsWoIwteRLBWjWwgHYXkScL7eCvIPwqs9MlnlRxD36pyQIYtfj46Jf/p0h6o=
X-Received: by 2002:ab0:70c9:: with SMTP id r9mr3673781ual.15.1590564930339;
 Wed, 27 May 2020 00:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200526154334.21222-1-pali@kernel.org>
In-Reply-To: <20200526154334.21222-1-pali@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 27 May 2020 09:34:54 +0200
Message-ID: <CAPDyKFptJ470iNGJ8pJCodnyqKcr263Seb3OPp4Pg0b3st8-zQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: Do not export MMC_NAME= and
 MODALIAS=mmc:block for SDIO cards
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
> SDIO non-combo cards are not handled by mmc_block driver and do not have
> accessible CID register which is used for MMC_NAME=3D construction.
>
> Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> Reviewed-by: Marek Beh=C3=BAn <marek.behun@nic.cz>
> ---
>  drivers/mmc/core/bus.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/mmc/core/bus.c b/drivers/mmc/core/bus.c
> index 74de3f2dd..103eea7cd 100644
> --- a/drivers/mmc/core/bus.c
> +++ b/drivers/mmc/core/bus.c
> @@ -93,15 +93,20 @@ mmc_bus_uevent(struct device *dev, struct kobj_uevent=
_env *env)
>                         return retval;
>         }
>
> -       retval =3D add_uevent_var(env, "MMC_NAME=3D%s", mmc_card_name(car=
d));
> -       if (retval)
> -               return retval;
> -
> -       /*
> -        * Request the mmc_block device.  Note: that this is a direct req=
uest
> -        * for the module it carries no information as to what is inserte=
d.
> -        */
> -       retval =3D add_uevent_var(env, "MODALIAS=3Dmmc:block");
> +       if (card->type !=3D MMC_TYPE_SDIO) {
> +               retval =3D add_uevent_var(env, "MMC_NAME=3D%s", mmc_card_=
name(card));
> +               if (retval)
> +                       return retval;
> +
> +               /*
> +                * Request the mmc_block device.
> +                * Note: that this is a direct request for the module it =
carries
> +                * no information as to what is inserted.
> +                */
> +               retval =3D add_uevent_var(env, "MODALIAS=3Dmmc:block");
> +               if (retval)
> +                       return retval;
> +       }
>
>         return retval;
>  }
> --
> 2.20.1
>

Overall this change makes sense to me, but at nitpick...

Rather than adding new nestled if-sentences, I suggest converting the
function into using the "early returns" pattern instead.

For example, already in the switch loop, above the code you change, we
could just return 0 instead of setting type =3D NULL. Likewise, you can
check "if (card->type =3D=3D MMC_TYPE_SDIO) return 0;"

Kind regards
Uffe
