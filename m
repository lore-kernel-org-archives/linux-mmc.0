Return-Path: <SRS0=CGCI=65=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76908C433DF
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44906206F4
	for <linux-mmc@archiver.kernel.org>; Fri, 15 May 2020 07:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pFgKDKk7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbgEOHCK (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Fri, 15 May 2020 03:02:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726295AbgEOHCK (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 15 May 2020 03:02:10 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E58DC061A0C
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:02:10 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id h9so637084vsa.3
        for <linux-mmc@vger.kernel.org>; Fri, 15 May 2020 00:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sgU13Kc+HGjnXldvrdhY5980/BNCXPEM10WiDRFS03A=;
        b=pFgKDKk720R91YwhG113PrRjxUIWD3RdicIP0iQlBI/gF9/XYXl9D5xEMKZG7l9mCa
         cr4mtt2zEa2hiWeX+rhx2o4qI7LQZ53x59z4Zu6IytOuwpV7Ps+xiG5XtRY+4ID33qHi
         zZ+cVDfABknYj7jtWygH+D7syWW1dvzEkbIzOrH9tFJoDF4bBRq+nJtHIVCQiE42Xr7Q
         CSgz5UtNVODPQ2HyRnfDR8+eH7uLPedCTzYgm3SZXr0j0XVYQWceRwD4lNeKK6Ksuf/d
         iz3G3DoIOwrFNdo2nDq1xDJVIPwGvlyK0HwZVL+CZUO9vOWpuGT8nfUtnUm+qcgOgXTh
         xTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sgU13Kc+HGjnXldvrdhY5980/BNCXPEM10WiDRFS03A=;
        b=PY8xuZGDIs/jeQFx8nRIN4EUi3lTve8MVgJmWDr95CJpF/JOKGb3cpnrQF/lr4mgBz
         kOOuSlpImpWHUURyPa9+/h9sZ0FqpNG65CNRKc4fEL5ML+p5uV9D0Ke2dtK60cABYpLz
         cOUxWss557hnuiBLzq3rjLn4lBIRCTdfKjnChtMsIUIkIBNP3ppmdxzd3h06gGbY7kvW
         G7AmqJprPAyvRiwjUy9f8Su/T6Bt9bG5Tz6OHLTn4o5cq/oSeWzlbYZ/gkflB7ZIErne
         VBAqiKpzGnd2YM4g1lG6xtittvw9ye77ReSg5ATL4OeoTYoZ6RnmOEKNOqjwzYheeh5C
         af9w==
X-Gm-Message-State: AOAM530D6u5BdQQO3zEZr+UeLkGnt8eFgbnuLbIvo30rm1WFCq8qJ9Vq
        bmyHAnI7G3sRh/WMGp9akNYxdLTRSDhK7FbFjMvQhHoM
X-Google-Smtp-Source: ABdhPJyaR7V3dikIRkypHdFpMj0NsapuNRzxksZYZbQt4Ns2w50pkKiUb9ZvS28rW6Lgu/f22M49zi8FBOgq9tC8KLQ=
X-Received: by 2002:a67:8b46:: with SMTP id n67mr1431361vsd.35.1589526129228;
 Fri, 15 May 2020 00:02:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200513174706.3eeddb2b@xhacker.debian> <CAPDyKFpE_uqiNQ22Fq9hDfb5pzMBdgmwgUbasEsEdXFkEOmq6A@mail.gmail.com>
 <20200514134507.54c17936@xhacker.debian> <CAPDyKFpUv=HGBAEchH25tdnRdUSAvbCgGGCgN8uuvPCQ92xwZg@mail.gmail.com>
 <20200515140008.6c8a8f2b@xhacker.debian>
In-Reply-To: <20200515140008.6c8a8f2b@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Fri, 15 May 2020 09:01:33 +0200
Message-ID: <CAPDyKFpXyhL32ZQH3Qi9FvXEu--0+YH8sLi927m56YJd3iNZWg@mail.gmail.com>
Subject: Re: [PATCH] Revert "mmc: sdhci-xenon: add runtime pm support and
 reimplement standby"
To:     Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 15 May 2020 at 08:00, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> On Thu, 14 May 2020 12:18:58 +0200 Ulf Hansson wrote:
>
> >
> >
> > On Thu, 14 May 2020 at 07:45, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> > >
> > > On Wed, 13 May 2020 14:15:21 +0200 Ulf Hansson wrote:
> > >
> > > >
> > > >
> > > > On Wed, 13 May 2020 at 11:47, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> > > > >
> > > > > This reverts commit a027b2c5fed78851e69fab395b02d127a7759fc7.
> > > > >
> > > > > The HW supports auto clock gating, so it's useless to do runtime pm
> > > > > in software.
> > > >
> > > > Runtime PM isn't soley about clock gating. Moreover it manages the
> > >
> > > Per my understanding, current xenon rpm implementation is just clock gating.
>
> what's your option about this? My point is the HW can auto clock
> gate, so what's the benefit of current rpm implementation given it only does
> clock gating. FWICT, when submitting the xenon rpm patch, I don't think the
> author  compared the power consumption. If the comparison is done, it's easy
> to find the rpm doesn't bring any power consumption benefit at all.

As I stated, runtime PM isn't solely about clock gating. It depends on the SoC.

For example, if this sdhci device is being powered by a shared voltage
rail through a PM domain, perhaps it's even critical from an energy
efficiency point to manage runtime PM correctly.

By looking at the original commit, that sounds exactly what is
happening as the registers seem to lose their context.

>
> > >
> > > > "pltfm_host->clk", which means even if the controller supports auto
> > > > clock gating, gating/ungating the externally provided clock still
> > > > makes sense.
> > >
> > >        clock -----------  xenon IP
> > >       |___ rpm           |__ HW Auto clock gate
> > >
> > > Per my understanding, with rpm, both clock and IP is clock gated; while with
> > > Auto clock gate, the IP is clock gated. So the only difference is clock itself.
> > > Considering the gain(suspect we have power consumption gain, see below), the
> > > pay -- 56 LoCs and latency doesn't deserve gain.
> > >
> > > Even if considering from power consumption POV, sdhci_runtime_suspend_host(),
> > > sdhci_runtime_resume_host(), and the retune process could be more than the clock
> > > itself.
> >
> > Right.
> >
> > The re-tune may be costly, yes. However, whether the re-tune is
> > *really* needed actually varies depending on the sdhci variant and the
> > SoC. Additionally, re-tune isn't done for all types of (e)MMC/SD/SDIO
> > cards.
> >
> > I see a few options that you can explore.
> >
> > 1. There is no requirement to call sdhci_runtime_suspend|resume_host()
> > from sdhci-xenon's ->runtime_suspend|resume() callbacks - if that's
> > not explicitly needed. The point is, you can do other things there,
> > that suits your variant/SoC better.
>
> Yes, there's no requirement to call sdhci_runtime_suspend|resume_host().
> But simply removing the calls would break system suspend. How to handle
> this situation?

Alright. Then perhaps you need parts of what
sdhci_runtime_suspend|resume() is doing?

Anyway, as I said below. If you really have some good reasons from an
energy efficiency point of view, you can always disable runtime
suspend, along the lines of below.

To put it clear, to me the reasons you are providing to justify the
revert just doesn't make sense. Please try a different option.

>
> >
> > 2. Perhaps for embedded eMMCs, with a non-removable slot, the
> > re-tuning is costly. If you want to prevent the device from entering
> > runtime suspend for that slot, for example, just do an additional
> > pm_runtime_get_noresume() during ->probe().
> >
> > [...]
> >

Kind regards
Uffe
