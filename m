From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Mon, 16 Mar 2015 14:34:59 +0100
Message-ID: <CAPDyKFrhfPZG4ZnqNTSEgbnpukw342gaeyi22OqAt6PA==E8ug@mail.gmail.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFooK=F88mO+8T0o1WAS=a+NntJszt-fa9+Ddkh_LpJsQg@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333F9FF93F@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFr2HoMveZ7t=U+CevXuO3hZmN-DivFKEaDnqpPtBYquWA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA0429D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFqLUBYUx9XrhnMeUtf8HU_=4PH_4Vf7m8mM-CT63jG24Q@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA1245B@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f175.google.com ([209.85.216.175]:34886 "EHLO
	mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbbCPNfA (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Mar 2015 09:35:00 -0400
Received: by qcbkw5 with SMTP id kw5so43270838qcb.2
        for <linux-mmc@vger.kernel.org>; Mon, 16 Mar 2015 06:34:59 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333FA1245B@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 16 March 2015 at 12:37, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
> Hi Ulf,
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Thursday, March 12, 2015 11:10 AM
>> To: Alex Lemberg
>> Cc: Avi Shchislowski; linux-mmc; Chris Ball
>> Subject: Re: [PATCH] mmc: sleep notification
>>
>> [...]
>>
>> >> > Also, I think we need to clarify one more point for this patch:
>> >> > As was mentioned in commit message - Sleep_Notification can be
>> >> > interrupted
>> >> by HPI.
>> >> > This allows not blocking the host during the Sleep_Notification
>> >> > busy time and allows accepting requests coming during this stage.
>> >> > Thus, without having HPI supported, suspend/resume process might be
>> >> > influenced by Sleep_Notification busy time, and this should not
>> >> > happen -
>> >> suspend/resume should be done in very fast and not blocking manner.
>> >>
>> >> I fail to understand your comment here.
>> >>
>> >> Please tell me at what point(s) your think it make sense to issue the
>> >> SLEEP_NOTIFICATION? If that is during the suspend phase, then a HPI
>> >> request can't be triggered.
>> >
>> > I think SLEEP_NOTIFICATION should be issued on mmc_pm_notify() call,
>> > on PM_SUSPEND_PREPARE case.
>>
>> So, exactly why is that to prefer, comparing doing it in system PM
>> ->suspend() callback?
>
> Assuming that SLEEP_NOTIFICATION may take time
> (defined in SLEEP_NOTIFICATION_TIME byte in EXT_CSD [216]),
> I think it is better to send it from pm notifier - mmc_pm_notify().

I assume you think that you will "earn" some milliseconds doing it in
this phase, but I am not so sure.

After the PM_SUSPEND_PREPARE notifier, we still have the mmc block
queue open and are ready to serve requests. Therefore I would expect
the SLEEP_NOTIFICATION to potentially be interrupted by using HPI.

Then we end up with the following sequence during the system PM sleep phase.
1. Issue SLEEP_NOTIFICATION.
2. Interrupt SLEEP_NOTIFICATION, using HPI.
3. Serve blk request
4. Issue SLEEP_NOTIFICATION.
5. Issue SLEEP (CMD5).

That seems like a bad idea to me.

Kind regards
Uffe
