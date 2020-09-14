Return-Path: <SRS0=0j+4=CX=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E75C433E2
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 17:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 547D621D1B
	for <linux-mmc@archiver.kernel.org>; Mon, 14 Sep 2020 17:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C1S5VUqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbgINRiu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 14 Sep 2020 13:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbgINM0K (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Sep 2020 08:26:10 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E912C061221
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 04:59:30 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id m8so1934995vka.6
        for <linux-mmc@vger.kernel.org>; Mon, 14 Sep 2020 04:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qmiMXrjncodw9mvJl4x/k/M3Ke1P+OsILp6o1NXi2o=;
        b=C1S5VUqPtrFz0YLFe1lwxDOgTdqJXc8GmauclNhGr7oUhNFaRCJOLQGcUPYAeALfMf
         ZakJAnA4Fvl/oJU8eQgnbYnEYbrU/Ag5dQG0tUTJvoJw8wvg3MsZVvruBhwK3MhVSSQL
         xnt0bfSOMD5ym/2XfZ3KSAY4PmxRn6YvfPdm5PfutTsVAi/pmivNosYAWa1hbB5pqapN
         lwYdz1cE9ZFF3F+aFnYYyDQ+w9YrXKmhV+v6ya6O2WE7gGCpY87YPRVn6hIlx7iFYNSj
         3mZc+tao7OcHazjyv9nGggARKvE2yN70jSNbmhoui/6YmvyyzrdJG3c+2fX7ayginv+o
         MoHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qmiMXrjncodw9mvJl4x/k/M3Ke1P+OsILp6o1NXi2o=;
        b=PKGHIRQhAOUhRp8reCDRllqu4hDL+1xU+twjvGmHsIdKXMto/3ll8/zd/jyfv6bWIG
         wWgLdIHcKwrCDl9lg1pDPfsw18bO58J5D+rTEwYTsJElbprPJwqhP1VHAXFRZewxreIu
         upqdpcWwHEtj6vsIQc30ROh81Mcahqh5zyNDj5Y8h5wJZujf+xNkUd/7WI3VoImicVaV
         Bb+wT5o82gEahz6eKvoCFpnQU33rDQbsMhTnfDKDDYSktGbiMbDVmfHSQYydPArlC4Fb
         RlbM0Z6AWYoKlQHrS7+eQOHlSHhD0erV3NqEJICSPEFxocAlui+pWluxahCKk9dX7M3u
         QM+Q==
X-Gm-Message-State: AOAM533pcBaBqgZDNJFiXJuW4+kt+5KAET4imPwz/+SkrditVON3NFHF
        pqwS8x/aLXTppS1/Aj5fvy4hgZ3c6M1go7hyZCYncHa9MPRunw==
X-Google-Smtp-Source: ABdhPJyn83V/uNDVK6NYuIWr/Cn8JDl2S+BLagQ88LbgC0Pb5icm2hjlLgRjbM4bGd73aGhQ+rw+IvqCbJCc43abPUE=
X-Received: by 2002:a1f:1dcf:: with SMTP id d198mr908402vkd.30.1600084769632;
 Mon, 14 Sep 2020 04:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200914112845.21855-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20200914112845.21855-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Sep 2020 13:58:53 +0200
Message-ID: <CAPDyKFrcYYj1sNuWipNJx7HgQZ8dN7zZg7J4gK9Z=B+rLw+PbQ@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: clear 'doing_init_tune' also after failures
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 14 Sep 2020 at 13:28, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> Reorganize the code, so that the flag is always cleared independently of
> a good or bad case.
>
> Fixes: 97a7d87e96b0 ("mmc: core: add a 'doing_init_tune' flag and a 'mmc_doing_tune' helper")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied for next, thanks!

Kind regards
Uffe

> ---
>
> Sorry for overlooking this :(
>
>  drivers/mmc/core/mmc.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
> index 67e95eba0e82..ff3063ce2acd 100644
> --- a/drivers/mmc/core/mmc.c
> +++ b/drivers/mmc/core/mmc.c
> @@ -1766,14 +1766,14 @@ static int mmc_init_card(struct mmc_host *host, u32 ocr,
>                 host->doing_init_tune = 1;
>
>                 err = mmc_hs200_tuning(card);
> -               if (err)
> -                       goto free_card;
> +               if (!err)
> +                       err = mmc_select_hs400(card);
> +
> +               host->doing_init_tune = 0;
>
> -               err = mmc_select_hs400(card);
>                 if (err)
>                         goto free_card;
>
> -               host->doing_init_tune = 0;
>         } else if (!mmc_card_hs400es(card)) {
>                 /* Select the desired bus width optionally */
>                 err = mmc_select_bus_width(card);
> --
> 2.20.1
>
