Return-Path: <SRS0=1974=Z2=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEEFDC432C3
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 02:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 641F32073F
	for <linux-mmc@archiver.kernel.org>; Wed,  4 Dec 2019 02:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bBeWPND6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbfLDCKJ (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Tue, 3 Dec 2019 21:10:09 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:35339 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLDCKJ (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 3 Dec 2019 21:10:09 -0500
Received: by mail-il1-f194.google.com with SMTP id g12so5228923ild.2
        for <linux-mmc@vger.kernel.org>; Tue, 03 Dec 2019 18:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CcksHrnDnvCw+7cPZSrlt/H4ilYewkHtwZbwPDwidps=;
        b=bBeWPND6kv9FMp5OE1CKADmvH0Mvtix+Wp7qsdAnZaLiqCAjo93NfmUHKxGfnYACab
         3VNXSiFr/Etto47AMIByMYYcmrvOz9rnEpJiDhI6JXegMMXChCJP3FSyr0istRHRWJUi
         a2omfRzO7ZCicvXfA2rc0mRkg7Ko6fwbLdjI/cXvwtmcIYhoaUPz5zL9EpVQ0+3ve9Hx
         vQEjc3ehiySCt1R1nQ2ezpl17NN7yXtIifTYKtapY7Akrh+ydFmLq07Iu3epfoHY0UUn
         cF3TPcQqR/VXYOuMB35CI5pjSPJXPGBnXfP0nvnfdgdUfMRv0Tv5u3KuHP+qLoCf2i2/
         Zz3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CcksHrnDnvCw+7cPZSrlt/H4ilYewkHtwZbwPDwidps=;
        b=WoDzoz1L5sVFrozR59EOSpWLXf9Igt9G3r43liisXYGOrxm57jd1Rgs7rijXldPewv
         s60xVM84bIoGmLk73oFSromgPhC1EUAV07bX2OtppjFOEDmPWbTuPTYNEZi7Aq0XnS7g
         tJ6e13fR/a+0hiEuGJZq6ij7fMruUOcH/qC4bKb6Wg5ywYBOHviyVYAc+3mMZkvPt5M6
         XrRXDeu4qJx9phZ1F76TBD+GM5R8NTtAyheiuhj+e0GQMLfyiBd/uvGYDifYgnVxpDZi
         VJhXpmsx1/rH1KcpDXvzYNSMlGmq5qnBjd0zvpKRvUbGfrOiMcOSPRrtX68u+6gVh8uF
         5Oow==
X-Gm-Message-State: APjAAAWy3AWXQ7tpiq2Tud1nmA0NiOtJEK1UoSIucY5Admo/G+ekdoE+
        YZLoBVOEoyp3e8Oo3iJ3yYUIsMB+uCC5dS5OCbW2mQ==
X-Google-Smtp-Source: APXvYqzCZgn+KTJMjfGfBVGRFGUk1RS7lUrI4vWwPucNKhPjo/MAabpBRco4G6J359xprZ2xHp/LW9zVjUB0Eqlfn1o=
X-Received: by 2002:a92:1547:: with SMTP id v68mr1331380ilk.58.1575425407814;
 Tue, 03 Dec 2019 18:10:07 -0800 (PST)
MIME-Version: 1.0
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
 <CAPDyKFoZEc-m7NMnaAa5bjtCSp4wyJqic3cLHk95xracoWcCUA@mail.gmail.com>
 <5c78cc29-deb1-4cea-5b30-6f7538ca4703@codeaurora.org> <CAD=FV=W+JbeF7yKk6Vup=5-MSbYC8qq5rm176hZk2WdiFwA3qg@mail.gmail.com>
 <0101016eb635d158-5e87498b-b906-4ec2-813f-83275cab3555-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eb635d158-5e87498b-b906-4ec2-813f-83275cab3555-000000@us-west-2.amazonses.com>
From:   Doug Anderson <dianders@google.com>
Date:   Tue, 3 Dec 2019 18:09:54 -0800
Message-ID: <CAD=FV=Xm2mAfnS2mvddxejgD1sV58FRaQmkO_sN8DxoJhOynUQ@mail.gmail.com>
Subject: Re: [RFC 0/6] mmc: Add clock scaling support for mmc driver
To:     Ram Prakash Gupta <rampraka@codeaurora.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        cang@codeaurora.org, ppvk@codeaurora.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Asutosh Das <asutoshd@codeaurora.org>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

Hi,

On Fri, Nov 29, 2019 at 12:10 AM <rampraka@codeaurora.org> wrote:
>
> > I am slightly baffled about why this would save energy unless it
> > allows you to lower the voltage to the controller.  I know you _can_
> > sometimes lower the voltage to the controller on Qualcomm parts, but
> > you are arguing that it is useful even on systems that can't lower the
> > voltage.  That feels slightly questionable.  I would expect that
> > racing to idle (with the right tuning parameters) would be a better
> > way to go.
>
> Sorry, if my explanation was misleading before. MMC driver is not
> changing
> card/controller voltage but by lowering clock frequency of card and
> controller brings down _bus_ and _system_ voltage corners of device
> which
> helps in saving power consumption.

Yes, I understood.  You are able to lower the voltage supplied to the
controller itself, not to the card.  ...but that is not something that
all SoCs can do.  I think here you are arguing that your feature is
useful to everyone--even if they can't ever lower the voltage of the
controller.  I am questioning that.


> > As a specific example, let's imagine we want to transfer 1000 MB of
> > data and we have 20 seconds with which to do it.  We can achieve this
> > by transferring 50 MB/s for the whole 20 seconds.  Alternatively, we
> > could transfer at 400 MB/s 2.5 seconds and then fully power gate the
> > eMMC for the next 17.5 seconds.
> >
> > In that example, I'd wonder ask is more power efficient.  Presumably
> > the 2nd.  This is the whole "race to idle" concept as I understand it.
> >
> > The "race to idle" is talked about a lot in the context of CPU
> > frequency decisions.  Presumably you'll point out that "race to idle"
> > is NOT the right thing to do for choosing a CPU frequency.  As I
> > understand it, this is primarily true because we need to raise the CPU
> > voltage to run at faster speeds.  This would lead me to believe that
> > the only case you'd want to do frequency scaling like this is if it
> > allows you to lower the voltage provided to the eMMC controller.  As
> > you said, for Qualcomm it _does_ allow you to do this, but most other
> > SoCs don't.  ...so unless there's a flaw in my logic (always
> > possible!) this patch series should be amended to say it's only useful
> > if it allows you to down-volt the controller.
> >
> > Just to think a little bit more about my logic: of course, you might
> > argue that we can't just do a 1000 MB data transfer.  We can break
> > that down into two cases:
> >
> > a) For writing, presumably the data is produced over time and you
> > don't want to buffer the whole 1000 MB and delay 17.5 seconds before
> > you start writing.  ...but presumably you could do _some_ buffering
> > and then break things into chunks where you ungate the clock to the
> > card, write a chunk out, and then re-gate the clock.  There will
> > obviously be some overhead with each clock gate/ungate, but
> > (hopefully) not too much.  ...and there will be time when data is in
> > RAM and not on the disk so you'd worry about power failure, but if you
> > want to get data on the disk ASAP why are you scaling the clock (and
> > thus delaying the data from getting to the disk) at all?  Maybe some
> > math?  How long does it take to ungate/gate the clocks.  1 ms?  It's
> > just flipping a bit, right?  ...and does assuming we can allocate a 40
> > MB write buffer seem sane?  So we eat 1 ms to ungate, 100 ms to
> > transfer 40 MB, 1 ms to gate.  Compared to transferring at 50 MB/sec
> > (w/ no gating), we'd transfer the same 40 MB in 800 ms.  So we either
> > keep the clock on at 50 MHz for 800 ms or we keep it on at 200 MHz for
> > 102 ms and gate it for 698 ms.
> >
>
> "race to idle" helps but this feature was implemented with focus on
> video
> playback case, where data transfer request to mmc driver spans over
> entire
> playback time of video. In this case, running device in low speed mode
> helps.

It doesn't matter if you've got a long playback.  A properly tuned
"race to idle" should still be better unless you are seriously saving
a lot of power by never bringing the voltage up.  The above example is
with a fixed size transfer, but just imagine the same thing over and
over again and you've got the video playback case.


> > b) If you're reading data then hopefully the system has some sort of
> > readahead going on.  In the "video playback" case the system should
> > have no problem predicting that if you've just read bytes
> > 1,000,000,000 - 2,000,000,000 of a file over the last 10 seconds that
> > you're likely to keep reading the same file.  Presumably it wouldn't
> > be totally insane to read 40 MB ahead of time and then we can do the
> > same math as a).  If 40 MB is too much for readahead, then shrink it
> > and redo the math.  Even with much smaller numbers the "race to idle"
> > wins because gating / ungating clocks is fast.  ...or do you know some
> > reason why gating / ungating clocks needs to be slow?  If so, how
> > slow?
> >
>
> I have performed one experiment by increasing read ahead size, but that
> is
> not helping. And I don't observe much difference in data request pattern
> generated in video playback case.

You have to make sure that you are proactively gating the card clock
in conjunction.  If you aren't gating the card clock quickly enough
(and aren't lowering the controller voltage when the card clock is
gated) then you won't notice the savings.


> >> Test case used are 1080p and 4k video playback use case. Please find
> >> below
> >> test case information and power impact data. In both the below video
> >> playback
> >> cases, a considerable amount of power savings can be observed with
> >> clock scaling
> >> feature.
> >>
> >> Use cases Delta at battery (mA) Power impact %
> >> 30 fps at HD 1080p decode 20 Mbps 10 mA 11%
> >> 30 fps at UHD 8b H.264 42 Mbps 20.93 mA 19%
> >
> > Numbers like this are exactly what is needed to justify your patch
> > series.  ...but I'd be super curious to how it would compare to:
> >
> > 1) Tuning the runtime PM auto-suspend delay.  If you have your
> > auto-suspend delay set wrong (like 500 ms) then all the math above is
> > totally wrong.  We'll keep clocking at 400 MHz needlessly even though
> > there is no data to transfer.  If autosuspend is just gating clocks
> > then it feels like you could set it to 1 ms, or 10 ms.  NOTE: if
> > autosuspend for you is something more major (fully turning off power
> > rails to the eMMC) then maybe you need another level where you just
> > turn off the clocks.  Seems like we could find some way to make that
> > work.
>
> Gating / Ungating can be fine tuned to help bring down power consumption
> too. I will share power numbers with tuned parameters in next
> communication.

Thanks, I think this is critical for the discussion.  Please make sure
that when you are gating you code it up in a way that you can remove
the vote for the higher controller voltage.


> > 2) Tuning any readached mechanism in your system.  If your system
> > somehow does zero readahead then obviously all my arguments don't work
> > for reads.  ...but why would you not have readahead?
> >
> > 3) Tuning any write buffering in your system.  Same argument as #2.
>
> This feature is specific to video playback use case from storage device.
> Not sure, which buffering can be tuned. Can you point out any buffering
> used?

If you're only testing video playback then I guess you don't care so
much here.  I was assuming you cared about video record too, but maybe
that's not such an important use case for saving power.


> > 4) Making sure that when the MMC card clock is gated that you request
> > the lowest voltage level for the controller (and set the controller's
> > bus clock to the lowest level since it's not doing anything).
> >
> >
> > I would also be very interested to know how much of those savings are
> > achieved if you keep the voltage to the MMC controller the same.  In
> > other words do something that arbitrarily keeps the MMC controller
> > requesting the same voltage level from the rest of the system and then
> > do your power measurements.  How much do your savings change?
> >
> >
> > I will also note that aggressive clock gating is exactly what the
> > dw_mmc controller does automatically (except for SDIO, but that's a
> > different story).  Seeing that the controller itself can stop the
> > clock in dw_mmc gives further credence that gating / ungating the
> > clock is a very lightweight operation and 1 ms is probably an
> > over-estimation of how long it takes.
> >
> >
> > I guess one very last note is that I spent most of the time above
> > arguing that the clock scaling concept is probably not useful for any
> > SoCs where you can't adjust the voltage provided to the MMC
> > controller.  That doesn't necessarily mean that your patch series is
> > useful for SoCs where you can.  Specifically you'd need to do math to
> > see how much more power the MMC controller takes at the higher
> > voltage.  Then you can calculate a "perf per watt".  If the watts to
> > transfer data at 400 MB/s aren't 8 times more than the watts to
> > transfer at 50 MB/s then that's a ding against your idea.  You'd also
> > don't have a dedicated voltage rail, right?  So you'd have to see what
> > percentage of the time the MMC controller was the only thing in the
> > system that was requesting the higher voltage.  If it happened that
> > something else in the system was keeping the voltage higher anyway
> > then it would be better for you to run faster and race to idle.
> > Really I guess the case you're most worried about is if the MMC
> > controller is causing other components in the system to be at a higher
> > voltage point (and thus take up more power)...
> >
>
> Rail is not dedicated for eMMC device. So during video playback its mmc
> votes only, which keeps device in higher voltage corners. So for a three
> hours of a video playback, power consumption due to mmc vote would be
> quite
> considerable.

You should be able to remove your vote whenever the card clock is
gated.  Maybe this is what you're missing?

-Doug
