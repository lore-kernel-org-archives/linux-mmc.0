From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Wed, 11 Mar 2015 12:50:26 +0100
Message-ID: <CAPDyKFr2HoMveZ7t=U+CevXuO3hZmN-DivFKEaDnqpPtBYquWA@mail.gmail.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
	<CAPDyKFooK=F88mO+8T0o1WAS=a+NntJszt-fa9+Ddkh_LpJsQg@mail.gmail.com>
	<282CEDFCBC30114F83C499CB8F2ED5333F9FF93F@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f53.google.com ([209.85.192.53]:46240 "EHLO
	mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbbCKLu1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 11 Mar 2015 07:50:27 -0400
Received: by qgfh3 with SMTP id h3so9066969qgf.13
        for <linux-mmc@vger.kernel.org>; Wed, 11 Mar 2015 04:50:27 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333F9FF93F@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Avi Shchislowski <Avi.Shchislowski@sandisk.com>, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>

On 10 March 2015 at 15:32, Alex Lemberg <Alex.Lemberg@sandisk.com> wrot=
e:
> Hi Ulf,
>
> Thanks for your review and comments!
>
>> -----Original Message-----
>> From: Ulf Hansson [mailto:ulf.hansson@linaro.org]
>> Sent: Tuesday, March 10, 2015 5:08 AM
>> To: Avi Shchislowski
>> Cc: linux-mmc; Chris Ball; Alex Lemberg
>> Subject: Re: [PATCH] mmc: sleep notification
>>
>> On 10 March 2015 at 10:36, Avi Shchislowski <avi.shchislowski@sandis=
k.com>
>> wrote:
>> > This patch is implements the new additional state of
>> > Power_Off_Notification =E2=80=93 SLEEP_NOTIFICATION.
>> > Until now, the implementation of Power_Off_Notification supported =
only
>> > three modes =E2=80=93 POWERED_ON (0x01), POWER_OFF_SHORT (0x02) an=
d
>> > POWER_OFF_LONG (0x03).
>> >
>> > As part of eMMC5.0 before moving to Sleep state hosts may set the
>> > POWER_OFF_NOTIFICATION byte to SLEEP_NOTIFICATION (0x04).
>> > After setting SLEEP_NOTIFICATION, host should wait for the busy li=
ne
>> > to be de-asserted.
>> > The max timeout allowed for busy line de-assertion defined in
>> > SLEEP_NOTIFICATION_TIME byte in EXT_CSD [216].
>> > HPI may interrupt the SLEEP_NOTIFICATION operation.
>> > In that case POWER_OFF_NOTIFICATION byte will restore to POWERED_O=
N.
>>
>> Oh, just great! JEDEC has invented yet another way of how to send a =
device to
>> sleep state. I wonder what was wrong with the CMD5 option.
>
> I think before adding sleep_notification, host has no way to notify d=
evice before sending
> sleep command. Now device can better prepare itself for moving into t=
he sleep state.
>
> Also, I think we need to clarify one more point for this patch:
> As was mentioned in commit message - Sleep_Notification can be interr=
upted by HPI.
> This allows not blocking the host during the Sleep_Notification busy =
time and allows accepting
> requests coming during this stage. Thus, without having HPI supported=
, suspend/resume process
> might be influenced by Sleep_Notification busy time, and this should =
not happen - suspend/resume
> should be done in very fast and not blocking manner.

I fail to understand your comment here.

Please tell me at what point(s) your think it make sense to issue the
SLEEP_NOTIFICATION? If that is during the suspend phase, then a HPI
request can't be triggered.

Kind regards
Uffe
