Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C66C761A6
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 12:43:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234748AbjDDMnP (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 08:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234720AbjDDMnB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 08:43:01 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B784448C
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 05:42:13 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id p203so38426359ybb.13
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 05:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680612129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Awoi0wocEa6pJJCJed+R75oaVptK3W5bV3LAY08GU5I=;
        b=MMBf6P5jVdJRRMHqUgTmhJ215Sa1knl6VaTZIjYwlTL/8jlfHR08mqam1O1eTCLENb
         bFSZ3Y7jXAEnzjEb9jL4ZrJzSsSmBuSbQT3JWUACQx8VpfnTBi0vJbmvAfSWHAMRF5Ls
         BtJGZcd9tyyvMfGB9+ZIZ+JCLW3abJ+ebChflPJ0CqrzdIKKFQ3juM+ODYfxTI8lZ+xe
         tU71fgzOSUI+vTWhFy/WGH9fHyO+8TiXnBD0VINFoJUJ1cCpH+XSzMBwDvKVprZPNOok
         2yv5dFGkH4APaVcPF5rzCzb7DzK58CGQ+1PJnGH6G6KDy+RDsTVGi6kn+83K7rJHYQ5e
         XJlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680612129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Awoi0wocEa6pJJCJed+R75oaVptK3W5bV3LAY08GU5I=;
        b=l0HtbfqGHjjw7n6nwR3xmtgh0v2DTQvwLE0G+tlDE6FEaPBldMWixRAXL/V6c5hhzf
         W9Xyx0AnCsdLIvqFmp+lwJPHpanx2bDpmLXFvwqv8+0Fjs2Z+wwKLz7Gr279/GqlZaJE
         +Geunc2vjXmBlraSbq7LRU0xaHGDx4ydRrjZfLWZV9/gYO50vifZuCBBERhU0OLi8Joj
         euZomYMhuw2AUXptVbEWexUtipEymqp8mqWkdbz15NgIj0ehSB603e5Uznv2BzS2nEB2
         HZcmpMRKWySa/nAzX/MiN4c7bzpNUJVb85+QWTt434PN4v1+SmEBMaOBpowRP1uBMVo7
         /JCw==
X-Gm-Message-State: AAQBX9d4yXG7VYmOFIMnkvTT4vXmvJVmv52WzHqlCN7GZ0TVFPvJW/kv
        moOnAFQ7TgxEcysbhXC5bxAYEImHABT1QSpdbyZlYPBqIx5eTecMrkg=
X-Google-Smtp-Source: AKy350acHFpiOims4OdGlvOmjrDUoNIfNIt+TUwrdE/zA582mC8KnFFiirW3QHXC02dopUIbxpN725KCXhqM3cdmOfs=
X-Received: by 2002:a25:7449:0:b0:b75:8ac3:d5d9 with SMTP id
 p70-20020a257449000000b00b758ac3d5d9mr1747321ybc.3.1680612129129; Tue, 04 Apr
 2023 05:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230401131626.ioiq5q5vzmpppe5v@pengutronix.de>
 <CAPDyKFr-yqW2RLA92dhEBe=QMTiLDGy1rTmhYzW0BJjnbrfFLw@mail.gmail.com> <20230403151712.pqzmyqz3tose3bc3@pengutronix.de>
In-Reply-To: <20230403151712.pqzmyqz3tose3bc3@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Apr 2023 14:41:33 +0200
Message-ID: <CAPDyKFp0W_e051Ke2QFx046GH-u+TW+TaQxTjzWkuQFxf4KcPg@mail.gmail.com>
Subject: Re: sdhci_am654 and runtime-pm issues
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Mon, 3 Apr 2023 at 17:17, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> On Mon, Apr 03, 2023 at 12:19:20PM +0200, Ulf Hansson wrote:
> > On Sat, 1 Apr 2023 at 15:16, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > Hello,
> > >
> > > I looked at the sdhci_am654's probe function and concerning runtime-p=
m
> > > this is at least unconvential:
> > >
> > > It does
> > >
> > >         clk_xin =3D devm_clk_get(dev, "clk_xin");
> > >         if (IS_ERR(clk_xin))
> > >                 ...
> > >
> > >         /* Clocks are enabled using pm_runtime */
> > >         pm_runtime_enable(dev);
> > >         ret =3D pm_runtime_resume_and_get(dev);
> > >         ...
> > >
> > > I'm not fluent in runtime-pm stuff (so I added Rafael to Cc), but I
> > > thought it is to be used the other way around, i.e. put the device in
> > > operational state and then runtime-pm cares to suspend the device und=
er
> > > some conditions (e.g. CONFIG_PM being enabled).
> > >
> > > With CONFIG_PM unset the driver is broken for sure, as then
> > > pm_runtime_enable() and pm_runtime_resume_and_get() have no effect. S=
o
> > > the clk stays off.
> >
> > In principle, you are correct. I wouldn't recommend the above pattern
> > in general, but it doesn't mean that it can't work.
> >
> > Some platforms are selecting "PM" from some of their toplevel Kconfig,
> > as they simply can't work without it. That means that the code you
> > refer to above, doesn't have to be broken.
>
> If I understand correctly the driver under discussion is supposed to be
> used on SoCs in the CONFIG_ARCH_K3 family. This isn't one of those that
> enforce PM.

Right. Thanks for checking this.

In fact, I have just queued up a patch that fixes the behaviour [1].
Maybe we should consider to backport it for stable kernels too, at
least if there are some reports about errors!?

>
> But yes, adding a depends on PM would be an action that improves the
> situation. Having said that even on such platforms you can disable
> runtime PM, so even a select on PM isn't a complete fix.

Note sure I understand this. In what way do you mean that runtime PM
can be disabled? Normally, it's the bus/driver that decide whether
runtime PM should be enabled or not. Right?

Kind regards
Uffe

[1]
https://lore.kernel.org/lkml/CAPDyKFpXfRqx4WLuiU6m=3DrgM9A=3D21KfDTuEb5Tboa=
OC+w_hMwg@mail.gmail.com/
