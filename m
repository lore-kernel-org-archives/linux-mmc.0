Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D898DC001B0
	for <linux-mmc@archiver.kernel.org>; Tue, 15 Aug 2023 11:33:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235855AbjHOLdQ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 15 Aug 2023 07:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbjHOLcs (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 15 Aug 2023 07:32:48 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D561F10E3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Aug 2023 04:32:46 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-583d702129cso58119437b3.3
        for <linux-mmc@vger.kernel.org>; Tue, 15 Aug 2023 04:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692099166; x=1692703966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0cIlhyjWne1murlHvTIDv20f0nQNybjsStT8wYuMbs=;
        b=KK53EMS9OFUuzcG6+Y9jWCR9UJjdavAseGfBF7l9MTIsU0CtgHyY74O5WDPu6uDVyd
         /3flAUEvsDmfBZsCIl2KD+tOhCuWVLJcp49luN1tyrfPd5hIl/6wvaakgcp+ZRrGC5oj
         4udoYkc3clEbtXpW6s91SWOotVQp3z6ezoxk3TV+KW4Eo3Ywr120hGvcr3tj2jaXdhQP
         h31YzroHZBT0mdj6/Jz/iKwk5HJZG9V6upvk2q35ZtJ8qERLLc6YfHi3AdqnR+lVzoY9
         18t3sNb8m/T2TZ7szDAE8qKJYEezJqwKNdtW4HF3Ogx3QBol2PHlLSAh4gqsZJ3E356o
         CsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692099166; x=1692703966;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0cIlhyjWne1murlHvTIDv20f0nQNybjsStT8wYuMbs=;
        b=T1FbCIGuiyQfbSYPTV/rp+EfK3bkqEuNRAxprywuH7yvtLyu2PloGb7zPMm3yS14CE
         VE/55UPH4ISkBFl6wcluiAY7HHpTLDn6kOJQ7ggF4zhjuGh1KgZtEX+h6GNxOj6sC3Gx
         n+DaFR761HZwBcxOvLJtOLD77XWrc6SBqGOU1cUbyhHFA4SoytTHQn2vOWMv/256DFqb
         X1Ygt3naadZt4UDrIqR/4UspE5vuTEanbqCGiV37//JMhGrkYyT8RWx+KwQdveZwGCfn
         Sjxi51bdV24YKFy6g76UgfeowogoMSq+ni2THI9Ksx/iD2eoNlzt5OeuZnH6wh07/mbq
         +Yqg==
X-Gm-Message-State: AOJu0YwBEDnvkKABkLjd6cyLaOT907p12ewZVkbwdRp+Hvm9V/bkZjEF
        HZuVc4ni4htAm6IrOa3Q+k/JYqhQmVrMuD4DkfrnVw==
X-Google-Smtp-Source: AGHT+IF+Uq4L1vZ2KYOj/7hnmB0axq1IhUvwed2+zIGTzDRSd6D0RQexOAD/BAlRCgknTqGst3bcTKnrGouhUHLTuVM=
X-Received: by 2002:a25:209:0:b0:d4b:4a1f:6e13 with SMTP id
 9-20020a250209000000b00d4b4a1f6e13mr12714722ybc.33.1692099165951; Tue, 15 Aug
 2023 04:32:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230727070051.17778-1-frank.li@vivo.com> <20230727070051.17778-62-frank.li@vivo.com>
 <90febfa5-b520-05f5-53ca-af0e1f3fc7c4@intel.com> <643e844b-2640-e2c8-d8a7-1cd91d453ccc@intel.com>
In-Reply-To: <643e844b-2640-e2c8-d8a7-1cd91d453ccc@intel.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 15 Aug 2023 13:32:09 +0200
Message-ID: <CAPDyKFpjPhgrn8E7WEmJeLeUVSb2es9bZRBV6WDVvMk6UR+QUA@mail.gmail.com>
Subject: Re: [PATCH v3 62/62] mmc: f-sdh30: fix order of function calls in sdhci_f_sdh30_remove
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Yangtao Li <frank.li@vivo.com>
Cc:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Aug 2023 at 07:46, Adrian Hunter <adrian.hunter@intel.com> wrote:
>
> On 27/07/23 16:55, Adrian Hunter wrote:
> > On 27/07/23 10:00, Yangtao Li wrote:
> >> The order of function calls in sdhci_f_sdh30_remove is wrong,
> >> let's call sdhci_pltfm_unregister first.
> >>
> >> Cc: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> >> Fixes: 5def5c1c15bf ("mmc: sdhci-f-sdh30: Replace with sdhci_pltfm")
> >> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> >> ---
> >>  drivers/mmc/host/sdhci_f_sdh30.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci=
_f_sdh30.c
> >> index 840084ee72e6..964fa18a61a4 100644
> >> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> >> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> >> @@ -211,11 +211,11 @@ static void sdhci_f_sdh30_remove(struct platform=
_device *pdev)
> >>      struct sdhci_host *host =3D platform_get_drvdata(pdev);
> >>      struct f_sdhost_priv *priv =3D sdhci_f_sdhost_priv(host);
> >>
> >> +    sdhci_pltfm_unregister(pdev);
> >
> > That also frees priv
> >
> >> +
> >>      reset_control_assert(priv->rst);
> >>      clk_disable_unprepare(priv->clk);
> >>      clk_disable_unprepare(priv->clk_iface);
> >> -
> >> -    sdhci_pltfm_unregister(pdev);
> >>  }
> >>
> >>  #ifdef CONFIG_OF
> >
>
> So it needs to end up looking something like below, right?
>
> diff --git a/drivers/mmc/host/sdhci_f_sdh30.c b/drivers/mmc/host/sdhci_f_=
sdh30.c
> index 840084ee72e6..47ae853f51aa 100644
> --- a/drivers/mmc/host/sdhci_f_sdh30.c
> +++ b/drivers/mmc/host/sdhci_f_sdh30.c
> @@ -210,12 +210,15 @@ static void sdhci_f_sdh30_remove(struct platform_de=
vice *pdev)
>  {
>         struct sdhci_host *host =3D platform_get_drvdata(pdev);
>         struct f_sdhost_priv *priv =3D sdhci_f_sdhost_priv(host);
> -
> -       reset_control_assert(priv->rst);
> -       clk_disable_unprepare(priv->clk);
> -       clk_disable_unprepare(priv->clk_iface);
> +       struct clk *clk_iface =3D priv->clk_iface;
> +       struct reset_control *rst =3D priv->rst;
> +       struct clk *clk =3D priv->clk;
>
>         sdhci_pltfm_unregister(pdev);
> +
> +       reset_control_assert(rst);
> +       clk_disable_unprepare(clk);
> +       clk_disable_unprepare(clk_iface);
>  }

I have amended the patch according to the above. Added Adrian's ack,
rebased it on top of the fixes branch, added a stable tag and applied
it for fixes.

Thanks to both of you!

Kind regards
Uffe
