Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BD0BC433ED
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 12:53:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB6AB6198F
	for <linux-mmc@archiver.kernel.org>; Wed, 31 Mar 2021 12:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbhCaMxF (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 31 Mar 2021 08:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235470AbhCaMwe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 31 Mar 2021 08:52:34 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F325C06174A
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 05:52:30 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id o4so4318652vka.12
        for <linux-mmc@vger.kernel.org>; Wed, 31 Mar 2021 05:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WqfmSnt4f/2ks+8X8RLAsKNXjo55vFKKYygsPeyt/Q0=;
        b=zEe0ReG8A6GKYusCinRNutkOo2zpEvXkGYjR2vB1KDpivEBahfIESl0a+D7NxYjmrG
         STztw17dFIURGSwU/bptahfd0wiARagvJUd/FfcagLXLK6LURwhkW9y9/D04M+tIVz0h
         vlEKGjYablpZRmiSw4o2swcZupxYlJpoqp7Dv2Q0HmBGUe/zrGTs2B28HVNbGbJykSFf
         Cii7HQkJ1ly06yYdw8+Ow3rP4vSxszICdEexB5O0CqWqvCZPk1YjxzYF05CcZ/npt0WT
         xnq9wQr5TUtBgwTFEFDMSDQP4SgqKlYu6Yim+7mGwIzYcYis4b8fVaMrFZLRO5k2erNM
         YHeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WqfmSnt4f/2ks+8X8RLAsKNXjo55vFKKYygsPeyt/Q0=;
        b=XLtS3qLPLho+cLLQ61Szs8FkEalYq6Saz28apynUFDZemrrAz/Z8vRDU52nSjOz6gB
         OAfaiei7Sd5rN7Qvz7aC73RP1vQ8PEY+o1izH+h4USt6d3bKGT3W4DhtkV/OHE7K34+h
         n+ADByj1IqjX2WJuxRAtTgth0accDkZXe2LTHn8SPzoUsDhkS5DEOxSZmS/PscUjCqfH
         +cyyvBOKLXm1POl1VDMFwh7l+KIXckkNQLzxPbovoMDJYNEO8r9U2aMjeJT/Ed2l5blO
         +aZCJdFk+56njaoTLX7KECguLr1iorz9C2FftlKu+aI6xIdcqmMECZeO+k3tps73SDiD
         P4gQ==
X-Gm-Message-State: AOAM533/gZO8ice581ZS8mU/w/aU/JNSfp/fyakYeTJSmhI65fiwm+CR
        QUn63O4d4fa4rwaFYma4APBvqibjFuLy9v+EfxeXbM1m9G9fnw==
X-Google-Smtp-Source: ABdhPJybHkcf/fzBx1R1+Nm9EN+RW07PpD3Xak3KMuTBuzRpcreHlpvaSKJnQa82dAU9Mw2nN45mYuhtro90ztYBcr0=
X-Received: by 2002:a1f:b689:: with SMTP id g131mr1434777vkf.6.1617195149483;
 Wed, 31 Mar 2021 05:52:29 -0700 (PDT)
MIME-Version: 1.0
References: <1617086448-51054-1-git-send-email-fanghao11@huawei.com>
 <CAPDyKFoUUu=Rb0pHMZb+gKXPsKESBnXG=4U=n_XFMZJLHyY7kA@mail.gmail.com> <c5284747-95dd-a4d5-0027-4da09bb56117@huawei.com>
In-Reply-To: <c5284747-95dd-a4d5-0027-4da09bb56117@huawei.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 31 Mar 2021 14:51:52 +0200
Message-ID: <CAPDyKFrBh+nMUB62nzTS4_6dVjEV9gVPP-X3un_DQ7rGLw2vUA@mail.gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc-k3: use the correct HiSilicon copyright
To:     "fanghao (A)" <fanghao11@huawei.com>
Cc:     Jaehoon Chung <jh80.chung@samsung.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        prime.zeng@hisilicon.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 30 Mar 2021 at 16:27, fanghao (A) <fanghao11@huawei.com> wrote:
>
>
>
> On 2021/3/30 18:38, Ulf Hansson wrote:
> > On Tue, 30 Mar 2021 at 08:43, Hao Fang <fanghao11@huawei.com> wrote:
> >>
> >> s/Hisilicon/HiSilicon/g.
> >> It should use capital S, according to
> >> https://www.hisilicon.com/en/terms-of-use.
> >>
> >> Signed-off-by: Hao Fang <fanghao11@huawei.com>
> >> ---
> >>  drivers/mmc/host/dw_mmc-k3.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/mmc/host/dw_mmc-k3.c b/drivers/mmc/host/dw_mmc-k3.c
> >> index 29d2494..0311a37 100644
> >> --- a/drivers/mmc/host/dw_mmc-k3.c
> >> +++ b/drivers/mmc/host/dw_mmc-k3.c
> >> @@ -1,7 +1,7 @@
> >>  // SPDX-License-Identifier: GPL-2.0-or-later
> >>  /*
> >>   * Copyright (c) 2013 Linaro Ltd.
> >> - * Copyright (c) 2013 Hisilicon Limited.
> >> + * Copyright (c) 2013 HiSilicon Limited.
> >
> > This change looks really silly to me, but I am not a lawyer - so I
> > can't tell if this makes sense or not.
> >
> > In any case, "Hisilicon" is being used all over the kernel - do you
> > intend to patch all places with similar changes like this one? Perhaps
> > just send a big tree-wide-patch instead and see what people think?
> >
>
> Although HiSilicon has applied for two trademarks Hisilicon/HiSilicon,
> there is only one English name for the company. We have consulted with
> company's lawyer who suggested that should use a copyright statement
> consistent with the official website.
>
> Though the kernel has tons of "Hisilicon", I just fix the copyright,
> and plan to send a commit to each subsystem where is uncorrect. Fortunately,
> there are not many modules that have the problem, this is one of them.

git grep Hisilicon | grep Copyright | nl
gives 159 cases.

Although if you make one patch per subsystem that should be a lot
less, which seems like a reasonable approach to me.

[...]

So, applied for next, thanks!

Kind regards
Uffe
