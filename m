Return-Path: <SRS0=Uo47=64=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A81C0C433E0
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 10:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FEC22065D
	for <linux-mmc@archiver.kernel.org>; Thu, 14 May 2020 10:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a3xqgdqL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgENKTh (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Thu, 14 May 2020 06:19:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726011AbgENKTg (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 14 May 2020 06:19:36 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D426C061A0C
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2020 03:19:36 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id p5so634390vke.1
        for <linux-mmc@vger.kernel.org>; Thu, 14 May 2020 03:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F9G3dflweaHDPQ+DS1CDjH+ihEsjNaelVa9NdojUt1E=;
        b=a3xqgdqLwtQ2GtV4uxSscMi3XPr4JXvwBDE9qNvMFMDrFxbMEMFHXxxmX2ScvvYnW2
         mgpfQbZLAERGYpSvOdPbdKx5bWFfrQcTSAbIjLBLFFo8Ck8sw/im0O/73LKOcLecUY0X
         7VEMA0I3XKJUVkSmUWj3sY36IYpvgkvUZAzgxsM1ipfsnyLHEt881StGmwi8uXBaENG8
         Qr8Mkv+u+Dje+bWINIQg+P1uQGZPJ9t5SJwa4wuX0+kO2b+fa3/3OT5haesXj2AXxUDD
         cZEADroHyXXkmQA8yln7dwFDwWbwAIAqovrj9RXf4wUOZREniJ9FTo7JbDwL/ceRUL/q
         QDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F9G3dflweaHDPQ+DS1CDjH+ihEsjNaelVa9NdojUt1E=;
        b=N0N/7Wv40i5cDiyF9VLHEF/eneXv5OKpTuHG6lglaxnQJp5V2hzMq/udf2rzA7d0HN
         cA8Who3vcSWN8BaHR9yR31ev852UcK4X6MGLw9cFggPg4sGeoTTxRv4xvgnBCkaecreT
         15sgLnqU6Ww7b6+LRSpo4eW0L6TZUm4gcbPEdZGck0APccnuv8NWfUt/JT0RsI/gl0b5
         C6Aclbkk0uYHq20YFrNewnpwClPPEqYMAK16CXiPvLTyQf86ciBCjXKQjihMBA27c+7s
         jqiNx9szTidse40qJPru2n5/siRZ+saVmYZPM9ArLwUKCxNqz4gX/3gQLla3vYix9sp4
         lskA==
X-Gm-Message-State: AOAM531khj1jrCYo/yTZ08MtkL0cdhPOuscUkZU3SkbcPJG4NPrgVjAE
        uvVlZsST8uD2Z2XYinw/+tyIbCCFxoz3/fpNw3PvCA==
X-Google-Smtp-Source: ABdhPJw/cbscMUafVNEDWx0LEt3Ufyo0rEx2MYE2HsdQpv4OQkUp3OpkBIOV7zGBHKw2YpLTymVJKWt7oI5hIJIImhs=
X-Received: by 2002:a1f:25d7:: with SMTP id l206mr2770124vkl.53.1589451575120;
 Thu, 14 May 2020 03:19:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200513174706.3eeddb2b@xhacker.debian> <CAPDyKFpE_uqiNQ22Fq9hDfb5pzMBdgmwgUbasEsEdXFkEOmq6A@mail.gmail.com>
 <20200514134507.54c17936@xhacker.debian>
In-Reply-To: <20200514134507.54c17936@xhacker.debian>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Thu, 14 May 2020 12:18:58 +0200
Message-ID: <CAPDyKFpUv=HGBAEchH25tdnRdUSAvbCgGGCgN8uuvPCQ92xwZg@mail.gmail.com>
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

On Thu, 14 May 2020 at 07:45, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
>
> On Wed, 13 May 2020 14:15:21 +0200 Ulf Hansson wrote:
>
> >
> >
> > On Wed, 13 May 2020 at 11:47, Jisheng Zhang <Jisheng.Zhang@synaptics.com> wrote:
> > >
> > > This reverts commit a027b2c5fed78851e69fab395b02d127a7759fc7.
> > >
> > > The HW supports auto clock gating, so it's useless to do runtime pm
> > > in software.
> >
> > Runtime PM isn't soley about clock gating. Moreover it manages the
>
> Per my understanding, current xenon rpm implementation is just clock gating.
>
> > "pltfm_host->clk", which means even if the controller supports auto
> > clock gating, gating/ungating the externally provided clock still
> > makes sense.
>
>        clock -----------  xenon IP
>       |___ rpm           |__ HW Auto clock gate
>
> Per my understanding, with rpm, both clock and IP is clock gated; while with
> Auto clock gate, the IP is clock gated. So the only difference is clock itself.
> Considering the gain(suspect we have power consumption gain, see below), the
> pay -- 56 LoCs and latency doesn't deserve gain.
>
> Even if considering from power consumption POV, sdhci_runtime_suspend_host(),
> sdhci_runtime_resume_host(), and the retune process could be more than the clock
> itself.

Right.

The re-tune may be costly, yes. However, whether the re-tune is
*really* needed actually varies depending on the sdhci variant and the
SoC. Additionally, re-tune isn't done for all types of (e)MMC/SD/SDIO
cards.

I see a few options that you can explore.

1. There is no requirement to call sdhci_runtime_suspend|resume_host()
from sdhci-xenon's ->runtime_suspend|resume() callbacks - if that's
not explicitly needed. The point is, you can do other things there,
that suits your variant/SoC better.

2. Perhaps for embedded eMMCs, with a non-removable slot, the
re-tuning is costly. If you want to prevent the device from entering
runtime suspend for that slot, for example, just do an additional
pm_runtime_get_noresume() during ->probe().

[...]

Kind regards
Uffe
