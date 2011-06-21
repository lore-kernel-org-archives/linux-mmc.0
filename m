From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] cb710: fix #ifdef HAVE_EFFICIENT_UNALIGNED_ACCESS
Date: Tue, 21 Jun 2011 12:14:59 -0400
Message-ID: <m239j3tb3w.fsf@bob.laptop.org>
References: <BANLkTikMc1WfJMJ2NeBr1E62dGjCj1Cd_w@mail.gmail.com>
	<20110621101725.GA670@rere.qmqm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:55853 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753673Ab1FUQPH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 21 Jun 2011 12:15:07 -0400
In-Reply-To: <20110621101725.GA670@rere.qmqm.pl> (=?utf-8?Q?=22Micha=C5=82?=
 =?utf-8?Q?_Miros=C5=82aw=22's?= message
	of "Tue, 21 Jun 2011 12:17:25 +0200")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: James Hogan <james@albanarts.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Hi,

On Tue, Jun 21 2011, Micha=C5=82 Miros=C5=82aw wrote:
> On Tue, Jun 21, 2011 at 10:55:34AM +0100, James Hogan wrote:
>> HAVE_EFFICIENT_UNALIGNED_ACCESS is a config option, therefore it nee=
ds
>> the CONFIG_ before it when used by the preprocessor.
>>=20
>> Signed-off-by: James Hogan <james@albanarts.com>
>> ---
>>  drivers/misc/cb710/sgbuf2.c |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>=20
>> diff --git a/drivers/misc/cb710/sgbuf2.c b/drivers/misc/cb710/sgbuf2=
=2Ec
>> index d019746..2a40d0e 100644
>> --- a/drivers/misc/cb710/sgbuf2.c
>> +++ b/drivers/misc/cb710/sgbuf2.c
>> @@ -47,7 +47,7 @@ static uint32_t sg_dwiter_read_buffer(struct
>> sg_mapping_iter *miter)
>>=20
>>  static inline bool needs_unaligned_copy(const void *ptr)
>>  {
>> -#ifdef HAVE_EFFICIENT_UNALIGNED_ACCESS
>> +#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
>>  	return false;
>>  #else
>>  	return ((ptr - NULL) & 3) !=3D 0;
>
> Acked-by: Micha=C5=82 Miros=C5=82aw <mirq-linux@rere.qmqm.pl>

Thanks, pushed to mmc-next for 3.0.

(James, your patch was corrupt due to a hard line break on the @@
line -- please fix that next time around.)

- Chris.
--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
