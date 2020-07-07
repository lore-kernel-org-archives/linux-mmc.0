Return-Path: <SRS0=aSBx=AS=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E177EC433DF
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jul 2020 07:15:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8DDC20656
	for <linux-mmc@archiver.kernel.org>; Tue,  7 Jul 2020 07:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pecCipcq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgGGHPE (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 7 Jul 2020 03:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgGGHPD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 7 Jul 2020 03:15:03 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2662C061755
        for <linux-mmc@vger.kernel.org>; Tue,  7 Jul 2020 00:15:03 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id h190so9181781vkh.6
        for <linux-mmc@vger.kernel.org>; Tue, 07 Jul 2020 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=X8k4LhyngBUgsPkXSIuJNd4eGfzJ30YM0Kw4kJO46WE=;
        b=pecCipcqBaIIXGxh5Rr/xZ6ORzkgD+l+9SY+gMkEc6lbYqVkTJBDq3ljKMB6TCZgqk
         S1zchLwa/XnMRuon8zOcsoSwgZJuZzJgzU40afdO8UY2NlzCSSMirTBn4JfsxDtVKzud
         qctjtjuCIHyq7ga7MoIo+N7vSNOAzMqbZ4FDd1EwGuqmpieCrc/WmfoX6mHaNLxC+B1y
         WXS52VtxthnlE9AqIi83Yf1qypNhU02j5hLhmbvb6D/8E8jEn9EO6P3FdPop29iBMjQP
         KutGedk7SnW9mTY5U4sAF5LFjkT/l4Xrnf6SFlN79i78nKbl2eEkOrWY6Xtb+Isv0yYi
         Z8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=X8k4LhyngBUgsPkXSIuJNd4eGfzJ30YM0Kw4kJO46WE=;
        b=cyjHoJ1qm03hnZCX+zf9oBWtJQO8YMbfRebUK6BbEj8J+O/S8H4wuhShcmpNRlB60H
         XQe1deaq7GXzVIWJMoyFqsgernUxKyLzF2h+FznwBnn4DEtHvmdgTXCMCFiB6lSkOmcN
         sv8z22BRXI9RlQArE0OpSR0juoHyty4ndb3/iTfUuB91O6MeAY90p01mPVrEC2ArEyaZ
         OA4XowNM9+1o9/0xt13r4RK0WCQ9TX2Fh1cAPT3ylf3spguDaInOBZ6dqqYpfBtjdJk3
         O1tE6IEG9ioEohAdctH5Vdm+Wh7Enlz8VnPEGCvnJMN+k/dzfx1oa7sTypYcYmm03V7g
         hPnQ==
X-Gm-Message-State: AOAM5308j+C8v5Q93slD2MVn7ioqe9fS7wjU8QvFCosdgBqoJnk1SDU4
        C+wvEtE8xvKkmJw03XaIn0Q5TgTg8Oqel6Lt0oQ4kA==
X-Google-Smtp-Source: ABdhPJxFrlE2Uv74xRyyyUk+mw5La7mTCFu3zD2rSt5vaFFD0yO+bCWdFasa+MeEk+EtQdrsOgplZR6Z45JIskW0Zqw=
X-Received: by 2002:a1f:3f0f:: with SMTP id m15mr37545331vka.53.1594106102886;
 Tue, 07 Jul 2020 00:15:02 -0700 (PDT)
MIME-Version: 1.0
References: <7768906b-7916-39be-08e9-0a5d0f6bf69e@microchip.com>
In-Reply-To: <7768906b-7916-39be-08e9-0a5d0f6bf69e@microchip.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Jul 2020 09:14:26 +0200
Message-ID: <CAPDyKFqvkHL3x9ODYAC1GMmabftoTZ9Ykois4t5RmnFfuKVfDA@mail.gmail.com>
Subject: Re: Clock selection before switching mode for eMMCs
To:     Eugen Hristev <Eugen.Hristev@microchip.com>
Cc:     "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 26 Jun 2020 at 18:00, <Eugen.Hristev@microchip.com> wrote:
>
> Hello Ulf, Adrian, and anyone interested,
>
> On our AT91 products we have an SD/MMC block with an included DLL that
> does not lock if the SD clock is not configured depending on speed
> modes, like high speed requires 25 Mhz, HS200 requires 100 Mhz, etc.
>
> All the spec and the code configures everything at 400 kHz and then
> moves to high speed, etc. and in the end , the clock is raised.
> While this is perfectly fine, on our block we need to raise the clock
> first and change the speed mode after.
>
> Namely, in the function mmc_select_timing , if we call first
> mmc_set_bus_speed then our DLL will lock correctly when selecting the
> mode. If we select the mode first, our clock is stuck.
>
> My question is actually how (if possible)  we could do a quirk in the
> mmc such that our block will work correctly.
> So I would need a little guidance about where to place such quirk, if it
> would be accepted or not, and we are forced to be incompatible with the
> linux-mmc sdhci .
>
> I have seen some patches for something similar a few years ago [1] on
> the ML, but they were left floating in the end, so that is why I am
> asking, which would be the proper way to do this.

I would prefer if this is addressed in the host driver. Typically in
the host's ->set_ios() callback, before you update the clock according
to ios->clock, you can check the ios->timing value. If the conditions
don't allow to update the clock, just defer it to next time when the
->set_ios() callback is being called, likely having the "correct"
ios->timing.

Would that work?

>
> Thanks !
> Eugen
>
> [1] https://patchwork.kernel.org/patch/7127441/

Kind regards
Uffe
