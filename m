From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
Date: Sun, 12 Dec 2010 13:52:24 +0000
Message-ID: <20101212135224.GA31812@void.printf.net>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com> <20101208115510.GD10998@console-pimps.org> <AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com> <AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com> <20101209064751.GA21128@void.printf.net> <AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com> <20101209160157.GA28586@void.printf.net> <AANLkTim3Rj2tTbqvT8nM4L=p=Wx8bdOnGq=EDv+cs02g@mail.gmail.com> <20101211192320.GA24430@void.printf.net> <AANLkTin5aVPz5Y=jS89V00XS=rje3gqeUb2VTYt2A_9=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:35250 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736Ab0LLNw0 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 12 Dec 2010 08:52:26 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTin5aVPz5Y=jS89V00XS=rje3gqeUb2VTYt2A_9=@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Will Newton <will.newton@gmail.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>, linux-arm-kernel@lists.infradead.org

Hi Will,

On Sun, Dec 12, 2010 at 10:57:44AM +0000, Will Newton wrote:
> > drivers/mmc/host/dw_mmc.c: In function =E2=80=98dw_mci_pull_data64=E2=
=80=99:
> > drivers/mmc/host/dw_mmc.c:998: error: implicit declaration of funct=
ion =E2=80=98__raw_readq=E2=80=99
> >
> > because arch/arm doesn't implement raw versions of these 64-bit acc=
esses.
> > I'm surprised that this driver hasn't been compiled on ARM before! =
=C2=A0What
>=20
> That particular bit of code has been added since it was last built fo=
r
> arm. Our architecture can do 64bit accesses so we implement readq.
> Unfortunately there doesn't seem to be a sane way to conditionalize
> code for architectures that have or don't have readq, so I suspect
> I'll have to just remove that branch of the if statement for now.

(Russell, thanks for the excellent explanation.)

Other drivers (MTD, gpio/basic_mmio_gpio.c, fs/fuse, pcm_oss.c)
conditionalize uses of {read,write}q on BITS_PER_LONG >=3D 64, so
something like this:

diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
index 7de6b42..526b5cb 100644
--- a/drivers/mmc/host/dw_mmc.c
+++ b/drivers/mmc/host/dw_mmc.c
@@ -988,10 +988,11 @@ static void dw_mci_pull_data32(struct dw_mci *hos=
t, void *buf, int cnt)
 		*pData++ =3D mci_readl(host, DATA);
 		cnt--;
 	}
 }
=20
+#if BITS_PER_LONG >=3D 64
 static void dw_mci_push_data64(struct dw_mci *host, void *buf, int cnt=
)
 {
 	u64 *pData =3D (u64 *)buf;
=20
 	WARN_ON(cnt % 8 !=3D 0);
@@ -1013,10 +1014,11 @@ static void dw_mci_pull_data64(struct dw_mci *h=
ost, void *buf, int cnt)
 	while (cnt > 0) {
 		*pData++ =3D mci_readq(host, DATA);
 		cnt--;
 	}
 }
+#endif
=20
 static void dw_mci_read_data_pio(struct dw_mci *host)
 {
 	struct scatterlist *sg =3D host->sg;
 	void *buf =3D sg_virt(sg);
@@ -1591,15 +1593,17 @@ static int dw_mci_probe(struct platform_device =
*pdev)
 	if (!i) {
 		host->push_data =3D dw_mci_push_data16;
 		host->pull_data =3D dw_mci_pull_data16;
 		width =3D 16;
 		host->data_shift =3D 1;
+#if BITS_PER_LONG >=3D 64
 	} else if (i =3D=3D 2) {
 		host->push_data =3D dw_mci_push_data64;
 		host->pull_data =3D dw_mci_pull_data64;
 		width =3D 64;
 		host->data_shift =3D 3;
+#endif
 	} else {
 		/* Check for a reserved value, and warn if it is */
 		WARN((i !=3D 1),
 			"HCON reports a reserved host data width!\n"
 			"Defaulting to 32-bit access.\n");


This is only useful if you just want the driver to compile (it compiles
on ARM after the above) and don't expect a working device if you find
the HCON programmed with 64-bit width on an ARM board, though.

Thanks,

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
