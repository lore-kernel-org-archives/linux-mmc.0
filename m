From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH] sdhci: sdhci-pxa only supports mmp2 at this time.
	Change Kconfig
Date: Tue, 23 Nov 2010 02:55:48 +0000
Message-ID: <20101123025548.GA29770@void.printf.net>
References: <3E707E23-91F2-4BA1-A74B-C8EE2E8EAF31@marvell.com> <AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36860 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751016Ab0KWCzt (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 22 Nov 2010 21:55:49 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTimMFsxHt3AEfHDgZsia3c+rYVx2P5Diw=Robrbe@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Mark F. Brown" <mark.brown314@gmail.com>
Cc: zhangfei.gao@gmail.com, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Philip Rakity <prakity@marvell.com>, markb@marvell.com, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

Hi,

On Mon, Nov 22, 2010 at 09:46:14PM -0500, Mark F. Brown wrote:
> > =A0config MMC_SDHCI_PXA
> > =A0 =A0 =A0 =A0tristate "Marvell PXA168/PXA910/MMP2 SD Host Control=
ler support"
> > - =A0 =A0 =A0 depends on ARCH_PXA || ARCH_MMP
> > + =A0 =A0 =A0 depends on (ARCH_PXA || ARCH_MMP) && (MACH_MARVELL_JA=
SPER || MACH_FLINT)
> > =A0 =A0 =A0 =A0select MMC_SDHCI
> > =A0 =A0 =A0 =A0select MMC_SDHCI_IO_ACCESSORS
> > =A0 =A0 =A0 =A0help
> > - =A0 =A0 =A0 =A0 This selects the Marvell(R) PXA168/PXA910/MMP2 SD=
 Host Controller.
> > - =A0 =A0 =A0 =A0 If you have a PXA168/PXA910/MMP2 platform with SD=
 Host Controller
> > + =A0 =A0 =A0 =A0 This selects the Marvell(R) MMP2 SD Host Controll=
er.
> > + =A0 =A0 =A0 =A0 If you have a MMP2 platform with SD Host Controll=
er
> > =A0 =A0 =A0 =A0 =A0and a card slot, say Y or M here.
>=20
> Currently the driver sdhci-pxa only supports the 88AP610 (MMP2)
> platform only. Until the sdhci-pxa code fixed or forked to support
> pxa168 and pxa910 we need to Philip's patch. Any feedback on this
> would be good thanks.

I don't mind changing the Kconfig text, but tying an SoC-level host
controller to dependencies on specific machines seems pretty wrong.
We should ask Haojian and Eric what they think.  I think Philip
suggested using CPU_MMP2 at one point -- how about that?

--=20
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
