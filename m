From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-of-esdhc: add workaround for pre divider
 initial value
Date: Tue, 25 Aug 2015 16:20:50 +0200
Message-ID: <CAPDyKFpDcWXyMDmZ5NmLBuuyiQdnBE6HOz7RBJVx9hQ79XVwmA@mail.gmail.com>
References: <1439261614-38605-1-git-send-email-yangbo.lu@freescale.com>
	<CAPDyKFpxcDWARoHhWejg69LxukjctB2iFdECYdSj23-cFjwMhQ@mail.gmail.com>
	<1440505294.3349.61.camel@transmode.se>
	<CAPDyKFpYAkU4JKE+RoM0ru2g8EpqwokoK7OLbSW9fXy+b3Z3xQ@mail.gmail.com>
	<1440511235.3349.74.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ig0-f176.google.com ([209.85.213.176]:35716 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286AbbHYOUv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 25 Aug 2015 10:20:51 -0400
Received: by igbjg10 with SMTP id jg10so13570971igb.0
        for <linux-mmc@vger.kernel.org>; Tue, 25 Aug 2015 07:20:50 -0700 (PDT)
In-Reply-To: <1440511235.3349.74.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "yangbo.lu@freescale.com" <yangbo.lu@freescale.com>

On 25 August 2015 at 16:00, Joakim Tjernlund
<joakim.tjernlund@transmode.se> wrote:
> On Tue, 2015-08-25 at 15:56 +0200, Ulf Hansson wrote:
>> On 25 August 2015 at 14:21, Joakim Tjernlund
>> <joakim.tjernlund@transmode.se> wrote:
>> > On Tue, 2015-08-25 at 14:05 +0200, Ulf Hansson wrote:
>> > > On 11 August 2015 at 04:53, Yangbo Lu <yangbo.lu@freescale.com> wrote:
>> > > > For eSDHC(version < 2.3), the pre divider only could divide base clock
>> > > > by 2 at least. Add workaround for this to avoid unexpected issue.
>> > > >
>> > > > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
>> > >
>> > > Thanks, applied for next!
>> >
>> > This should go to linus now for 4.2 as master is broken.
>>
>> That wasn't obvious while reading the change log.
>
> hmm, it was visible in the mail thread I think.

Okay, perhaps I missed it.

>
>>
>> I don't intend to send any more PR with fixes for 4.2, but we could
>> apply a fixes tag if there is regression involved. Can you point me to
>> the commit it fixes?
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/mmc/host?id=bd455029d01cb55dca6
> 2129282466ccea3698813

Thanks! I updated the change log with the following line.

Fixes: bd455029d01c ("mmc: sdhci-of-esdhc: Pre divider starts at 1")

Kind regards
Uffe
