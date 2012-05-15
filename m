From: =?GB2312?B?U3RlZmZlbiBLqLlobg==?= <sk@ammonit.com>
Subject: Re: [PATCH] mmc: atmel-mci: fix deadlock
Date: Tue, 15 May 2012 18:05:25 +0200
Message-ID: <4FB27EC5.70507@ammonit.com>
References: <1336555416-14640-1-git-send-email-sk@ammonit.com> <4FAA4ADA.1080008@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:57637 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933099Ab2EOQHl (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 15 May 2012 12:07:41 -0400
In-Reply-To: <4FAA4ADA.1080008@atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "ludovic.desroches" <ludovic.desroches@atmel.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>

Dear Ludovic,

in the meantime I have some new informations about the atmel-mci
deadlock problem: When you write permanently with

dd if=3D/dev/zero of=3D/dev/<device> bs=3D512

and removing the card you will get almost always a hang up. With
"printk" I have find out that the function "atmci_tasklet_func" doesn't
run anymore in this case.

I would ask you to add card inserting and removing during write and rea=
d
in your test cases.

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

