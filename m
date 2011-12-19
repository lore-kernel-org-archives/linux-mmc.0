From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH V2 2/2] mmc: Minimize resume-time by deferring resume
Date: Mon, 19 Dec 2011 13:21:44 +0100
Message-ID: <4EEF2C58.3040005@stericsson.com>
References: <1323875170-7103-1-git-send-email-ulf.hansson@stericsson.com>	<1323875170-7103-3-git-send-email-ulf.hansson@stericsson.com>	<CAMJBoFNU_+Ah8oxXy2Smr5L5oZ4wjZ1m8v6sp-kVcxgk4kYmNg@mail.gmail.com>	<4EE8C0C0.6010307@stericsson.com>	<CAMJBoFM9v9ugDL8gtNJ+AMCKmvOsUQHEmEf13VDXko41AkFfFA@mail.gmail.com>	<CAMJBoFPcBzezFDRXpL36zJZTttGgUFzDCUaFC69Pxg+gEWcAOw@mail.gmail.com>	<4EE8D23E.8030000@stericsson.com>	<CAMJBoFPSEtM1rQ7Rq8d+Y6Qgd_GKq2o4p=vk60wZdbJ_Mhk_Gw@mail.gmail.com>	<4EE9BC61.7080705@stericsson.com> <CAMJBoFN5tub+Lv5p2Ae3UQY48G2TMBBmdkdsA1TNDqf2stDGVg@mail.gmail.com> <4EEF0541.6070306@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:60411 "EHLO
	eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752211Ab1LSMWD (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 19 Dec 2011 07:22:03 -0500
In-Reply-To: <4EEF0541.6070306@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Per FORLIN <per.forlin@stericsson.com>, Johan RUDHOLM <johan.rudholm@stericsson.com>, Lee Jones <lee.jones@linaro.org>

If you got this half written reply, please ignore it.

BR
Ulf Hansson

Ulf Hansson wrote:
> Vitaly Wool wrote:
>> Hi,
>>
>> I did some measurement, having two eMMC connected (one of them with a
>>  root file system mounted) and one rather good SD-card with VFAT. The
>>  resume time for the kernel before these patches were around 600 ms. 
>> After my patches I had around 20 ms.
>>
>> What do you call "resume time" in this case?
>>
>> Total kernel resume time.
>>
>> This is an artificial and unfair definition. No one should care about
>> that. You can think of a time-to-splashscreen or
>> time-to-functional-userspace and both are not going to be improved
>> much with your patch if we run off of a eMMC-based root.
>>
> 
> I think you are missing a very valuable thing about how the resume 
> sequence is being changed with this patch.
> 
> Before this patch:
> _Every_ MMC and SD card were resumed sequentially. Thus every resume for 
> every card adds up to the resume time _always_.
> 
> After this patch:
> 1. MMC and SD cards can be is resumed in parallel.
> 2. Only MMC and SD cards which will get requests within ~3 s after the 
> kernel has resumed will notice the resume time. Requests triggered later 
> will be performed on a already resumed host.done coming
> 
>   moreover, only if there arrives a request for before
> 
> only tho No resume is forst of all only done if there is a request
> 
> 
> So for some reas and that the resume time (and also the the time for use
> 
> 
>       in a sequence
> 
>>
>> Moreover, I noticed very seldom than any mmc/sd request arrived 
>> within the time were the deferred resumed has not been done. Of 
>> course this will very much depend on what kind of userspace 
>> application that is running and if there is an ongoing file transfer 
>> that were frozen when doing suspend.
>>
>> ...or  the wakeup source was the userspace alarm etc. etc.
>>
>>
>> But, if this happens (deferred resume not done), the total resume 
>> time for that particular userspace application will anyway be heavily
>>  decreased since the other hosts resume time did not affect the
>> resume time for this application.
>>
>> I take that by "other hosts" you mean SD card? :)
>>
>> "Other hosts", are all those hosts holding an eMMC/MMC or an SD-card,
>>  but not that host that there were a request for, before the deferred
>>  resume has finalized.
>>
>> Ok, what if a rootfs application to be started first has to re-read
>> say certificates from the SD card? And what if not doing that in time
>> means QoS degradation?
>>
>> No, you don't see all the _real_ use cases that you can break with
>> your patch.
>>
>>
>>
>>
>>
>> -be async (e. g. start card resume process in resume routine, set 
>> atomic, return success and have wait_event_interruptible_timeout in 
>> block_rq if this atomic is set).
>>
>> Don't follow you. This is exactly what the patch is doing. Not just 
>> for SD, but also for (e)MMC. I don't see your issue.
>>
>> No it doesn't. It defers the execution by arbitrary chosen time of 3
>> seconds.
>>
>>
>>
>> Do you mean that we should implement this for SD cards as well?
>>
>> Anyway, I don't understand what this should prevent a resume from
>> being executed for SD/SDIO/(e)MMC at all?
>>
>> Please elaborate.
>>
>>
>> I'm not going to, at least not in this thread. The method you propose
>> is a hack and it can not be accepted at least because it doesn't give
>> a damn about QoS. The whole idea of "let's unconditionally defer
>> resume of something for arbitrary amount of time no matter what" is
>> invalid.
>>
>> Thanks, Vitaly
>>
> 
> 

