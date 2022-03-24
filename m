Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F54C433EF
	for <linux-mmc@archiver.kernel.org>; Thu, 24 Mar 2022 12:13:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349978AbiCXMPE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 24 Mar 2022 08:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349976AbiCXMPB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Mar 2022 08:15:01 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E3B825294
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2022 05:13:26 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id g24so8052912ybj.13
        for <linux-mmc@vger.kernel.org>; Thu, 24 Mar 2022 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Uw6g4YsNRZs7dvbvdfz68KCNF9zTM2uIQY4UH0egBE=;
        b=NwAGl5PjjQYaTY/ibiX0U0a5HDuHxhbD+Kyi/TzF4oo6bK22mHnC/3HB07FB3W9sKU
         HftzjhJl5A65DQHiB0Z+lWMxC64pLeia9/0OWV6SF4VoBxxJMNC6TCevfgsGuDRK3dUt
         keTQfmeDhsw1aK4vOrrNDLLTYjLSYOHJ++Ff6djaG0+IpxIN7KabVpUixYbwJQAo+jH2
         wP94EqXDaXfTEIea/8ihlTgOmrKSX6+IljQ1mJx0x+CUTsMJ5enAh3RRg9sgjKElmIQD
         UDW0GINzrS6m8n0BEgpj1gvl0pkdfbf670hJ3lQuikKxfpP2KCEn1m0kNmTc74gmGIz/
         5Www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Uw6g4YsNRZs7dvbvdfz68KCNF9zTM2uIQY4UH0egBE=;
        b=W5Kej9r+P1Hizu9WR4l+bprU3LJQlq5HjaDTY2lAvV4kM+B5bvFOjQsiHXwoAN2KQV
         9dme5mF4POdXQ6w4jWXH3xiBItKPHOg3ilKs/1UNEpxhyYUSrjlal4H/AzWD84mhFaY6
         6rTLJfd7qC3z/ykD9tKvgJQxQ43MbuzB8ET5KMdp2PYGCnhUao4J+P98WepGdDBbFr+C
         Vr1pIH37TMgyarerMRMAE35yJNvEAtoKok7Lyqp74H2kCZoUTMa5E6fMsuVT84WEmTro
         z6Mjt4pYb1ulRxHzpTmhAE0rjGA16ok13wpUvkCt47VO7T5QdxTKjoD6utl6Rdwci+8q
         It0w==
X-Gm-Message-State: AOAM532cIWlqnTFPUONNCQ1mlkoOMqY8t6pXlRQESxW2hXG6wnNHKrNf
        uas2f8jr8pliHi/JPMpmoigrmDrAnZCMA88M9PHKlw==
X-Google-Smtp-Source: ABdhPJyY/P4kzUoohyrCOwyDJ56XsDNfY1zNXB0nyRdpTxSmF3W9bRGbG5rn37x9hjuHpaCPfrlLW54G5MMRQ99G1nc=
X-Received: by 2002:a25:23c2:0:b0:633:b871:ce27 with SMTP id
 j185-20020a2523c2000000b00633b871ce27mr4248237ybj.644.1648124005363; Thu, 24
 Mar 2022 05:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220318185139.v2.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
In-Reply-To: <20220318185139.v2.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 24 Mar 2022 13:12:48 +0100
Message-ID: <CAPDyKFqCcSkHx92XcDkGH19JZyGgkALuf9wGNiBjKkFt4SaDTQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Set HS clock speed before sending HS CMD13
To:     Brian Norris <briannorris@chromium.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 19 Mar 2022 at 02:52, Brian Norris <briannorris@chromium.org> wrote:
>
> Way back in commit 4f25580fb84d ("mmc: core: changes frequency to
> hs_max_dtr when selecting hs400es"), Rockchip engineers noticed that
> some eMMC don't respond to SEND_STATUS commands very reliably if they're
> still running at a low initial frequency. As mentioned in that commit,
> JESD84-B51 P49 suggests a sequence in which the host:
> 1. sets HS_TIMING
> 2. bumps the clock ("<= 52 MHz")
> 3. sends further commands
>
> It doesn't exactly require that we don't use a lower-than-52MHz
> frequency, but in practice, these eMMC don't like it.
>
> The aforementioned commit tried to get that right for HS400ES, although
> it's unclear whether this ever truly worked as committed into mainline,
> as other changes/refactoring adjusted the sequence in conflicting ways:
>
> 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode
> switch")
>
> 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode
> for mmc")
>
> In any case, today we do step 3 before step 2. Let's fix that, and also
> apply the same logic to HS200/400, where this eMMC has problems too.
>
> Resolves errors like this seen when booting some RK3399 Gru/Scarlet
> systems:
>
> [    2.058881] mmc1: CQHCI version 5.10
> [    2.097545] mmc1: SDHCI controller on fe330000.mmc [fe330000.mmc] using ADMA
> [    2.209804] mmc1: mmc_select_hs400es failed, error -84
> [    2.215597] mmc1: error -84 whilst initialising MMC card
> [    2.417514] mmc1: mmc_select_hs400es failed, error -110
> [    2.423373] mmc1: error -110 whilst initialising MMC card
> [    2.605052] mmc1: mmc_select_hs400es failed, error -110
> [    2.617944] mmc1: error -110 whilst initialising MMC card
> [    2.835884] mmc1: mmc_select_hs400es failed, error -110
> [    2.841751] mmc1: error -110 whilst initialising MMC card
>
> Fixes: 08573eaf1a70 ("mmc: mmc: do not use CMD13 to get status after speed mode switch")
> Fixes: 53e60650f74e ("mmc: core: Allow CMD13 polling when switching to HS mode for mmc")
> Fixes: 4f25580fb84d ("mmc: core: changes frequency to hs_max_dtr when selecting hs400es")
> Cc: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>
> Changes in v2:
>  * Use ext_csd.hs200_max_dtr for HS200
>  * Retest on top of 3b6c472822f8 ("mmc: core: Improve fallback to speed
>    modes if eMMC HS200 fails")
>
>  drivers/mmc/core/mmc.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index e7ea45386c22..b75fa4b67964 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1385,12 +1385,17 @@ static int mmc_select_hs400es(struct mmc_card *card)
>         }
>
>         mmc_set_timing(host, MMC_TIMING_MMC_HS);
> +
> +       /*
> +        * Bump to HS frequency. Some cards don't handle SEND_STATUS reliably
> +        * at the initial frequency.
> +        */
> +       mmc_set_clock(host, card->ext_csd.hs_max_dtr);
> +
>         err = mmc_switch_status(card, true);
>         if (err)
>                 goto out_err;
>
> -       mmc_set_clock(host, card->ext_csd.hs_max_dtr);
> -
>         /* Switch card to DDR with strobe bit */
>         val = EXT_CSD_DDR_BUS_WIDTH_8 | EXT_CSD_BUS_WIDTH_STROBE;
>         err = mmc_switch(card, EXT_CSD_CMD_SET_NORMAL,
> @@ -1482,6 +1487,12 @@ static int mmc_select_hs200(struct mmc_card *card)
>                 old_timing = host->ios.timing;
>                 mmc_set_timing(host, MMC_TIMING_MMC_HS200);
>
> +               /*
> +                * Bump to HS200 frequency. Some cards don't handle SEND_STATUS
> +                * reliably at the initial frequency.
> +                */
> +               mmc_set_clock(host, card->ext_csd.hs200_max_dtr);
> +

If the mmc_switch_status() fails with -EBADMSG, we should probably
restore the clock to its previous value. Otherwise I think we could
potentially break the fallback implemented in 3b6c472822f8 ("mmc:
core: Improve fallback to speed modes if eMMC HS200 fails")

Moreover, this change means that we will be calling
mmc_set_bus_speed() from mmc_select_timing(), to actually set the same
HS200 clock rate again. That is unnecessary, can we please avoid that
in some way.

>                 /*
>                  * For HS200, CRC errors are not a reliable way to know the
>                  * switch failed. If there really is a problem, we would expect

Kind regards
Uffe
