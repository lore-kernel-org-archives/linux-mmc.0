From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2 2/2] mmc: Minimize resume-time by deferring resume
Date: Mon, 19 Dec 2011 12:03:38 +0100
Message-ID: <4EEF1A0A.4010209@stericsson.com>
References: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>	<1323875170-7103-3-git-send-email-ulf.hansson@stericsson.com>	<CAMJBoFNU_+Ah8oxXy2Smr5L5oZ4wjZ1m8v6sp-kVcxgk4kYmNg@mail.gmail.com>	<4EE8C0C0.6010307@stericsson.com>	<CAMJBoFM9v9ugDL8gtNJ+AMCKmvOsUQHEmEf13VDXko41AkFfFA@mail.gmail.com>	<CAMJBoFPcBzezFDRXpL36zJZTttGgUFzDCUaFC69Pxg+gEWcAOw@mail.gmail.com>	<4EE8D23E.8030000@stericsson.com>	<CAMJBoFPSEtM1rQ7Rq8d+Y6Qgd_GKq2o4p=vk60wZdbJ_Mhk_Gw@mail.gmail.com>	<4EE9BC61.7080705@stericsson.com> <CAMJBoFN5tub+Lv5p2Ae3UQY48G2TMBBmdkdsA1TNDqf2stDGVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123]:44666 "EHLO
	eu1sys200aog107.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752295Ab1LSLD7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 06:03:59 -0500
In-Reply-To: <CAMJBoFN5tub+Lv5p2Ae3UQY48G2TMBBmdkdsA1TNDqf2stDGVg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Vitaly Wool wrote:
> Hi,
> 
> I did some measurement, having two eMMC connected (one of them with a
>  root file system mounted) and one rather good SD-card with VFAT. The
>  resume time for the kernel before these patches were around 600 ms. 
> After my patches I had around 20 ms.
> 
> What do you call "resume time" in this case?
> 
> Total kernel resume time.
> 
> This is an artificial and unfair definition. No one should care about
> that. You can think of a time-to-splashscreen or
> time-to-functional-userspace and both are not going to be improved
> much with your patch if we run off of a eMMC-based root.
> 

This is again not correct. You must not _always_ assume, just because 
you have a eMMC-based root, that requests arrives within 3 s after the 
kernel has been resumed, this is completely dependent on the active use 
cases. Moreover I think you are missing a very valuable thing about how 
the resume sequence is being changed with this patch. I will try to 
elaborate a bit more.

Before this patch:
_Every_ MMC and SD card were resumed sequentially. Thus _every_ resume 
for _every_ card adds up to the resume time _always_.

After this patch:
1. MMC and SD cards can be is resumed in parallel since the resume for 
those cards are deferred to be handled in a work instead.

2. Only those usecases which sends request on MMC and SD cards within ~3 
s after the kernel has been resumed, will notice a resume time for that 
particular card and of course only for the first request after a resume. 
Requests triggered after the ~3 s will be performed on a already resumed 
host.


> 
> 
> Moreover, I noticed very seldom than any mmc/sd request arrived 
> within the time were the deferred resumed has not been done. Of 
> course this will very much depend on what kind of userspace 
> application that is running and if there is an ongoing file transfer 
> that were frozen when doing suspend.
> 
> ...or  the wakeup source was the userspace alarm etc. etc.
> 
> 
> But, if this happens (deferred resume not done), the total resume 
> time for that particular userspace application will anyway be heavily
>  decreased since the other hosts resume time did not affect the
> resume time for this application.
> 
> I take that by "other hosts" you mean SD card? :)
> 
> "Other hosts", are all those hosts holding an eMMC/MMC or an SD-card,
>  but not that host that there were a request for, before the deferred
>  resume has finalized.
> 
> Ok, what if a rootfs application to be started first has to re-read
> say certificates from the SD card? And what if not doing that in time
> means QoS degradation?
> 
> No, you don't see all the _real_ use cases that you can break with
> your patch.
> 

I understand that potentially some userspace application might be 
affected. I did not see this a any critical problem which you definitely 
pointed out that it might be. But the reason to why I took this approach 
is simply because I think it is more a matter of in what context you are 
"waiting".

Earlier a userspace application could not even execute until all mmc and 
sd cards were resumed and thus waiting a long time for the kernel to be 
resumed. After this patch a userspace application will be able to 
execute much earlier but could in worst case have to wait for a SD or 
MMC card to be resumed when it need access to it.

I think this problem for these userspace applications, should be 
possible to solve within each application instead. Do you not think that 
should be possible?

If you feel that dot 2 (see above) is kind of what makes this patch more 
problematic for you to accept, what do you think about removing the 3 s 
resume delay and instead schedule the resume work immediately?

> 
> 
> 
> 
> -be async (e. g. start card resume process in resume routine, set 
> atomic, return success and have wait_event_interruptible_timeout in 
> block_rq if this atomic is set).
> 
> Don't follow you. This is exactly what the patch is doing. Not just 
> for SD, but also for (e)MMC. I don't see your issue.
> 
> No it doesn't. It defers the execution by arbitrary chosen time of 3
> seconds.
> 

Execution? Why?

> 
> 
> Do you mean that we should implement this for SD cards as well?
> 
> Anyway, I don't understand what this should prevent a resume from
> being executed for SD/SDIO/(e)MMC at all?
> 
> Please elaborate.
> 
> 
> I'm not going to, at least not in this thread. The method you propose
> is a hack and it can not be accepted at least because it doesn't give
> a damn about QoS. The whole idea of "let's unconditionally defer
> resume of something for arbitrary amount of time no matter what" is
> invalid.

As suggested above. We could easily remove the timer for the scheduled 
work. The idea as such will not change for this patch but userspace will 
be less affected.

It would have been good to really understand more about the idea you 
have of how to solve the long kernel resume time for mmc/sd/sdio with 
QoS. If you decide to send out a patch of rfc please keep me on the cc-list.

> 
> Thanks, Vitaly
> 

Br
Ulf Hansson
