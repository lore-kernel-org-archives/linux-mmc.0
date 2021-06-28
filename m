Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D7BC49EAB
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 07:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B316861C51
	for <linux-mmc@archiver.kernel.org>; Mon, 28 Jun 2021 07:49:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhF1HwM (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 28 Jun 2021 03:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbhF1HwK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Jun 2021 03:52:10 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 260AFC061766
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2021 00:49:45 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id e7so6601965uaj.11
        for <linux-mmc@vger.kernel.org>; Mon, 28 Jun 2021 00:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SpDL1yFtnBlqCZuK3CHLVZzWipOCqhkoV76MfrS+XPw=;
        b=A5/4xK8X5ZR9E6P0cb6x18jpF/MTNKiIOalvBQM5I6HhZXFVSz2dSXs0cAiVXGV0aA
         sJJACsN13TmWPg8rDJl4YEJZne/raXh78ys4/AQLdqRaWpdK0t8jr1RJLd1cvu8DjxiQ
         g9M8adyqxjEqoYCD7CKDM8jhlwgpri6pDL1JP4nhOGGuzG5dY/ylyD6Co/yJGl1eIlow
         fnlKTZoOUSHMzON7o4f61g7JQJfTZdINfFKd8Ic7FY0KFoxeBgmmqZ7ZQv7bQhA2ahA5
         81IsTLQ30fVZkW2Z4RwWJjmv0y40jADbq08AkUwX1hBCZ1h++xpmXsPn5hWaCKqr+PaJ
         SIBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SpDL1yFtnBlqCZuK3CHLVZzWipOCqhkoV76MfrS+XPw=;
        b=gRue0GVZi8HfbsJ86EwPiyn+c6cjNgYoB8RfIRvVjelrNZYGUTYyrHB22f2nkpKnUx
         22TNIBNBHT0vgi2MFa9x1G927RlhkTi58VlmjGM7rhvXgxpqRONPaRhbLZmXD3YpqKTL
         hpaNn484/K+AyNWCambXekH0H41AZGD7WZJMyVlG4L9zNGkzR5ZRHOdhkX/xCbeYyG85
         wPz4QURaboPj9E+7xqZ4KTTy1y0g8luOYSHuf+268IbjQ7CKgBneh5084gR8KABvTZjj
         M9Tj9xVQZEQxaP8MkfJhl1n6eqQVmhrF9olT0k1+mFQbH/LydubdcsUM3uGzvbwuJRI7
         sF2g==
X-Gm-Message-State: AOAM531onyy0NIkvTu26YelbzrM0CjiqpEFBehknZ8hSAvuImlV6em3l
        1/k8NjQiOIuddNwP/KqNYFOUOJZ/R3f8tEYdcJgM5w==
X-Google-Smtp-Source: ABdhPJwUdpg7JYcrOq4EEhy5BIfAtqS1t34Bu6KnY7BMgxcOojDtQELRD0HYCUiNtgyLQ6rB4dvjQDmC00Zf/FXrgBM=
X-Received: by 2002:ab0:484b:: with SMTP id c11mr19690937uad.100.1624866583711;
 Mon, 28 Jun 2021 00:49:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210624123251.191299-1-ulf.hansson@linaro.org> <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
In-Reply-To: <CAHk-=whn_yTjV=YAU4xMBkLEb+E76zUKM_Xy5ZwMp_504wqR9A@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 28 Jun 2021 09:49:07 +0200
Message-ID: <CAPDyKFrLSMpPJOgd5e4B1x3Vwfg4q23zgy4ESc8EmFL2MnyK7g@mail.gmail.com>
Subject: Re: [GIT PULL] MMC fixes for v5.13-rc8
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

+ Neil, Robin

On Thu, 24 Jun 2021 at 20:00, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Jun 24, 2021 at 5:32 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Neil Armstrong (1):
> >       mmc: meson-gx: use memcpy_to/fromio for dram-access-quirk
>
> Ugh. How horribly ugly.
>
> Why is that 'host->dram_access_quirk' test _inside_ the loop, rather
> than be something like
>
>         if (host->dram_access_quirk)
>                 return sg_copy_to_buffer(data->sg, data->sg_len,
>                                 host->bounce_buf, xfer_bytes);
>
> at the top of the function, with meson_mmc_copy_buffer() then only
> handling the mmio case?
>
> No, I don't know this code, I'm just looking at the patch and going
> "that looks really ugly".
>
> Anyway, I've pulled it, but I thought I'd voice my reaction to it..

Thanks, good point!

Robin and Neil did discuss some cleanup that could be made on top [1],
but it looks like that was targeting a different part.

In any case, Neil, would you mind sending a cleanup according to the
comment from Linus?

Kind regards
Uffe

[1]
https://www.spinics.net/lists/arm-kernel/msg901045.html
