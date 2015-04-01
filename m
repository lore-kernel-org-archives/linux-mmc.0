From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Wed, 1 Apr 2015 13:46:02 +0200
Message-ID: <CAPDyKFo0S=5Xek_i4TRo-YAHxE5UKa4PLw_t7awrtdd_AtuTZQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f41.google.com ([209.85.192.41]:35639 "EHLO
	mail-qg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751711AbbDALqD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 1 Apr 2015 07:46:03 -0400
Received: by qgh3 with SMTP id 3so39434513qgh.2
        for <linux-mmc@vger.kernel.org>; Wed, 01 Apr 2015 04:46:02 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333FA5B753@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

[...]

>> Okay, so to me, I think the SLEEP notification needs to be sent as a=
 part of the
>> system PM suspend phase. And more exactly from the
>> bus_ops->suspend() callback.
>>
>
> PM suspend phase is a right place for PON Sleep_Notification,
> but it also the critical one and need to be completed as fast as poss=
ible.
>
> If I'm not mistaken, during the PM Suspend, the user space is freezin=
g.
> Is it OK to let PON Sleep_Notification to be called at that stage?

Of course we shall strive in minimizing the system PM suspend time.
Though to me, I think the system PM _resume_ time is of more
importance.

In this case we don't have any option. We need to issue the sleep
notification as part of the the system PM suspend phase and that will
unfortunate and likely increase the total system PM suspend time.

>
> Calling from the notifier_call (mmc_pm_notify()) will allow to comple=
te
> Sleep_Notification process before entering to the critical part - the=
 Suspend.
> Isn't it?

Why is mmc_pm_notify() a less critical part?

More importantly as stated several times, we can still get I/O
requests after the mmc_pm_notify() phase and then the sleep
notification needs to be interrupted and re-issued anyway.

>
>> In addition to that, we should be able improve the situation by also=
 sending the
>> SLEEP notification as part of an "idle operation". With "idle operat=
ion" I mean
>> the mmc block layer hasn=E2=80=99t received any new request for a wh=
ile (the
>> framework for this is already implemented by using runtime PM).
>
> OK, sounds like a good approach.
> In case runtime PM is supported, we can call PON Sleep_Notification f=
rom
> mmc_runtime_suspend() during the "idle operation",
> and then call it again during PM Suspend.

Yes.

If you plan to send a new version of $subject patch, please split into
at least two patches. One which adds the system PM part and one which
adds the "idle operation" part.

Kind regards
Uffe
