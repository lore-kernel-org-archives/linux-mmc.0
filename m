Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B6D2C433FE
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Oct 2021 11:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5112A61166
	for <linux-mmc@archiver.kernel.org>; Mon,  4 Oct 2021 11:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232693AbhJDLDc (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 4 Oct 2021 07:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbhJDLDb (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Oct 2021 07:03:31 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F29C061745
        for <linux-mmc@vger.kernel.org>; Mon,  4 Oct 2021 04:01:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id y23so30578213lfb.0
        for <linux-mmc@vger.kernel.org>; Mon, 04 Oct 2021 04:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=URCJeJ//i21kt2HQZuP4+ONPAa0mUFJTP/rOPl6nrkU=;
        b=hDM2Ru5ICrroBNDxLmX0If6DCGiyxNrOCxoYD447SPukcHDmbBPLNisrdhOLXQ0z+O
         XAGpgeNiSLvK62mVR4ycyTMTlxOUILWm5ec3jHIazC1TTcmE73Wiu6Uw4vHsUObQZ88A
         VxG8L26gqN1qrB2CE408IFuJmANo6HHn/LiqpAKVqjl4+Fv6k7ICtg/O46hugliGIxbi
         S/OxLLbFm/pg/rjpCfpNW1Knl+/16xjrIofQdoho7b+zWsc33s3wkXlvS7VH5BYU8/rA
         bq9k2sPB1ak/yK37C/Nh9dpokzhoA+CoGOF3/o+k0JQbg3KEE7GgAczasadRr+Ip1+pd
         ujCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=URCJeJ//i21kt2HQZuP4+ONPAa0mUFJTP/rOPl6nrkU=;
        b=sXUnU1nV7os07X2InDTyF4XY9ZtNyQA15PmNHzWX2urN4i5XrvZgrYhtcnG4EZut8d
         oysQdrW+EklWUBw89OakojM5moIi9YrADQ/Tx6JLsDCwuNyVvKdyXidUFM3eWulteEft
         iy+T1LpncW8xAlm+ifO63KQVDZmm0q5coEsDWHPRE5x1CkLCgtEgl2zwJTNgAmsbQBbP
         9fAbC+AjE8QYyjEvXDo5qDGGqJpQX8+vyT6iO59bIbX/4jYDFkyKS8xADmf8KwzQ1O8l
         /rd5ATcbvaQSoR7NA7xaflqaDWrBR+dqJX6vbj+08T95JUEsvVidVyVG/eDwM4LMuQsE
         Bvdg==
X-Gm-Message-State: AOAM531K1PK3OJ2nrPY8Mq4QWz2DOPLu+gnPL/YDs2WXfuokJKsb9FdZ
        jrnrr3Ql+qaAkUy5OuITe2eFM8NrTOMMmXc/kCB9Gw==
X-Google-Smtp-Source: ABdhPJyFugIk4Tybq6G/fbOCCDLI0zDDe0OJLAEmCzaWz2xcRwlwVNqSWwGjRpZKOyrDmly1b2n9Ta2aR7jygzrrPNg=
X-Received: by 2002:a05:6512:2397:: with SMTP id c23mr13296805lfv.358.1633345298337;
 Mon, 04 Oct 2021 04:01:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210926224058.1252-1-digetx@gmail.com> <20210926224058.1252-14-digetx@gmail.com>
 <CAPDyKFpzhv1UxjM0q5AWHVxTWC_cCO_Kg_6exO0o_=EoVvjo+w@mail.gmail.com>
 <aad7a508-7fb5-3418-f902-def80c365094@gmail.com> <CAPDyKFppSuP6FfaBaGn3o+8WvTT=vJ8XMzZ47WPQ1JKiUYyEpw@mail.gmail.com>
 <8d75436d-864a-7ce0-ba53-daa8b663035a@gmail.com>
In-Reply-To: <8d75436d-864a-7ce0-ba53-daa8b663035a@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 4 Oct 2021 13:01:01 +0200
Message-ID: <CAPDyKFpqs5gUcym4q+GuiJy13eXqjEnx-eFdUT4bQpcfPAOEYw@mail.gmail.com>
Subject: Re: [PATCH v13 13/35] drm/tegra: gr2d: Support generic power domain
 and runtime PM
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Peter Chen <peter.chen@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        linux-staging@lists.linux.dev, linux-pwm@vger.kernel.org,
        linux-mmc <linux-mmc@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Lucas Stach <dev@lynxeye.de>, Stefan Agner <stefan@agner.ch>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 1 Oct 2021 at 21:00, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 01.10.2021 17:55, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Fri, 1 Oct 2021 at 16:29, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 01.10.2021 16:39, Ulf Hansson =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> On Mon, 27 Sept 2021 at 00:42, Dmitry Osipenko <digetx@gmail.com> wro=
te:
> >>>>
> >>>> Add runtime power management and support generic power domains.
> >>>>
> >>>> Tested-by: Peter Geis <pgwipeout@gmail.com> # Ouya T30
> >>>> Tested-by: Paul Fertser <fercerpav@gmail.com> # PAZ00 T20
> >>>> Tested-by: Nicolas Chauvet <kwizart@gmail.com> # PAZ00 T20 and TK1 T=
124
> >>>> Tested-by: Matt Merhar <mattmerhar@protonmail.com> # Ouya T30
> >>>> Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
> >>>> ---
> >>>>  drivers/gpu/drm/tegra/gr2d.c | 155 ++++++++++++++++++++++++++++++++=
+--
> >>>
> >>> [...]
> >>>
> >>>>  static int gr2d_remove(struct platform_device *pdev)
> >>>> @@ -259,15 +312,101 @@ static int gr2d_remove(struct platform_device=
 *pdev)
> >>>>                 return err;
> >>>>         }
> >>>>
> >>>> +       pm_runtime_dont_use_autosuspend(&pdev->dev);
> >>>> +       pm_runtime_disable(&pdev->dev);
> >>>
> >>> There is no guarantee that the ->runtime_suspend() has been invoked
> >>> here, which means that clock may be left prepared/enabled beyond this
> >>> point.
> >>>
> >>> I suggest you call pm_runtime_force_suspend(), instead of
> >>> pm_runtime_disable(), to make sure that gets done.
> >>
> >> The pm_runtime_disable() performs the final synchronization, please se=
e [1].
> >>
> >> [1]
> >> https://elixir.bootlin.com/linux/v5.15-rc3/source/drivers/base/power/r=
untime.c#L1412
> >
> > pm_runtime_disable() end up calling _pm_runtime_barrier(), which calls
> > cancel_work_sync() if dev->power.request_pending has been set.
> >
> > If the work that was punted to the pm_wq in rpm_idle() has not been
> > started yet, we end up just canceling it. In other words, there are no
> > guarantees it runs to completion.
>
> You're right. Although, in a case of this particular patch, the syncing
> is actually implicitly done by pm_runtime_dont_use_autosuspend().
>
> But for drivers which don't use auto-suspend, there is no sync. This
> looks like a disaster, it's a very common pattern for drivers to
> 'put+disable'.
>
> > Moreover, use space may have bumped the usage count via sysfs for the
> > device (pm_runtime_forbid()) to keep the device runtime resumed.
>
> Right, this is also a disaster in a case of driver removal.
>
> >> Calling pm_runtime_force_suspend() isn't correct because each 'enable'
> >> must have the corresponding 'disable'. Hence there is no problem here.
> >
> > pm_runtime_force_suspend() calls pm_runtime_disable(), so I think that
> > should be fine. No?
>
> [adding Rafael]
>
> Rafael, could you please explain how drivers are supposed to properly
> suspend and disable RPM to cut off power and reset state that was
> altered by the driver's resume callback? What we're missing? Is Ulf's
> suggestion acceptable?
>
> The RPM state of a device is getting reset on driver's removal, hence
> all refcounts that were bumped by the rpm-resume callback of the device
> driver will be screwed up if device is kept resumed after removal. I
> just verified that it's true in practice.

Note that, what makes the Tegra drivers a bit special is that they are
always built with CONFIG_PM being set (selected from the "SoC"
Kconfig).

Therefore, pm_runtime_force_suspend() can work for some of these
cases. Using this, would potentially avoid the driver from having to
runtime resume the device in ->remove(), according to the below
generic sequence, which is used in many drivers.

pm_runtime_get_sync()
clk_disable_unprepare() (+ additional things to turn off the device)
pm_runtime_disable()
pm_runtime_put_noidle()

Kind regards
Uffe
