From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sleep notification
Date: Tue, 10 Mar 2015 18:22:11 +0100
Message-ID: <CAPDyKFrZi1WqkYvOfDsMLh=xYxhYrVJMnjzStGut3YOYCG+mVA@mail.gmail.com>
References: <1425980197-823-1-git-send-email-avi.shchislowski@sandisk.com>
	<54FEF34E.20205@intel.com>
	<282CEDFCBC30114F83C499CB8F2ED5333FA00476@SACMBXIP01.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f181.google.com ([209.85.216.181]:46813 "EHLO
	mail-qc0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbCJRWL (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 10 Mar 2015 13:22:11 -0400
Received: by qcyl6 with SMTP id l6so3602227qcy.13
        for <linux-mmc@vger.kernel.org>; Tue, 10 Mar 2015 10:22:11 -0700 (PDT)
In-Reply-To: <282CEDFCBC30114F83C499CB8F2ED5333FA00476@SACMBXIP01.sdcorp.global.sandisk.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Alex Lemberg <Alex.Lemberg@sandisk.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, Avi Shchislowski <Avi.Shchislowski@sandisk.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "chris@printf.net" <chris@printf.net>

On 10 March 2015 at 17:32, Alex Lemberg <Alex.Lemberg@sandisk.com> wrote:
> Hi Adrian,
>
>> -----Original Message-----
>> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
>> Sent: Tuesday, March 10, 2015 6:36 AM
>> To: Avi Shchislowski; ulf.hansson@linaro.org
>> Cc: linux-mmc@vger.kernel.org; chris@printf.net; Alex Lemberg
>> Subject: Re: [PATCH] mmc: sleep notification
>>
>> On 10/03/15 11:36, Avi Shchislowski wrote:
>> > This patch is implements the new additional state of
>> > Power_Off_Notification - SLEEP_NOTIFICATION.
>> > Until now, the implementation of Power_Off_Notification supported only
>> > three modes - POWERED_ON (0x01), POWER_OFF_SHORT (0x02) and
>> > POWER_OFF_LONG (0x03).
>> >
>> > As part of eMMC5.0 before moving to Sleep state hosts may set the
>> > POWER_OFF_NOTIFICATION byte to SLEEP_NOTIFICATION (0x04).
>> > After setting SLEEP_NOTIFICATION, host should wait for the busy line
>> > to be de-asserted.
>> > The max timeout allowed for busy line de-assertion defined in
>> > SLEEP_NOTIFICATION_TIME byte in EXT_CSD [216].
>> > HPI may interrupt the SLEEP_NOTIFICATION operation.
>> > In that case POWER_OFF_NOTIFICATION byte will restore to POWERED_ON.
>>
>> Is it so that the point of SLEEP_NOTIFICATION is to notify that VCC will be
>> powered off after the device is put to sleep by CMD5?
>
> From the spec:
>
> the host should issue a power off notification (POWER_OFF_LONG, POWER_OFF_SHORT )
> if it intends to turn off both VCC and VCCQ power supplies or it may use
> to a power off notification (SLEEP_NOTIFICATION ) if it intends to turn-off VCC
> after moving the device to Sleep state.

Ah, so CMD5 will still need to be issued. Thanks for clarifying.

>
>>
>> At the moment, the card does not get put to sleep if there is support for power-
>> off-notification?
>
> Driver will send Sleep only if PON is not supported...

Nope, that's not entirely correct.

The MMC core requires PON to be supported by the card and the host to
have MMC_CAP2_FULL_PWR_CYCLE set. Else it will send sleep (CMD5)
instead.

Kind regards
Uffe
