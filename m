Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8677C64ED8
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Feb 2023 16:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230081AbjB0QN6 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Feb 2023 11:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229762AbjB0QN5 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Feb 2023 11:13:57 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EBF1ABDD
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 08:13:56 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id i10so7217519plr.9
        for <linux-mmc@vger.kernel.org>; Mon, 27 Feb 2023 08:13:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iU3DIPiFHtyl6MAm66myHOcnybgqDkhP99roOt2WViA=;
        b=muARfEHVBJSBPQF3V/HIv82zR+6d+0M8snnG/omf3SMTJrZd9yx5aSHSUvTxc5+7fB
         j9ohcL7w8tctZ+6qDIZFbftTarwx8R7f4InksG7uXbcMOWdvxgSsEucSS/EPOrtEdf5b
         rigd63046P5nmnNZGlzV7ZJYmX1jv2m6EKpQmPcRQrbBC+wHH7ZD4wDAT88xv8x8Ao21
         5t8Z463DSiYcPx8WfDP2oatRSTTQ8v4wNd+wJBQgykaqsNC6Zk/owxEFtYFwQ03uAFk2
         45v6evTTHOdRutMkgBgGeeqPv4/a4Z0N+ySGndPRnSlnv7bv+Q5Jx5sy0FsjbfcN0fVG
         a8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iU3DIPiFHtyl6MAm66myHOcnybgqDkhP99roOt2WViA=;
        b=a0U59dpMkJeFKzcFPy+uLER3AXy7DLO/OG5JnOHSXTw0KWfc3uEg6lkx6TLT6+x4Xo
         W0Ihso1AtLIRq9WOFoCYPvNFhbgp3JOOw6rwBqz2YXFqwG38b6e1/NZ15mAoVajZiABK
         gDY/2Col/UZm/sEL0WWSQ+SBRGRfgG9lDeoLFsXJdIsbUryV2BistUvHOETgWgCpDenN
         xVWLjogz+m4GWcOLCQTTCeU0mK7dSXnVzspcaTxdmY7dliBNBh2x425GjTiM8arxNMD/
         4Jl/5+q9zM/OVMWLydILlM4r2U3ot3NwI73KrvTZ2qSIqq3faWqb22w3g+ffBZuNFn9j
         /RPg==
X-Gm-Message-State: AO0yUKVchIFUUE7vfzlQ3gRB3ZBKy8AhmQiUxI4aFsW2yU9XYLZxQ2bB
        xBG1RdscqHtR+pjJUNfAva6jte2tV5N6z9n7q0OsSCvRC/COnCFn
X-Google-Smtp-Source: AK7set+3RvTeQEziGmtk2RuQy5O5q53GPTIM08XtVfn+x2E/MpjnjVsIv7Zlx2KgiyWDdvKW7HlccfQMlHrFw2G7ONA=
X-Received: by 2002:a17:90a:dc04:b0:233:d131:29be with SMTP id
 i4-20020a17090adc0400b00233d13129bemr5023702pjv.9.1677514435569; Mon, 27 Feb
 2023 08:13:55 -0800 (PST)
MIME-Version: 1.0
References: <02b46550-e0b5-4251-8156-56eb0f690d89@gmail.com>
 <2553f3bc-b1e6-4af2-fb6c-def486dd99a3@gmail.com> <CAPDyKFpCEzubkJ=roniomXHaWrY5AOqfPZmNLbMbBnubHzZrEg@mail.gmail.com>
 <0725e5eb-43fd-65a7-27e8-84bbfe31c798@gmail.com>
In-Reply-To: <0725e5eb-43fd-65a7-27e8-84bbfe31c798@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Feb 2023 17:13:19 +0100
Message-ID: <CAPDyKFouH_uxF_p7ke_WAwwuQxp=O3qitC7iXHU7n1MGN1Nhmw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mmc: core: add helpers mmc_regulator_set_ocr_vmmc_up/off
To:     Heiner Kallweit <hkallweit1@gmail.com>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 17 Feb 2023 at 21:09, Heiner Kallweit <hkallweit1@gmail.com> wrote:
>
> On 17.02.2023 11:47, Ulf Hansson wrote:
> > On Wed, 15 Feb 2023 at 21:14, Heiner Kallweit <hkallweit1@gmail.com> wrote:
> >>
> >> A lot of drivers use this code, therefore let's factor it out to
> >> helpers.
> >>
> >> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> >> ---
> >>  include/linux/mmc/host.h | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> >> index 812e6b583..f93fb8c7d 100644
> >> --- a/include/linux/mmc/host.h
> >> +++ b/include/linux/mmc/host.h
> >> @@ -597,6 +597,23 @@ static inline int mmc_regulator_set_vqmmc(struct mmc_host *mmc,
> >>  }
> >>  #endif
> >>
> >> +static inline int mmc_regulator_set_ocr_vmmc_up(struct mmc_host *mmc,
> >> +                                               struct mmc_ios *ios)
> >> +{
> >> +       if (IS_ERR(mmc->supply.vmmc))
> >> +               return 0;
> >
> > Rather than adding these two new helper functions, how about adding
> > the similar check in mmc_regulator_set_ocr() instead?
> >
> There's a number of drivers having 3 paths here:
> 1. IS_ERR() is true -> do nothing and go one
> 2. mmc_regulator_set_ocr() returns 0 -> some action and go on
> 3. mmc_regulator_set_ocr() returns an error -> bail out

Right, thanks for pointing this out.

The important point I am trying to make is that the mmc core is
treating "mmc->supply.vmmc" as optional (see
mmc_regulator_get_supply()). To be consistent with that behaviour, I
think it would make sense to bail out and return 0, in
mmc_regulator_set_ocr() "if (IS_ERR(mmc->supply.vmmc))". We don't need
a new set of helper functions to do that.

>
> So the question is: what should mmc_regulator_set_ocr_vmmc_up return
> if IS_ERR() is true:
> 1. An errno? Then this errno would have to be different from the
>    error codes the function can normally return.
> 2. A positive value? Seems to be the best option
>
> Then we could write:
>
> ret = mmc_regulator_set_ocr()
> if (ret < 0)
>         return ret;
> if (!ret) {
>         some_action();
> }
> ...
>
> Works but I'm not sure whether it's very intuitive.
>
> The other benefit of the proposed helpers is that they hide the
> complexity of using mmc->supply.vmmc and ios->vdd.
>
> Mileage may vary here. Do you have any preference?

Actually, there is no complexity. Drivers should always be able to
pass 'ios->vdd' to mmc_regulator_set_ocr() (as it holds the correct
value).

For some reasons, some driver authors seem to find it clearer (I
guess) to call mmc_regulator_set_ocr() with an explicit '0' at
MMC_POWER_OFF, but it isn't needed (see mmc_power_off()).

[...]

Kind regards
Uffe
