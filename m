Return-Path: <SRS0=wLMj=2I=vger.kernel.org=linux-mmc-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A83C2D0BF
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 15:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3D024676
	for <linux-mmc@archiver.kernel.org>; Wed, 18 Dec 2019 15:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sjxLPdqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727513AbfLRPLr (ORCPT <rfc822;linux-mmc@archiver.kernel.org>);
        Wed, 18 Dec 2019 10:11:47 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:46080 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbfLRPLq (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 18 Dec 2019 10:11:46 -0500
Received: by mail-ua1-f66.google.com with SMTP id l6so736428uap.13
        for <linux-mmc@vger.kernel.org>; Wed, 18 Dec 2019 07:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OG/pM/wl2nU75Ce+HHMv6RzUgI11FdyesZawxBUPdMo=;
        b=sjxLPdqPMrWCiphZxrkk/aw+he+VCwR/j4xHVgnfx30c9y7WrySH0ZYfQ7gh3PREfX
         wQRdWBaCujUPM62xcIlkuUyLa0wFeKzZkuUT86MuIDwLLJjvJu4Nfp0RXzU1KyHY+I7E
         f+tfhzGksjrXSTjSfAGuLrf2FB1LywGABMos918G4y5Gi+dKniW7jLz2NdrfTBv/Sres
         mKHEkeGAGqDurGMX0VzvKl87Ft5xhzwAVN37w2mxLek+aM4x8tCCyDuLs0U46a+F8bxn
         CK8bNsy93M34jpcpDhqau5xatHXEBHjviqduADf0U+OP+/q4W9lRh697GWBgvPJr41X9
         bvKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OG/pM/wl2nU75Ce+HHMv6RzUgI11FdyesZawxBUPdMo=;
        b=iPism/ItOadBX/MMjrjluwTGnDu8izRMb5bJ6w097uJg9QHgvBIK1wmXDiSwzzROmp
         NVSQuWc7B9NIIV/jyMIRMZlYiF+SVDk0YgWmWjnE3TjHL86YDKugpZQG08af1/WeupH/
         nB29GzoI2bp5VXeHQuEseMz9MWKIaX4Q+4s0EtCtRoRtcLWVPgOG/jvh+pjfoeohnsfK
         MkpMZNIVz8gazY0KSn7ROTzHyFY7V5mjcEHX2SL37Rp09Q+ZMMSgVK3BNcPaNrwxRevx
         xWB8Cgs6l5PLIXu5c6g06DAsF+fozU0ZY1Q79mcvtbA+YOkD2/tmSUX5/84PTNYP2IaY
         /rGA==
X-Gm-Message-State: APjAAAV6o7l+Z9HQ+6njAjf8saaqG4otxlhVOICIhCN7pA6JfhjHl8lx
        zCBJOJTQAvqpw+YB33aT6HmWjLCpQhupnGE6fFK6WQ==
X-Google-Smtp-Source: APXvYqxIemSRkPQQlkOHIgb1DLI/F80ZGX0B3DDxjvdIfGtoGmFwb3OGpLHbe5uZsgnRUDNiscbxAsqS/SFF84Oq+ro=
X-Received: by 2002:ab0:e16:: with SMTP id g22mr1660978uak.129.1576681904792;
 Wed, 18 Dec 2019 07:11:44 -0800 (PST)
MIME-Version: 1.0
References: <1571668177-3766-1-git-send-email-rampraka@codeaurora.org>
 <CAPDyKFoZEc-m7NMnaAa5bjtCSp4wyJqic3cLHk95xracoWcCUA@mail.gmail.com> <0101016eb6152d19-fa1453b7-ae71-49d7-b13b-8c4009375ee1-000000@us-west-2.amazonses.com>
In-Reply-To: <0101016eb6152d19-fa1453b7-ae71-49d7-b13b-8c4009375ee1-000000@us-west-2.amazonses.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 18 Dec 2019 16:11:08 +0100
Message-ID: <CAPDyKFoc-c23d4U6m3UMxtA7KhnHeeUN5u-Rpiwsbsz7PnyT+w@mail.gmail.com>
Subject: Re: [RFC 0/6] mmc: Add clock scaling support for mmc driver
To:     Ram Prakash Gupta <rampraka@codeaurora.org>
Cc:     Asutosh Das <asutoshd@codeaurora.org>,
        Sahitya Tummala <stummala@codeaurora.org>,
        Sayali Lokhande <sayalil@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        cang@codeaurora.org, ppvk@codeaurora.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Doug Anderson <dianders@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-mmc-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mmc.vger.kernel.org>
X-Mailing-List: linux-mmc@vger.kernel.org

On Fri, 29 Nov 2019 at 08:34, <rampraka@codeaurora.org> wrote:
>
> Hi Ulf,
>
> Seems some setting issue with my thunderbird application.
> Sorry for spams, please ignore my last responses as unsupported
> characters got added.
>
> Typing my response again from browser and re-sending.
>
> Thanks,
> Ram
>
> On 2019-10-22 14:10, Ulf Hansson wrote:
> > On Mon, 21 Oct 2019 at 16:30, Ram Prakash Gupta
> > <rampraka@codeaurora.org> wrote:
> >>
> >> This change adds the use of devfreq based clock scaling to MMC.
> >> This applicable for eMMC and SDCard.
> >> For some workloads, such as video playback, it isn't necessary
> >> for these cards to run at high speed. Running at lower
> >> frequency, in such cases can still meet the deadlines for data
> >> transfers.
> >>
> >> Scaling down the clock frequency dynamically has power savings
> >> not only because the bus is running at lower frequency but also
> >> has an advantage of scaling down the system core voltage, if
> >> supported. Provide an ondemand clock scaling support similar
> >> to the cpufreq ondemand governor having two thresholds,
> >> up_threshold and down_threshold to decide whether to increase
> >> the frequency or scale it down respectively as per load.
> >
> > This sounds simple, but what the series is doing is far more
> > complicated but scaling the bus clock, as it also re-negotiates the
> > bus speed mode.
> >
> > Each time the triggering point for scaling up/down is hit, then a
> > series of commands needs to be sent to the card, including running the
> > tuning procedure. The point is, for sure, this doesn't come for free,
> > both from a latency point of view, but also from an energy cost point
> > of view. So, whether this really improves the behaviour, seems like
> > very use case sensitive, right!?
>
> Switching modes would incur some latency for sending commands to switch
> modes, but tuning is not needed as most of the emmc devices used now a
> days are with enhanced strobe support, so tuning would not add up any
> latency as it is not required in hs400 enhanced strobe mode.
>
> This feature is implemented for video playback case, where data transfer
> request is less, where this feature helps with saving power consumption.
>
> And when there is burst of data transfer request, load will remain
> _high_
> so there won't be any switching and hence it won't affect any existing
> use cases from latency point of view.
>
> Also if hw supports to switch clk frequency without changing mode. I
> will
> make change in code. For this I have seek input from hw team.
>
>  From collected data, I see this feature is helping in saving power
> consumption. And no energy penalty is observed. Please share if I am
> missing any specific. Power saving using this feature is quite good
> and considerable. Please find the data below.
>
> Use Case                             Delta at Battery  Power Impact
> 30 fps at HD 1080p decode 20Mbps       10 mA               11%
> 30 fps at UHD 8b H.264 42 Mbps         20.93 mA            19%
>
> >
> > Overall, when it comes to use cases, we have very limited knowledge
> > about them at the mmc block layer level. I think it should remain like
> > that. If at any place at all, this information is better maintained by
> > the generic block layer and potentially the configured I/O scheduler.
>
> I think, generic block layer do not have knowledge of use case for data
> transfer request. And devfreq framework have been used to implement this
> feature, which should be same in any layer.

Just to be clear, my main concern here is not using the devfreq framework.

It's rather whether switching speed modes is really worth it, which
Doug pointed out as well.

>
> Also mobile platforms comes mostly with emmc and ufs as storage media.
> And clock scaling is already implemented in upstream ufs driver using
> devfreq framework. On similar line, this feature is implemented for mmc
> driver. So I believe, clk scaling implementation is better placed in mmc
> driver rather in generic block layer.

At some point you want to trigger the clock to be scaled up/down,
probably because of reaching some bandwidth threshold. This part seems
like a generic block thing and not an mmc specific thing.

Exactly how that would affect this approach is hard to say, but my
point is, that I don't want to sprinkle the mmc subsystem with code
that may belong in upper common layers.

>
> >
> > This brings me to a question about the tests you have you run. Can you
> > share some information and data about that?
>
> Test case used are 1080p and 4k video playback use case. As this feature
> is implemented specifically for video playback use case.

Right.

It seems to me, that you are optimizing for only one particular use
case. How do you make sure to not increase energy consumption, for
other use cases that would gain from running at the highest speed mode
and "race to idle"?

I think you need to take a step back and think more general about this
approach. More importantly, you need to provide more data to prove
your approach, also according to suggestions from Dough.

> >
> >>
> >>
> >> Ram Prakash Gupta (6):
> >>   mmc: core: Parse clk scaling dt entries
> >>   mmc: core: Add core scaling support in driver
> >>   mmc: core: Initialize clk scaling for mmc and SDCard
> >>   mmc: core: Add debugfs entries for scaling support
> >>   mmc: sdhci-msm: Add capability in platfrom host
> >>   dt-bindings: mmc: sdhci-msm: Add clk scaling dt parameters
> >>
> >>  .../devicetree/bindings/mmc/sdhci-msm.txt          |  19 +
> >
> > I noticed that the DT patch was put last in the series, but the
> > parsing is implemented in the first patch. Please flip this around. If
> > you want to implement DT parsing of new bindings, please make sure to
> > discuss the new bindings first.
>
> I will update in next post.
>
> >
> >>  drivers/mmc/core/block.c                           |  19 +-
> >>  drivers/mmc/core/core.c                            | 777
> >> +++++++++++++++++++++
> >>  drivers/mmc/core/core.h                            |  17 +
> >>  drivers/mmc/core/debugfs.c                         |  90 +++
> >>  drivers/mmc/core/host.c                            | 226 ++++++
> >>  drivers/mmc/core/mmc.c                             | 246 ++++++-
> >>  drivers/mmc/core/queue.c                           |   2 +
> >>  drivers/mmc/core/sd.c                              |  84 ++-
> >>  drivers/mmc/host/sdhci-msm.c                       |   2 +
> >>  include/linux/mmc/card.h                           |   7 +
> >>  include/linux/mmc/host.h                           |  66 ++
> >>  12 files changed, 1550 insertions(+), 5 deletions(-)
> >
> > This is a lot of new code in the mmc core, which I would then need to
> > maintain, of course. I have to admit, I am a bit concerned about that,
> > so you have to convince me that there are good reasons for me to apply
> > this.
> >
> > As I stated above, I think the approach looks quite questionable in
> > general. And even if you can share measurement, that it improves the
> > behaviour, I suspect (without a deeper code review) that some of the
> > code better belongs in common block device layer.
>
>  From the collected power data, I see this as good reason to have this
> feature in mmc driver as number is quite considerable.
>
> For approach, it would be helpful if you share your inputs regarding
> this
> approach. And as you have stated, this can be further discussed after a
> review from you.

Besides my comments above, Doug has provided you with valuable
feedback. Please follow up on that as well, if you still intend to
pursue with this approach.

Kind regards
Uffe
