From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2 2/2] mmc: Minimize resume-time by deferring resume
Date: Wed, 14 Dec 2011 16:29:04 +0100
Message-ID: <4EE8C0C0.6010307@stericsson.com>
References: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>	<1323875170-7103-3-git-send-email-ulf.hansson@stericsson.com> <CAMJBoFNU_+Ah8oxXy2Smr5L5oZ4wjZ1m8v6sp-kVcxgk4kYmNg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:38429 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753859Ab1LNP3T (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 10:29:19 -0500
In-Reply-To: <CAMJBoFNU_+Ah8oxXy2Smr5L5oZ4wjZ1m8v6sp-kVcxgk4kYmNg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Vitaly Wool wrote:
> Hi Ulf,
> 
> On Wed, Dec 14, 2011 at 4:06 PM, Ulf Hansson <ulf.hansson@stericsson.com<mailto:ulf.hansson@stericsson.com>> wrote:
> Typically an sd/mmc card takes around 200 - 1100 ms to
> initialize when the power to the card has been cut, which
> is what happens during a suspend/resume sequence.
> 
> I'm a bit pessimistic about this patch. What if we have a root filesystem on an SD card, or, what is a more common case, on an eMMC? How is it going to be handled?
> 

This is handled for sure. I have verified this case and I agree that 
this is likely a common case.

In principle, every mmc/sd requests handled in issue_rq (block.c), will 
unless the host is not already resumed, do a "sync" of the resume work.


> I see no trace of taking this into account in here so it's a NAK for now from my side.
> 
> Thanks,
>    Vitaly
> 

Br
Ulf Hansson
