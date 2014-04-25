From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/38] MMC updates, plus CuBox-i WiFi support
Date: Fri, 25 Apr 2014 13:40:03 +0200
Message-ID: <CAPDyKFo-V4--vK2anHUNn3hgevnAC6cE+vvRjF__sQ8dqK8AdQ@mail.gmail.com>
References: <20140423185534.GA26756@n2100.arm.linux.org.uk>
	<CAPDyKFozP69yngKAkdwHYyyvi+pdLEm05udOmBiVshQFi4hnLQ@mail.gmail.com>
	<20140424101726.GH26756@n2100.arm.linux.org.uk>
	<CAPDyKFrGReKF0ucer7D195boEoQW26=4vDXT+=Wn6BO-p_B1gQ@mail.gmail.com>
	<20140424105745.GM26756@n2100.arm.linux.org.uk>
	<CAPDyKFr=2=dg1NTYb1_EAgxXZq2Rd+o2Q2B5TE+GZwr8MUU1_Q@mail.gmail.com>
	<20140425090343.GH26756@n2100.arm.linux.org.uk>
	<CAPDyKFpAiegwfh=kA8NyB+DdwKT=wSGJsB=gbEgLbyv0RJ2EOQ@mail.gmail.com>
	<20140425112018.GJ26756@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qa0-f50.google.com ([209.85.216.50]:45808 "EHLO
	mail-qa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752901AbaDYLkF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Apr 2014 07:40:05 -0400
Received: by mail-qa0-f50.google.com with SMTP id s7so2295501qap.9
        for <linux-mmc@vger.kernel.org>; Fri, 25 Apr 2014 04:40:03 -0700 (PDT)
In-Reply-To: <20140425112018.GJ26756@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Chris Ball <chris@printf.net>, Anton Vorontsov <anton@enomsg.org>, Barry Song <baohua@kernel.org>, Ben Dooks <ben-linux@fluff.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Jaehoon Chung <jh80.chung@samsung.com>, Kumar Gala <galak@codeaurora.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, linux-doc@vger.kernel.org, linux-mmc <linux-mmc@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Mark Rutland <mark.rutland@arm.com>, Michal Simek <michal.simek@xilinx.com>, Pawel Moll <pawel.moll@arm.com>, Randy Dunlap <rdunlap@infradead.org>, Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Seungwon Jeon <tgih.jun@samsung.com>, Shawn Guo <shawn.guo@freescale.com>, spear-devel@list.st.com, Stephe

On 25 April 2014 13:20, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
> On Fri, Apr 25, 2014 at 01:18:28PM +0200, Ulf Hansson wrote:
>> On 25 April 2014 11:03, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> > On Thu, Apr 24, 2014 at 01:13:05PM +0200, Ulf Hansson wrote:
>> >> On 24 April 2014 12:57, Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:
>> >> > This is nothing new or unexpected - it was last posted back in February,
>> >> > and I elected that it should be held off until after the last merge
>> >> > window.
>> >> >
>> >> > Unfortunately, I didn't have time to post it immediately after the merge
>> >> > window closed, partly because it needed to be rebased on top of tglx's
>> >> > IRQ changes on which it depends.  I was carrying those as separate commits
>> >> > to the ones Thomas was carrying in his tree - and in the event, Thomas had
>> >> > modified his patches slightly between sending me copies of them and the
>> >> > versions he sent during the merge window.
>> >>
>> >> Okay, so let's keep up the frequency here then. I only had some minor
>> >> comments, please fix them and send a v2.
>> >
>> > Right, so I've updated the patches, and added one ack to one patch.
>> > That seems insufficient to me - the only platform these have been
>> > tested on is iMX6, which is sdhci-esdhc-imx.c.
>> >
>> > They _really_ need testing elsewhere too.  Or is the plan to merge
>> > them and then see about getting people to test them and fix them up
>> > afterwards?
>>
>> I was hoping people could start doing tests, before Chris actually
>> decided to pull them in. Now, if that doesn't happen, we could just
>> merge them, as you say, and thus we have to fix potential problems
>> afterwards. I would expect you to help out if problem occurs.
>>
>> If we decide to not merge in a while, I am not sure how long we could
>> prevent other sdhci patches from being merged. I guess Chris will have
>> to take the final call.
>
> Or we just drop them for yet another cycle and show how mainline kernel
> development sucks, why getting stuff into mainline is utterly painful,
> and why using vendor kernels is /soo/ much better than this crap.

Dropping them is too me a bad option and I really don't think that
should be needed.

I would like to encourage people to help out with testing and I
suppose we have to give this at least some time.

Anyway, post your new version. I will create the pull request based on that.

>
> --
> FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
> improving, and getting towards what was expected from it.
