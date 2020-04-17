Return-Path: <SRS0=NquR=6B=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1DDC352BE
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B5C420776
	for <linux-mmc@archiver.kernel.org>; Fri, 17 Apr 2020 09:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d68y2crm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgDQJbg (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbgDQJbg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Apr 2020 05:31:36 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44525C061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 02:31:36 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id o3so768201vsd.4
        for <linux-mmc@vger.kernel.org>; Fri, 17 Apr 2020 02:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ci5hRVmjulAYrmfkyZuf4AJKD86QhaAVQJ/VV77WqoQ=;
        b=d68y2crmC1HbkvnMjQT/eWTRcxtHmWS9rILk33LCB9VweLLePg4jcXJi5kRwNkg21O
         GOxYU5OcvPUyFlwKb13An0vKKJd3Ls0kOTdhB5dd26Kn5LBPOh/i6ahtoylXaYyoxBuk
         ZOfVTis8aK5SSn1ctoSQrAMWq3D6943dRoQcoLQXgBWVIxsoCvWCwqddoG02WKfp9s3e
         oEJDprW5WL5tzFeSreG3a9Hr9O+p4uPqPNh7YOZTidLPuFzqfG6VYoM0G+weVuBdmmGT
         ReGjRdRuM+OD0xZ+7AO43qX6iZnKQF4bEz7l4Ix3mL4eaqSvxpAnTPbK1GQEimpq0vIY
         jEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ci5hRVmjulAYrmfkyZuf4AJKD86QhaAVQJ/VV77WqoQ=;
        b=ksa31N9q+tCHIRpmhmcnn4vLMsSsibNi0UoMlduOxjMyS/UOkvDDym510cBNtA1h3k
         zJrZa+FRk4LGEvhLyul6QA0qYUa41Lr3EFvPMr/mtTaJbXxi5DMJVLOIPQWQtmz1Cn6z
         MA2BSYpL35eVumHdITUXea2LlvSt3AYZjHZCevjRzHBGDkvC3wkS4DNmy4lhvAUM2HTr
         s3kHSxy131uQlV/XaQ3crFQt5i6pImKqz9u1WFfIDgpiz3um9V6eLu5HqpGkRvQL+7+e
         JoqRQYCc5x8xtsU/LxVgzSDAm4Tc+5+bZWl9yVefMxk1WBPet0XwQhU1MOyAr3p+T9I4
         o5ug==
X-Gm-Message-State: AGi0PuZ1ooVTf0PlYJYJBNAnezWmEQcEliQux1UaBXbkW4zRBtEIkeAB
        TK9TgAVOE+6zaxIowUGnRmyy/FnDOqAAhdlc0zpdXg==
X-Google-Smtp-Source: APiQypLY46DGg3PN3KuNcbkFlSLFXabZFqXY+yuTgvqOWw9NiSNZtZojeFE0mb5c64prIq2CaKoIhi9LDSNBVE46VhM=
X-Received: by 2002:a67:11c4:: with SMTP id 187mr1463592vsr.34.1587115895484;
 Fri, 17 Apr 2020 02:31:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200416163649.336967-1-marex@denx.de> <20200416163649.336967-2-marex@denx.de>
In-Reply-To: <20200416163649.336967-2-marex@denx.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 17 Apr 2020 11:30:59 +0200
Message-ID: <CAPDyKFpf5E6AmnLNt=6kmnYK3JzsrMgeY+7XSFb=8HsMeyaQ8A@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] mmc: Return 1 from mmc_regulator_set_vqmmc() if
 switch skipped
To:     Marek Vasut <marex@denx.de>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Ludovic Barre <ludovic.barre@st.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Patrice Chotard <patrice.chotard@st.com>,
        Patrick Delaunay <patrick.delaunay@st.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 16 Apr 2020 at 18:37, Marek Vasut <marex@denx.de> wrote:
>
> Adjust mmc_regulator_set_vqmmc() to return 1 if the voltage switch was
> skipped because the regulator voltage was already correct. This allows
> drivers to detect such condition and possibly skip various voltage
> switching extras.
>
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Ludovic Barre <ludovic.barre@st.com>
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
> Cc: Patrice Chotard <patrice.chotard@st.com>
> Cc: Patrick Delaunay <patrick.delaunay@st.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-mmc@vger.kernel.org

Applied for next, thanks!

Kind regards
Uffe


> ---
> V2: - Rename variable curr_voltage to current_uV
>     - Update mmc_regulator_set_vqmmc() to handle the fact that
>       mmc_regulator_set_voltage_if_supported() can return value > 0
> ---
>  drivers/mmc/core/regulator.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/regulator.c b/drivers/mmc/core/regulator.c
> index b6febbcf8978..96b1d15045d6 100644
> --- a/drivers/mmc/core/regulator.c
> +++ b/drivers/mmc/core/regulator.c
> @@ -136,6 +136,8 @@ static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
>                                                   int min_uV, int target_uV,
>                                                   int max_uV)
>  {
> +       int current_uV;
> +
>         /*
>          * Check if supported first to avoid errors since we may try several
>          * signal levels during power up and don't want to show errors.
> @@ -143,6 +145,14 @@ static int mmc_regulator_set_voltage_if_supported(struct regulator *regulator,
>         if (!regulator_is_supported_voltage(regulator, min_uV, max_uV))
>                 return -EINVAL;
>
> +       /*
> +        * The voltage is already set, no need to switch.
> +        * Return 1 to indicate that no switch happened.
> +        */
> +       current_uV = regulator_get_voltage(regulator);
> +       if (current_uV == target_uV)
> +               return 1;
> +
>         return regulator_set_voltage_triplet(regulator, min_uV, target_uV,
>                                              max_uV);
>  }
> @@ -198,9 +208,10 @@ int mmc_regulator_set_vqmmc(struct mmc_host *mmc, struct mmc_ios *ios)
>                  * voltage in two steps and try to stay close to vmmc
>                  * with a 0.3V tolerance at first.
>                  */
> -               if (!mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
> -                                               min_uV, volt, max_uV))
> -                       return 0;
> +               ret = mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
> +                                                       min_uV, volt, max_uV);
> +               if (ret >= 0)
> +                       return ret;
>
>                 return mmc_regulator_set_voltage_if_supported(mmc->supply.vqmmc,
>                                                 2700000, volt, 3600000);
> --
> 2.25.1
>
