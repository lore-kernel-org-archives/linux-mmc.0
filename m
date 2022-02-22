Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EB3C433EF
	for <linux-mmc@archiver.kernel.org>; Tue, 22 Feb 2022 15:49:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbiBVPuL (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 22 Feb 2022 10:50:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232248AbiBVPuK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Feb 2022 10:50:10 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D0446B20
        for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2022 07:49:45 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id v22so18341693ljh.7
        for <linux-mmc@vger.kernel.org>; Tue, 22 Feb 2022 07:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NZZm6qWe1SwIb8KcDfZKZw7LrmnA+xYk4KC1Fi2iiNE=;
        b=jA1SbpiMI50DskuXEcULhrcfAjfibrqLpVBH3lqP1WwhyFGAF1jl4QMYw604Vx1F9q
         mABbjxiYoPiSIukSqdDGQGVACjoj7FV/Fgv2DZLtQIPHEgdeJoLtTTfScDhQGkE7m99g
         dr8nVAJQBVZtgAvqZo2tk9v5PNjx/2B6V3rQOKpfCfQkbixc3YqlEwWhWZulvqYBcY2W
         7JdY752tB7ucvHNYzoQN5mxFvCGDEGvSOynjbuXjg/rpMVHKFh22UChIChVNIDTtidSE
         doCqXCFTE4b/lM46YRaQLsIrcPPDEDaFBPVtQSIoCfXxrVL0yu5l48CYksa/mV1VbXa4
         w5gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NZZm6qWe1SwIb8KcDfZKZw7LrmnA+xYk4KC1Fi2iiNE=;
        b=3VWFn4ekw4SKkHzqqDdMhK1f6mE9j6/PgBexRw/DjMz8WwOTynvpdrPV8hl00cFSxU
         qJ+ALGxNoY6EN1pBBRvS4I5f2elsaJ+tchLQZMyRnYUobKRC8FI82dakT0/gOnNI1/VN
         6OeAM8zaUn19jWbShTyq9+zKRBRvsZ7J2kXyK+tEdSW6QEnbuxB8iLbk4MGGn+WdMGW4
         xkmEZpNTPfaabxNBBd3TddmEV3DL+SlHGvYgNDbm/t5OvOn0vvqZjq4dh1bnJX4Y2ypE
         fMJs0RAgK/hMlr7lyW2w8Bbj5zUpg0p5gy51Dl/cJRnazvCobpjYfjpCB7BN5Iyz3u7f
         x0Jw==
X-Gm-Message-State: AOAM530UYSacCydKvW08QrzFy2kuAyXA1A5QWPaDhs9ilwt4PBgDeEJx
        IrYiOAFkxDpI/OGqiK/ghwsnMYcbckwIaHNveJ4S0w==
X-Google-Smtp-Source: ABdhPJxYfUXFM+iKqXhXbTywYwmn9Khlzeo+cKheqXmeD90PcADvNxqnaj2q13pvIyXLd8v98tx/p5QVeBa5F0jQIVc=
X-Received: by 2002:a2e:9cc5:0:b0:239:da6e:290d with SMTP id
 g5-20020a2e9cc5000000b00239da6e290dmr18128143ljj.4.1645544983573; Tue, 22 Feb
 2022 07:49:43 -0800 (PST)
MIME-Version: 1.0
References: <20220210224933.379149-1-yury.norov@gmail.com> <20220210224933.379149-30-yury.norov@gmail.com>
 <CAPDyKFqvYhPTenGEH=LZyJXb5rJKbyeds4rH+aRN=u6JH_eJ5A@mail.gmail.com> <CAAH8bW9X4HGNDW9xY1zA8d0O0ty7kh_zcOKBDu88FL8uWEFAkA@mail.gmail.com>
In-Reply-To: <CAAH8bW9X4HGNDW9xY1zA8d0O0ty7kh_zcOKBDu88FL8uWEFAkA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 22 Feb 2022 16:49:06 +0100
Message-ID: <CAPDyKFrHo30Nak3aet1CgABH6_K6BuGq=C7O9Y3Vxk3FD8H9Fg@mail.gmail.com>
Subject: Re: [PATCH 29/49] memstick: replace bitmap_weight with
 bitmap_weight_eq where appropriate
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <david.laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org,
        Maxim Levitsky <maximlevitsky@gmail.com>,
        Alex Dubov <oakad@yahoo.com>, Jens Axboe <axboe@kernel.dk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Shubhankar Kuranagatti <shubhankarvk@gmail.com>,
        linux-mmc@vger.kernel.org,
        Shubhankar Kuranagatti <shubhankar.vk@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 17 Feb 2022 at 17:55, Yury Norov <yury.norov@gmail.com> wrote:
>
> On Thu, Feb 17, 2022 at 7:39 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Fri, 11 Feb 2022 at 00:55, Yury Norov <yury.norov@gmail.com> wrote:
> > >
> > > msb_validate_used_block_bitmap() calls bitmap_weight() to compare the
> > > weight of bitmap with a given number. We can do it more efficiently with
> > > bitmap_weight_eq because conditional bitmap_weight may stop traversing the
> > > bitmap earlier, as soon as condition is (or can't be) met.
> > >
> > > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> > > Acked-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > Acked-by: Shubhankar Kuranagatti <shubhankar.vk@gmail.com>
> >
> > Applied for next, thanks!
>
> Hi Ulf,
>
> This patch depends on patch 26/49 "bitmap: add bitmap_weight_{cmp, eq,
> gt, ge, lt, le} functions"
> from this series. Can you  make sure you applied them together? Or I can
> apply it later.

I can't apply them, unless there is an immutable branch being shared
between the different trees.

Therefore I have dropped the patch for now.

Kind regards
Uffe
