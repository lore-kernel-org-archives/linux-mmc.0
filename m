Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8BCC56201
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:26:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CA5B20795
	for <linux-mmc@archiver.kernel.org>; Tue, 10 Nov 2020 12:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HR+afSDs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730074AbgKJM0q (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 10 Nov 2020 07:26:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbgKJM0p (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Nov 2020 07:26:45 -0500
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B734C0613CF
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:26:45 -0800 (PST)
Received: by mail-vs1-xe43.google.com with SMTP id y73so6906110vsc.5
        for <linux-mmc@vger.kernel.org>; Tue, 10 Nov 2020 04:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+4HfV4HcTWWifdRiIwBl3NJeUVjBCfnr5ggY4aZiD50=;
        b=HR+afSDs2xp6EyCGQDdjm36uSz9XqUrSGL/s6HIYuw8fvyifRb5PZUa/V/S1dWd9gJ
         L5NQOFjQkOYXnzy0R2KqmH/MHATZjHVPg8cSNgsmhvITwaie+6XsXX/Kb+pVHKdejnEf
         E5WjbCNw21vs6oq2ycyQcI4h4FCv+s8VBv57W/A9rWIHGQSsC+Q8eHSk2/bAsTuRqDnv
         8G5HSDtPQ4QBLEZy8uswZM7OKTtqJ4FCoOZAybrHnennBi5WtRSCcfO6cd3+wcrjLL0w
         eeTIExIZjqupJAuS7G/KTkw0ZLwbdg5JsCgruWgY/a6GM9HOxTzsFvwmw4ZIHsUEmzmN
         t1Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+4HfV4HcTWWifdRiIwBl3NJeUVjBCfnr5ggY4aZiD50=;
        b=S7ID811EAkYYC934iKaxV7rL+Ig8EdeaGe4QVLYThP84igCKojsufeVAUu88GfYfF8
         mdZALr8ccDHDqPe2fFtAlIKUHhvSl2VUE1myIkQoeGGvyMxBw9EKK4IB6coWZ0PLu/B1
         Z9aHuKGs2taDmARHaWFUxjfRe4xHSs806THIwBqlvM3uWCRfCjIjW5+C5UU6KMoo9T9+
         ga6zTdFnMpUtqnj6DZwXjFSDIBXDz1DkzuchB5ZXULUjFmunKA+6RwWM6+tDZwOUo8ZI
         y0zJ7pcDex3jynEI2B7tecEZwSL2Mn2rrsgyo62N/ZN25w7R3zISqa78rkiEmAlBNTue
         HLZw==
X-Gm-Message-State: AOAM5332rtXLafMEQ2AWe9P8BmsG8/DDdsqJM9vXX4eITAM9mzNVxFEd
        j1KdMnvUTyvp8ezBmhNR2LtoOJ+JbxwD50VzKhIH2hJfDoxs4Q==
X-Google-Smtp-Source: ABdhPJzhAz95876CXcG+niRXySelIUggZwcDlb80XN/VChOU7kn49XCxPpRHEmhKP8GJuPE9keyb5xMWyZWbedsi8h8=
X-Received: by 2002:a05:6102:30a7:: with SMTP id y7mr10947641vsd.55.1605011204402;
 Tue, 10 Nov 2020 04:26:44 -0800 (PST)
MIME-Version: 1.0
References: <20201106072549.1495-1-wsa+renesas@sang-engineering.com>
In-Reply-To: <20201106072549.1495-1-wsa+renesas@sang-engineering.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 10 Nov 2020 13:26:08 +0100
Message-ID: <CAPDyKFpGX0HOQr4z4LEH9FLiqeRJzNiUpBLpCNquJGJnZNFycg@mail.gmail.com>
Subject: Re: [PATCH 0/3] tmio/sdhi: fix workaround for a regression
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 6 Nov 2020 at 08:26, Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> After some refactoring, I had to insert a workaround because a
> regression was discovered when re-inserting SD cards. Now, this series
> implements the proper fixes and finally reverts the workaround.
>
> This has been tested on Salvator-XS (M3N and H3 ES2.0). These patches
> were already discussed with Shimoda-san and the BSP team internally.
> However, I'd appreciate Shimoda-san's tags be given here to make sure
> the patches are exactly that what we discussed.
>
> Thanks and happy hacking!
>
>
> Wolfram Sang (3):
>   mmc: tmio: when resetting, reset DMA controller, too
>   mmc: tmio: bring tuning HW to a sane state with MMC_POWER_OFF
>   Revert "mmc: renesas_sdhi: workaround a regression when reinserting SD
>     cards"
>
>  drivers/mmc/host/renesas_sdhi_core.c | 13 -------------
>  drivers/mmc/host/tmio_mmc_core.c     |  7 +++++--
>  2 files changed, 5 insertions(+), 15 deletions(-)
>

Applied for next, thanks!

Kind regards
Uffe
