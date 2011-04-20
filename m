From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 19:31:20 +0200
Message-ID: <BANLkTim4VUmQmWEVJahhw4yfXiSmXi+K0g@mail.gmail.com>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <alpine.DEB.2.00.1104131737280.15392@peruna>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:39727 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751366Ab1DTRbl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 13:31:41 -0400
Received: by qyg14 with SMTP id 14so549956qyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 10:31:40 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1104131737280.15392@peruna>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

2011/4/14 John Calixto <john.calixto@modsystems.com>:
[...]

> + =C2=A0 =C2=A0 =C2=A0 /* DAT buffer */
> + =C2=A0 =C2=A0 =C2=A0 __u32 data_ptr_size; =C2=A0/* size of the *poi=
nter* */
> + =C2=A0 =C2=A0 =C2=A0 __u64 data_ptr;

So... again... What's the problem with anonymous union of pointer and u=
64?

Example implementation:

struct mmc_ioc_cmd {
  ...
  union {
    void __user *data_ptr;
    __u64 __data_ptr_storage;
  };
};

static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
unsigned int cmd, unsigned long arg)
{
  struct mmc_ioc_cmd blk;

  if (cmd !=3D MMC_IOC_CMD)
    return -EINVAL;

  copy_from_user((void __user *)arg, &blk) ...

  return mmc_blk_ioctl_cmd(bdev, &blk);
}

static int mmc_blk_compat_ioctl(struct block_device *bdev, fmode_t
mode, unsigned int cmd, unsigned long arg)
{
  struct mmc_ioc_cmd blk;

  if (cmd !=3D MMC_IOC_CMD)
    return -EINVAL;

  copy_from_user(compat_ptr(arg), &blk) ...
  blk.data_ptr =3D compat_ptr(*(__u32 *)&blk.data_ptr);

  return mmc_blk_ioctl_cmd(bdev, &blk);
}

Best Regards,
Micha=C5=82 Miros=C5=82aw
