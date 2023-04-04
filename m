Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A63C761A6
	for <linux-mmc@archiver.kernel.org>; Tue,  4 Apr 2023 15:19:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbjDDPT3 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 4 Apr 2023 11:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234616AbjDDPT1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 4 Apr 2023 11:19:27 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226A24488
        for <linux-mmc@vger.kernel.org>; Tue,  4 Apr 2023 08:19:26 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-5445009c26bso619882157b3.8
        for <linux-mmc@vger.kernel.org>; Tue, 04 Apr 2023 08:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680621565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+hxN4RYTV4eHGXG1nyMBkRqaXfgeEfY8tA61waLItc=;
        b=hnvL2XdrCCff9Aw2cFRcJmwpZR2EosicV0yd+L19DLwIkTKusVY4auBxyubLjdczjD
         UeWKbG7Hfw25UhGXs9BIHCdyvShQSAJCS1IaezSiffQhvwgOdNyUVu1osjQvXuZyGlFp
         61EM4C67RqmtQluJMU7dMX/ZTfAAZ8Qh3xGGz0ksLyRy17087hG4WKNK3F7Ds/Q4H/iQ
         7QSG1ql2H7G8yAfYaksuRelbKGg6t5U3GplIVjpW6e2HFOxHJHRtydCIVPlqafePMzCJ
         HMAnijUWA+v8FXgVc7rmMEge/u9f9oGdS9SCnAUENPtKj2gKS+GrsT0hkl+I9DPbHEC+
         oYJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680621565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+hxN4RYTV4eHGXG1nyMBkRqaXfgeEfY8tA61waLItc=;
        b=pE29PhW3asVahjybOTaqLBBG9qn7E9G68ggRRHL/6hd9apGiD8K/7rLqhBQI5+GHE/
         Zm8ewczf2yeOdLStH78KTNMwnTZJH4tXpXOzN9mFqvhf2R32zQb4rj8Gs3Yrkk1/IRV/
         1uxKrnUYaD2k/AgT1PVrB6apDtcGCVftAjPsJ7hUdLmavztQ+Nk5iWAR00HliwUo6oDt
         V0FcmRroSKOvIaXUstr5xD7OBBXFV0SX+wUQfc6hRd/SptPzhg+KVbR4HTl/S7z5kYur
         1VEpOoTgZlQuqlASNVfkPoR//ZccdYIxLN+o2f/DOq8NPa1AfdFN6X1abRDd6O8sgKUa
         Sy8A==
X-Gm-Message-State: AAQBX9cYi5LfL0U7gV47lkKizUsx7RTfkRtWmiXBlhSFvia4j5v8wGrT
        A7WtZCayc6wx8CYBelMC+zrv1kppJiLS0wpfm55bsLuKttdUDskIbFI=
X-Google-Smtp-Source: AKy350YyO3tpK1K9bcDoCBBNdNh1DzPqYWCdonHE8i0tQvfsQuCeCW474ouOYx/bmUZ6GCHWDAa5X6UnbWFWE2oB0A4=
X-Received: by 2002:a81:c509:0:b0:549:143f:3d3 with SMTP id
 k9-20020a81c509000000b00549143f03d3mr1749148ywi.0.1680621565333; Tue, 04 Apr
 2023 08:19:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230401131626.ioiq5q5vzmpppe5v@pengutronix.de>
 <CAPDyKFr-yqW2RLA92dhEBe=QMTiLDGy1rTmhYzW0BJjnbrfFLw@mail.gmail.com>
 <20230403151712.pqzmyqz3tose3bc3@pengutronix.de> <CAPDyKFp0W_e051Ke2QFx046GH-u+TW+TaQxTjzWkuQFxf4KcPg@mail.gmail.com>
 <20230404150158.c5qy45truzyd6kjm@pengutronix.de>
In-Reply-To: <20230404150158.c5qy45truzyd6kjm@pengutronix.de>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Apr 2023 17:18:49 +0200
Message-ID: <CAPDyKFqG9oWUWo-0y4Dgr0CrhO_gBaOnm+6RNZ2R-dw4bTCrrg@mail.gmail.com>
Subject: Re: sdhci_am654 and runtime-pm issues
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     linux-mmc@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Tue, 4 Apr 2023 at 17:02, Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Hello Ulf,
>
> On Tue, Apr 04, 2023 at 02:41:33PM +0200, Ulf Hansson wrote:
> > On Mon, 3 Apr 2023 at 17:17, Uwe Kleine-K=C3=B6nig
> > <u.kleine-koenig@pengutronix.de> wrote:
> > >
> > > On Mon, Apr 03, 2023 at 12:19:20PM +0200, Ulf Hansson wrote:
> > > > On Sat, 1 Apr 2023 at 15:16, Uwe Kleine-K=C3=B6nig
> > > > <u.kleine-koenig@pengutronix.de> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > I looked at the sdhci_am654's probe function and concerning runti=
me-pm
> > > > > this is at least unconvential:
> > > > >
> > > > > It does
> > > > >
> > > > >         clk_xin =3D devm_clk_get(dev, "clk_xin");
> > > > >         if (IS_ERR(clk_xin))
> > > > >                 ...
> > > > >
> > > > >         /* Clocks are enabled using pm_runtime */
> > > > >         pm_runtime_enable(dev);
> > > > >         ret =3D pm_runtime_resume_and_get(dev);
> > > > >         ...
> > > > >
> > > > > I'm not fluent in runtime-pm stuff (so I added Rafael to Cc), but=
 I
> > > > > thought it is to be used the other way around, i.e. put the devic=
e in
> > > > > operational state and then runtime-pm cares to suspend the device=
 under
> > > > > some conditions (e.g. CONFIG_PM being enabled).
> > > > >
> > > > > With CONFIG_PM unset the driver is broken for sure, as then
> > > > > pm_runtime_enable() and pm_runtime_resume_and_get() have no effec=
t. So
> > > > > the clk stays off.
> > > >
> > > > In principle, you are correct. I wouldn't recommend the above patte=
rn
> > > > in general, but it doesn't mean that it can't work.
> > > >
> > > > Some platforms are selecting "PM" from some of their toplevel Kconf=
ig,
> > > > as they simply can't work without it. That means that the code you
> > > > refer to above, doesn't have to be broken.
> > >
> > > If I understand correctly the driver under discussion is supposed to =
be
> > > used on SoCs in the CONFIG_ARCH_K3 family. This isn't one of those th=
at
> > > enforce PM.
> >
> > Right. Thanks for checking this.
> >
> > In fact, I have just queued up a patch that fixes the behaviour [1].
> > Maybe we should consider to backport it for stable kernels too, at
> > least if there are some reports about errors!?
> >
> > > But yes, adding a depends on PM would be an action that improves the
> > > situation. Having said that even on such platforms you can disable
> > > runtime PM, so even a select on PM isn't a complete fix.
> >
> > Note sure I understand this. In what way do you mean that runtime PM
> > can be disabled? Normally, it's the bus/driver that decide whether
> > runtime PM should be enabled or not. Right?
>
> You can disable runtime PM per device via sysfs. (Something like:
>
>         echo on > /sys/devices/.../power/control
>
> .) The docs say "Changing this attribute to "on" [...] while the device
> is suspended causes it to be woken up.", so the right thing seems to
> happen. (I didn't test what happens if that file is written before the
> driver is bound.)

Right, that part is changing the reference count. It doesn't really
enable/disable runtime PM for the device, so it shouldn't really
matter. Unless I am missing something, of course.

Kind regards
Uffe
