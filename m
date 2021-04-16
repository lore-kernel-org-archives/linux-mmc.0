Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BFBC433B4
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 07:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF10961153
	for <linux-mmc@archiver.kernel.org>; Fri, 16 Apr 2021 07:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234688AbhDPHSN (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 16 Apr 2021 03:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234010AbhDPHSM (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Apr 2021 03:18:12 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E59FC061756
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 00:17:48 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id s190so1361986vkd.6
        for <linux-mmc@vger.kernel.org>; Fri, 16 Apr 2021 00:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gl5+NOKWMEE1assjztlhUD+W7foevJhGIs8QyGLYzSI=;
        b=yycJUhrrIgOseu1XG8h/LbCBaxuYWRZ6CsOUprPnVWY7FhK8Q55edVa0O7UQdT/1c1
         qWsBVf4tuqzZIqLG2onQBytehefSPD9yCOarMek/xu8nN2EhdVjEk2cbiV+k7+M8/Nz6
         kpNJq3/mx6UOxeNOrYB4FhgCC8mEsC8+aNHcH9X9IVbQTpqljMIWNQrh6k4OCHxHfd6b
         OM/k9BhOoW/MN7GPfS1QuuzAQ4+NvoF9zwx5chnJguUHi50MbblS4VQti7Poixsc2bjd
         Saev//94EFkrXCWaY3XHy5jSqha1z/KApEyLHR9W4FoH1rcJr2+IUhtKRkF/4ASsumku
         4grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gl5+NOKWMEE1assjztlhUD+W7foevJhGIs8QyGLYzSI=;
        b=t4gDgTVX//MoD4TGd+2kkFm7tqcHFVcU14FkAcbaC7MjaeIPxjWoys5DCK20YeMvnU
         syGWGG17OOCEcMNG06/WFZxIbSBp9uptSv8cjSZMhh/IgZkfkAvLZOrZStFy++8nYK+Z
         RZRrDkAAyJP6ewq66X2ylobLGWYbHwPw1G/+7E0W5QFWDQJxFnnfM2f1pTfPDwcewUf5
         gAf5GTtoTa92H1LC+0HNwajCoJVAbJQCx5bgtaNOAcdWcyFoQx2UAE/qlQbP6azTE+cH
         NTAV3XWYbD+n/lUUe9H7GdcZMHRKBgC6jxLIKrpzdHI7FvgXJ1bm2GFl3/iNqUqEfEVB
         oJsg==
X-Gm-Message-State: AOAM531WlsPn4sojE5OnhskBQXP1H7LQzJk//5zq6Z4C/aQO/6lqYFiz
        rR1i2qt1tKL/oYV05/yYE8dec56pYT4zLD9hwqGkiQ==
X-Google-Smtp-Source: ABdhPJzxU3pnEUtkDwHbGXzel9y4sOTkeW68dwqJ4ESuKIQVN+AaSgG5kC3B41yKYCRtLqvAGN7VlIw1FZsi9NqFRuQ=
X-Received: by 2002:a1f:1f81:: with SMTP id f123mr5572708vkf.6.1618557466977;
 Fri, 16 Apr 2021 00:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210413003621.1403300-1-swboyd@chromium.org> <CAPDyKFquhnG1tGAx+GGNKM7_haThSa34FcONHGhdBwFYuryeag@mail.gmail.com>
 <161851496169.46595.399410018266490859@swboyd.mtv.corp.google.com>
In-Reply-To: <161851496169.46595.399410018266490859@swboyd.mtv.corp.google.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 16 Apr 2021 09:17:10 +0200
Message-ID: <CAPDyKFoZL6mygBQZiU329nagPJQzELPiFYjuJ0V3PfvaiJRv2w@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Don't allocate IDA for OF aliases
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sujit Kautkar <sujitka@chromium.org>,
        Zubin Mithra <zsm@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, 15 Apr 2021 at 21:29, Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Ulf Hansson (2021-04-15 01:56:12)
> > On Tue, 13 Apr 2021 at 02:36, Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > -       err = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
> > > -       if (err < 0) {
> > > -               kfree(host);
> > > -               return NULL;
> > > +               index = ida_simple_get(&mmc_host_ida, min_idx, max_idx, GFP_KERNEL);
> > > +               if (index < 0) {
> > > +                       kfree(host);
> > > +                       return NULL;
> > > +               }
> >
> > This means that a DTB that is screwed up in a way that it has two mmc
> > aliases with the same index, would be allowed to use the same index.
> >
> > What will happen when we continue the probe sequence in such a case?
>
> Yeah I thought about this after sending the patch. So the problem would
> be like this right?
>
>         aliases {
>                 mmc1 = &sdhci0;
>                 mmc1 = &sdhci1;
>         };

Correct.

>
> I have good news! DT won't compile it because it saw the same alias
> assigned to twice. I tried it on my sc7180 board.
>
> arch/arm64/boot/dts/qcom/sc7180.dtsi:35.3-18:
> ERROR (duplicate_property_names): /aliases:mmc1: Duplicate property name
> ERROR: Input tree has errors, aborting (use -f to force output)
> arch/arm64/boot/dts/qcom/sc7180-idp.dtb] Error 2
>
> I suppose if someone forced the compilation it may be bad, but do we
> really care?
>
> TL;DR: this seems like it isn't a problem.

Yep, I definitely tend to agree with you here. Thanks for doing the
test and sharing the result.

>
> >
> > >         }
> > >
> > > -       host->index = err;
> > > +       host->index = index;
> > >
> > >         dev_set_name(&host->class_dev, "mmc%d", host->index);
> > >         host->ws = wakeup_source_register(NULL, dev_name(&host->class_dev));
> >
> > Another concern that could potentially be a problem, is that the
> > "thread" that holds the reference that prevents ida from being
> > removed, how would that react to a new mmc device to become
> > re-registered with the same index?
> >
> > I wonder if we perhaps should return -EPROBE_DEFER instead, when
> > ida_simple_get() fails?
> >
>
> Don't think so. The device (with the kobject inside) is removed, and
> thus the mmc1 device will be removed, but the kobject's release function
> is delayed due to the config. This means that
> mmc_host_classdev_release() is called at a later time. The only thing
> inside that function is the IDA removal and the kfree of the container
> object. Given that nothing else is in that release function I believe it
> is safe to skip IDA allocation as it won't be blocking anything in the
> reserved alias case.
>
> Furthermore, when the device is deleted in mmc_remove_host() there could
> be other users of the device that haven't called put_device() yet.
> Either way, those other users are keeping the device memory alive, but
> otherwise device_del() has unlinked it from the various driver core
> lists and sysfs has removed it too so it's in a state where code may be
> referencing it but it's on the way out so users of the device will not
> be able to do much with it during this time.

Right, but see more below.

>
> This sort of problem (if it exists which I don't think it does) would
> have been there all along and can't be fixed at this level. When a
> device that has an alias calls the mmc_alloc_host() function twice it
> gets two different device structures created so there are two distinct
> kobjects that will need to be released at some point. The index is
> usually different for those two kobjects, but with aliases it turns out
> it is the same. When it comes to registering that device with the same
> name the second one will fail because a device with that name already
> exists on the bus. This would be really hard to do given that it would
> need to be the same aliased device in DT calling the mmc_add_host()
> function without calling mmc_remove_host() for the first one it added in
> between.

In fact, we have a few rare corner cases that can trigger KASAN splats
when mmc_remove_host() gets executed. Similar splats can be triggered
by just doing a sudden card removal. It's especially related to the
cases, where a thread holds a reference to the card/host object when
it's being removed. I am working on patches to fix these cases, but
haven't yet decided on the best solution.

That's the reason why I was thinking that maybe returning
-EPROBE_DEFER could be an option, but certainly I need to think more
about this.

>
> (Sorry if that is long. I'm sort of stream of conciousness writing it to
> you here and not rewriting it to be more concise)

No worries, thanks a lot for sharing your thoughts!

Kind regards
Uffe
