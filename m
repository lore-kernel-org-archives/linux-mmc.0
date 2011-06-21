From: James Hogan <james@albanarts.com>
Subject: Re: [PATCH] cb710: fix #ifdef HAVE_EFFICIENT_UNALIGNED_ACCESS
Date: Tue, 21 Jun 2011 17:40:53 +0100
Message-ID: <BANLkTik7CqKJUGNbvTO-WbfzVR2MxT=j3A@mail.gmail.com>
References: <BANLkTikMc1WfJMJ2NeBr1E62dGjCj1Cd_w@mail.gmail.com>
	<20110621101725.GA670@rere.qmqm.pl>
	<m239j3tb3w.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:54635 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756993Ab1FUQkz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 12:40:55 -0400
In-Reply-To: <m239j3tb3w.fsf@bob.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

2011/6/21 Chris Ball <cjb@laptop.org>:
> Hi,
>
> On Tue, Jun 21 2011, Micha=C5=82 Miros=C5=82aw wrote:
>> On Tue, Jun 21, 2011 at 10:55:34AM +0100, James Hogan wrote:
>>> HAVE_EFFICIENT_UNALIGNED_ACCESS is a config option, therefore it ne=
eds
>>> the CONFIG_ before it when used by the preprocessor.
>>>
>>> Signed-off-by: James Hogan <james@albanarts.com>
>>> ---
>>> =C2=A0drivers/misc/cb710/sgbuf2.c | =C2=A0 =C2=A02 +-
>>> =C2=A01 files changed, 1 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/misc/cb710/sgbuf2.c b/drivers/misc/cb710/sgbuf=
2.c
>>> index d019746..2a40d0e 100644
>>> --- a/drivers/misc/cb710/sgbuf2.c
>>> +++ b/drivers/misc/cb710/sgbuf2.c
>>> @@ -47,7 +47,7 @@ static uint32_t sg_dwiter_read_buffer(struct
>>> sg_mapping_iter *miter)
>>>
>>> =C2=A0static inline bool needs_unaligned_copy(const void *ptr)
>>> =C2=A0{
>>> -#ifdef HAVE_EFFICIENT_UNALIGNED_ACCESS
>>> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>>> =C2=A0 =C2=A0 =C2=A0return false;
>>> =C2=A0#else
>>> =C2=A0 =C2=A0 =C2=A0return ((ptr - NULL) & 3) !=3D 0;
>>
>> Acked-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>
>
> Thanks, pushed to mmc-next for 3.0.
>
> (James, your patch was corrupt due to a hard line break on the @@
> line -- please fix that next time around.)

Ahh, sorry about that Chris, I thought I had that problem sorted!

Thanks
James

>
> - Chris.
> --
> Chris Ball =C2=A0 <cjb@laptop.org> =C2=A0 <http://printf.net/>
> One Laptop Per Child
>



--=20
James Hogan
