From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Fri, 27 Mar 2015 13:57:22 +0100
Message-ID: <CAPDyKFroXQ8CThExfbn3F+wMX6=6+-OgLawx2+RA8WC-Y-EKrw@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f47.google.com ([209.85.192.47]:32897 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752725AbbC0M5X convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 27 Mar 2015 08:57:23 -0400
Received: by qgfa8 with SMTP id a8so125070725qgf.0
        for <linux-mmc@vger.kernel.org>; Fri, 27 Mar 2015 05:57:22 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333FA3FA3A@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

[...]

>> > What if Sleep_Notification will take several seconds?
>>
>> Yes, that horrible! You should tell your colleagues designing FTLs t=
o make sure
>> that _never_ happens.
>
> Agree, but we need to consider and take care of all such cases in the=
 driver side.
> Device might be busy with its internal garbage collection, and as spe=
c allows, it
> will complete it in a great manner after host sends PON command.
>

Okay, so to me, I think the SLEEP notification needs to be sent as a
part of the system PM suspend phase. And more exactly from the
bus_ops->suspend() callback.

In addition to that, we should be able improve the situation by also
sending the SLEEP notification as part of an "idle operation". With
"idle operation" I mean the mmc block layer hasn=E2=80=99t received any=
 new
request for a while (the framework for this is already implemented by
using runtime PM).

So if the SLEEP notification was sent during the "idle operation" and
no new request was needed during the system PM suspend phase we
wouldn't have to wake up the card again using HPI, but instead just
leave it "sleeping" and send CMD5.

Still, there would be no guarantees that "idle operations" is executed
before a system PM suspend phase starts. So there are no way we can
improve the worst case scenario.

Kind regards
Uffe
