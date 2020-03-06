Return-Path: <SRS0=VpFb=4X=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD700C10DCE
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 14:02:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B09E520848
	for <linux-mmc@archiver.kernel.org>; Fri,  6 Mar 2020 14:02:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="altekUg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbgCFOCu (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 6 Mar 2020 09:02:50 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:39026 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726194AbgCFOCu (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 6 Mar 2020 09:02:50 -0500
Received: by mail-vk1-f194.google.com with SMTP id t129so619290vkg.6
        for <linux-mmc@vger.kernel.org>; Fri, 06 Mar 2020 06:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LmmLgOu4yNtKTtubKabl6i16xh9uv6w9PYdCV3ZHy6s=;
        b=altekUg7NG0QUQu8zkg6qyEXqFdE37IKZZCSKeW9C6eryBU3XqvWiPkHi4dZ3YO2ux
         3i970ejWlcORYYjbbb2x4UvmEARSxjWfYrBS5/g1z5j2g6LL8b9OLfgmMLr8NhvzY/BN
         BRtHKQEbIwYNX3D9BeQPwl2bSq8WEaplQKhYVEr6ofFUXsSBT3qyVILr6kWdPNF9y6b5
         p7cHJp1NlO0x2qsCtap3wT5XV8T4Ci9vyh45dCuy9wC9XtyXWT2fpI7iwOlLFrjPDEaB
         jkg4uQ7A1YeUWCEq1PAGCavj+o43DnGGmKqLyl5Tbk9oHjv/a2GTesC1ml6Un/ubCNq/
         z3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LmmLgOu4yNtKTtubKabl6i16xh9uv6w9PYdCV3ZHy6s=;
        b=iWOmRYQ1v0ZttOzn9Mv/vRlg8kCvVjdX09LiUlk9VBYJ6Qd1Lptd2dm2EDNGJB0Uj5
         UWx99z0cKcwA93aR9fiRH6NMacnch9Dvqim2IzZw0ZqJ87xSYTWken76xeQGm96/0klE
         NXjXqCcrq97+jccUI4V2RZcRwwddFtXLAF6uCM4YPOiJnCn5dRQZuDK5RJZPC03cJho2
         fCBqvtOz8r7h7mAZ4avqNhFkkfJ/lF7K4w/3Au2TZRpzPkOf7HLBVj6NQaIX86dH7NCL
         svKKSfcnjfb+s7S1gMH+dnWCkqDh0xnuqsNKZsxlIArqltgk+/+kr+IOukUuPLbAuwe7
         6U4w==
X-Gm-Message-State: ANhLgQ1T8PBgEANGyOe3P9jCyA6WOtBGlzoHXtbLxmpjCkleP8M1bFvg
        vFeTdWjXTg6mcKPSUbQGmgqBCGuxWMR1VP+mN/9LLw==
X-Google-Smtp-Source: ADFU+vsvO6kunRRR8mAZ9+R8uLmhNoz94EQxSKHpmioaS9wVQlNcKGLp3hNkC2w6a9A4Y6O7OCfjzfF3faRUp5qbWq4=
X-Received: by 2002:ac5:c4fc:: with SMTP id b28mr1664245vkl.101.1583503366678;
 Fri, 06 Mar 2020 06:02:46 -0800 (PST)
MIME-Version: 1.0
References: <1582100757-20683-1-git-send-email-haibo.chen@nxp.com>
 <1582100757-20683-9-git-send-email-haibo.chen@nxp.com> <CAPDyKFrR3oawA0o8KJ1ZEP41Ydb+-QWFbtxLua5TLemHybQ6QQ@mail.gmail.com>
 <20200304162844.GA11727@lst.de> <CACRpkdakLfH_bpU5W44HGZ8XBYGqNsH7B+zuVKs2AXuJLwDtPw@mail.gmail.com>
 <20200305152337.GC4870@lst.de>
In-Reply-To: <20200305152337.GC4870@lst.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 6 Mar 2020 15:02:09 +0100
Message-ID: <CAPDyKFovCm5r7J4pQNfV21KiyAC+VGHvowddgkdzkSE4f3UnGA@mail.gmail.com>
Subject: Re: [PATCH v4 14/14] mmc: queue: create dev->dma_parms before call dma_set_max_seg_size()
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Haibo Chen <haibo.chen@nxp.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 5 Mar 2020 at 16:23, Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Mar 05, 2020 at 03:29:55PM +0100, Linus Walleij wrote:
> > I agree. This relates to my reply to Greg K-H recently:
> > https://lore.kernel.org/lkml/CACRpkdajhivkOkZ63v-hr7+6ObhTffYOx5uZP0P-MYvuVnyweA@mail.gmail.com/
> >
> > The core of the problem is that drivers/of/platform.c is
> > very simple and has no idea what kind of bus it is populating
> > with devices from Device Tree. It is just guessing.
> >
> > For example platform.c contains this:
> >
> >         dev->dev.coherent_dma_mask = DMA_BIT_MASK(32);
> >         if (!dev->dev.dma_mask)
> >                 dev->dev.dma_mask = &dev->dev.coherent_dma_mask;
> >
> > And again part of the problem is that the device tree parser
> > mostly just create struct platform_device's on the platform bus
> > and has no real idea about any constraints on the bus where
> > it will eventually end up after the platform device is probed and
> > a new device on some other bus has been created.
>
> the plaform device code should allocate the dma_params for every
> device.  It should not set any limits in that, that is up to the
> host drivers.

That makes sense to me, but we also have other bus types to consider,
like the amba bus for example.

So, in principle, those buses that may get DMA capable devices
attached, needs to do the allocation, that's what you are proposing?

Kind regards
Uffe
