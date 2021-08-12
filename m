Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB80AC4338F
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 01:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A55CA60187
	for <linux-mmc@archiver.kernel.org>; Thu, 12 Aug 2021 01:23:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhHLBYR (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 11 Aug 2021 21:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233250AbhHLBYQ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Aug 2021 21:24:16 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373F7C061765;
        Wed, 11 Aug 2021 18:23:52 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id i7so6212733iow.1;
        Wed, 11 Aug 2021 18:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YRObm59cjW4mPv2dUb0C1++B3DtkugJeydgUsYgRRPM=;
        b=WHAlLg9ohkG813Q1TWwD7YRLqbWJO8dOX4v9wHAFZmcD1RZPyGeC1gpkgBfKxgJvw2
         EGGzFabxOOgs6JREgvq/WoAY/2WmEALv5+Y58bbBzVjMUZ0LurC9jxpjXZxu8mIvq/0k
         96YybilFkxL0fq5e0gKHrSw90URpZcgoaKXleG14U/X8ie0YEYvKsqV9+9o3oKBq43qG
         s8OlAg01Ui2E91xjfqDHbuc3Me5hwjJOAI5aRPSccEoOnfmWJVZlJQSO7HNJFEqoeSN6
         ka30FptXOr2FGryl5qJXdkzm24s7X5UGuRMihGracJN4wDs+syEzd/5YKmCe4DH/QhTV
         SDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YRObm59cjW4mPv2dUb0C1++B3DtkugJeydgUsYgRRPM=;
        b=d1a+vZnp7uSMiyj0Votwtj5vR9PHeQ04k13+moFYUzbUumekRPvj5FR3b2kHecpALd
         XaUareo3i+lPzgfUzDPab/EoW3u1Vk8bXs0ASlkelVNCU/plHbEYGOFncag88FwF/VpX
         X2u0RXTDRowk5CNgd5JxIAzctJpgjDmS2hCZy5DwJCo+nZG/lB4nQhRyv9uEDqbplSCF
         +SdQForSVKoQXKnAg/evl1M8tDRE2y/b4pcXnS7WpUUdYNz9nqOtJ6ccUI7xMK3yhDSf
         Lw2k5iP32exjTRO8oPrnVjfZEiepJSa4WHKqFZD/DU9M/M/rPWQtuTVW9Ao7hDIhGP1v
         MSpw==
X-Gm-Message-State: AOAM532ZHbGpX89VnYsSxuoHzV+9RPRxHWTVvAIuORPOM2jgTM7ttHFL
        KaTVpnK9bftDIQeuCVxLZht/JolF+4V9dCOfMQI=
X-Google-Smtp-Source: ABdhPJwac8bfGP0DN27pXt2mjduCWrdFapg50/Wx6BbbRcQxgeb5tHNgq9SdNaTU5BgumIVHbxbEGZ/qvGGXyo9L3XA=
X-Received: by 2002:a6b:cf15:: with SMTP id o21mr1116471ioa.132.1628731431579;
 Wed, 11 Aug 2021 18:23:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210719021755.883182-1-yury.norov@gmail.com> <20210719021755.883182-3-yury.norov@gmail.com>
 <YRN+dmd0lKtYNe5N@ninjato>
In-Reply-To: <YRN+dmd0lKtYNe5N@ninjato>
From:   Yury Norov <yury.norov@gmail.com>
Date:   Wed, 11 Aug 2021 18:23:40 -0700
Message-ID: <CAAH8bW-+-e+Qevcjiucqa0PtQwhFd+BGe=VH2QG9-12pZcGRJg@mail.gmail.com>
Subject: Re: [PATCH 2/4] bitmap: unify find_bit operations
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Yury Norov <yury.norov@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, linux-mmc@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Tejun Heo <tj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Dennis Zhou <dennis@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 11, 2021 at 12:38 AM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
>
> On Sun, Jul 18, 2021 at 07:17:53PM -0700, Yury Norov wrote:
> > bitmap_for_each_{set,clear}_region() are similar to for_each_bit()
> > macros in include/linux/find.h, but interface and implementation
> > of them are different.
> >
> > This patch adds for_each_bitrange() macros and drops unused
> > bitmap_*_region() API in sake of unification.
> >
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
>
> I fetched your bitmap-20210716 branch and tested it on a Renesas
> Salvator-XS board with an R-Car M3-N SoC with some debug output added.
> Still works and values make sense, so:
>
> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thank you Wolfram for looking into this. I'll resend all the series
this weekend.
