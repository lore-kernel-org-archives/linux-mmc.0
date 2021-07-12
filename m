Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DFBDC07E9C
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Jul 2021 19:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5441A6120A
	for <linux-mmc@archiver.kernel.org>; Mon, 12 Jul 2021 19:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234973AbhGLT13 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 12 Jul 2021 15:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236190AbhGLT13 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 12 Jul 2021 15:27:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21051C0613E5
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jul 2021 12:24:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id go30so9637261ejc.8
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jul 2021 12:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r3C0MNcdPuaQMoy2DZLesW5CVXpDYfQzTqrwGXdHaRg=;
        b=MJrdQt/xj/X89L2akDuRIxLQO4djMTLLgU8eBvU6YVC8dUlC07Y6kHh4rBlkT1q7MV
         Ea7nnfbhd2stzRZFtdTC0KqSjngvfVy93JncJKAiLwNmjmfcozdphfyI2xTiy3uOptFv
         Vhn12vpbGZd8c3Bo7seoaaiJzsRoQUlb47+hA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r3C0MNcdPuaQMoy2DZLesW5CVXpDYfQzTqrwGXdHaRg=;
        b=hIQ6uxQXqGbkxZhBiIEN5306sYjY1ISrjYUIT9L/J+IOnb4cIAO7/T9Vd4Ym3pMIfi
         Om5PPgQ7m46z5zAO6UkizOtcDmUNmsbVuBhqr5Yy4yj8lY7jMgonQycD5v1s3jeKnlnI
         ERE8ZNLu9G776wB+5RxUs6kT8EzjEg7w8sgOq4H+Krh3UhEB0uPHqqhrqffaanUFbSh2
         V01+KNh/RvjUfbIyCfqlM+NOJ3DHWgw2rXXwjzV3xrzd0pVIcrtkZzNN1BZjVJEvIm18
         0/UxzYGJfHhYo7BeWUwWsf8CJ/MbYFlNc/cavExFGW+CtW16Eep/3AAQ7tw/XqZwwT6Y
         PqYA==
X-Gm-Message-State: AOAM5305mnFuZXE0dUdRdz4jKeNOOlL97+5yi4nqfAbZ+FcBvKGtAY3I
        5HwTAuFucMDO0qJIBBnU2AmO3rnq/7xEpwSszRQ=
X-Google-Smtp-Source: ABdhPJzdUv4Ws35m/w5LNt4HIXHL9VfxxROt0VspWx+n/uvSto+yIysji15jvGs0mOiHDRTecCjPuA==
X-Received: by 2002:a17:906:6d8e:: with SMTP id h14mr753402ejt.128.1626117878508;
        Mon, 12 Jul 2021 12:24:38 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id v13sm1815017ejh.62.2021.07.12.12.24.38
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:24:38 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id ga14so21718149ejc.6
        for <linux-mmc@vger.kernel.org>; Mon, 12 Jul 2021 12:24:38 -0700 (PDT)
X-Received: by 2002:a2e:9241:: with SMTP id v1mr639513ljg.48.1626117867421;
 Mon, 12 Jul 2021 12:24:27 -0700 (PDT)
MIME-Version: 1.0
References: <20210712060928.4161649-1-hch@lst.de>
In-Reply-To: <20210712060928.4161649-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 12:24:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=whd0GaAH7gHuEiuKjOeD6JGKY1q5ydG1TCKjVBFNBUEJA@mail.gmail.com>
Message-ID: <CAHk-=whd0GaAH7gHuEiuKjOeD6JGKY1q5ydG1TCKjVBFNBUEJA@mail.gmail.com>
Subject: Re: flush_kernel_dcache_page fixes and removal
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Russell King <linux@armlinux.org.uk>,
        Guo Ren <guoren@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Nick Hu <nickhu@andestech.com>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Helge Deller <deller@gmx.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Geoff Levand <geoff@infradead.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Alex Shi <alexs@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-csky@vger.kernel.org,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        linux-parisc@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        linux-mmc@vger.kernel.org, linux-scsi <linux-scsi@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sun, Jul 11, 2021 at 11:09 PM Christoph Hellwig <hch@lst.de> wrote:
>
> I think we should just remove it and eat the very minor overhead in
> exec rather than confusing poor driver writers.

Ack.

I think architectures that have virtual caches might want to think
about this patch a bit more, but on the whole I can't argue against
the "it's badly documented and misused".

No sane architecture will care, since dcache will be coherent (there
are more issues on the I$ side, but that's a different issue)

              Linus
