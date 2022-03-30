Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98BB0C433EF
	for <linux-mmc@archiver.kernel.org>; Wed, 30 Mar 2022 20:29:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231261AbiC3Ua5 (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 30 Mar 2022 16:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350967AbiC3Uaz (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 30 Mar 2022 16:30:55 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 821CF2E692
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2022 13:29:10 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-df02f7e2c9so10798395fac.10
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2022 13:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EBcFsPpBOyUxMEU9H+5eyn/s7lGgdO0ytASVcAnuyUk=;
        b=oOXcqfjkyuYdgdmxLI/iIxMEP8saEapZ2EYdYfJYsjZCN64M7/VMNSmTtFhfde3FOy
         KaaTOpOJ1d0bjO4QHmroHNjF/YgNAEIrpOQUAyqS0CHH/XdOxh3pHc4g+t/VQPkk2aIl
         QPlyy7qQngXPjAZ4eEOHksfLmIg++gKf1+M8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EBcFsPpBOyUxMEU9H+5eyn/s7lGgdO0ytASVcAnuyUk=;
        b=KTsMgRP+yPly57xG1ayEJGvKcO/wQPYwcGo8kSonbCGETI1YB9hMHKse2cBBKQirau
         l/B8Cum6qtn+E7zsSGxRj+55S7HJ0uNR0B0aeM31+IlNWopiXRuLOs6Wk05SE0o3RKJ3
         +uIZlBfubMej+atV9RGBzwBD3E+krx6LxRhaVyqUvK2DsmmCQetBNIhZSH/XkKICsAW4
         cRTuh669PHIgrIbMrjOoXvEp8UrPIQGDaMSXhxKSJp5AwcVaZjjN8SVWjiHAhfMYRfFG
         tSiBSjVUkXHqCtNN42eKrwEHVj+hSE7l3u9/wxelOIxs/o9J8mKW6S8uomh/jZv4v9eu
         Q0bw==
X-Gm-Message-State: AOAM532IDBiZteSiYtaUcKfErdjUNiJNPfKruBUExfhygH/p0yGF9BDy
        QQoarYYMnk1lbpAE9lPBFoggP8Y31H2ohQ==
X-Google-Smtp-Source: ABdhPJyOPIRkDD3yDsnafR+93LxbNQ/xRGbaopqr+BKvjeT6RKN0wFQq9PHDbv4jxr5AMWvRP0oWyg==
X-Received: by 2002:a05:6870:f144:b0:da:b3f:2b88 with SMTP id l4-20020a056870f14400b000da0b3f2b88mr814095oac.295.1648672149029;
        Wed, 30 Mar 2022 13:29:09 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id t19-20020a05687044d300b000de4e33171csm9940911oai.34.2022.03.30.13.29.07
        for <linux-mmc@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 13:29:07 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id q189so23221176oia.9
        for <linux-mmc@vger.kernel.org>; Wed, 30 Mar 2022 13:29:07 -0700 (PDT)
X-Received: by 2002:aca:5e84:0:b0:2ec:9c1d:fc77 with SMTP id
 s126-20020aca5e84000000b002ec9c1dfc77mr886786oib.291.1648672146590; Wed, 30
 Mar 2022 13:29:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220318185139.v2.1.I484f4ee35609f78b932bd50feed639c29e64997e@changeid>
 <CAPDyKFqCcSkHx92XcDkGH19JZyGgkALuf9wGNiBjKkFt4SaDTQ@mail.gmail.com>
In-Reply-To: <CAPDyKFqCcSkHx92XcDkGH19JZyGgkALuf9wGNiBjKkFt4SaDTQ@mail.gmail.com>
From:   Brian Norris <briannorris@chromium.org>
Date:   Wed, 30 Mar 2022 13:28:55 -0700
X-Gmail-Original-Message-ID: <CA+ASDXM_RdU3qucLSZ421rw3uzDdf0-_459os-Ox_JFM8kn1bQ@mail.gmail.com>
Message-ID: <CA+ASDXM_RdU3qucLSZ421rw3uzDdf0-_459os-Ox_JFM8kn1bQ@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: core: Set HS clock speed before sending HS CMD13
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Thu, Mar 24, 2022 at 5:13 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Sat, 19 Mar 2022 at 02:52, Brian Norris <briannorris@chromium.org> wrote:
> > @@ -1482,6 +1487,12 @@ static int mmc_select_hs200(struct mmc_card *card)
> >                 old_timing = host->ios.timing;
> >                 mmc_set_timing(host, MMC_TIMING_MMC_HS200);
> >
> > +               /*
> > +                * Bump to HS200 frequency. Some cards don't handle SEND_STATUS
> > +                * reliably at the initial frequency.
> > +                */
> > +               mmc_set_clock(host, card->ext_csd.hs200_max_dtr);
> > +
>
> If the mmc_switch_status() fails with -EBADMSG, we should probably
> restore the clock to its previous value. Otherwise I think we could
> potentially break the fallback implemented in 3b6c472822f8 ("mmc:
> core: Improve fallback to speed modes if eMMC HS200 fails")

OK, done for v3.

> Moreover, this change means that we will be calling
> mmc_set_bus_speed() from mmc_select_timing(), to actually set the same
> HS200 clock rate again. That is unnecessary, can we please avoid that
> in some way.

There's not a super clean way to track which paths pre-bumped the
frequency, especially once you account for host->f_max (as
mmc_set_clock() does). I've chosen to teach mmc_set_clock() how to
return early if the clock change is redundant.

Brian
