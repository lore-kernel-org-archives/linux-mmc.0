From: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 20:23:18 +0200
Message-ID: <BANLkTi=Ni+GZN3Ah4k-pMheZR7PTrwQDYg@mail.gmail.com>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <alpine.DEB.2.00.1104131737280.15392@peruna>
 <BANLkTim4VUmQmWEVJahhw4yfXiSmXi+K0g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qy0-f181.google.com ([209.85.216.181]:37328 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916Ab1DTSXj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 14:23:39 -0400
Received: by qyg14 with SMTP id 14so576039qyg.19
        for <linux-mmc@vger.kernel.org>; Wed, 20 Apr 2011 11:23:38 -0700 (PDT)
In-Reply-To: <BANLkTim4VUmQmWEVJahhw4yfXiSmXi+K0g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: John Calixto <john.calixto@modsystems.com>
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

W dniu 20 kwietnia 2011 19:31 u=BFytkownik Micha=B3 Miros=B3aw
<mirqus@gmail.com> napisa=B3:
> 2011/4/14 John Calixto <john.calixto@modsystems.com>:
> [...]
>
>> + =A0 =A0 =A0 /* DAT buffer */
>> + =A0 =A0 =A0 __u32 data_ptr_size; =A0/* size of the *pointer* */
>> + =A0 =A0 =A0 __u64 data_ptr;
>
> So... again... What's the problem with anonymous union of pointer and=
 u64?
>
> Example implementation:
>
> struct mmc_ioc_cmd {
> =A0...
> =A0union {
> =A0 =A0void __user *data_ptr;
> =A0 =A0__u64 __data_ptr_storage;
> =A0};
> };
>

Hmm. This might be even better:

static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
unsigned int cmd, unsigned long arg)
{
 =A0struct mmc_ioc_cmd blk;

 =A0if (cmd !=3D MMC_IOC_CMD)
 =A0 =A0return -EINVAL;

 =A0copy_from_user((void __user *)arg, &blk) ...

#ifdef CONFIG_COMPAT
  if (is_compat_task())
    blk.data_ptr =3D compat_ptr(*(u32 *)&blk.data_ptr);
#endif

 =A0return mmc_blk_ioctl_cmd(bdev, &blk);
}

[no compat_ioctl needed]

Best Regards,
Micha=B3 Miros=B3aw
