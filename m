From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2 2/2] mmc: Minimize resume-time by deferring resume
Date: Thu, 15 Dec 2011 10:22:41 +0100
Message-ID: <4EE9BC61.7080705@stericsson.com>
References: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>	<1323875170-7103-3-git-send-email-ulf.hansson@stericsson.com>	<CAMJBoFNU_+Ah8oxXy2Smr5L5oZ4wjZ1m8v6sp-kVcxgk4kYmNg@mail.gmail.com>	<4EE8C0C0.6010307@stericsson.com>	<CAMJBoFM9v9ugDL8gtNJ+AMCKmvOsUQHEmEf13VDXko41AkFfFA@mail.gmail.com>	<CAMJBoFPcBzezFDRXpL36zJZTttGgUFzDCUaFC69Pxg+gEWcAOw@mail.gmail.com>	<4EE8D23E.8030000@stericsson.com> <CAMJBoFPSEtM1rQ7Rq8d+Y6Qgd_GKq2o4p=vk60wZdbJ_Mhk_Gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog115.obsmtp.com ([207.126.144.139]:47869 "EHLO
	eu1sys200aog115.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752934Ab1LOJZO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 15 Dec 2011 04:25:14 -0500
In-Reply-To: <CAMJBoFPSEtM1rQ7Rq8d+Y6Qgd_GKq2o4p=vk60wZdbJ_Mhk_Gw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

Hi Vitaly,

Vitaly Wool wrote:
> 
> On Wed, Dec 14, 2011 at 5:43 PM, Ulf Hansson
> <ulf.hansson@stericsson.com<mailto:ulf.hansson@stericsson.com>>
> wrote:
> 
> So in fact instead of decreasing time-to-userspace for resume, you
> are rather going to increase it in this case.
> 
> Nope, not true. :-)
> 
> Somewhere you need to handle the resume. Earlier it was done
> immediately when getting the resume request, thus every host resume
> in the sequence is added to the total time for userspace to be
> resumed.
> 
> I did some measurement, having two eMMC connected (one of them with a
> root file system mounted) and one rather good SD-card with VFAT. The
> resume time for the kernel before these patches were around 600 ms.
> After my patches I had around 20 ms.
> 
> What do you call "resume time" in this case?

Total kernel resume time.

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
> decreased since the other hosts resume time did not affect the resume
> time for this application.
> 
> I take that by "other hosts" you mean SD card? :)

"Other hosts", are all those hosts holding an eMMC/MMC or an SD-card,
but not that host that there were a request for, before the deferred
resume has finalized.

> 
> 
> -be async (e. g. start card resume process in resume routine, set
> atomic, return success and have wait_event_interruptible_timeout in
> block_rq if this atomic is set).
> 
> Don't follow you. This is exactly what the patch is doing. Not just
> for SD, but also for (e)MMC. I don't see your issue.
> 
> The issue is  that in most cases when you have a root filesystem on
> the eMMC, block request will come in less than 3 seconds and this
> application will have to wait. You don't spawn resume immediately.
> 
> Also, how about race conditions resuming say SD and eMMC at the same
> time?

One host holds one card. One card has one blkdev thread/queue. Resume is
done for each host separate, no such thing as race can ever occur, I
believe.

> 
> 
> Anyway, in fact this patch is only addressing SD card case as of now
> which can be covered by runtime PM.
> 
> Nope, both SD and (e)MMC. How can runtime PM solve a normal suspend?
> It has noting to do we each other I believe.
> 
> SD card may not be resumed on system resume if it was runtime
> suspended before system suspend. That basically covers your case,
> doesn't it?

Don't quite follow you. Right now SDIO is the only type of card that
make use of runtime PM, which means mmc_power_save|restore_host could
potentially be executed for SDIO cards.

Do you mean that we should implement this for SD cards as well?

Anyway, I don't understand what this should prevent a resume from being
executed for SD/SDIO/(e)MMC at all?

Please elaborate.

> 
> ~Vitaly
> 

Please try to in-line comments, it will make it easier to follow the
discussion.


Br
Ulf Hansson

