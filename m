Return-Path: <SRS0=CvS5=DC=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB459C4363D
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 11:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6EA21741
	for <linux-mmc@archiver.kernel.org>; Fri, 25 Sep 2020 11:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="idF0RM6F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbgIYLcP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 25 Sep 2020 07:32:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728147AbgIYLcM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Sep 2020 07:32:12 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E78C0613D3
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2020 04:32:10 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id 5so1183226vsu.5
        for <linux-mmc@vger.kernel.org>; Fri, 25 Sep 2020 04:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AK2xKBf38jIncqQXUOXzr0Q8nKbCDFfcVqsOZ+AQjKg=;
        b=idF0RM6FwWTHjL2Ru7MruW/e3XuePPBoSAnUfI4a9V8Wp4GpJvFwSdpyGWpT+ezNFY
         tYkNpv7jSxYZT+Dd4l/z7o5X5aMHWYN/V3lWY/VyDbXgusLr58p/hb8fq65Lyeua085B
         uX2udX5vudKVA98Bj6wqJJxfjsI9NOOCBqh4cKZI3N7FqizofE+JtFUR3Wz1me1TsYIo
         GqWyatlyxM7OmULaHYA+RnTc2gsulG7VjqoWZI0g4AIltaCXCpvLQ8xNnPve6eJkXVIM
         V+P8eq9OAh6gbdiuAN5/NSkpsNScN2j2qwE2IukOWAqNbrWFKYmd5hob3scEMb4Aj4t9
         UGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AK2xKBf38jIncqQXUOXzr0Q8nKbCDFfcVqsOZ+AQjKg=;
        b=ktF4a3GbVWrBmMhARGSnU07w/1ZpxFL3ojR3YmGmJmyjhKS72hpAXskdF35gNGfXnE
         2xzFQTww7EA0Gu/iONglq8K7SsavdLc1kLPJPXMEmdY3F8EgAfMrTOgCPvuxhrNk3TH9
         Ri5OghXEhD1cDJXBQj4cOxjiAjdaVjZU5L6TG34/BJJpcqMu/SNlUMlRaIPHeCaWRPF6
         Aw+pOACziOa1FxFK2ouJsCFTbj2rBzhgJoHaIy3be2O+kjbe0/hLAFbM78T/nGqYK2A9
         wzlk3U4cVhjVxNRJ7CS2EXlg9iV6UbUHVHP4189sruCii2Un4646ZeugGLtkLIOCgnli
         Hmrw==
X-Gm-Message-State: AOAM533iREYkB7ZjdcXh++aoQqGLJhqv9BezKvMYtzXiGv3u7KAKLqqX
        o0cFwPvwdVMQjsZ7Ay7o1jVgam9nMiyFHWVkuvRq8w==
X-Google-Smtp-Source: ABdhPJzORGOUPeovrlLq8j/6gekYRvr8WIFO0ittDHW239GvqKPogB4tMqMM/C6nkXvUbLm/1SwTcy+FqOClu3SIAF8=
X-Received: by 2002:a67:2e54:: with SMTP id u81mr2304621vsu.55.1601033529627;
 Fri, 25 Sep 2020 04:32:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200920204907.225287-1-ameynarkhede03@gmail.com> <CAPDyKFo7TeKFXLcNJFPoJqWsBsNySjeQrbb2+KRjO=jib+1jJA@mail.gmail.com>
In-Reply-To: <CAPDyKFo7TeKFXLcNJFPoJqWsBsNySjeQrbb2+KRjO=jib+1jJA@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 25 Sep 2020 13:31:32 +0200
Message-ID: <CAPDyKFo-FHGs7Po5naNwhe9xEGfxfdJo2gnddpfOJ73YzTFTyA@mail.gmail.com>
Subject: Re: [PATCH] mmc: davinci: Drop pointer to mmc_host from mmc_davinci_host
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        =?UTF-8?B?TWljaGHFgiBNaXJvc8WCYXc=?= <mirq-linux@rere.qmqm.pl>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 24 Sep 2020 at 14:49, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Sun, 20 Sep 2020 at 22:51, Amey Narkhede <ameynarkhede03@gmail.com> wrote:
> >
> > The TI DaVinci MMC host driver uses a pointer to get from
> > the private mmc_davinci_host structure to generic mmc_host
> > structure. However mmc_host always immediately precedes
> > mmc_davinci_host in memory hence get the address of that
> > mmc_host structure using mmc_from_priv() which performs
> > subtraction(which is cheaper than a dereference) and drop
> > the unnecessary pointer.
> >
> > Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
>
> Applied for next, thanks!

Turned out that this one did cause build errors, so I have dropped it
from my next branch.

Please re-spin a v2 and make sure to run a build test before you submit again.

[...]

Kind regards
Uffe
