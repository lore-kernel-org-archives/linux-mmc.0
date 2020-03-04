Return-Path: <SRS0=jYsQ=4V=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3AD0C3F2D7
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A761C24658
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Mar 2020 15:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HxwjdvIr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388116AbgCDPfL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:35:11 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40004 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbgCDPfK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 4 Mar 2020 10:35:10 -0500
Received: by mail-vs1-f67.google.com with SMTP id c18so1408930vsq.7
        for <linux-mmc@vger.kernel.org>; Wed, 04 Mar 2020 07:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=607USbInCPhErOqAR+rQmRLg2cAUXpDH/Wdrk48PRkY=;
        b=HxwjdvIrAhxRWqM0xoHcPCla2sl36KuJ2jfiMJ4/Ah98SMgRhr4WEl8ksuR5VLDptC
         fekPB8aYp1FPKfQZaZ19NssPoj0U9CWqGeYSvdeEJF0wk5VPzSg7WlWwRKFWYXnhA6OT
         fGS6nq2edty0YK3E3OBbXC1O7qYGqLayb89IhfVZbMNZABON1WZxBihJedyu1uwFA3ob
         xMTAxMHv/RHXnzD5tPwiyyEajIJnCWeyD2ElqfRcSxhP0OU2Wew2xwNyZEDDWuT6etL9
         ER2rY1apFQsBvkjQLH6ABUU60hxzwjYD5wFjqLWW6xikxZuahnF3R5ilNiVbdP3BzDcx
         P/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=607USbInCPhErOqAR+rQmRLg2cAUXpDH/Wdrk48PRkY=;
        b=fJBOELAEB/1KXUtTlAJUFUE6a40a74RtC9n3aWg8QjExNCgKfiJhW7GAACyy3Cr0Uj
         srsQpfJTwJO63EgdapgVeQngBmC4PtR0REfKtThSnARHrcLsjMEa/GEQPPXYnNfyEJzt
         xuU2zQu2U08Mh0KlIZ6QtFvg6kuep6gRWRYJ0oQ46498bdTObtumGtgVILAR5S2g4jQY
         dI6Bh6HT0WdtWBPr8ZYCo1H2AVfks79GwV1LAIOAdHxbgkFgtTObkLl2fjIs5JM6/AdU
         sN5mu1E0HGhim1Nd6W/I+H4MgkKumTaGX1aLqnn+upwDUI/cdBgvcMWyzOjF6R/fBJHE
         gcXw==
X-Gm-Message-State: ANhLgQ1f10mMxlWZnU6i5MonEk+auPKi1ikSshg5MWsLW2wPmjCnVNCf
        M86tRTHpeB1rLD9Z9B6G8xTLhXAGqnai/U9JhN750V3t
X-Google-Smtp-Source: ADFU+vt5YUaBm2Cv5bwdr+N4lTy0pvVPOqWx1UDOgb8Ufrbuyzw2mN4dBUdswksoPqVVqU33mp1Xm3MVwiAFdqAWsO4=
X-Received: by 2002:a67:f4cf:: with SMTP id s15mr2024303vsn.165.1583336109225;
 Wed, 04 Mar 2020 07:35:09 -0800 (PST)
MIME-Version: 1.0
References: <20200221163147.608677-1-Jerome.Pouiller@silabs.com>
In-Reply-To: <20200221163147.608677-1-Jerome.Pouiller@silabs.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 Mar 2020 16:34:33 +0100
Message-ID: <CAPDyKFq4aNohO6p+Bn=_z11+sEjnZUP6Ny0TWLNALSoTdCcbSA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Fix indentation
To:     Jerome Pouiller <Jerome.Pouiller@silabs.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 21 Feb 2020 at 17:32, Jerome Pouiller
<Jerome.Pouiller@silabs.com> wrote:
>
> From: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>
>
> sdio_single_irq_set() was indented with a mix of tabs and spaces.
>
> Signed-off-by: J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>

Applied for next, thanks!

Kind regards
Uffe


> ---
> v2:
>   - Also add braces arounf for loop (suggested by Joe)
>
>  drivers/mmc/core/sdio_irq.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/mmc/core/sdio_irq.c b/drivers/mmc/core/sdio_irq.c
> index 900871073bd7..3ffe4ff49aa7 100644
> --- a/drivers/mmc/core/sdio_irq.c
> +++ b/drivers/mmc/core/sdio_irq.c
> @@ -276,14 +276,15 @@ static void sdio_single_irq_set(struct mmc_card *ca=
rd)
>
>         card->sdio_single_irq =3D NULL;
>         if ((card->host->caps & MMC_CAP_SDIO_IRQ) &&
> -           card->host->sdio_irqs =3D=3D 1)
> +           card->host->sdio_irqs =3D=3D 1) {
>                 for (i =3D 0; i < card->sdio_funcs; i++) {
> -                      func =3D card->sdio_func[i];
> -                      if (func && func->irq_handler) {
> -                              card->sdio_single_irq =3D func;
> -                              break;
> -                      }
> -              }
> +                       func =3D card->sdio_func[i];
> +                       if (func && func->irq_handler) {
> +                               card->sdio_single_irq =3D func;
> +                               break;
> +                       }
> +               }
> +       }
>  }
>
>  /**
> --
> 2.25.1
>
