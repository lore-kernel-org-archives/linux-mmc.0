From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Tue, 17 Mar 2015 11:43:48 +0100
Message-ID: <CAPDyKFrRAMRDNRX+zW-Odh+-ouZO7b0S4RvKQka+90D63uqBDQ@mail.gmail.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFooK=F88mO+8T0o1WAS=a+NntJszt-fa9+Ddkh_LpJsQg@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333F9FF93F@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFr2HoMveZ7t=U+CevXuO3hZmN-DivFKEaDnqpPtBYquWA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA0429D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFqLUBYUx9XrhnMeUtf8HU_=4PH_4Vf7m8mM-CT63jG24Q@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA1245B@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFrhfPZG4ZnqNTSEgbnpukw342gaeyi22OqAt6PA==E8ug@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA14148@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f54.google.com ([209.85.192.54]:34257 "EHLO
	mail-qg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933064AbbCQKnt (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 17 Mar 2015 06:43:49 -0400
Received: by qgh62 with SMTP id 62so3868620qgh.1
        for <linux-mmc@vger.kernel.org>; Tue, 17 Mar 2015 03:43:48 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333FA14148@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 16 March 2015 at 17:58, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
>
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Monday, March 16, 2015 3:35 PM
>> To: Alex Lemberg
>> Cc: Avi Shchislowski; linux-mmc; Chris Ball
>> Subject: Re: [PATCH] mmc: sleep notification
>>
>> On 16 March 2015 at 12:37, Alex Lemberg <Alex.Lemberg@sandisk.com>
>> wrote:
>> > Hi Ulf,
>> >
>> >> -----Original Message-----
>> >> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> >> Sent: Thursday, March 12, 2015 11:10 AM
>> >> To: Alex Lemberg
>> >> Cc: Avi Shchislowski; linux-mmc; Chris Ball
>> >> Subject: Re: [PATCH] mmc: sleep notification
>> >>
>> >> [...]
>> >>
>> >> >> > Also, I think we need to clarify one more point for this patch:
>> >> >> > As was mentioned in commit message - Sleep_Notification can be
>> >> >> > interrupted
>> >> >> by HPI.
>> >> >> > This allows not blocking the host during the Sleep_Notification
>> >> >> > busy time and allows accepting requests coming during this stage.
>> >> >> > Thus, without having HPI supported, suspend/resume process might
>> >> >> > be influenced by Sleep_Notification busy time, and this should
>> >> >> > not happen -
>> >> >> suspend/resume should be done in very fast and not blocking manner.
>> >> >>
>> >> >> I fail to understand your comment here.
>> >> >>
>> >> >> Please tell me at what point(s) your think it make sense to issue
>> >> >> the SLEEP_NOTIFICATION? If that is during the suspend phase, then
>> >> >> a HPI request can't be triggered.
>> >> >
>> >> > I think SLEEP_NOTIFICATION should be issued on mmc_pm_notify()
>> >> > call, on PM_SUSPEND_PREPARE case.
>> >>
>> >> So, exactly why is that to prefer, comparing doing it in system PM
>> >> ->suspend() callback?
>> >
>> > Assuming that SLEEP_NOTIFICATION may take time (defined in
>> > SLEEP_NOTIFICATION_TIME byte in EXT_CSD [216]), I think it is better
>> > to send it from pm notifier - mmc_pm_notify().
>>
>> I assume you think that you will "earn" some milliseconds doing it in this phase,
>> but I am not so sure.
>
> I was thinking mainly about how to prevent "blocking" during Sleep_Notification process.
>
>>
>> After the PM_SUSPEND_PREPARE notifier, we still have the mmc block queue
>> open and are ready to serve requests. Therefore I would expect the
>> SLEEP_NOTIFICATION to potentially be interrupted by using HPI.
>
> Right, and this was a reason for adding HPI support during the Sleep_Notification.
>
>>
>> Then we end up with the following sequence during the system PM sleep phase.
>> 1. Issue SLEEP_NOTIFICATION.
>> 2. Interrupt SLEEP_NOTIFICATION, using HPI.
>> 3. Serve blk request
>> 4. Issue SLEEP_NOTIFICATION.
>> 5. Issue SLEEP (CMD5).
>
> Correct, this is a sequence that we see after adding the patch.
>
>> That seems like a bad idea to me.
>
> Could you please explain why?
> Would you suggest to call Sleep_Notification from Suspend only?

Since otherwise we may end up issuing SLEEP_NOTIFICATION not only
once, but twice during a system PM sleep sequence. So then we actually
get an increased system PM suspend time.

> What if Sleep_Notification will take several seconds?

Yes, that horrible! You should tell your colleagues designing FTLs to
make sure that _never_ happens.

Also, this makes me wonder how this kind of feature ever could make it
into the JEDEC specification.

What we had earlier with "CMD5 only" should never have been changed.

Kind regards
Uffe
