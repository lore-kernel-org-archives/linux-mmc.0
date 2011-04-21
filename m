From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Thu, 21 Apr 2011 13:47:11 +0200
Message-ID: <BANLkTikTBK+0_KLjcB_sk4kF+a_vdaOckQ@mail.gmail.com>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <201104210711.15457.arnd@arndb.de>
 <BANLkTinuzNRUOKOVY+SOqJ3fjjfKFUhNdA@mail.gmail.com> <201104211315.51984.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:52111 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753431Ab1DULrc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Apr 2011 07:47:32 -0400
Received: by qyk7 with SMTP id 7so2775321qyk.19
        for <linux-mmc@vger.kernel.org>; Thu, 21 Apr 2011 04:47:31 -0700 (PDT)
In-Reply-To: <201104211315.51984.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: John Calixto <john.calixto@modsystems.com>, linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Chris Ball <cjb@laptop.org>

W dniu 21 kwietnia 2011 13:15 u=BFytkownik Arnd Bergmann <arnd@arndb.de=
> napisa=B3:
> On Thursday 21 April 2011, Micha=B3 Miros=B3aw wrote:
>> Subject: Re: [PATCH v4] mmc: Add ioctl to let userspace apps send AC=
MDs
>> Date: Wed, 13 Apr 2011 01:00:39 +0200
>> Message-Id: <201104130100.39810.arnd@arndb.de>
>>
>> Then I already provided an example of implementation that's
>> independent of endianness and avoids casts on userspace.
>
> Yes, v4 got that aspect right, as far as I can tell, aside
> from an incorrect cast (u8* instead of u8 __user *).

Just to have an understanding about the issue. In the mail I pointed
to, you argued that union will not work because of endianness
problems. I haven't seen other arguments against the union approach,
and I have provided a solution for this case.

BTW, kernel side can also avoid the cast if the union is extended with
32-bit field. This works because an address of a union is an address
of each of its fields. IOW all fields start at the same address
regardless if the they are 32 or 64 bits in size.

struct mmc_ioc_cmd {
  union {
    __u64 __data_ptr_storage64;
    __u32 __data_ptr_storage32;
    void __user *data_ptr;
  };
  ...
};

[...]

static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t mode=
,
    unsigned int cmd, unsigned long arg)
{
  struct mmc_ioc_cmd blk;

  if (cmd !=3D MMC_IOC_CMD)
    return -EINVAL;

  copy_from_user(compat_ptr(arg), &blk) ...
  blk.data_ptr =3D compat_ptr(blk.__data_ptr_storage32);

  return mmc_blk_ioctl_cmd(bdev, &blk);
}

Best Regards,
Micha=B3 Miros=B3aw
