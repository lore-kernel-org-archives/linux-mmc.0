Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0203DC433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 18:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEB2460FC3
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 18:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJ2SHm (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 14:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhJ2SHl (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 14:07:41 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E54C061714
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 11:05:12 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 188so18180374ljj.4
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 11:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K6KCBeD/pNCG9HZQnIVtuH+wCZVkgQgovkR8K6qXsz0=;
        b=DK+Tp3O/3gtk6Mj6EirsKfvX8mAe0+szIVxVBHJaMcoxLOtuvV48Rqi0Ta0I9gUMTR
         F0btd8b3EQOXM97fEoJPbO3hLFaaM//stWMVDGe6zk5xsGZmTRz6EQE2YKHKyw7CXr/F
         N8UoFNI/13+/GBJUOvYX4fRekOCCnOhfYNR30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K6KCBeD/pNCG9HZQnIVtuH+wCZVkgQgovkR8K6qXsz0=;
        b=p97/N0xVoJpBDqsT0HODOD3MlGXEbbq1D+Wv7kLoNCAHPv99ISiW5VO0+jXfri2Dxw
         w7LNiKot+gmPKMp4Yhk3zW0mpnDy0Dty8MFd+9bv5WrEmrvYZ8aSdFntJrZytFDogpXy
         9lbRobp8KZEUUEaDwUdiDXR1CoxqR+NxZR04btArv2DPKgbGzHoEUdCqE/OEXRwejuZD
         yIgs/DtQy5HRWwzTOWESfc56Fl17mf6j1l4dTEyrB73jAZ6e9kG1oAQQ4f+YTDVB5gYK
         8UDNLFe8wWtkKbqvh+Z74CAEd+VIx1d3CryZFWb/+zrkkHUYxDpQH/FNi43RtgTA5H20
         +o9A==
X-Gm-Message-State: AOAM532iEELAPYvzk/D++g3hxBeYLHbkQ/iSlkL6TU475rfng9NQdSBi
        t6+ZaWcS6rA6QOByi1Eb3DbPIVkJqmlxAKGqjj4=
X-Google-Smtp-Source: ABdhPJw2NUAwCwUTe5J/SsXZfzYPA/mxPS91jSIRSoEajBuJ7SYEQ22MpFZJWxtypP1wykew6S4Mlg==
X-Received: by 2002:a2e:888a:: with SMTP id k10mr13223506lji.329.1635530710344;
        Fri, 29 Oct 2021 11:05:10 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id q20sm651187ljp.61.2021.10.29.11.05.09
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 11:05:10 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id p16so22659945lfa.2
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 11:05:09 -0700 (PDT)
X-Received: by 2002:a05:6512:3993:: with SMTP id j19mr9826124lfu.402.1635530709299;
 Fri, 29 Oct 2021 11:05:09 -0700 (PDT)
MIME-Version: 1.0
References: <20211029120709.79366-1-ulf.hansson@linaro.org>
In-Reply-To: <20211029120709.79366-1-ulf.hansson@linaro.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 Oct 2021 11:04:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgQLtvDh-3zhGNCWNAssubDxgxC+7RdEmHBmK_84rLT2Q@mail.gmail.com>
Message-ID: <CAHk-=wgQLtvDh-3zhGNCWNAssubDxgxC+7RdEmHBmK_84rLT2Q@mail.gmail.com>
Subject: Re: [GIT PULL] MMC fixes for v5.15-rc8
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mmc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Oct 29, 2021 at 5:07 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
>  - winbond: Silences build errors on M68K

I think this one is wrong.

I think the problem is that m68k declares "claim_dma_lock()" in the
wrong header file. It's in <asm/floppy.h> instead of <asm/dma.h>

I'm somewhat surprised that this doesn't hit m68k in other places -
there are other drivers that use that same ISA DMA interface.

I've pulled this, but I hate how random that fix is.

(And on the topic of hate - the merge messages are just auto-munged
from the commit line - please spend a _bit_ more time on it, ok? Or at
least make it closer to proper English - things like "Re-enable card
irqs after a reset in tmio driver" instead of "tmio: Re-enable card
irqs after a reset")

              Linus
