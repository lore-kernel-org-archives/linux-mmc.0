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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B68C2C433DB
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 10:50:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71FC8619BD
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 10:50:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCWKt5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 06:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbhCWKti (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 06:49:38 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C467EC061574;
        Tue, 23 Mar 2021 03:49:37 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id a1so25004490ljp.2;
        Tue, 23 Mar 2021 03:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=nqW3Ssldrc7vBRXGjDD6xe91KrdIMEodDP2y2NpZseY=;
        b=EVBlk//qPyN52fAdm6hrUKkQ1byMjaraioY8QM0GiLM2VbJYf076+4MhId/aqpLSPt
         AwvwtWVca73S2oREW2pwhfY018ZnPevM1NYa/4C/JeLimwR7bwbcZhWyIzUVlCQO7UHe
         YR0l3D26QuLLt/2N7XaUuTdt1Cp6RFW3JNPlsQPE3r8iAXn4yx9iL4gzPaGt+cd1uJkq
         Y75+v4JuHgBLMWq6F04P7V0TZyseM+g3B7J93TNJhJ9HCVNIuXCqmY9Ko0DpB4aRdlVb
         cFg+OKiBUr/wycCdfV1BDvKA5KpigjzcCx02SoAsNzYjYFm5OnIZvTJig4WwVjdJK5UF
         h+Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=nqW3Ssldrc7vBRXGjDD6xe91KrdIMEodDP2y2NpZseY=;
        b=UWuDMqG0qYSsX3zKsqO4xt6QPUNCv8j2GkerlWKHDSsBADHTSLAPv7OeCG8YZ8WaM2
         uwt9wh09m3LYiEh2dHsOpS9T6oGElV3rLtzr+6MsTKrlpMo1uyRS+EflOpwiZX7GSAYF
         Mx1vlrNBHxn0BCcd6nookcUjhDeHbOMiYt+egsx6UsSg8ZGvUZNZxmkB2Ky1vWWtzyrk
         VgiHVzZ568Lnfm82vJh7891Q/pwUwQn4gekNkqD6cVcqD8fxeUpPlGI5dhh5nh63EYSc
         L1+/xkUHA7LuniMXF8pKOZCZUjTxFiDgjPRLhoB/UT3cSSYLwwK2RGjij8Cc0JAJV7Ut
         VcRg==
X-Gm-Message-State: AOAM531asfiMb5IqoO7ElDYPCP/ZamrLlrs3uFEJVUC4gPl1Qw/LyNOm
        uPo2OrYFC0yi5XsFG22BiCQBm08RU1tyI9z9/BiVU1zNqu0=
X-Google-Smtp-Source: ABdhPJy+WLZ9h16QR1ddpur0PtaCVNzYgWP1G4TbbIRKPq3+ybrdN3BIV/WkYDXrstfCWwcth0AYuHy/8/gFgfFhcDM=
X-Received: by 2002:a05:651c:481:: with SMTP id s1mr2635809ljc.152.1616496576241;
 Tue, 23 Mar 2021 03:49:36 -0700 (PDT)
MIME-Version: 1.0
References: <20210320045720.11872-1-chgokhl@gmail.com> <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
In-Reply-To: <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
Reply-To: chgokhl@163.com
From:   hieagle <chgokhl@gmail.com>
Date:   Tue, 23 Mar 2021 18:49:24 +0800
Message-ID: <CAMjpFAW0D12vxNSYLcwSWxf-zB+toT5cmiQ8mtUUE+nzWMJZ3g@mail.gmail.com>
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

We encounter a resume issue in our device sometimes. The mmc device's
parent list is
mmc0:0001->mmc_host mmc0->fa630000.mmc->soc in our soc. We found in the blo=
w
case with mmc0->power.disable_depth=3D0 the mmc_runtime_resume will be skip=
ped,
which cause subsequent mmc command fail.

mmc_get_card(mmc0:0001)->pm_runtime_get_sync->rpm_resume(mmc0:0001)->rpm_re=
sume(mmc0)
The rpm_resume(mmc0) return -ENOSYS due to no callback and
mmc0->power.runtime_status
keep RPM_SUSPENDED. This lead to rpm_resume(mmc0:0001) return -EBUSY and sk=
ip
rpm_callback which call mmc_runtime_resume, the mmc is still in
suspended and the
subsequent mmc command fail.

[  198.856157] Call trace:
[  198.858917] [<ffffff800808bd9c>] dump_backtrace+0x0/0x1cc
[  198.864966] [<ffffff800808bf7c>] show_stack+0x14/0x1c
[  198.870627] [<ffffff8008400e88>] dump_stack+0xa8/0xe0
[  198.876288] [<ffffff800854d38c>] rpm_resume+0x850/0x938
[  198.882141] [<ffffff800854cd8c>] rpm_resume+0x250/0x938
[  198.887994] [<ffffff800854d4c4>] __pm_runtime_resume+0x50/0x74
[  198.894530] [<ffffff80087b9e64>] mmc_get_card+0x3c/0xb8
[  198.900388] [<ffffff80087cd2e0>] mmc_blk_issue_rq+0x2b0/0x4d8
[  198.906824] [<ffffff80087cd5e4>] mmc_queue_thread+0xdc/0x198
[  198.913165] [<ffffff80080d4b2c>] kthread+0xec/0x100
[  198.918632] [<ffffff8008083890>] ret_from_fork+0x10/0x40
[  198.924582] mmc0  callback           (null)
[  198.935837] mmcblk mmc0:0001: __pm_runtime_resume ret -16

Mark mmc_host device with pm_runtime_no_callbacks will solve the issue.
Thanks.
Huanlin Ke

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
