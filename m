Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DF7C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 25 Jan 2022 17:31:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384078AbiAYRby (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 25 Jan 2022 12:31:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384253AbiAYR37 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Jan 2022 12:29:59 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8657C061751
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jan 2022 09:29:58 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id j14so16248814lja.3
        for <linux-mmc@vger.kernel.org>; Tue, 25 Jan 2022 09:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMe/e0zpT/eE0uMK14jJGZXEZUuis5z0YZe/+oEjwbE=;
        b=oNZDuGQnFx6JXCmxEZpKSEt3SYs0Or3kHVoz9ZhVfr3Fu9ncwRBvfm6NHXwdmV9qAu
         eO8ZEZpV/FI1f3C9JMjP7d85D+0G9INgb+GdP535ZqogzR6BkA9X9K5ODUexJ24qaXMy
         7VfKehM11aLvDw97YbBJ755ICKoUpv7X1+cpxJ3HNl9hj+Svq7bTH0iCnJbJAgYYQi8+
         16/adg+OGJ9uNB2fxkTJZPx6gHMZRhmeRsckQYAhYCo2ITj98Eu8mrRqqKUiI/i+r/qj
         B2lTvh+hF457CmupeOQxHH7QH29b2pv21OviCI8dOI3Cep+Iwlp09o1pHK97By8Hg4wX
         S/ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMe/e0zpT/eE0uMK14jJGZXEZUuis5z0YZe/+oEjwbE=;
        b=NfraH7ekvvgMRVa645+Z96BGl4okyhqZjm2y6GjDa8hnTOAE21CApL9dNj9cbp9GjL
         4JDjxkarPT3Eh+1ue5ep/P6KAf8Uw0zaDvf7/1/Axl1/DqR1HUUj3Z83sYA/WPpZ9pym
         Na8cwosnJHPEkNXosPKeAwu/nIS7BnUrHdDLk7aw/w/sSGNfFEEmHcCcUqEzQX2WY/FV
         DvdAVgsLQPJ5A+zMKq6SMZkNK7iiUy9GPqpbJVJYzAkwVDU+pWGBdSnkUa1eAsPucQpg
         Efvfzc/WUt62ugJggGmRReWHfhgPPxWFTtrQBOhaK/etQXYiGcKwxyQHe28wU7Y7injt
         7kAA==
X-Gm-Message-State: AOAM532CMCmlNOcb55VCkmC8IWxbyuqVfMu6du/UV0QQoiMy51iQ4ITM
        O9CS746YBxbdMjV8KOhHp2YbZpwJmg9cBQZGPyhYDA==
X-Google-Smtp-Source: ABdhPJwevJ3AE74svS2BdlHqCG+ikm2inbk3kWLs+LLRQzeuETW+NkfVeyR6lr3qQTlECPSFYtpSuwrDOCI4yqJefmo=
X-Received: by 2002:a2e:9217:: with SMTP id k23mr15023089ljg.229.1643131797141;
 Tue, 25 Jan 2022 09:29:57 -0800 (PST)
MIME-Version: 1.0
References: <CGME20211224112220epcas5p2491fcef539e793179fcfa14b983999db@epcas5p2.samsung.com>
 <20211224111917.707440-1-shankar.ma@samsung.com>
In-Reply-To: <20211224111917.707440-1-shankar.ma@samsung.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Jan 2022 18:29:20 +0100
Message-ID: <CAPDyKFqZR=Do3rpvS1dGPi93zr8cHNNxSWR2VcBpi=MuGR26Kw@mail.gmail.com>
Subject: Re: [PATCH 1/2] Display BARRIER_CTRL Status when printing EXT_CSD
To:     Shankar Athanikar <shankar.ma@samsung.com>
Cc:     linux-mmc@vger.kernel.org, avri.altman@wdc.com, chris@printf.net,
        puneet.5@samsung.com, sumeet.paul@samsung.com,
        mohanraj.v@samsung.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 24 Dec 2021 at 12:23, Shankar Athanikar <shankar.ma@samsung.com> wrote:
>
> The status of BARRIER_CTRL can be read from this byte: EXT_CSD[31](R/W)
> Signed-off-by : shankar.ma@samsung.com
> Reviewed-by : mohanraj.v@samsung.com

Applied to git.kernel.org/pub/scm//utils/mmc/mmc-utils.git master, thanks!

I have fixed up the S-o-B tag and some whitespace errors, as
checkpatch complained about it.

Kind regards
Uffe



> ---
>  mmc_cmds.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/mmc_cmds.c b/mmc_cmds.c
> index c5eea65..5e5e79e 100644
> --- a/mmc_cmds.c
> +++ b/mmc_cmds.c
> @@ -1831,7 +1831,10 @@ int do_read_extcsd(int nargs, char **argv)
>                 printf("Control to turn the Cache ON/OFF"
>                         " [CACHE_CTRL]: 0x%02x\n", ext_csd[33]);
>                 /* flush_cache ext_csd[32] not readable */
> -               /*Reserved [31:0] */
> +               printf("Control to turn the Cache Barrier ON/OFF"
> +                       " [BARRIER_CTRL]: 0x%02x\n", ext_csd[31]);
> +               /*Reserved [30:0] */
> +
>         }
>
>         if (ext_csd_rev >= 7) {
> --
> 2.25.1
>
