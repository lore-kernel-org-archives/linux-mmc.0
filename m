Return-Path: <linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D8AC433B4
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 20:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DAAC61205
	for <linux-mmc@archiver.kernel.org>; Wed,  7 Apr 2021 20:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233083AbhDGUhy (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 7 Apr 2021 16:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbhDGUhx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 7 Apr 2021 16:37:53 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1E1C061760;
        Wed,  7 Apr 2021 13:37:41 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id e186so20826942iof.7;
        Wed, 07 Apr 2021 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCpElm+uN0nKlaXcOWhtgRYdg8EWv7jaC5fSZFSUuVQ=;
        b=eeKK+hokZ78lIxpp1CJIqB/m3pYB/VQl9FlwjgwATA2DUVH+a93H0Nh3eo7Roa7d46
         oNwonyszu29BCWeqrzKTM46Ihh52BB/4JqlOOwzuvYvBIcVTHYatWmyKmv8IXt7MzNz8
         NUJJQCkh4n9rwO/HDB9lBrhWN3pmrjJow3aYE00+NcNsSEpB3wlLLid/bk5aYzaBY1p8
         mpgzTkWZQfy8f+NmJjfq1nxguLl37vdqRZuaVZYI8iT3t9d6qHsEDJ7rLZu9iMcRRw5t
         BS0IaSi6iqb67W8ebB6vbyaeh2/gFjF5FRD/zrvR2qI0Y2+LwMqyre6ZzvZo8vAwTEYN
         lGzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCpElm+uN0nKlaXcOWhtgRYdg8EWv7jaC5fSZFSUuVQ=;
        b=KzQFPhy97lg8/ckcpvE3t+6zl1+39KJ7xKHbgRZt/8yfDlDrsKA2KLRSb1MAHr4gl+
         6yiyrqBDR8oXJvbTiIcE1NN4hmh0fKxCN4m3Vq1kg4P3Q+BDs+6DUZY6OZPXpDrAVlOy
         aNCdMI/id4mZPAuAalEzkVXXOmzyuSuXKzJea64JeXYrk75IjmtthPZACssgYnaeCPrU
         Tkj0Ret5A0qFxp9kHRNHSYjLWVHGO5BEy5HEs0tms4qiZdkYT6iSzCKxRdrqrxrrDJHn
         +Glo5nhSmG5cvqlVRTxLxm/E47y24tNhI/WPkKVw1FSJnb/Iz3jCrz6orJBWAuBdXr/b
         HhMA==
X-Gm-Message-State: AOAM5309n5VKhTG87U9uflA4uObxvH8iOjfO+YoApU0FNWqf0s/w7W/C
        T14aK7cw0l8VNixSE0M2gAKR7/V9HQoVlAJmeJo=
X-Google-Smtp-Source: ABdhPJxm7xRmu9Llm1HKwK5Mfz4r5Kj77R/0UlJokS2jCKML85l6w6O1YFI2dH2GFwI2ZtvpbwbH1cZDERodEXGgrZE=
X-Received: by 2002:a05:6638:2209:: with SMTP id l9mr5297192jas.13.1617827860500;
 Wed, 07 Apr 2021 13:37:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210322185816.27582-1-nsaenz@kernel.org> <20210322185816.27582-5-nsaenz@kernel.org>
 <401100ea-90ad-57b1-50da-967118a090da@i2se.com> <78dec30c052e9bb76e52c38f3da5af371e5d65f5.camel@suse.de>
 <2d2a2638-8213-5d6e-0a3a-927ed5bb2ed7@i2se.com> <c7c8e20d3d11c7d6cd203797c5faffa8a4d202a6.camel@suse.de>
 <CAOGqxeUxOA_s6=KUh_XWFtRF_EWZgQH_y2MEdxUeDQTYMeb+3A@mail.gmail.com> <4d4e3de99dbee711cf47878bf98a7cc34c3f1e65.camel@suse.de>
In-Reply-To: <4d4e3de99dbee711cf47878bf98a7cc34c3f1e65.camel@suse.de>
From:   Alan Cooper <alcooperx@gmail.com>
Date:   Wed, 7 Apr 2021 16:37:29 -0400
Message-ID: <CAOGqxeWzjn70A_gP4Eh_ZLW0H3KkE_wA7QzeGRqU1u7xtJr-+Q@mail.gmail.com>
Subject: Re: [PATCH 4/4] ARM: dts: Fix-up EMMC2 controller's frequency
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        linux-rpi-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>, phil@raspberrypi.com,
        Tim Gover <tim.gover@raspberrypi.com>,
        Scott Branden <sbranden@broadcom.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        ": Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Nicolas,

I got a better description of the failure and it looks like the bus
clock needs to be limited to 300KHz for a 500MHz core clock.
What's happening is that an internal reset sequence is needed after a
command timeout and the reset signal needs to be asserted for at least
2 ticks of the bus clock. This is done using a 12 bit counter clocked
by the core clock. That means a 500MHz core clock produces a 122KHz
reset signal which is too fast for 2 ticks of the 200KHz bus clock
(100KHz) but is okay for the 300KHz (150Khz) bus clock.

Al

On Mon, Apr 5, 2021 at 4:45 AM Nicolas Saenz Julienne
<nsaenzjulienne@suse.de> wrote:
>
> Hi Alan,
>
> On Thu, 2021-04-01 at 11:23 -0400, Alan Cooper wrote:
> > Nicolas,
> >
> > Sorry, I just noticed this thread.
> > This is a known bug in some newer Arasan cores.
> > The problem happens when the difference between the core clock and the bus
> > clock is too great.
> > Limiting the clock to 200KHz minimum should be a good fix.
>
> Great, that's what I was hoping to hear :). Out of curiosity, can you share
> more details on how the failure occurs?
>
> > In my experience, it's only eMMC that needs the clock to be retried
>
> > below 400KHz and not SD or SDIO. That's because the CMD signal for
> > eMMC starts out as open-drain during identification and the size of
> > the pull-up on the CMD signal can require the <400KHz clock. Once eMMC
> > is out of identification mode the CMD signal is switched to push-pull
> > and can run at much higher clock rates.
>
> Fair enough, I need to do some tests, some of the compute modules use an eMMC.
>
> > I don't think that SD and SDIO have any open-drain signals, so they
> > shouldn't need to retry at slower clock speeds.
>
> Noted.
>
> > I'm trying to get more detail on the bug, like the exact ratio of core
> > clock to bus clock that causes the problem. When I first found this
> > bug I was told that the failure would not happen at 200KHz, but we
> > were using a 405MHz core clock.
>
> That would be nice to have.
>
> > One other question. Why are you using polling for the SD card, this
> > newer controller supports the interrupt driven "Card Inserted" signal
> > and avoids wasting time polling?
>
> I believe the line isn't routed on RPi4.
>
> > Al
>
