Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A9CC07E95
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 13:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC28961C89
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Jul 2021 13:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231357AbhGGNwi (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Jul 2021 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhGGNwi (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Jul 2021 09:52:38 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E86C061574;
        Wed,  7 Jul 2021 06:49:57 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id s4so1934084qkm.13;
        Wed, 07 Jul 2021 06:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xM/HXB6EZ/kjhqMXjRqn3qykSAZCYos8ehhLN3+dqMw=;
        b=r7KTDuXU6VaXhTMjpH4J0bEEV5/S+w5Jf/K3fOExF6GWFS4BObJ6P3qUWutP93lWO4
         74OnjHLrjsLztkS8+zPIq7RVg9EAmy+5qKCbnoFA1Gz7uuVHsrbPv/zqozo6fPO1+hyU
         QX39Xnr5vVk9DRgG2y3ub+t9p2xKONBNgOWfuDHaCxLxjVq/EBvKPf7GFqZeCfCzwxXj
         Pg4QwKRZnXZhbezwuAT2U+YOKW4dNfEWJkZNTP1aIkc7VXumCcMD8Kn7n75CcXYUkflL
         tv3WOq9Tdt8W019UYt6xWY/Ssa4pydqGdnQ89yyDNY+wFyDhBmxVLalXheL1tuLTg+s7
         6wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xM/HXB6EZ/kjhqMXjRqn3qykSAZCYos8ehhLN3+dqMw=;
        b=mroY6AySYZ+a69b9x0tFQJyWT+gk1qHX2NZv2O0J04mT83Bahfjp9uwoJEmHc8xyeE
         0gPyXgH/ibzbWe21qwhlGP8zP3RFhOY1KnM0zyYKx72VeK+/HYdBoPbAK2O0nowQHxju
         seKncH2opPzmPp7NOGwVT/PxNXrkA5cgdCqbhNlezb0NmFocET6BXSraEFqBSM9qe8Ic
         MrQdwQgfVLCtb/HQ4sMXKdii9t6z0UypXfesw36I2Dd4Q45fM338f/ghvShxuoVGgTph
         FLcuvNYRdXuYYyKCAo9cNiFHpY/MI8yRK7XUE3z1Zb47txUCV4F9CaIFsGiKpsCxHe4q
         eVbg==
X-Gm-Message-State: AOAM533hxIYrwwp2Qe4h9beTWUCyKrVVXlMVV2dctrwwXejn1G4+TqZ9
        BEnbPxx1kLBhSSUFF1zY1qgSg9kWngE3fyGQATs=
X-Google-Smtp-Source: ABdhPJyMPgR14Ps1NHWI9dQrwjkry7w+R2XGt2J19etYiWw1kINueBUM3kk1n/jXWfdzY+Yjp6x3QpjUn122tsIfV7s=
X-Received: by 2002:a05:620a:13ec:: with SMTP id h12mr9480677qkl.217.1625665796840;
 Wed, 07 Jul 2021 06:49:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210705090050.15077-1-reniuschengl@gmail.com>
 <CAPDyKFotmw-HQpZKCOD_8kThEa0_KSPnn36FNFLKRyUHYRHQjQ@mail.gmail.com>
 <CAJU4x8u8JPBJ3V6MCi1XcO4Qim-COPuxOhTdUnor7JdNCUFb=w@mail.gmail.com>
 <CAPDyKFqXsn91BvkJXMYSnc7X=RP9DXxXp2nKMmv+aMPoNdK2Tw@mail.gmail.com>
 <CAJU4x8srB7skGFVcj1SPrzEZSnVkwKiW3OPN0GQxvgtRG7GAAQ@mail.gmail.com>
 <CAPDyKFq0yHxX7wb4XGeiMiSGGiOf8RKJ5ahhFQ+_vodqnyPV9Q@mail.gmail.com>
 <CAJU4x8uGxb5VD1WVV5-QeLkVzuuR09-NacL-9nuXe8Zofzb2=w@mail.gmail.com>
 <CAPDyKFpvCFYQVEp77hiRHY6CVDej-ffF5UE=LH=HSGcqMZA02w@mail.gmail.com>
 <CAJU4x8t+aOqq82EJMUNDpWiE3GPeyZkjFhy=AkmctcDE3mx6fA@mail.gmail.com> <CAPDyKFoSOk+4pmW60uGzKaYw3XOXshx+NSNqF_po=VLkK1-7Qw@mail.gmail.com>
In-Reply-To: <CAPDyKFoSOk+4pmW60uGzKaYw3XOXshx+NSNqF_po=VLkK1-7Qw@mail.gmail.com>
From:   Renius Chen <reniuschengl@gmail.com>
Date:   Wed, 7 Jul 2021 21:49:45 +0800
Message-ID: <CAJU4x8sMJSOnfBwDq7tVygRGFRw-SyrM1z8GBsF_Mur64-Y3_g@mail.gmail.com>
Subject: Re: [PATCH] [v2] mmc: sdhci-pci-gli: Improve Random 4K Read
 Performance of GL9763E
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ben Chuang <Ben.Chuang@genesyslogic.com.tw>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Ulf Hansson <ulf.hansson@linaro.org> =E6=96=BC 2021=E5=B9=B47=E6=9C=887=E6=
=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=888:16=E5=AF=AB=E9=81=93=EF=BC=9A
>
> [...]
>
> >
> > Thanks, I understand what you mean.
> >
> > I simply searched for the keyword "MMC_READ_MULTIPLE_BLOCK" in the
> > drivers/mmc/host folder, and found that in some SD/MMC host controller
> > driver codes such as alcor.c, cavium.c, ...etc, there are also
> > behaviors for monitoring the request in their driver. What's the
> > difference between theirs and ours?
>
> Those checks are there to allow the HWs to be supported properly.
>
> >
> > And if the code that monitors the requstes does not belong the driver,
> > where should I implement the code and how to add some functions only
> > for GL9763e in that place, in your opinion?
>
> Honestly, I am not sure what suits your use case best.
>
> So far we have used runtime PM with a default auto suspend timeout, in
> combination with dev PM Qos. In other words, run as fast as possible
> to complete the requests in the queue then go back to idle and enter a
> low power state. Clearly, that seems not to be sufficient for your use
> case, sorry.
>
Yes, the runtime PM, auto suspend, and PM Qos are all about the
suspend/resume behaviors of the system or related to power states such
as D0/D3 of the device. But these are totally different from the ASPM
L0s/L1 for link states. Entering/exiting the ASPM is pure hardware
behavior on the link layer and is not handled by any codes in
drivers/mmc/core or drivers/mmc/host. We'd like to try to modify the
patch by your opinions, but we are also confused about what or where
suits our use case best. So we wonder how to start the modification
and may need some suggestions to deal with the work, sorry.

Thank you.


Best regards,

Renius


> Kind regards
> Uffe
