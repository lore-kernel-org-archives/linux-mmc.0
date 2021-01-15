Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF9D4C433DB
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 22:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A17A423A6C
	for <linux-mmc@archiver.kernel.org>; Fri, 15 Jan 2021 22:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726172AbhAOWus (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 Jan 2021 17:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbhAOWur (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 Jan 2021 17:50:47 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29048C0613D3
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 14:50:07 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id v67so15539265lfa.0
        for <linux-mmc@vger.kernel.org>; Fri, 15 Jan 2021 14:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9KSr8/xWSCyHW7tN9xnYcCbpuAtDjpL1+6SsF6x/c8=;
        b=m0G/IYzZj3G7d8stfAQn9ESWdEifj4TTtPEV1mAA6XZixfSweCE/9vFz9AI/zkVHOi
         h2maiRt5yA8tL/AuQ8CzG0stziso5ZC1tKUpMTrqugyG1suaHt0t+YJtNsREYarAT2u0
         ikMzgiAzmms1fYZ3wRF84D8dcE4V05U40k1I5g4Hk8AXcHtjZY+1f1pWKq7xMQ0YxmP9
         jhF0W3YFwtW1XQ6dY28BnVo+jY1uc4hLT+Q1EJx43JXr1MxF6r/JDtjUMVqhk6elRmua
         qgocTuvk3N0qAxet5KZsYLooYRD5wKCmfihh6zwIYjxgQ/b5jOQIo56LxceGu4BuNGoA
         imhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9KSr8/xWSCyHW7tN9xnYcCbpuAtDjpL1+6SsF6x/c8=;
        b=RWsQDvLeL8z7qVkkP2wTVr36lGjqac29BjxQdUDTa8Hhbahh08uNkVq27UsN93YVVI
         LgiANHNEHUYpDJxuz1P/EjpcuPeOeQWNMcocOfYDspm7dqp/uK9EHDY0B7s3u/NvMOBn
         KkjFaQL9TIY7YSleLzKZZFbAMsvSq6BMnIzlIBTICoOTAP6rkE0Uy6zDamZrYvExdiXh
         /Z3L7sFotfSQ9UC/L36v2cmJvxR1cI7bS8F9t6iUIT/omJ9d0d9KJue3dhC+xljvLtWo
         y/DTrBRGVvfdKenCPw6hQJdVan3/PeY3JzfF+75jUeCb93N5w/vkDjCUjNGxqilE3lzZ
         F+WQ==
X-Gm-Message-State: AOAM530VemWyYXavFv0xw/crAs/3H37UtUL+13MiyOcKDlEkbDLKkMYv
        E645t/w4YcvXwPBqGvKUHTo+IEa38ACun7wD9+Q3TysBEy8=
X-Google-Smtp-Source: ABdhPJwlRs6Es/A2YqSiBPXLgGTbo0FkuYbgKqGxUpEC1Rcbcg7AwYKokJ8VGaSpGDmS90BJvJCL9sTpvN3hSQwD5Rk=
X-Received: by 2002:a19:6557:: with SMTP id c23mr6095888lfj.157.1610751005247;
 Fri, 15 Jan 2021 14:50:05 -0800 (PST)
MIME-Version: 1.0
References: <20210105140718.122752-1-marex@denx.de> <CAPDyKFoQfm2ZtPdsZSZtOCDH-FJqNzihYqZny-vUdK4Q4tWTzQ@mail.gmail.com>
 <b83c1112-010b-a40f-319f-84c755424b0f@denx.de> <CAPDyKFo5Sqxj31owrnmz1sTZqgW_PtZM2H=pDPBz+9hc0W0hHA@mail.gmail.com>
 <77dd612b-23f0-1f77-797a-9cde512926e3@denx.de> <f91fbdfc-453d-78a6-970a-5d6eecd443b2@foss.st.com>
 <ccef7ae4-8cd7-4434-9632-917a4fb92f53@denx.de> <ad4a108e-81f1-daf5-9921-9884ed06d237@foss.st.com>
In-Reply-To: <ad4a108e-81f1-daf5-9921-9884ed06d237@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 15 Jan 2021 23:49:54 +0100
Message-ID: <CACRpkdY=n_-5giDVyqvSbCF7wy_-Xf7RfOrQbxrCQ+jC9b2rXw@mail.gmail.com>
Subject: Re: [Linux-stm32] [PATCH] [RFC] mmc: mmci: Add support for probing
 bus voltage level translator
To:     Yann GAUTIER <yann.gautier@foss.st.com>
Cc:     Marek Vasut <marex@denx.de>, Ulf Hansson <ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Jan 14, 2021 at 11:13 AM Yann GAUTIER <yann.gautier@foss.st.com> wrote:
> On 1/13/21 3:45 PM, Marek Vasut wrote:
> > On 1/13/21 3:21 PM, Yann GAUTIER wrote:
> >> On 1/13/21 12:52 PM, Marek Vasut wrote:

> >> I also wonder if this HW detection should be done in kernel, or if it
> >> should be done in Bootloader. But it may be more complex, to add the
> >> st,use_ckin in kernel DT if bootloader detects this translator.
> >
> > Lets not attempt to hide inobvious functionality in bootloaders, the
> > kernel should be independent of bootloader where possible. And here it
> > is clearly and easily possible.
>
> OK for this part, I understand it will be better not to hide this in
> bootloader.

We all agree. I am against bootloaderism, the tendency to toss all
complex hardware detection over the wall and call it
a bootloader problem.

Let's proceed with Marek's solution.

Yours,
Linus Walleij
