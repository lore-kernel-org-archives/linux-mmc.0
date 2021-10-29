Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0865C433FE
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 15:29:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8706460E76
	for <linux-mmc@archiver.kernel.org>; Fri, 29 Oct 2021 15:29:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbhJ2PcK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 29 Oct 2021 11:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbhJ2PcD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 29 Oct 2021 11:32:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A7FC06120E
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 08:29:33 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id x27so21791469lfu.5
        for <linux-mmc@vger.kernel.org>; Fri, 29 Oct 2021 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zb5to8IVmbXLcOuzy5HbR2D8SvYMJeBSxxm0t+10yes=;
        b=jJdFEoGn8EIaT8Neu3EZWdJ0T5kC3jtTFduArBVtuDx6mWscceXNrcx8A7PEO5SBFt
         VxxBXXtewNAOyGL9NISwbn8uqUJ5agsj+UemHZbI2/6GXh0Tr7GVCB0sMxna8iiURDvP
         v9RHYsHtNaNk3Z5iFWB2866iTaQva51DvN9TpWrWrCbscBsIE0cO9GtkiubMAwsrOnIj
         yM8X/+Go+hn6MacM8IB9wZCUBNon7GCbqfRHOQnFdCG8KGX3ZiGnYkm2SdJYeEhRuB4s
         y7d2vyxzyYm6MajX8LroWwZMrNJxTMCADiRhF8UTkbgJfaP60pk1oD6GF5HsVYx/WHnM
         NnEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zb5to8IVmbXLcOuzy5HbR2D8SvYMJeBSxxm0t+10yes=;
        b=QpUhK6GYxXqsY6jk8bVzARSMM5kM+wWltpuc6ihl1w7cEsXMUmQ9Mo/U0ZNHpwaIdE
         pfPXkY3XhPHdeK0w9Fjy69PETLVceCRVxsHz44ofJTb90bhTUNzRgmzCGZZpZn3MhW1C
         JJg2+6L6K3gYkLohiqi3lfAtYnGUxwNgLkFqWew03UXaTMxnNrww2B+Z7qBzgOKEVRlY
         lGHCE4Kluxcx+d3HZ8z/uBLIO13ypSoRNJ4hDpCD+kydwS9zG9nKdUyy+5ZO3PoU/ao5
         jsBHaMVQkd+33ne0rbj5AuUCRl4pu/6nXaNDce4nzZyr88/YFLap8n+IrYcNlpF0naO5
         /nOw==
X-Gm-Message-State: AOAM530dXwsauZw0vay/aXTCXDa1KrfPqHLkeZB3s2d54ZleO26w4ozB
        RO+RZ7T8eM81zYNE+fYdsKAleYuloP9lP7ANYjWS5A==
X-Google-Smtp-Source: ABdhPJz3Gt3DD4ggJlW5a/iffQ9H3If6jJ5fMxiXKNlpkM72XuoMKE2zri1Er8kmZWdw04yhv5F2a0V1Eko88RxRgy4=
X-Received: by 2002:ac2:5328:: with SMTP id f8mr11555895lfh.233.1635521371526;
 Fri, 29 Oct 2021 08:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <20211025224032.21012-1-digetx@gmail.com> <20211025224032.21012-21-digetx@gmail.com>
 <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
In-Reply-To: <09c05206-c0e5-9a25-8ffa-b9291f6ea5ae@gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 29 Oct 2021 17:28:55 +0200
Message-ID: <CAPDyKFoa5eQTrNxyiFevUCWitUecX=hi=y7qv1dC2mqk0+0XBA@mail.gmail.com>
Subject: Re: [PATCH v14 20/39] pwm: tegra: Add runtime PM and OPP support
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Lee Jones <lee.jones@linaro.org>,
        =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Nishanth Menon <nm@ti.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-mmc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, David Heidelberg <david@ixit.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 29 Oct 2021 at 17:20, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 26.10.2021 01:40, Dmitry Osipenko =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > +     ret =3D devm_pm_runtime_enable(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D devm_tegra_core_dev_init_opp_table_common(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> > +     ret =3D pm_runtime_resume_and_get(&pdev->dev);
> > +     if (ret)
> > +             return ret;
> > +
> >       /* Set maximum frequency of the IP */
> > -     ret =3D clk_set_rate(pwm->clk, pwm->soc->max_frequency);
> > +     ret =3D dev_pm_opp_set_rate(pwm->dev, pwm->soc->max_frequency);
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "Failed to set max frequency: %d\n", =
ret);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> >       /*
> > @@ -278,7 +294,7 @@ static int tegra_pwm_probe(struct platform_device *=
pdev)
> >       if (IS_ERR(pwm->rst)) {
> >               ret =3D PTR_ERR(pwm->rst);
> >               dev_err(&pdev->dev, "Reset control is not found: %d\n", r=
et);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> >       reset_control_deassert(pwm->rst);
> > @@ -291,10 +307,15 @@ static int tegra_pwm_probe(struct platform_device=
 *pdev)
> >       if (ret < 0) {
> >               dev_err(&pdev->dev, "pwmchip_add() failed: %d\n", ret);
> >               reset_control_assert(pwm->rst);
> > -             return ret;
> > +             goto put_pm;
> >       }
> >
> > +     pm_runtime_put(&pdev->dev);
> > +
> >       return 0;
> > +put_pm:
> > +     pm_runtime_put_sync_suspend(&pdev->dev);
> > +     return ret;
> >  }
> >
> >  static int tegra_pwm_remove(struct platform_device *pdev)
> > @@ -305,20 +326,44 @@ static int tegra_pwm_remove(struct platform_devic=
e *pdev)
> >
> >       reset_control_assert(pc->rst);
> >
> > +     pm_runtime_force_suspend(&pdev->dev);
>
> I just noticed that RPM core doesn't reset RPM-enable count of a device
> on driver's unbind (pm_runtime_reinit). It was a bad idea to use
> devm_pm_runtime_enable() + pm_runtime_force_suspend() here, since RPM is
> disabled twice on driver's removal, and thus, RPM will never be enabled
> again.
>
> I'll fix it for PWM and other drivers in this series, in v15.

Good catch - and sorry for not spotting it while reviewing!

Maybe devm_pm_runtime_enable() isn't that useful after all? Should we
suggest to remove it so others don't fall into the same trap?

Kind regards
Uffe
