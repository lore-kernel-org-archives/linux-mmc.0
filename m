From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Wed, 8 Apr 2015 11:49:08 +0200
Message-ID: <CAPDyKFopOFH1rHrf6hu_oTJj+EmiDLSyPn9pKc34iUtANbYTsA@mail.gmail.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFooK=F88mO+8T0o1WAS=a+NntJszt-fa9+Ddkh_LpJsQg@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333F9FF93F@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFr2HoMveZ7t=U+CevXuO3hZmN-DivFKEaDnqpPtBYquWA@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA0429D@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFqLUBYUx9XrhnMeUtf8HU_=4PH_4Vf7m8mM-CT63jG24Q@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA1245B@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFrhfPZG4ZnqNTSEgbnpukw342gaeyi22OqAt6PA==E8ug@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA14148@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFrRAMRDNRX+zW-Odh+-ouZO7b0S4RvKQka+90D63uqBDQ@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA3FA3A@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFroXQ8CThExfbn3F+wMX6=6+-OgLawx2+RA8WC-Y-EKrw@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA5B753@SACMBXIP01.sdcorp.global.sandisk.com>
	<CAPDyKFo0S=5Xek_i4TRo-YAHxE5UKa4PLw_t7awrtdd_AtuTZQ@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED53343B2DC51@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f182.google.com ([209.85.220.182]:34359 "EHLO
	mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752944AbbDHJtI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Apr 2015 05:49:08 -0400
Received: by qkgx75 with SMTP id x75so78902857qkg.1
        for <linux-mmc@vger.kernel.org>; Wed, 08 Apr 2015 02:49:08 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED53343B2DC51@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 6 April 2015 at 15:44, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote=
:
> Hi Ulf,
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Wednesday, April 01, 2015 2:46 PM
>> To: Alex Lemberg
>> Cc: Avi Shchislowski; linux-mmc; Chris Ball
>> Subject: Re: [PATCH] mmc: sleep notification
>>
>> [...]
>>
>> >> Okay, so to me, I think the SLEEP notification needs to be sent a=
s a
>> >> part of the system PM suspend phase. And more exactly from the
>> >> bus_ops->suspend() callback.
>> >>
>> >
>> > PM suspend phase is a right place for PON Sleep_Notification, but =
it
>> > also the critical one and need to be completed as fast as possible=
=2E
>> >
>> > If I'm not mistaken, during the PM Suspend, the user space is free=
zing.
>> > Is it OK to let PON Sleep_Notification to be called at that stage?
>>
>> Of course we shall strive in minimizing the system PM suspend time.
>> Though to me, I think the system PM _resume_ time is of more importa=
nce.
>>
>> In this case we don't have any option. We need to issue the sleep no=
tification as
>> part of the the system PM suspend phase and that will unfortunate an=
d likely
>> increase the total system PM suspend time.
>>
>> >
>> > Calling from the notifier_call (mmc_pm_notify()) will allow to
>> > complete Sleep_Notification process before entering to the critica=
l part - the
>> Suspend.
>> > Isn't it?
>>
>> Why is mmc_pm_notify() a less critical part?
>>
>> More importantly as stated several times, we can still get I/O reque=
sts after
>> the mmc_pm_notify() phase and then the sleep notification needs to b=
e
>> interrupted and re-issued anyway.
>
> You are right - the sleep_notification might be re-issued several tim=
es,
> but in case of mmc_pm_notify() the user space is not frozen yet, and
> system will not stuck until sleep_notification completion, like in ca=
se of
> PM suspend.
>
>>
>> >
>> >> In addition to that, we should be able improve the situation by a=
lso
>> >> sending the SLEEP notification as part of an "idle operation". Wi=
th
>> >> "idle operation" I mean the mmc block layer hasn=E2=80=99t receiv=
ed any new
>> >> request for a while (the framework for this is already implemente=
d by using
>> runtime PM).
>> >
>> > OK, sounds like a good approach.
>> > In case runtime PM is supported, we can call PON Sleep_Notificatio=
n
>> > from
>> > mmc_runtime_suspend() during the "idle operation", and then call i=
t
>> > again during PM Suspend.
>>
>> Yes.
>>
>> If you plan to send a new version of $subject patch, please split in=
to at least two
>> patches. One which adds the system PM part and one which adds the "i=
dle
>> operation" part.
>
> As far as I see, the same _mmc_suspend() function is used in both cas=
es -
> PM Suspend and "idle operation".
> The _mmc_suspend() is called from both  - mmc_suspend() and
> mmc_runtime_suspend().
> In case we decide to go with PM Suspend and "idle operation",
> should we just add the sleep_notification support to _mmc_suspend() f=
or
> covering both cases?

That works as a start.

Though, it would mean MMC_CAP_AGGRESSIVE_PM is needed to enable "idle
operations" for this case. It might be good enough. If not, we need to
send the sleep notification from mmc_runtime_suspend() as well.

Kind regards
Uffe
