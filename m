Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42172C4361A
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F84B22B2E
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727660AbgLDOP2 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:15:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbgLDOP0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 4 Dec 2020 09:15:26 -0500
X-Gm-Message-State: AOAM530QWWos4qFgidJVkJPJM1dSfwJ3T/l3OVvvWOreCiO82c3NfMNh
        GcuWhc8cHjTOzaKi3KwxENNqXSmZ6mTfkvkNfVU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607091286;
        bh=tIDO5wu/h3iugtm6EuT3IRty5Sei5IsCyw0gw/9uM+A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Z3/sbcYVvUTJhWMSd3RYaU/IetceyoHh8ACdVYKbFy5NldapW4wpCViXJZ/YUYB8n
         Qq1dpciIgustxCId64mgd/El0x6cxxRZrdl+dtocwQLTB1+mK5Yx6/GKFj8La1ID3Q
         rMODFaN56hG8zvZ0QzVISrqZtl2s9Sc+SMgucZyZHU6xJDUyigSA8ATxdvd3oVao5l
         C0KLe1iq06GClkP5k/R/SkU4340LLAGK/3wl2Rbn63wnAAvPWnCXdYEcLx1hk/U165
         mQCZNHGeFfssOVzv7plny26VNZfzxBdxlFq4wRhBCXJkXq+5KbMI9rHInJLteqEKfj
         x+5uCHJphKxaw==
X-Google-Smtp-Source: ABdhPJwxym/mU9bR1admW/kOH0JVRSYw6YjCWCAcHxsvuVRLLDVdF2nlbFSj4oIRatquO+QNtEj4N/04EluuruTGCBQ=
X-Received: by 2002:a9d:6317:: with SMTP id q23mr3785791otk.251.1607091285516;
 Fri, 04 Dec 2020 06:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20201203222922.1067522-1-arnd@kernel.org> <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
In-Reply-To: <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Fri, 4 Dec 2020 15:14:29 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
Message-ID: <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Chaotian Jing <chaotian.jing@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Chun-Hung Wu <chun-hung.wu@mediatek.com>,
        yong mao <yong.mao@mediatek.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Marek Vasut <marex@denx.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, Dec 4, 2020 at 11:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Thu, 3 Dec 2020 at 23:29, Arnd Bergmann <arnd@kernel.org> wrote:

> > -#ifdef CONFIG_PM
> >  static void msdc_save_reg(struct msdc_host *host)
>
> Shouldn't msdc_save|restore_reg() be turned into "__maybe_unused" as well?

There is no need since the compiler can figure that out already when there
is a reference to the function from dead code.

> >
> > -static int msdc_resume(struct device *dev)
> > +static int __maybe_unused msdc_resume(struct device *dev)
> >  {
> >         return pm_runtime_force_resume(dev);
> >  }
> > -#endif
> >
> >  static const struct dev_pm_ops msdc_dev_pm_ops = {
>
> You may also change this to a __maybe_unused, as long as you also
> assign the .pm pointer in the mt_msdc_driver with
> pm_ptr(&msdc_dev_pm_ops).
>
> Ideally the compiler should drop these functions/datas entirely then.

I don't see a lot of other instances of that yet, and it's fairly new.
Maybe we should fix it before it gets propagated further.

I would suggest we redefine pm_ptr like

#define pm_ptr(_ptr) (IS_ENABLED(CONFIG_PM) ? (_ptr) : NULL)

and remove the __maybe_unused annotations on those that we
already have. This also has the effect of dropping the unused
data from the object, but without having to an an #ifdef or
__maybe_unused.

Adding Paul and Rafael to Cc for clarification on this.

       Arnd
