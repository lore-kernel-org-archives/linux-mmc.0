From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Thu, 21 Apr 2011 15:40:14 +0200
Message-ID: <BANLkTins+p-oRN9QwNaTJYK+DTMbZRT0LQ@mail.gmail.com>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <201104211315.51984.arnd@arndb.de>
 <BANLkTikTBK+0_KLjcB_sk4kF+a_vdaOckQ@mail.gmail.com> <201104211439.14510.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:40231 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab1DUNkf convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 09:40:35 -0400
Received: by qyg14 with SMTP id 14so996649qyg.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 06:40:34 -0700 (PDT)
In-Reply-To: <201104211439.14510.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

W dniu 21 kwietnia 2011 14:39 u=BFytkownik Arnd Bergmann <arnd@arndb.de=
> napisa=B3:
> On Thursday 21 April 2011, Micha=B3 Miros=B3aw wrote:
>> W dniu 21 kwietnia 2011 13:15 u=BFytkownik Arnd Bergmann <arnd@arndb=
=2Ede> napisa=B3:
>
>> static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t m=
ode,
>> =A0 =A0 unsigned int cmd, unsigned long arg)
>> {
>> =A0 struct mmc_ioc_cmd blk;
>>
>> =A0 if (cmd !=3D MMC_IOC_CMD)
>> =A0 =A0 return -EINVAL;
>>
>> =A0 copy_from_user(compat_ptr(arg), &blk) ...
>> =A0 blk.data_ptr =3D compat_ptr(blk.__data_ptr_storage32);
>>
>> =A0 return mmc_blk_ioctl_cmd(bdev, &blk);
>> }
>
> Yes, this works, but it requires having a compat_ioctl() handler func=
tion that
> knows about the data structure, which we generally try to avoid.
> The same method would even work if you only had a pointer member in t=
he
> structure and did not even attempt to make the structure compatible.

Not really. If the structures were different, you would need write
code to translate it fully (this doesn't really apply for this simple
case, where there is only one pointer at the end of the structure). My
example only fixes/converts pointers in place.

The compat/native handler could be made in one function that takes
another bool arg and ioctl handlers would look like the code below. In
this scheme you avoid having to duplicate ioctl handler at all and let
compiler optimize out conditionals (you can even force
__mmc_blk_ioctl() inline to make sure of it).

#ifndef CONFIG_COMPAT
static inline void *compat_ptr(unsigned long) { BUG(); return NULL; }
#endif

static int __mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
=A0 =A0 unsigned int cmd, unsigned long arg, bool compat32)
{
  void __user *p;
=2E..
  p =3D compat32 ? compat_ptr(arg) : (void *)arg;
=2E..
  if (compat32)
 =A0  blk.data_ptr =3D compat_ptr(blk.__data_ptr_storage32);
=2E..
}

static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
=A0 =A0 unsigned int cmd, unsigned long arg)
{
  return __mmc_blk_ioctl(bdev, mode, cmd, arg, false);
}

#ifdef CONFIG_COMPAT
static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode=
,
=A0 =A0 unsigned int cmd, unsigned long arg)
{
  return __mmc_blk_ioctl(bdev, mode, cmd, arg, true);
}
#endif
