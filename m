From: Dmitry Shmidt <dimitrysh@google.com>
Subject: Re: [PATCH] sdio: add new function for RAW (Read after Write)
	operation
Date: Fri, 14 May 2010 17:02:24 -0700
Message-ID: <AANLkTilCD2wylI_11B_S9-SbktXvUYgYB7d224XIMRt1@mail.gmail.com>
References: <1272403088-4727-1-git-send-email-notasas@gmail.com>
	 <AANLkTinEGhNI_n25FVZ4NrLr6ClNw3JVusnJVDZdQchn@mail.gmail.com>
	 <20100514150620.70323c76.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out.google.com ([74.125.121.35]:20964 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250Ab0EOAC1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 14 May 2010 20:02:27 -0400
Received: from wpaz5.hot.corp.google.com (wpaz5.hot.corp.google.com [172.24.198.69])
	by smtp-out.google.com with ESMTP id o4F02PR0031443
	for <linux-mmc@vger.kernel.org>; Fri, 14 May 2010 17:02:26 -0700
Received: from qyk7 (qyk7.prod.google.com [10.241.83.135])
	by wpaz5.hot.corp.google.com with ESMTP id o4F02Oa7001253
	for <linux-mmc@vger.kernel.org>; Fri, 14 May 2010 17:02:24 -0700
Received: by qyk7 with SMTP id 7so3433520qyk.7
        for <linux-mmc@vger.kernel.org>; Fri, 14 May 2010 17:02:24 -0700 (PDT)
In-Reply-To: <20100514150620.70323c76.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Grazvydas Ignotas <notasas@gmail.com>, Kalle Valo <kalle.valo@iki.fi>, linux-mmc@vger.kernel.org

Hi Andrew,

wl1251 has some HW problem for ELP register that demands to do
something like "write during read" in order
not to loose bits from this register during simple read.
=46ortunately it was enough just to add low 8 bits previous register
value to the cmd.args during read operation
and SD Controller will behave as needed. And it was tested on real
wl1251 device that is used in G1 and MyTouch.

However, patch author for some reason is using WRITE operation instead =
of READ.
>>> ret =3D mmc_io_rw_direct(func->card, 1, func->num, addr, b, &val);
>>> 1 means WRITE

Maybe in case of wl1251 HW it is not important - to write during read,
or to read during write, but the problem in wl1251 was during ELP
register READ operation, so I do not understand why author used WRITE
flag.

Thanks,

Dmitry

On Fri, May 14, 2010 at 3:06 PM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Fri, 14 May 2010 14:04:17 +0300
> Grazvydas Ignotas <notasas@gmail.com> wrote:
>
>> Hi Kalle,
>>
>> On Wed, Apr 28, 2010 at 12:18 AM, Grazvydas Ignotas <notasas@gmail.c=
om> wrote:
>> > SDIO specification allows RAW (Read after Write) operation using
>> > IO_RW_DIRECT command (CMD52) by setting the RAW bit. This operatio=
n is
>> > similar to ordinary read/write commands, except that both write an=
d read
>> > are performed using single command/response pair. The Linux SDIO l=
ayer
>> > already supports this internaly, only external function is missing=
 for
>> > drivers to make use, which is added by this patch.
>> >
>> > This type of command is required to implement proper power save mo=
de
>> > support in wl1251 wifi driver.
>>
>> As wl1251 maintainer, can you confirm this is needed for wl1251 driv=
er
>> to function in SDIO mode? Perhaps this could help convince Andrew to
>> merge this patch.
>
> I kinda ducked the patch because there are no callers of the function=
=2E
>
>> Without this the chip is having problems leaving ELP
>> mode. Android has similar patch for G1 in it's tree for the same
>> reason:
>>
>> http://android.git.kernel.org/?p=3Dkernel/common.git;a=3Dcommitdiff;=
h=3D74a47786f6ecbe6c1cf9fb15efe6a968451deb52
>
> Well let's cc Dmitry then. =A0Dmitry's patch is somewhat different fr=
om
> yours and that needs to be looked at.
>
> Some comments:
>
> : From: Grazvydas Ignotas <notasas@gmail.com>
> :
> : SDIO specification allows RAW (Read after Write) operation using
> : IO_RW_DIRECT command (CMD52) by setting the RAW bit. =A0This operat=
ion is
> : similar to ordinary read/write commands, except that both write and=
 read
> : are performed using single command/response pair. =A0The Linux SDIO=
 layer
> : already supports this internaly, only external function is missing =
for
> : drivers to make use, which is added by this patch.
> :
> : This type of command is required to implement proper power save mod=
e
> : support in wl1251 wifi driver.
> :
> : Signed-off-by: Grazvydas Ignotas <notasas@gmail.com>
> : Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> : ---
> :
> : =A0drivers/mmc/core/sdio_io.c =A0 =A0| =A0 31 +++++++++++++++++++++=
++++++++++
> : =A0include/linux/mmc/sdio_func.h | =A0 =A03 +++
> : =A02 files changed, 34 insertions(+)
> :
> : diff -puN drivers/mmc/core/sdio_io.c~sdio-add-new-function-for-raw-=
read-after-write-operation drivers/mmc/core/sdio_io.c
> : --- a/drivers/mmc/core/sdio_io.c~sdio-add-new-function-for-raw-read=
-after-write-operation
> : +++ a/drivers/mmc/core/sdio_io.c
> : @@ -406,6 +406,37 @@ void sdio_writeb(struct sdio_func *func,
> : =A0EXPORT_SYMBOL_GPL(sdio_writeb);
> :
> : =A0/**
> : + * =A0 sdio_writeb_readb - write and read a byte from SDIO functio=
n
> : + * =A0 @func: SDIO function to access
> : + * =A0 @b: byte to write
> : + * =A0 @addr: address to write to
> : + * =A0 @err_ret: optional status value from transfer
> : + *
> : + * =A0 Performs a RAW (Read after Write) operation as defined by S=
DIO spec -
> : + * =A0 single byte is written to address space of a given SDIO fun=
ction and
> : + * =A0 response is read back from the same address, both using sin=
gle request.
> : + * =A0 If there is a problem with the operation, 0xff is returned =
and
> : + * =A0 @err_ret will contain the error code.
> : + */
> : +u8 sdio_writeb_readb(struct sdio_func *func, u8 b,
>
> "b" is a poor name. =A0Please choose something meaningful.
>
> : + =A0 =A0 unsigned int addr, int *err_ret)
> : +{
> : + =A0 =A0 int ret;
> : + =A0 =A0 u8 val;
> : +
> : + =A0 =A0 BUG_ON(!func);
>
> This test doesn't gain us much. =A0If `func' is NULL, we'll reliably =
oops
> when dereferencing it, which gives the same info as the BUG_ON().
>
> : + =A0 =A0 ret =3D mmc_io_rw_direct(func->card, 1, func->num, addr, =
b, &val);
> : + =A0 =A0 if (err_ret)
> : + =A0 =A0 =A0 =A0 =A0 =A0 *err_ret =3D ret;
> : + =A0 =A0 if (ret)
> : + =A0 =A0 =A0 =A0 =A0 =A0 val =3D 0xff;
> : +
> : + =A0 =A0 return val;
> : +}
> : +EXPORT_SYMBOL_GPL(sdio_writeb_readb);
> : +
> : +/**
> : =A0 * =A0 sdio_memcpy_fromio - read a chunk of memory from a SDIO f=
unction
> : =A0 * =A0 @func: SDIO function to access
> : =A0 * =A0 @dst: buffer to store the data
> : diff -puN include/linux/mmc/sdio_func.h~sdio-add-new-function-for-r=
aw-read-after-write-operation include/linux/mmc/sdio_func.h
> : --- a/include/linux/mmc/sdio_func.h~sdio-add-new-function-for-raw-r=
ead-after-write-operation
> : +++ a/include/linux/mmc/sdio_func.h
> : @@ -145,6 +145,9 @@ extern void sdio_writew(struct sdio_func
> : =A0extern void sdio_writel(struct sdio_func *func, u32 b,
> : =A0 =A0 =A0 unsigned int addr, int *err_ret);
> :
> : +extern u8 sdio_writeb_readb(struct sdio_func *func, u8 b,
> : + =A0 =A0 unsigned int addr, int *err_ret);
> : +
> : =A0extern int sdio_memcpy_toio(struct sdio_func *func, unsigned int=
 addr,
> : =A0 =A0 =A0 void *src, int count);
> : =A0extern int sdio_writesb(struct sdio_func *func, unsigned int add=
r,
>
>
>
