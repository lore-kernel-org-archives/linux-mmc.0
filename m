From: John Calixto <john.calixto@modsystems.com>
Subject: Re: [PATCH v3] mmc: Add ioctl to let userspace apps send ACMDs
Date: Mon, 11 Apr 2011 16:32:42 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1104111626060.32082@peruna>
References: <alpine.DEB.2.00.1104071816270.10238@peruna> <m3ipuka3dm.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811328-1126771776-1302564769=:32082"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from elasmtp-banded.atl.sa.earthlink.net ([209.86.89.70]:40249 "EHLO
	elasmtp-banded.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753424Ab1DKXcu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 11 Apr 2011 19:32:50 -0400
In-Reply-To: <m3ipuka3dm.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811328-1126771776-1302564769=:32082
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 11 Apr 2011, Chris Ball wrote:
> This adds two gcc warnings here (compiling for ARM):
>=20
>   CC      drivers/mmc/card/block.o
> drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_ioctl_copy_from_us=
er=E2=80=99:
> drivers/mmc/card/block.c:199:33: warning: cast to pointer from integer of=
 different size [-Wint-to-pointer-cast]
> drivers/mmc/card/block.c: In function =E2=80=98mmc_blk_ioctl_acmd=E2=80=
=99:
> drivers/mmc/card/block.c:308:20: warning: cast to pointer from integer of=
 different size [-Wint-to-pointer-cast]
>=20
> ...
> > +=09if (copy_from_user(idata->buf, (u8 *) user->data_ptr, idata->buf_by=
tes)) {
> > +=09=09err =3D -EFAULT;
> > +=09=09goto copy_err;
> > +=09}
> ...
> > +=09=09if (copy_to_user((u8 *) ic_ptr->data_ptr, idata->buf, idata->buf=
_bytes)) {
> > +=09=09=09err =3D -EFAULT;
> > +=09=09=09goto acmd_rel_host;
> > +=09=09}
> ...
>=20

Hrmmm...  So, what's the correct way to do this compat_ioctl() stuff?
My first attempt at a compat_ioctl() implementation in v2 used a 32bit
version of the structure to marshall the data.  That was shot down as
being unnecessarily complicated since the buffer pointer was the only
thing that was not compat friendly.  It was recommended that I could
just make this a 64bit int field and let the callers do the appropriate
casting.  However, this latter solution (implemented in v3) causes the
compiler warning that you describe above.

Should I revert to the v2 implementation?

John
---1463811328-1126771776-1302564769=:32082--
