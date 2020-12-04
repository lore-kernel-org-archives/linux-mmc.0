Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00276C4361B
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83CB22B45
	for <linux-mmc@archiver.kernel.org>; Fri,  4 Dec 2020 14:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbgLDOkU (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 4 Dec 2020 09:40:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbgLDOkS (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Dec 2020 09:40:18 -0500
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE751C061A4F
        for <linux-mmc@vger.kernel.org>; Fri,  4 Dec 2020 06:39:30 -0800 (PST)
Received: by mail-lj1-x241.google.com with SMTP id a1so5546243ljq.3
        for <linux-mmc@vger.kernel.org>; Fri, 04 Dec 2020 06:39:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6sWIE6MSVnFN2Z1SFZ8QW/N7guFxVpjF1mW79UulhJs=;
        b=RfcUNAfKbPRmMKo7OcV+vcKhf8gkhXXWbgOjRQECyb79B5Kr8J55uu34UsLfxxUPom
         7NEJDhsiYI7XXFxNqQi/41lLal9d1LYqnr2vQSWhl3ZGT+woctsjPXr9Xr09HeUYzwTH
         4sYKrvzexNplNWsyr+AQys2/4I7jeyHKWANdgJPA6jBiijImp0602h+mSteHCWlDfmdQ
         YXwBsfYJFRRA/jFkwq66l0qkO33EWCS+8WPE3EkBo2bnFfj2+Uqy0cJgUfub/OsjLexQ
         u9GN3Y0hEQuLeV1vRg2wJQtiSAp8QqgrVOF0XuFxzBGyVyWGORmIgknoFXE6kB3bnUWZ
         7dZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6sWIE6MSVnFN2Z1SFZ8QW/N7guFxVpjF1mW79UulhJs=;
        b=H/YIZ/fHRLGvTT4COnDmj7y2qFCBz3H2O4RwMj6NwWj0LZtDp3GBsph1dwyea6sB1K
         xKv12K4fBh7Bx6EKshWYAr/OuRQV+Cwz8zMk/DsoQn2b78dpb4DSpG0HdXLThe6+fPqm
         RI1uHY6pki+oW8hFxBlwDLuKfJkIgOod/YHPt+aFC51aI5xvuKEk22X3x1ix/TbV87sk
         qn2baCqeHdmGzhZY/O2h/CEabVic8mO6Th6icxse4Bd6Jk+pfIpQ+G5fyA42XO3grE55
         eNEhBnajytf7YTGDTEcb/bTvPvMubdSf6xo32724D4cDkUScinlOXtnctJGEEVizjSDT
         /yuw==
X-Gm-Message-State: AOAM532Jl/oIjM4p53qhqSIMYmbO3KZ9daWdseneIgy9Uv9UE/hlirg3
        IdOiHp4TuV83Bu5f2LzUeVY+IytfsNctT6PHC7ZEww==
X-Google-Smtp-Source: ABdhPJyskVYAzDS48JDvWbmfiXfOC8BuBYtUHBD5BXTQ5EFVNcQqiqycMB0UDj7GVEp894YzQizdbfY9OTD5WfpyvaY=
X-Received: by 2002:a2e:3608:: with SMTP id d8mr3697375lja.68.1607092769314;
 Fri, 04 Dec 2020 06:39:29 -0800 (PST)
MIME-Version: 1.0
References: <20201203222922.1067522-1-arnd@kernel.org> <CAPDyKFqtFYqc8i_fVzOUnuZGJjtwjVLqE-vebtOKuYJ-4PrDBg@mail.gmail.com>
 <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
In-Reply-To: <CAK8P3a3srmTdY69j+g-wazMkrTL8_Grsw=vCMyizyA_7oOC4tg@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 4 Dec 2020 15:38:49 +0100
Message-ID: <CAPDyKFqS5touMvORyovCS-QQrHZg+0LGob9DtS1m61quvXYezw@mail.gmail.com>
Subject: Re: [PATCH] mmc: mediatek: mark PM functions as __maybe_unused
To:     Arnd Bergmann <arnd@kernel.org>
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

On Fri, 4 Dec 2020 at 15:14, Arnd Bergmann <arnd@kernel.org> wrote:
>
> On Fri, Dec 4, 2020 at 11:02 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Thu, 3 Dec 2020 at 23:29, Arnd Bergmann <arnd@kernel.org> wrote:
>
> > > -#ifdef CONFIG_PM
> > >  static void msdc_save_reg(struct msdc_host *host)
> >
> > Shouldn't msdc_save|restore_reg() be turned into "__maybe_unused" as well?
>
> There is no need since the compiler can figure that out already when there
> is a reference to the function from dead code.

Alright, thanks for clarifying.

>
> > >
> > > -static int msdc_resume(struct device *dev)
> > > +static int __maybe_unused msdc_resume(struct device *dev)
> > >  {
> > >         return pm_runtime_force_resume(dev);
> > >  }
> > > -#endif
> > >
> > >  static const struct dev_pm_ops msdc_dev_pm_ops = {
> >
> > You may also change this to a __maybe_unused, as long as you also
> > assign the .pm pointer in the mt_msdc_driver with
> > pm_ptr(&msdc_dev_pm_ops).
> >
> > Ideally the compiler should drop these functions/datas entirely then.
>
> I don't see a lot of other instances of that yet, and it's fairly new.
> Maybe we should fix it before it gets propagated further.
>
> I would suggest we redefine pm_ptr like
>
> #define pm_ptr(_ptr) (IS_ENABLED(CONFIG_PM) ? (_ptr) : NULL)

Why is this better than the original definition?

>
> and remove the __maybe_unused annotations on those that we
> already have. This also has the effect of dropping the unused
> data from the object, but without having to an an #ifdef or
> __maybe_unused.

I didn't quite get this (sorry it's Friday afternoon... getting
tired), can you perhaps give a concrete example?

That said, I have applied your patch for fixes, but let's try to sort
out the above to make sure we are all on the same page.

Kind regards
Uffe
