From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] sdhci-of-esdhc: Support 8BIT bus width.
Date: Tue, 5 May 2015 15:01:29 +0200
Message-ID: <CAPDyKFqzSmGectThdFsNVxY88ihsxLGRBs6EOANPq2Pk7Xb9OA@mail.gmail.com>
References: <1429564296-30396-1-git-send-email-joakim.tjernlund@transmode.se>
	<CAPDyKFpQuLDafARu6=5XqxPsShRzcC__ZFgjE1yUrP4SobFjGQ@mail.gmail.com>
	<1430816674.27859.71.camel@transmode.se>
	<CAPDyKFo-j-9SCH+EBqqgCaRpDcHsNp3s_hOL7aAuUMiVmBe-ig@mail.gmail.com>
	<1430828577.27859.77.camel@transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f171.google.com ([209.85.216.171]:35928 "EHLO
	mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423195AbbEENB3 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 May 2015 09:01:29 -0400
Received: by qcbgy10 with SMTP id gy10so34253894qcb.3
        for <linux-mmc@vger.kernel.org>; Tue, 05 May 2015 06:01:29 -0700 (PDT)
In-Reply-To: <1430828577.27859.77.camel@transmode.se>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 5 May 2015 at 14:22, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
> On Tue, 2015-05-05 at 12:11 +0200, Ulf Hansson wrote:
>> On 5 May 2015 at 11:04, Joakim Tjernlund <joakim.tjernlund@transmode.se> wrote:
>> > On Tue, 2015-05-05 at 10:34 +0200, Ulf Hansson wrote:
>> > > On 20 April 2015 at 23:11, Joakim Tjernlund
>> > > <joakim.tjernlund@transmode.se> wrote:
>> > > > Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
>> > >
>> > > Thanks, applied.
>> > >
>> > > Kind regards
>> > > Uffe
>> >
>> > Argh, I just learned that this patch is buggy. Please "unapply"
>> >
>> >  Jocke
>> >
>>
>> Done!
>
> Thanks, new version sent :)
>
> BTW, can I ask, cat /sys/kernel/debug/mmc0/ios:
> clock:          52000000 Hz
> actual clock:   50000000 Hz
> vdd:            7 (1.65 - 1.95 V)
> bus mode:       2 (push-pull)
> chip select:    0 (don't care)
> power mode:     2 (on)
> bus width:      3 (8 bits)
> timing spec:    1 (mmc high-speed)
> signal voltage: 0 (3.30 V)
>
> What is signal voltage: 0 (3.30 V) here ?

Since you are running in mmc high-speed mode, the 3.3V is the signal
voltage that is being used.


Kind regards
Uffe
