From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v6] mmc: Add mmc CMD+ACMD passthrough ioctl
Date: Wed, 20 Apr 2011 12:06:49 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104201131080.28361@peruna>
References: <alpine.DEB.2.00.1104131713570.15392@peruna> <alpine.DEB.2.00.1104131737280.15392@peruna> <BANLkTim4VUmQmWEVJahhw4yfXiSmXi+K0g@mail.gmail.com> <BANLkTi=Ni+GZN3Ah4k-pMheZR7PTrwQDYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-91465326-1303326416=:28361"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-mealy.atl.sa.earthlink.net ([209.86.89.69]:37781 "EHLO
	elasmtp-mealy.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752737Ab1DTTG7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 20 Apr 2011 15:06:59 -0400
In-Reply-To: <BANLkTi=Ni+GZN3Ah4k-pMheZR7PTrwQDYg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, Andrei Warkentin <andreiw@motorola.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-91465326-1303326416=:28361
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Micha=B3,

On Wed, 20 Apr 2011, Micha=B3 Miros=B3aw wrote:
> Hmm. This might be even better:
>=20
> static int mmc_blk_ioctl(struct block_device *bdev, fmode_t mode,
> unsigned int cmd, unsigned long arg)
> {
>  =A0struct mmc_ioc_cmd blk;
>=20
>  =A0if (cmd !=3D MMC_IOC_CMD)
>  =A0 =A0return -EINVAL;
>=20
>  =A0copy_from_user((void __user *)arg, &blk) ...
>=20
> #ifdef CONFIG_COMPAT
>   if (is_compat_task())
>     blk.data_ptr =3D compat_ptr(*(u32 *)&blk.data_ptr);
> #endif
>=20
>  =A0return mmc_blk_ioctl_cmd(bdev, &blk);
> }
>=20
> [no compat_ioctl needed]
>=20

I'm okay with the anon union + ``compat_ptr(*(u32 *))`` part of your
solution.  If everyone else thinks it is reasonable, I'll submit a v7
with it.

However, I still think it should be implemented in compat_ioctl()
because compat_blkdev_ioctl() expects it.  Either that, or I add to the
big switch in compat_blkdev_driver_ioctl(), and spreading this change
out to block/compat_ioctl.c does not seem like The Right Thing to me.

John
---1463811328-91465326-1303326416=:28361--
