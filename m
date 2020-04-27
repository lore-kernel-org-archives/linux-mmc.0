Return-Path: <SRS0=ssCU=6L=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD97C54FCB
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 16:24:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841D7206B9
	for <linux-mmc@archiver.kernel.org>; Mon, 27 Apr 2020 16:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="C/UeX3V2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbgD0QYC (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726229AbgD0QYC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Apr 2020 12:24:02 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22425C0610D5;
        Mon, 27 Apr 2020 09:24:02 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id nv1so14649380ejb.0;
        Mon, 27 Apr 2020 09:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KWPoYwJEl9V5YJAC4WNuwBg/dxHA3IxOpuyKiILxznU=;
        b=C/UeX3V22n4clKX0lidBg1wfTgyte141RHR4D/yMWPz4MmLO9VSKjxOGhfZUMvSxh5
         lahhhGC1BnRLcRys8vkijyNhoC3ZriRyC34w1IELDASTlvq2yV7ZfrwIiYS72NBDmLDu
         yaZl3kzdt+u9A/quzE5wJf2u6aJQ4ktAIJa87cuf1+MfjEeICkqJ44WBRN47Iy3Uswx6
         ahFVmC+2xRhc80opYNR1EgJrlmOVOA3wuePis6UkUONHFv//rO7Cuqf3X12VTLz7xU0p
         GkNxzuyjfUzFaHe7y1wNaVWkmcegsxROdx7l1tBryU73TvdBcHVdr/yKY9XSL8hzj0cR
         Hyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KWPoYwJEl9V5YJAC4WNuwBg/dxHA3IxOpuyKiILxznU=;
        b=Hkk1/1aBlR6m2oySy67fiJoFhERt4y3OebyXAfLTXtey2I3wgXkyBYu2uFDnNY5Jfm
         8pTmEtr21c1jmshugRbPpx+kLZoS7waYPTKxLu21DmzF8yFvRLtKYdDBU/XDGlf9pOWh
         Yf/JzliuhlsDNwoW/eYNIDASkVOlGdnrpNpbi84aK4W5A+39zLNfLmYi7uxYfv6pCft2
         C/rk2LW+CeOT6X6ZkKzilvCFvlu3TSfeWxoRfyPxQyDbM0a5z7KiBMoI4q//API/Aenx
         ufX7673RTqFe5PnNW3PORndrn+Er8Jhgdq2qtIpE3KHQ+zgvL18UKl9kS896qqEDf7/R
         GwMA==
X-Gm-Message-State: AGi0PuZNG483UKqmj9LRbvoAeKIJCflcyHleY1wblvJZ3ECcy0Qe9LfK
        6Md9fGNHgXQXfZPigvqa/2thlKVicjuVbYZwHf0=
X-Google-Smtp-Source: APiQypLMHO3pnC6/d3Uf/T8HCEFOxHwcaSjxBATefEkEjE6SvjUvYOMC854uurowtQ2fXp3sQqiBg2bcmRKVKa8jO68=
X-Received: by 2002:a17:906:1a06:: with SMTP id i6mr19961325ejf.90.1588004640687;
 Mon, 27 Apr 2020 09:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200328003249.1248978-1-martin.blumenstingl@googlemail.com> <1jblnd2tp3.fsf@starbuckisacylon.baylibre.com>
In-Reply-To: <1jblnd2tp3.fsf@starbuckisacylon.baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 27 Apr 2020 18:23:49 +0200
Message-ID: <CAFBinCDzNw6nV3oBJs6C0sssW61GERBXq39DCM22BT9zS8M31A@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] Amlogic 32-bit Meson SoC SDHC MMC controller driver
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-mmc@vger.kernel.org, ulf.hansson@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, jianxin.pan@amlogic.com,
        linux-kernel@vger.kernel.org, yinxin_1989@aliyun.com,
        linux-arm-kernel@lists.infradead.org, lnykww@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi Jerome,

On Mon, Apr 27, 2020 at 10:56 AM Jerome Brunet <jbrunet@baylibre.com> wrote:
[...]
> > Changes since v3 at [3]:
> > - split the clock bits into a separate clock controller driver because
> >   of two reasons: 1) it keeps the MMC controller driver mostly clean of
> >   the clock bits
>
> If the register is in the MMC controller register space and the MMC
> driver is the driver using these clocks, it is where the clocks belong.
> I don't get why it could be an issue ?
>
> Is the clock block is shared with another device, like on the Gx family ?
no, it is not shared with another device (to my knowledge).

> > 2) the pure clock controller can use
> >   devm_clk_hw_register() (instead of devm_clk_register(), which is
> >   deprecated) and the MMC controller can act as a pure clock consumer.
>
> Why can't you use devm_clk_hw_register in an MMC driver ?
> Unless I missed something, it is provided by clk-provider.h, which can be
> included by any driver.
indeed, I could use devm_clk_hw_register in the MMC driver.
Ulfs concern was that a lot of code was needed for managing the clocks
and I agree with him. so this is my way of keeping those details away
from the MMC driver and have two separate drivers which are better to
understand overall.


Martin
