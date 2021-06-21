Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAE1C49EA3
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 01:38:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67E0B61208
	for <linux-mmc@archiver.kernel.org>; Mon, 21 Jun 2021 01:38:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhFUBlB (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Sun, 20 Jun 2021 21:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhFUBlB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Sun, 20 Jun 2021 21:41:01 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07E66C061574;
        Sun, 20 Jun 2021 18:38:47 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id s22so22788970ljg.5;
        Sun, 20 Jun 2021 18:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=Ucm3wibUKjyDXQlWvsaDkSdXqDbxxo3t9VSQN89L9Co=;
        b=BTlxdwbuRpgVcK978ahZti3mOppExd/U6mwBAaLVrjhA5uQaZGlR3lBoODkFn0HOqk
         62jBeVq9CY95Yu1xfBJlML0yHnMuCIP/9U+Ab1rxcGbgNG9ZBxEY2ag+aPPzUGR5otjs
         aqSBMT8ME6WaVxbcKal9RcHhIHfn45KBkAUTPbEnnqR3InZkcSxrCjBbGq5KDNR+ffI4
         le0n5y2SK01XdEdJ8n+8QazVPH7zorDXFaK3i5reARh0KcGNht2hlOLs2i0PB5aqs5eF
         xuEZdk8zGXAz4FjopjVehUYszCezbBEMafTDgs4vVmk/UCRcCMFJiMa+kOo2BTRrB645
         Al3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=Ucm3wibUKjyDXQlWvsaDkSdXqDbxxo3t9VSQN89L9Co=;
        b=WG3EEpcRlvcCbG2oWS4mEhEb/P/P8IoBOtiwtFPJJlCxl0lmqFjx6HyzJY8nQoBevQ
         a2/5F50c5pCJiKe2mla5kBwzIHfsFUA/sPGko3Hw2gbQKHpoEkepFkBXTksCusDw1zxD
         y+Iua/MVdMJsN4XCmLPvXBvxDysmIpuPJgzFF5sVq6M4mmwy3jGg0iqanp8BU9uW3Is8
         oiWOuznOx7Tngc4msmDdLPmnU3y01EjooBTIqnVwjJVo2HkOH8n+MfWr1GAq131CTedA
         SgRYHjrcpTh54YK4G5efX3rDLSAoYOEaB8SCSZ5diZ+vyjqyCmKSf3KbAe3SEJItAdJL
         vdDA==
X-Gm-Message-State: AOAM5302RsQ+EDj2Zp0Qbk7n1TqYipk94LRSgN3AKQRTuU5j6EZ8S6ka
        Nx5tz+Q4cDIKDFQ/9WClmrFTiuLyjoLJ5cPML/o=
X-Google-Smtp-Source: ABdhPJxp1+mKBu76yS7r8Uyat0furanFf8Nvs2vaKaHNhbKYe6J5BU4yUx53dWxGthf7PEvqTxoM3LEIdEllBCywSug=
X-Received: by 2002:a2e:8190:: with SMTP id e16mr19511865ljg.81.1624239525427;
 Sun, 20 Jun 2021 18:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210320045720.11872-1-chgokhl@gmail.com> <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
In-Reply-To: <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
Reply-To: chgokhl@163.com
From:   hieagle <chgokhl@gmail.com>
Date:   Mon, 21 Jun 2021 09:38:34 +0800
Message-ID: <CAMjpFAUTsei-PWLDdM+_78qXTo=QFdw-Wbgo9QA2Jnss+i4yRA@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Mark mmc_host device with pm_runtime_no_callbacks
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kehuanlin@fishsemi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Sorry, I don't receive the reply email in my gmail.

Normally the mmc_host's power.disable_depth is large than zero, the
rpm_resume(mmc:0001) will not be called recursively for parent. This is
the most case.

Although the mmc class device never calls pm_runtime_enable() directly,
there are still some cases as below to call pm_runtime_enable(), which
may cause it's power.disable_depth decremented to zero.
  case1: device_resume_early->pm_runtime_enable
  case2: device_resume->pm_runtime_enable

Anything that can go wrong will go wrong. Unfortunately we meet the case.
If you trigger to set the mmc_host's power.disable_depth value to zero
after mmc suspended, you can find the issue.

In our platform the mmc device's parent list is as below:
     mmc0:0001->mmc_host mmc0->fa630000.mmc->soc.
The rpm_resume call trace is as below in our scenario:

rpm_resume(mmc0:0001)
|
if (!parent && dev->parent) //true
if (!parent->power.disable_depth
   && !parent->power.ignore_children) //true
rpm_resume(parent, 0) --->  rpm_resume(mmc_host, 0)
|                           |
|                           callback =3D RPM_GET_CALLBACK(mmc_host, ...) =
=3D NULL
|                           retval =3D rpm_callback(callback, mmc_host) =3D=
 -ENOSYS
|                           |
|                           return retval =3D -ENOSYS
if (retval) goto out; //skip rpm_callback()
return retval =3D -ENOSYS

The scenario is rare, but anything that can go wrong will go wrong.
The patch can enhance the code to avoid this scenario.

Ulf Hansson <ulf.hansson@linaro.org> =E4=BA=8E2021=E5=B9=B43=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=9A
>
> On Sat, 20 Mar 2021 at 05:57, kehuanlin <chgokhl@gmail.com> wrote:
> >
> > The rpm_resume() will call parent's resume callback recursively.
> > Since mmc_host has no its own pm_runtime callbacks, the mmc devices
> > may fail to resume (-ENOSYS in rpm_callback) sometimes. Mark mmc_host
> > device with pm_runtime_no_callbacks can fix the issue.
>
> Can you please elaborate more on this? What do you mean by "sometimes"?
>
> More precisely, how do you trigger the rpm_callback() for mmc class
> device to return -ENOSYS?
>
> Don't get me wrong, the patch is fine, but I want to understand if it
> actually solves a problem for you - or that it's better considered as
> an optimization?
>
> Kind regards
> Uffe
>
> >
> > Signed-off-by: kehuanlin <chgokhl@gmail.com>
> > ---
> >  drivers/mmc/core/host.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 9b89a91b6b47..177bebd9a6c4 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -15,6 +15,7 @@
> >  #include <linux/of.h>
> >  #include <linux/of_gpio.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/pm_runtime.h>
> >  #include <linux/pm_wakeup.h>
> >  #include <linux/export.h>
> >  #include <linux/leds.h>
> > @@ -480,6 +481,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct d=
evice *dev)
> >         host->class_dev.class =3D &mmc_host_class;
> >         device_initialize(&host->class_dev);
> >         device_enable_async_suspend(&host->class_dev);
> > +       pm_runtime_no_callbacks(&host->class_dev);
> >
> >         if (mmc_gpio_alloc(host)) {
> >                 put_device(&host->class_dev);
> > --
> > 2.30.0
> >
