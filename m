Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9386C54FD0
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 06:59:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77412084D
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 06:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R/yZNbJ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726690AbgD0G7P (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 02:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbgD0G7O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 02:59:14 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4058C061A0F
        for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2020 23:59:14 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id s5so16269977uad.4
        for <linux-mmc@vger.kernel.org>; Sun, 26 Apr 2020 23:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p75ZI/P1vAKdvQGL/dkDYNcJX48p538uaKviA/7sw78=;
        b=R/yZNbJ/FXJTeWHoBM/VGrSujsjvdbo2k6YfYwGCyStA4w4Vu+3r6pSliy3CmjHCY9
         SfTABC9U26Iuir75W2uhDMbjYrKuCe5gUJz+hjZT/9SPfNH7Wq+s6evzjQF/O4AlxycF
         7sWy9vdMYVW9+yX3/Mj1hq8Cq3GpFlBCf+O/f2/OrfpFFZM2dIPGtKvQdDFpzz+h3cRb
         YxUtXuByeXDj0ep4IIuVfFOTzrd8fJuc5IhLadjFSz8WuRsGOpPAvfFz5aPQ12iGPdpR
         +6r3h9+BxdYKM75iYz3wwyH0hWBh//y4y7f8slVNxEbN4lNLXnntUxChGWyVjmNjp1tw
         oeLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p75ZI/P1vAKdvQGL/dkDYNcJX48p538uaKviA/7sw78=;
        b=VUoBDtT/KhX/OT3kKtGJw7jQFTcvYrzvP8eLxnXJMtV1+dKqC7ycKmI9viUH7J2Qy5
         5rC53Jwd7h2Mt/kAEqoMFyBCxvOoXgPW5IECVrRrytgT0l8gwErPa1fyorRJtDJBvnSx
         ypeeaMBnd1XFs6gmN/A8n5rVXo+ixNVX8a3eZcfkctTb/J11Thwzi+FUl7EYf0Z3+prS
         hk0qCpCgb7tTtB+RfyqlF42LjH8n0En+PCXL6jKtDoNr5hDFBZ5F28hC7xeUYu5FizOR
         RjcIrda72EmAtO3DRhF1UORc87jImfbAMwia+FfpO5DYwt6fO4FqvCHOIgwSaL3hJuca
         GiDw==
X-Gm-Message-State: AGi0PuY0bS8se5Fz6wE9a7yb99nELSJL0m0QJ++H/+RWyJqgXg5rkRN0
        cOABaKUOLRJSGX248C39kbf3vPTYn+4kAmBEtPhlx+BZjuQ=
X-Google-Smtp-Source: APiQypLgdu94xf46n59WAXNWbtQ/etKr47I9IXWtRxhdXwH7gOWdeXqlB5oxfaZVEhk0xe+ABAYpaedqjH2ouRHKL5s=
X-Received: by 2002:a67:11c4:: with SMTP id 187mr15068680vsr.34.1587970753925;
 Sun, 26 Apr 2020 23:59:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com> <CAFBinCDCv-zNf1FX+8FHMxcNdJ_69yog+O_=QPz3Fzryg3ynAw@mail.gmail.com>
In-Reply-To: <CAFBinCDCv-zNf1FX+8FHMxcNdJ_69yog+O_=QPz3Fzryg3ynAw@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 27 Apr 2020 08:58:37 +0200
Message-ID: <CAPDyKFqNgS4JGRqMDeMgguAHd11W_OpzxyKDjaWoTUXUdc6fwg@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Amlogic 32-bit Meson SoC SDHC MMC controller driver
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        lnykww@gmail.com, yinxin_1989@aliyun.com,
        Jerome Brunet <jbrunet@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Sat, 25 Apr 2020 at 22:27, Martin Blumenstingl
<martin.blumenstingl@googlemail.com> wrote:
>
> Hi Ulf,
>
> On Sat, Mar 28, 2020 at 1:33 AM Martin Blumenstingl
> <martin.blumenstingl@googlemail.com> wrote:
> [...]
> > Martin Blumenstingl (3):
> >   dt-bindings: mmc: Document the Amlogic Meson SDHC MMC host controller
> >   clk: meson: add a driver for the Meson8/8b/8m2 SDHC clock controller
> >   mmc: host: meson-mx-sdhc: new driver for the Amlogic Meson SDHC host
> I have Rob's reviewed-by for the dt-bindings patch and three
> tested-by's for the MMC driver in patch #3 (which means that patch #2
> was implicitly tested as well)
> I tried to answer all your previous questions where possible, but for
> some of your questions I simply don't have an answer.
>
> is there anything from your side which is holding this driver back
> from being merged?

Apologize for the delay. I will have a look asap.

>
> +Cc Jerome, because he is the maintainer of the Amlogic clock
> controller drivers - where this series adds another one, so we need to
> coordinate where patches go.

It seems like you may need to resend the series so the clock
maintainers (Stephen and Jerome) can get a look as well.

Perhaps it's better if the series is queued together - and can help to
do that, but then I need acks from Stephen/Jerome for the clock patch.

Kind regards
Uffe
