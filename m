Return-Path: <SRS0=ACzm=CR=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 290DFC43461
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8226206B8
	for <linux-mmc@archiver.kernel.org>; Tue,  8 Sep 2020 16:40:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Umg5s4XG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731933AbgIHQkk (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 8 Sep 2020 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbgIHQhZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Sep 2020 12:37:25 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBCDC061A15
        for <linux-mmc@vger.kernel.org>; Tue,  8 Sep 2020 07:05:13 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id q124so4077484vkb.8
        for <linux-mmc@vger.kernel.org>; Tue, 08 Sep 2020 07:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2HixXsh/i4wRCywM25LOVRxdnOWqFN3Kihr7kBnUMtY=;
        b=Umg5s4XGDLznycAi8eh3KtIX3m/oKtp6PBGSTVFjm7nPG0PzyocKEQjfQbViNtgt6I
         QxIgERNOf1BRZ8Pzy7dKqTR1mxD0PRsaQDxt/Lskbs2XBnMH6CrW44ckTiUeQ8ahPWp5
         usSKEXBHPMB6fQqY2bE8e846MfWT9ORMjPy1y9xwzPLOmUNEPTxH00oHYyN8o3ErzJ7J
         xfXs3/5LsOsSwHOprzXBbuQvP8wVowP4r6Rrh+qyH7YYWGHpJieJ6HcTHC0PN0tbUfmp
         qNxRnDpqEytvs0irOFVodOaDL1davKeln4mFmPEnK3FGsbdyi6Bu8FURjTOf6iBSePHJ
         /h/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2HixXsh/i4wRCywM25LOVRxdnOWqFN3Kihr7kBnUMtY=;
        b=l04nBe/tBLjbSmZlY8pJwNW6ocQSAh8gVHqpkdrSxu/tBgAwvYgCylFecGGuWhNYAq
         W6yrvczBQN+imSPGvNXYxP8I4lDA5qzVyx9TxVCjxXsBf6Mau7ba//6YfsxCYAjaY9CU
         3w9pqVnphjMiNJmW0dOJr/ekl6+sMZ4JIJzJAxSuyEKhpNhvKlsnVYSrAT6xY5oudE5y
         sTap6G79VsCJPvtrXQfLw+PO1pFwOn/+xgRrwbWCokYSzR+2wlzmW0b6p0hcLkw6yNJH
         SZKkOOt30dhHsFcLtEmDpF5oYuQJw5TzkM/y7G3WfRV0m1IQMYcKlAi1xpv7G7R1ABb3
         fTTQ==
X-Gm-Message-State: AOAM5311wLiQesGKA1VinemxmDOJbAQ4MO+8t81z489LJig8IkdJBCef
        9+ZJuQUhSXVok6UR3EAZrr36g+1pXsVk/Dwg2wy8nw==
X-Google-Smtp-Source: ABdhPJzHAWTtWKl8RajuaXPJ34COnitX9tlxj7uZpYUFpoCPWWh1/3+3qdqIQRa4D9eojHDxNa4cEAC0yvvWGVjYPS8=
X-Received: by 2002:a1f:a596:: with SMTP id o144mr15011532vke.39.1599573911839;
 Tue, 08 Sep 2020 07:05:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200907105254.31097-1-krzk@kernel.org> <CAPDyKFowS-psoJqVUChU35Xp92nrvH5r5eY=_8bMKU0SVBxLcw@mail.gmail.com>
 <CAJKOXPdX7UOkTNMVS_uLi7sG_h0bHCs_b6R0uL2B241y_+niqg@mail.gmail.com>
In-Reply-To: <CAJKOXPdX7UOkTNMVS_uLi7sG_h0bHCs_b6R0uL2B241y_+niqg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 8 Sep 2020 16:04:35 +0200
Message-ID: <CAPDyKFoytD2mgQD3qPeDL2zRuOPMrS9TaGGu8R=j+z=zcYKNnw@mail.gmail.com>
Subject: Re: [PATCH v3] mmc: host: Enable compile testing of multiple drivers
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 8 Sep 2020 at 15:57, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Tue, 8 Sep 2020 at 15:54, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > + Arnd
> >
> > On Mon, 7 Sep 2020 at 12:53, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > Multiple MMC host controller driver can be compile tested as they do not
> > > depend on architecture specific headers.
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> >
> > It seems like this is causing build errors for my next branch when
> > running allmod config [1].
> >
> > [...]
> >
> > >
> > >  config MMC_S3C
> > >         tristate "Samsung S3C SD/MMC Card Interface support"
> > > -       depends on ARCH_S3C24XX
> > > +       depends on ARCH_S3C24XX || COMPILE_TEST
> > >         depends on S3C24XX_DMAC
> > >         help
> > >           This selects a driver for the MCI interface found in
> >
> > [...]
> >
> > The problem doesn't exist in linux-next, since it has the
> > corresponding cleanup/rework patches for MMC_S3C from Arnd.
> >
> > To fix the problem, we should probably remove COMPILE_TEST for
> > MMC_S3C, for now. Then we can add it again and send it as a fix for
> > v5.10-rc1.
> >
> > What do you think?
>
> Yes, better to remove it otherwise it will pop up when Linus merges
> your tree. Do you want a patch for this or you fix it up by yourself?

I posted a patch, applying it on top. No worries.

Kind regards
Uffe
