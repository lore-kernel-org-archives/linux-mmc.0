Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE40C433F5
	for <linux-mmc@archiver.kernel.org>; Fri,  7 Jan 2022 16:50:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiAGQui (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 7 Jan 2022 11:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239973AbiAGQuh (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Jan 2022 11:50:37 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B61CC061574
        for <linux-mmc@vger.kernel.org>; Fri,  7 Jan 2022 08:50:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id o12so17703639lfk.1
        for <linux-mmc@vger.kernel.org>; Fri, 07 Jan 2022 08:50:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LykQ8JvLsF0ujZTEedjBws1nZuvKkSm/2BrHJb5/NR8=;
        b=QiVKSy+iGyC8g/3jTi1Z1nFohQVIFOSt2+0/YWq+lYZLpWjm7frzI/3na1/r26gWwR
         4amTKU4RoqnV7m7Pdz8v9j4jywD2LprBvnglpUBAx1HvAfr6K7gF2ikL4zjRKjImhWtw
         52aHG1vOecBLzAgkOyov/lfdkJlmicbJErePSy0qJKZylRji7osMYdnuuDBrVVsgtUbc
         9Qz+nExkknFVsLNQNLtVL1B4bBC2MnMTGsbGdaTymZjNACyj1/6j6gRMbtsJKyvdOkn6
         k3xiQCGlfUUJIvCOEeCSkkqhM1dlKXVEU0cnlkaEh8MS4ijll+IhIJ1quQ3FhnmzM9+d
         rhxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LykQ8JvLsF0ujZTEedjBws1nZuvKkSm/2BrHJb5/NR8=;
        b=41beKcve6WG/870gmYnGYVDT78A0YUkK9vvBOUa9R59Dz/cUZAypQtUhp4ZfvVptdU
         jut9yJRuFbjBUnDxdQ/OM9iKs8BikoS8hKoGfafRxl+Bnliwg91oCZhDc95z+JJqoks1
         G+mTe4x/ud6Jv/Ydv20nHNxVi3gAA9tDKBhHcZYYAVeMVW1f+fRHBo1b7YHgxBq8f4qu
         tNBoXvQVwJyeslrsOls6ssw5sWlTCONdYacgiKCkTC1xZRVK4335n8LpEiFI/F+RspjE
         MfDXoA1ELVUnSvS/z3eAqRmGCai3DK/TsSmr2JsQkXZCGpKF6dR1dXtGnCmSXP3ae9lj
         UI+A==
X-Gm-Message-State: AOAM533p0aTqWloAw6KaqpCK6Br2lSsgjAj3ssddE9LwxbtOFgK5yxNJ
        l/JGWKOaiO937UXiRT9o/pwlzdDYp9c98kkWjge8Vw==
X-Google-Smtp-Source: ABdhPJxzYICXq4JylhrK7XyzPMC1Me12d9+0qzNII7n0Fy9mlBcR4fa1CVhygugbIWMdtgyusKSfE4kgx/VDj5bPuQk=
X-Received: by 2002:a05:6512:3d9e:: with SMTP id k30mr56207440lfv.184.1641574235588;
 Fri, 07 Jan 2022 08:50:35 -0800 (PST)
MIME-Version: 1.0
References: <20211203105103.11306-1-jasonlai.genesyslogic@gmail.com>
 <20211203105103.11306-6-jasonlai.genesyslogic@gmail.com> <CAPDyKFp2mv5Z+0e8ckKnhyE-XvGYcuda-z=vJoz0crnTVa9ZVw@mail.gmail.com>
 <CAG0XXUFXTHh-tbLG1WQ8-AtNUtTykPzj4sFUK0PT9aigy-S0Lw@mail.gmail.com>
In-Reply-To: <CAG0XXUFXTHh-tbLG1WQ8-AtNUtTykPzj4sFUK0PT9aigy-S0Lw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 7 Jan 2022 17:49:58 +0100
Message-ID: <CAPDyKFo6xwCVKPXeCXuLDizGqvQDho=-n9LaL2BYSAOwyo8kYw@mail.gmail.com>
Subject: Re: [PATCH 5/7] mmc: add UHS-II related definitions in headers
To:     Lai Jason <jasonlai.genesyslogic@gmail.com>
Cc:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?B?R3JlZ1R1W+adnOWVn+i7kl0=?= <greg.tu@genesyslogic.com.tw>,
        Jason Lai <Jason.Lai@genesyslogic.com.tw>,
        otis.wu@genesyslogic.com.tw,
        =?UTF-8?B?6I6K5pm66YeP?= <benchuanggli@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

[...]

> > > diff --git a/include/linux/mmc/core.h b/include/linux/mmc/core.h
> > > index ab19245e9..8ac4b0b52 100644
> > > --- a/include/linux/mmc/core.h
> > > +++ b/include/linux/mmc/core.h
> > > @@ -1,7 +1,5 @@
> > >  /* SPDX-License-Identifier: GPL-2.0-only */
> > > -/*
> > > - *  linux/include/linux/mmc/core.h
> > > - */
> >
> > It's okay to remove these lines. However, it should be a separate
> > patch - and please keep it outside of the UHS-II series, as it doesn't
> > belong here.
>
> Okay. I will put them back in the next version.

Yes, please.

> Should I create a patch for this rescovery?

If you want to remove these lines, that's fine by me. Although, then
send a separate patch for it.

[...]

> > > @@ -421,7 +442,7 @@ struct mmc_host {
> > >  #define MMC_CAP2_CRYPTO                0
> > >  #endif
> > >
> > > -       struct sd_uhs2_caps     uhs2_caps;      /* SD UHS-II capabilities */
> > > +       struct sd_uhs2_caps     uhs2_caps;      /* SD UHS-II host capabilities */
> >
> > If you prefer "host capabilities" over plain "capabilities", that's fine by me.
> >
> > However, please make this change as part of the patch that introduced
> > the code, earlier in the series.
>
> I did not change the variable name, I modified the comment just to
> remind me what
> the capability is used for. (host side or device side)
>
> Shall I do anything related to this comment change?
> If I revert to the old comment in the next version, should I create a
> separate patch for it?

I think it would be best to amend my original patch, to fix my mistakes.

[...]

Kind regards
Uffe
