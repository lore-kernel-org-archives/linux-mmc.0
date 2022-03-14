Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29D7C433F5
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Mar 2022 10:54:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238723AbiCNK4A (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Mar 2022 06:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238732AbiCNKz7 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Mar 2022 06:55:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1512AC5A
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 03:54:44 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id w7so26338693lfd.6
        for <linux-mmc@vger.kernel.org>; Mon, 14 Mar 2022 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vRzVdmii+d1cRN7UUZvjKYaaOk5b0ubFZRbbFk1xnRM=;
        b=WOfWrWmy0naPgZhVqDU9oBsnW9w/GajwOvDdBr8tdiTSrCzoO5S0M0dPAbIpU5oBbv
         gBHGP5e1shXAYGvRzTab6g/ag4v8nCkOCkvvZ6Sq4xt2XOQaXfDNLPoxIpEwwcit3adK
         jGSwFUAgxuwohakllItBGBYEkY8j/FrPnFfNH1aPtyJ6rqIjWbNI5fVFAFgB4NHVB1ca
         9QiMkrr8EygobsrU0AKovYRFPhNOA1MIBLD2B2GA5dRlEULv8ccSnM3sK71+mpizNyLs
         +pJK7eTiM9aO6Rr2H9mMduAZIV/M5vYhcle29fwiIJYA+XXmsr9Dw4dOTzlIedNXNCJd
         99ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vRzVdmii+d1cRN7UUZvjKYaaOk5b0ubFZRbbFk1xnRM=;
        b=7M5IBRZTVX+7Pvxjao3CiFSG3PuiPA3cpVL0ht6Iuvwh44h6AkXRV7tTDoA2975SsT
         TCls+qJJ9z1seiaFEDUAkNs80AdX2NlTTL2tpo+uWnlQz/xeABAb4H3/pPhRXmEM11zH
         RgnqUGE0NtIeNKPId6LecvYH95IbQLLFSzyeoUmR6LVdndEpxj18Z4SRCdwIPl+iQZiN
         iEPX9Yud/Zci5xegeOYjTx6UPq4UPHueDufnJqYgHonSxQVYmHzJoiKO08uVBZGXjxjr
         COqj8mW9h+OMgGQlJSdn5+2EL75QlUcKAsd7PdjhTe1lYRGfnE9GHJftf2+n/HH+3NcB
         4hnQ==
X-Gm-Message-State: AOAM532tF54EG6ERGN0bBgOk2DbXqFCkWBWqIst4ZnvPtCXlEftwjVD/
        M+KUHbZfUKmQr5skRYYITEUruf5xT49iNRgVvUKnwQ==
X-Google-Smtp-Source: ABdhPJxIJjYE9r/4kFXslwW+YzFmI5aeSDCVRy6PflGXevF8einmHE4Hrsb5JyQbb3vGO2YaaTn+GEbuLpxxph0yCCU=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr13956278lfr.233.1647255282348; Mon, 14
 Mar 2022 03:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220303164522.129583-1-ulf.hansson@linaro.org>
In-Reply-To: <20220303164522.129583-1-ulf.hansson@linaro.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Mar 2022 11:54:06 +0100
Message-ID: <CAPDyKFod3LdfRRgVfdASqgSBAXqJnGkdKMM9qKnAYcfUQptF_g@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Improve fallback to speed modes if eMMC HS200 fails
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     linux-mmc@vger.kernel.org, Adrian Hunter <adrian.hunter@intel.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yann Gautier <yann.gautier@foss.st.com>,
        linux-kernel@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 3 Mar 2022 at 17:45, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> In the error path of mmc_select_hs200() we are trying our best to restore
> the card/host into a valid state. This makes sense, especially if we
> encounter a simple switch error (-EBADMSG). However, rather than then
> continue with using the legacy speed mode, let's try the other better speed
> modes first. Additionally, let's update the card->mmc_avail_type to avoid
> us from trying a broken HS200 mode again.
>
> In an Amlogic S905W based TV box where the switch to HS200 mode fails for
> the eMMC, this allows us to use the eMMC in DDR mode in favor of the legacy
> mode, which greatly improves the performance.
>
> Suggested-by: Heiner Kallweit <hkallweit1@gmail.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Heiner, does this solve your problems? Can you perhaps run some tests
at your side to see how it works for you?

Kind regards
Uffe

> ---
>  drivers/mmc/core/mmc.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 141f851c9f58..6e7db45cb8e0 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1518,13 +1518,23 @@ static int mmc_select_timing(struct mmc_card *card)
>         if (!mmc_can_ext_csd(card))
>                 goto bus_speed;
>
> -       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES)
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS400ES) {
>                 err = mmc_select_hs400es(card);
> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200)
> +               goto out;
> +       }
> +
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS200) {
>                 err = mmc_select_hs200(card);
> -       else if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
> +               if (err == -EBADMSG)
> +                       card->mmc_avail_type &= ~EXT_CSD_CARD_TYPE_HS200;
> +               else
> +                       goto out;
> +       }
> +
> +       if (card->mmc_avail_type & EXT_CSD_CARD_TYPE_HS)
>                 err = mmc_select_hs(card);
>
> +out:
>         if (err && err != -EBADMSG)
>                 return err;
>
> --
> 2.25.1
>
