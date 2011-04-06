From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v2 1/2] mmc: Add ioctl to let userspace apps send ACMDs
Date: Wed, 6 Apr 2011 10:37:24 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104061021350.391@peruna>
References: <alpine.DEB.2.00.1104051450480.25803@peruna> <BANLkTinsYioaa69ZdFpBAr-BK6RDh8V83g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-62886019-1302111451=:391"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:48550 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755732Ab1DFRhf (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Apr 2011 13:37:35 -0400
In-Reply-To: <BANLkTinsYioaa69ZdFpBAr-BK6RDh8V83g@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: =?ISO-8859-2?Q?Micha=B3_Miros=B3aw?= <mirqus@gmail.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Arnd Bergmann <arnd@arndb.de>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-62886019-1302111451=:391
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 6 Apr 2011, Micha=C5=82 Miros=C5=82aw wrote:
> 2011/4/5 John Calixto <john.calixto@modsystems.com>:
> > + =C2=A0 =C2=A0 =C2=A0 /*
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* Only allow ACMDs on the whole block devi=
ce, not on partitions. =C2=A0This
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0* prevents overspray between sibling parti=
tions.
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0*/
> > + =C2=A0 =C2=A0 =C2=A0 if (bdev !=3D bdev->bd_contains)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EPERM;
>=20
> This should at least also check CAP_SYS_ADMIN capability.
>=20

Yep.  I broke out the capability check into a separate patch - I'll
reply to your permissions-related comments on that thread.

> > +
> > + =C2=A0 =C2=A0 =C2=A0 md =3D mmc_blk_get(bdev->bd_disk);
> > + =C2=A0 =C2=A0 =C2=A0 if (!md)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 card =3D md->queue.card;
> > + =C2=A0 =C2=A0 =C2=A0 if (IS_ERR(card))
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return PTR_ERR(card)=
;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 host =3D card->host;
> > + =C2=A0 =C2=A0 =C2=A0 mmc_claim_host(host);
> > +
> > + =C2=A0 =C2=A0 =C2=A0 err =3D mmc_app_cmd(host, card);
> > + =C2=A0 =C2=A0 =C2=A0 if (err)
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 mrq.cmd =3D &cmd;
> > + =C2=A0 =C2=A0 =C2=A0 mrq.data =3D &data;
> > +
> > + =C2=A0 =C2=A0 =C2=A0 if (copy_from_user(&sdic, sdic_ptr, sizeof(sdic)=
)) {
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 err =3D -EFAULT;
> > + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto acmd_done;
> > + =C2=A0 =C2=A0 =C2=A0 }
>=20
> You should first copy and verify ioctl's data and only then claim host
> and send commands. Preferably the check-and-copy should be separate
> function.
>=20

Will do.

> > +
> > +#ifdef CONFIG_COMPAT
> > +struct sd_ioc_cmd32 {
> > + =C2=A0 =C2=A0 =C2=A0 u32 write_flag;
> > + =C2=A0 =C2=A0 =C2=A0 u32 opcode;
> > + =C2=A0 =C2=A0 =C2=A0 u32 arg;
> > + =C2=A0 =C2=A0 =C2=A0 u32 response[4];
> > + =C2=A0 =C2=A0 =C2=A0 u32 flags;
> > + =C2=A0 =C2=A0 =C2=A0 u32 blksz;
> > + =C2=A0 =C2=A0 =C2=A0 u32 blocks;
> > + =C2=A0 =C2=A0 =C2=A0 u32 postsleep_us;
> > + =C2=A0 =C2=A0 =C2=A0 u32 force_timeout_ns;
> > + =C2=A0 =C2=A0 =C2=A0 compat_uptr_t data_ptr;
> > +};
> > +#define SD_IOC_ACMD32 _IOWR(MMC_BLOCK_MAJOR, 0, struct sd_ioc_cmd32)
> [...]
>=20
> Since your implementing a new ioctl you can make the structure the
> same for 64 and 32-bit archs and avoid all this compat crap.
>=20

I was also less than pleased with this, but I chose to implement the
compat crap because it allow a "natural" userspace API for both the
kernel32+user32 and kernel64+user64 environments.  The ugliness in the
kernel is just when you have defined CONFIG_COMPAT.  I think 32-bit-only
is still an important target for this functionality (think set-top media
players, mobile devices; basically, anything running on ARM) so always
having to cast your data pointer to 64-bit is not appealing.  I suspect
it will be very unlikely to see people using this in the kernel64+user32
environment.

Cheers,

John
---1463811328-62886019-1302111451=:391--
