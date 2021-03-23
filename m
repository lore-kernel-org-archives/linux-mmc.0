Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0125C433C1
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 14:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A3AB6199F
	for <linux-mmc@archiver.kernel.org>; Tue, 23 Mar 2021 14:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbhCWOCC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 23 Mar 2021 10:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhCWOBe (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 23 Mar 2021 10:01:34 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F41B5C061764
        for <linux-mmc@vger.kernel.org>; Tue, 23 Mar 2021 07:01:33 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id x8so6719537ual.6
        for <linux-mmc@vger.kernel.org>; Tue, 23 Mar 2021 07:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EFM8vj54tYKb1Jf8bEnuuvv/LY9C1ofZG/2jctBPMnI=;
        b=zqmUyKoJFPC8TdMrKTiIDMwIaUgF9x15Z+0hCvB4ZRJFRt86l737p/WyEUPJYTATkP
         g8NN5+n4vYOXnyjS50D/et/YnT7b5vq4Netv/bp1hgbau1DWDUnlXsIdXClA6mdRwPEb
         JAgSB9/am/t5ifJw0YMb/8jIM+WHoY6/KTi9hwfhW+J+mO7e7OY0Nr2vb42L7uRPoOz+
         3A9K0jkts+XWogYM8oWCO2U4h3kXwsvZwkF2fnTV6uJAQfIo7zIoGMuanyJpcq+Bhh9w
         BJ0b7YiOqQl8Zn0AJy2wCie7GTrMIJERWIQodppGLzdwNcsO1faV0tEtC/5+IPQuDgF+
         y2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EFM8vj54tYKb1Jf8bEnuuvv/LY9C1ofZG/2jctBPMnI=;
        b=b/n2nw9wBJXk/0C+oyP2oFurAwujwq9zJyUPIF60MQE2TzJQvXfRpnrNt4tllgXs1K
         LCYPsTcUEI7X9wTQa8o5Dm4duSxle9C7yqqovCbxfrxERWUwWJqgjsfEEOie3h6b/hNC
         O/BRHM8TDOQPadRIacI37gaHLSQGDhQS1HuaH8lF37Ler2Jrav42QJlmCMfBaApnB1Rh
         gHkIip7D+lLMkkwFz+h1dOayAG02j3XisGOxVmZlBiaZWYWK1FpoUSVynlefWDKeOYmY
         IBXMcX9SE0r4Vo5974oS3QCLuatkwNVjU/f2vhtYww4B+pFStaBrFIWcF+1zgVPdSYuN
         G8lQ==
X-Gm-Message-State: AOAM533aBTIteSI0eDFGH5BtMAgku+gdeLsfdUhWQf53rPEHY5DIIYrC
        X3zKdm5b9CQkjizToMPi7ZGRI0R/qyOLIBaF0v6U+A==
X-Google-Smtp-Source: ABdhPJxJAHbpX2/GRwhTQQeCW9lCgzMQUr9j/i2dfLh16Z4eXb8X6W27BLfYs5/5U0eQBdvrp+jI+sIJSFo5rHkdYrI=
X-Received: by 2002:ab0:7a68:: with SMTP id c8mr3397238uat.104.1616508093043;
 Tue, 23 Mar 2021 07:01:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210320045720.11872-1-chgokhl@gmail.com> <CAPDyKFqXtKPngfnQZXXaF=rvqw0=nWzDc7P++QxNHPwGHHSxUA@mail.gmail.com>
 <CAMjpFAW0D12vxNSYLcwSWxf-zB+toT5cmiQ8mtUUE+nzWMJZ3g@mail.gmail.com>
In-Reply-To: <CAMjpFAW0D12vxNSYLcwSWxf-zB+toT5cmiQ8mtUUE+nzWMJZ3g@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 23 Mar 2021 15:00:56 +0100
Message-ID: <CAPDyKFqqRY3rj9zzzDvPTCO68abfQ+G-siAJVgdPuESUwko28A@mail.gmail.com>
Subject: Re: [PATCH] mmc: core: Mark mmc_host device with pm_runtime_no_callbacks
To:     chgokhl@163.com
Cc:     linux-mmc <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kehuanlin@fishsemi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 23 Mar 2021 at 11:49, hieagle <chgokhl@gmail.com> wrote:
>
> We encounter a resume issue in our device sometimes. The mmc device's
> parent list is
> mmc0:0001->mmc_host mmc0->fa630000.mmc->soc in our soc. We found in the b=
low
> case with mmc0->power.disable_depth=3D0 the mmc_runtime_resume will be sk=
ipped,
> which cause subsequent mmc command fail.
>
> mmc_get_card(mmc0:0001)->pm_runtime_get_sync->rpm_resume(mmc0:0001)->rpm_=
resume(mmc0)
> The rpm_resume(mmc0) return -ENOSYS due to no callback and
> mmc0->power.runtime_status
> keep RPM_SUSPENDED. This lead to rpm_resume(mmc0:0001) return -EBUSY and =
skip
> rpm_callback which call mmc_runtime_resume, the mmc is still in
> suspended and the
> subsequent mmc command fail.
>
> [  198.856157] Call trace:
> [  198.858917] [<ffffff800808bd9c>] dump_backtrace+0x0/0x1cc
> [  198.864966] [<ffffff800808bf7c>] show_stack+0x14/0x1c
> [  198.870627] [<ffffff8008400e88>] dump_stack+0xa8/0xe0
> [  198.876288] [<ffffff800854d38c>] rpm_resume+0x850/0x938
> [  198.882141] [<ffffff800854cd8c>] rpm_resume+0x250/0x938
> [  198.887994] [<ffffff800854d4c4>] __pm_runtime_resume+0x50/0x74
> [  198.894530] [<ffffff80087b9e64>] mmc_get_card+0x3c/0xb8
> [  198.900388] [<ffffff80087cd2e0>] mmc_blk_issue_rq+0x2b0/0x4d8
> [  198.906824] [<ffffff80087cd5e4>] mmc_queue_thread+0xdc/0x198
> [  198.913165] [<ffffff80080d4b2c>] kthread+0xec/0x100
> [  198.918632] [<ffffff8008083890>] ret_from_fork+0x10/0x40
> [  198.924582] mmc0  callback           (null)
> [  198.935837] mmcblk mmc0:0001: __pm_runtime_resume ret -16
>
> Mark mmc_host device with pm_runtime_no_callbacks will solve the issue.
> Thanks.
> Huanlin Ke

Thanks for sharing more details! I have to admit, that this sounds
quite weird to me. I wonder if this is a problem that deserves to be
fixed in the runtime PM core....

Let me have a closer look a get back to you again. Please be patient
though, I have a busy week in front of me.

Kind regards
Uffe

>
> Ulf Hansson <ulf.hansson@linaro.org> =E4=BA=8E2021=E5=B9=B43=E6=9C=8822=
=E6=97=A5=E5=91=A8=E4=B8=80 =E4=B8=8B=E5=8D=886:26=E5=86=99=E9=81=93=EF=BC=
=9A
> >
> > On Sat, 20 Mar 2021 at 05:57, kehuanlin <chgokhl@gmail.com> wrote:
> > >
> > > The rpm_resume() will call parent's resume callback recursively.
> > > Since mmc_host has no its own pm_runtime callbacks, the mmc devices
> > > may fail to resume (-ENOSYS in rpm_callback) sometimes. Mark mmc_host
> > > device with pm_runtime_no_callbacks can fix the issue.
> >
> > Can you please elaborate more on this? What do you mean by "sometimes"?
> >
> > More precisely, how do you trigger the rpm_callback() for mmc class
> > device to return -ENOSYS?
> >
> > Don't get me wrong, the patch is fine, but I want to understand if it
> > actually solves a problem for you - or that it's better considered as
> > an optimization?
> >
> > Kind regards
> > Uffe
> >
> > >
> > > Signed-off-by: kehuanlin <chgokhl@gmail.com>
> > > ---
> > >  drivers/mmc/core/host.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > index 9b89a91b6b47..177bebd9a6c4 100644
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -15,6 +15,7 @@
> > >  #include <linux/of.h>
> > >  #include <linux/of_gpio.h>
> > >  #include <linux/pagemap.h>
> > > +#include <linux/pm_runtime.h>
> > >  #include <linux/pm_wakeup.h>
> > >  #include <linux/export.h>
> > >  #include <linux/leds.h>
> > > @@ -480,6 +481,7 @@ struct mmc_host *mmc_alloc_host(int extra, struct=
 device *dev)
> > >         host->class_dev.class =3D &mmc_host_class;
> > >         device_initialize(&host->class_dev);
> > >         device_enable_async_suspend(&host->class_dev);
> > > +       pm_runtime_no_callbacks(&host->class_dev);
> > >
> > >         if (mmc_gpio_alloc(host)) {
> > >                 put_device(&host->class_dev);
> > > --
> > > 2.30.0
> > >
