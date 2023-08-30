Return-Path: <linux-mmc-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73F68C83F22
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbjH3S3U (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242234AbjH3HcZ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Aug 2023 03:32:25 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD1FDCCB
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 00:32:19 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bbb3195013so116495ad.1
        for <linux-mmc@vger.kernel.org>; Wed, 30 Aug 2023 00:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693380739; x=1693985539; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iz2oCR+RAlpCrkxasky0/cEyFi5EfsfgieHbbEfIWZM=;
        b=yLxBw6Egb45a0joG/LAHUP2vv3u5FOVU8rsczXV7MAXxXuUA3qqj04LC8A/Kvu9vFm
         CeNhIbRL2PPycc2BrqO0l+sDJcRCNVZMIVlI13zGbVM9HDXIWmBk4LB8qFWJRuk3ELEB
         bMlxM9oFaS1QTjfFRgsUdaSES/0CIdzxYHj07K1Bqv/XB0ptcl302L4R7Qe+AqjMCrxE
         co+TE6zQEvwl7JWlNMr6PQqjEuqjjZnmowoOOcmrKvgbEXvolIUxqkVU2TMx2CD4eTfS
         +IKFD7+4CfiGBX9OFZgJCSgaVW6inxpXOWh9J/c1RTv+gcGi7Y+XQF44iqf/FLxPdWhB
         SsOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693380739; x=1693985539;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Iz2oCR+RAlpCrkxasky0/cEyFi5EfsfgieHbbEfIWZM=;
        b=PCzyn9adXidb0DNt63G6d5JVSPgdbuuCGHYW6VQkWYkpN2YP4zNYLaXIw1AHnzpWKq
         jfQbc2qhQNi/bWzPAPhcpOMlc+ZSJTSBBQ3nhKnhg2xLMpUn9nCSAMlUh/BYgSUgIGyT
         X6yfH5c+rTV54nQMYRHsJWiUilqkzhKl/2C5E7i+YxURyVa1zTHep7yItP9LtlXT9wHD
         V1mEWJcLsPr3/k7NZlsHUOrN38mMdIP2ifXCTwXVfBF9og1SvKcYn17YrbTs4xgUr/3P
         7zrU85JvQ8NV4XnbUkY1LvBbYZBhUEYNG2IMB7iHxemsIVWfk84drwmEQ1StzTMPFkrc
         Di1Q==
X-Gm-Message-State: AOJu0YwjrWJosr0R4JArfNtM/2cE9X/CDu6KrNiZDR8CGTk/AsOCxSn1
        ADPXp6NfR6kWerdKDkaHWTAt5eMZU4+ngVkAHtj+/g==
X-Google-Smtp-Source: AGHT+IHZDLHCdHYQ9I3MT4mWpxfcxGu0ny/XtY9avjaPygtJms04xIPzZ3tibXlSN07Fmv4Sg13Y6y8nu+j0D9py61Y=
X-Received: by 2002:a17:902:d2c2:b0:1ae:51f3:a4d with SMTP id
 n2-20020a170902d2c200b001ae51f30a4dmr468257plc.13.1693380738930; Wed, 30 Aug
 2023 00:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <391c4270-637a-2afb-210d-6b6dfef01efa@intel.com>
 <20230828100313.3051403-1-benchuanggli@gmail.com> <CAG-rBig+koxDf3TuC-0p=tcBY_2WM1sPCvRDtjRmR7AnikrN-A@mail.gmail.com>
 <CACT4zj-BaX4tHji8B8gS5jiKkd-2BcwfzHM4fS-OUn0f8DSxcw@mail.gmail.com>
 <CAG-rBihBkTeZR6yMSF+5zg-h1U1pxGuN-nv=Y7DXLvxV435hDw@mail.gmail.com> <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
In-Reply-To: <CACT4zj_84eCYOq56zdqaydaEGqyqBrXDrsTkDRyCntvVF78-0A@mail.gmail.com>
From:   =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>
Date:   Wed, 30 Aug 2023 09:31:41 +0200
Message-ID: <CADj_en4MTtqm0VSs2=1K5VB0fpZjga3ttMLE7RoEGQgxvQ8XFA@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Ben Chuang <benchuanggli@gmail.com>
Cc:     Sven van Ashbrook <svenva@chromium.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        adrian.hunter@intel.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, greg.tu@genesyslogic.com.tw,
        jason.lai@genesyslogic.com.tw, jasonlai.genesyslogic@gmail.com,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        reniuschengl@gmail.com, stable@vger.kernel.org,
        ulf.hansson@linaro.org, victor.shih@genesyslogic.com.tw,
        victorshihgli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Wed, Aug 30, 2023 at 4:27=E2=80=AFAM Ben Chuang <benchuanggli@gmail.com>=
 wrote:
>
> Hi,
> On Wed, Aug 30, 2023 at 12:35=E2=80=AFAM Sven van Ashbrook <svenva@chromi=
um.org> wrote:
> >
> > + Rafael for advice on runtime_pm corner cases.
> >
> > On Mon, Aug 28, 2023 at 10:48=E2=80=AFPM Ben Chuang <benchuanggli@gmail=
.com> wrote:
> > >
> > >
> > > My concern is that when runtime_pm is false, gl9763e is disabled LPM
> > > negotiation, gl9763e can't enter L1.x and s0ix may fail.
> > > It seems that runtime_pm will always exist and that's ok.
> > >
> >
> > Thank you. I believe we can address your concern.
> >
> > - XXX_suspend/XXX_resume (i.e. classic suspend/resume) depends on
> >   CONFIG_PM_SLEEP. This always selects CONFIG_PM. This always includes
> >   the runtime_pm framework. So, if XXX_suspend/XXX_resume gets called,
> >   the runtime_pm framework is always present, but may not be actively
> >   managing the device.
> This is ok.
>
> >
> > - "when runtime_pm is false" AFAIK the only way to disable runtime_pm
> >   when CONFIG_PM is set, is to write "on" to /sys/devices/.../power/con=
trol.
> >   See https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-device=
s-power
> >   In that case, the runtime_pm framework will activate the device, call=
ing
> >   XXX_runtime_resume() if necessary. Are there other ways of disabling =
it?
> >
> > - if /sys/devices/.../power/control is "on", then:
> >   gl9763e_runtime_resume() always called -> LPM always disabled
> >   gl9763e_suspend() -> LPM enabled -> gl9763e_resume() -> LPM disabled
> >   In between "classic" XXX_suspend and XXX_resume, LPM will be enabled,
> >   so the device can enter L1.x and S0ix.
> In this cas, after gl9763e_resume(), it is LPM disabled.
> Is there no chance for gl9763e to enter L1.x again when the system is idl=
e?
With runtime PM disabled via sysfs, the short answer is not since
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?=
id=3Df9e5b33934cec24b8c024add5c5d65d2f93ade05.

The longer answer is:
1. System boots up with LPM flags in PCI config space in default value
(might be LPM enabled).
2.1. If runtime PM is disabled before first runtime suspend -
registers will be left in their default state.
2.2. If runtime PM is disabled after first runtime suspend, the device
will be woken up and the gl9763e runtime resume callback will disable
LPM.
>
> >
> > And the LPM negotiation flags look correct.
> > Does that address your concerns?
>
> Best regards,
> Ben Chuang

--
Best Regards,
Stanis=C5=82aw Kardach
