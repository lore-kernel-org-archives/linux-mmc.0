From: =?GB2312?B?U3RlZmZlbiBLqLlobg==?= <sk@ammonit.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix deadlock
Date: Wed, 09 May 2012 14:12:47 +0200
Message-ID: <4FAA5F3F.8060906@ammonit.com>
References: <1336555416-14640-1-git-send-email-sk@ammonit.com> <4FAA4ADA.1080008@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:58248 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758687Ab2EIMMu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 9 May 2012 08:12:50 -0400
In-Reply-To: <4FAA4ADA.1080008@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ludovic.desroches" <ludovic.desroches@atmel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>

Hi Ludovic,

my hardware is a multiprocessor system by which the access to the card
is shared between two processors. Because of this changes happen really
frequently.

I have observed that the deadlock only occurs when the card is
desappearing and there are errors like 'end_request: I/O error, dev
mmcblk0, sector XXX'. A process has to read permanently from the card.

The problem seems to be that the driver waits for finishing the
transfer, but this comes never because the card is unavailable. Maybe a
new state machine solves this in a better way as my workaround.

Regards
Steffen

Am 09.05.2012 12:45, schrieb ludovic.desroches:
> Hi Steffen,
>=20
> Le 05/09/2012 11:23 AM, Steffen K=A8=B9hn a =A8=A6crit :
>> solves a deadlock problem which appears when a mmc card is
>> removing and a process is reading from the card at the same time.
>> ---
>>   drivers/mmc/host/atmel-mci.c |    4 +++-
>>   1 files changed, 3 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/mmc/host/atmel-mci.c b/drivers/mmc/host/atmel-m=
ci.c
>> index e94476b..effdc36 100644
>> --- a/drivers/mmc/host/atmel-mci.c
>> +++ b/drivers/mmc/host/atmel-mci.c
>> @@ -1499,8 +1499,10 @@ static void atmci_tasklet_func(unsigned long =
priv)
>> 			}
>>
>> 			if (!atmci_test_and_clear_pending(host,
>> -						EVENT_XFER_COMPLETE))
>> +						EVENT_XFER_COMPLETE)) {
>> +				host->stop_transfer(host);
>> 				break;
>> +            }
>>
>> 			atmci_set_completed(host, EVENT_XFER_COMPLETE);
>> 			prev_state =3D state =3D STATE_DATA_BUSY;
>> --
>> 1.7.2.5
>=20
> Even if it solves your issue, I am not sure about the consequences of
> this fix even if it is working well in your case and with your hardwa=
re.
>=20
> This condition allows to wait for the end of a transfer. The
> EVENT_XFER_COMPLETE flag is set when the dma transfer is complete (or=
 pdc).
> If the transfer is not complete you will ask to stop it. I understand=
 it
> could solve your issue but I am afraid it can also stop a transfer
> before its normal completion.
>=20
> I am currently working on atmel-mci and the state machine would be
> changed.  So I prefer to wait the new atmel-mci version to take this
> patch. I will add your issue to my test cases.
>=20
>=20
> By the way, can you give me more details about your issue because I
> can't reproduce it on my side. If I remove the card while a process i=
s
> reading from it, I also have I/O errors but I have no issue to detect=
 a
> new card insertion.
>=20
>=20
> Regards
>=20
> Ludovic
