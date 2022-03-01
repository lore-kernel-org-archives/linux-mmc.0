Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65B2C433F5
	for <linux-mmc@archiver.kernel.org>; Tue,  1 Mar 2022 13:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231309AbiCANvj (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 1 Mar 2022 08:51:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbiCANvj (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 1 Mar 2022 08:51:39 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C534CDF7C
        for <linux-mmc@vger.kernel.org>; Tue,  1 Mar 2022 05:50:56 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id bu29so27076279lfb.0
        for <linux-mmc@vger.kernel.org>; Tue, 01 Mar 2022 05:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKbNB+QFCelUuFIWDTxEUSr2023K4PLkKkX5DLtqjDs=;
        b=cLWP8XiR8+Ia5Sbi85algUG7M4V42UIOiGrjK4TssmFDsMhvv/orkMXJfBTTFFawxX
         rCJmaYY+5jZIj40kvq+IJw6YH1VMal+eAWpqgK5qV6aeNZ8RZXzUC8YXhabUlPw0GTdA
         xPQWlm4iRrozKX2txmm+aq97wE0f/1q68uvk2/4DSXleyEISpKzV8WpGKRUdiHxrL349
         raYCaS/Ai7gfnqxCJOflv98/5Oif61xNCuVt7kGsBquUCxaC/rvTPp3BtQ3FZKSrGE2+
         LUQNb1y4eBMPH/Bgc7L0gIsQkoD90qW8fC4AbwWXnyeK7Eo+qtQV2+9odTOC+213JazG
         XzZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKbNB+QFCelUuFIWDTxEUSr2023K4PLkKkX5DLtqjDs=;
        b=69lLV2FfITjFubH8+f64D0YJ4Z6IZ5z1k+7BqdnePjuVgWVGKE977oSFVsIxZjTIZ4
         ZZKSxTsFOXmDbLdX+kRy6HLX0mGYW4WUqKUDFCo0K0/TGh8Ub0WFUDn4TsMkhJ9FWIAj
         hjot5CqoNJbL5J0M1SAI6WdkHJh8JzS5pYuPhdbYxxGG7bffvM/WgTqnnBkah2syZ5Ar
         NgKojA282tX5n05CZ3k+J77KdlHKkMMljLNZe0Lzs8enKgdm8vZJ3ctYY1PPVN/uHY9a
         VgK5mcakVV45pP5+G6GBk9K3/uoB3dHthBt7yyHvgSyE/t9itMntId195MQcvudyAMPV
         tC/g==
X-Gm-Message-State: AOAM53148nczlIKJsshblMZaowggPkhjsuCoeWLHJ3BSKKCSjP8HnLIj
        SyBMSbtPAPKXwTuPyn7LJ1ddo8QOB38J2Iiy3T9lQtsStFc=
X-Google-Smtp-Source: ABdhPJxkiRw9RFbwuO0NVCLlDukDZeTilTWmcjG5JurAuA0YrWueLlIvsvbS5OCyC+PEWV7AZaJKXvI4ii28yUfo/Uc=
X-Received: by 2002:a05:6512:3604:b0:443:5d4b:3760 with SMTP id
 f4-20020a056512360400b004435d4b3760mr15701448lfs.358.1646142655067; Tue, 01
 Mar 2022 05:50:55 -0800 (PST)
MIME-Version: 1.0
References: <fae9ee4b-6b93-95ac-abf3-f97c62e07b9d@gmail.com>
In-Reply-To: <fae9ee4b-6b93-95ac-abf3-f97c62e07b9d@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 1 Mar 2022 14:50:18 +0100
Message-ID: <CAPDyKFqeb=EM25vWThynoTt0A2Fbe6K-fp2s3yeqLpfdCfdkgg@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: improve fallback in mmc_select_timing()
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 18 Feb 2022 at 08:00, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> I have a system (cheap Amlogic S905W based TV box) where the eMMC chip
> refuses to switch to HS200 timing. That's not nice, but my bigger
> problem is that the system then falls back to the very slow default
> mode, even though DDR52 is supported and works well.
>
> Therefore, if setting a mode fails with EBADMSG (switch error), try the
> next (in descending performance order) mode instead of immediately
> falling back to the slowest mode.
>
> With the patch it looks like this on my system:
>
> mmc1: mmc_select_hs200 failed, error -74
> mmc1: new DDR MMC card at address 0001
> mmcblk1: mmc1:0001 DG4008 7.28 GiB
>

Overall, I think the approach seems very much reasonable!

Although, I want to have a closer look at the impact on the different
scenarios, as mmc_select_timing() is being called during power
management and reset too.

Allow me a day or so, then I will get back to this, either with some
more detailed suggestions or I may post a patch.

Kind regards
Uffe

> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/mmc/core/mmc.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index bbbbcaf70..c0272192d 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1523,11 +1523,23 @@ static int mmc_select_timing(struct mmc_card *card)
>         if (!mmc_can_ext_csd(card))
>                 goto bus_speed;
>
> -       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
>                 err = mmc_select_hs400es(card);
> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
> +               if (!err)
> +                       goto bus_speed;
> +               if (err != -EBADMSG)
> +                       return err;
> +       }
> +
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200) {
>                 err = mmc_select_hs200(card);
> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
> +               if (!err)
> +                       goto bus_speed;
> +               if (err != -EBADMSG)
> +                       return err;
> +       }
> +
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>                 err = mmc_select_hs(card);
>
>         if (err && err != -EBADMSG)
> --
> 2.35.1
>
