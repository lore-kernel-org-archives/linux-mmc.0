From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2 2/2] mmc: Minimize resume-time by deferring resume
Date: Wed, 14 Dec 2011 17:43:42 +0100
Message-ID: <4EE8D23E.8030000@stericsson.com>
References: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>	<1323875170-7103-3-git-send-email-ulf.hansson@stericsson.com>	<CAMJBoFNU_+Ah8oxXy2Smr5L5oZ4wjZ1m8v6sp-kVcxgk4kYmNg@mail.gmail.com>	<4EE8C0C0.6010307@stericsson.com>	<CAMJBoFM9v9ugDL8gtNJ+AMCKmvOsUQHEmEf13VDXko41AkFfFA@mail.gmail.com> <CAMJBoFPcBzezFDRXpL36zJZTttGgUFzDCUaFC69Pxg+gEWcAOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:37086 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756583Ab1LNQnz (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 14 Dec 2011 11:43:55 -0500
In-Reply-To: <CAMJBoFPcBzezFDRXpL36zJZTttGgUFzDCUaFC69Pxg+gEWcAOw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Vitaly Wool wrote:
> On Wed, Dec 14, 2011 at 4:29 PM, Ulf Hansson <ulf.hansson@stericsson.com<mailto:ulf.hansson@stericsson.com>> wrote:
> 
> I'm a bit pessimistic about this patch. What if we have a root filesystem on an SD card, or, what is a more common case, on an eMMC? How is it going to be handled?
> 
> 
> This is handled for sure. I have verified this case and I agree that this is likely a common case.
> 
> In principle, every mmc/sd requests handled in issue_rq (block.c), will unless the host is not already resumed, do a "sync" of the resume work.
> 
> 
> So in fact instead of decreasing time-to-userspace for resume, you are rather going to increase it in this case.

Nope, not true. :-)

Somewhere you need to handle the resume. Earlier it was done immediately 
when getting the resume request, thus every host resume in the sequence 
is added to the total time for userspace to be resumed.

I did some measurement, having two eMMC connected (one of them with a 
root file system mounted) and one rather good SD-card with VFAT. The 
resume time for the kernel before these patches were around 600 ms. 
After my patches I had around 20 ms.

Moreover, I noticed very seldom than any mmc/sd request arrived within 
the time were the deferred resumed has not been done. Of course this 
will very much depend on what kind of userspace application that is 
running and if there is an ongoing file transfer that were frozen when 
doing suspend.

But, if this happens (deferred resume not done), the total resume time 
for that particular userspace application will anyway be heavily 
decreased since the other hosts resume time did not affect the resume 
time for this application.

  >
> IMHO, at the end of the day this thing should either
> - be capability-based (add MMC_CAP_...)

Why do someone not want this?

> - be PM_QOS based

Why do someone not want this?

> -be async (e. g. start card resume process in resume routine, set atomic, return success and have wait_event_interruptible_timeout in block_rq if this atomic is set).

Don't follow you. This is exactly what the patch is doing. Not just for 
SD, but also for (e)MMC. I don't see your issue.

> 
> Anyway, in fact this patch is only addressing SD card case as of now which can be covered by runtime PM.

Nope, both SD and (e)MMC. How can runtime PM solve a normal suspend? It 
has noting to do we each other I believe.

> 
> Thanks,
>    Vitaly
> 


Br
Ulf Hansson
