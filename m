From: Scott Wood <oss@buserror.net>
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Wed, 20 Jul 2016 13:31:48 -0500
Message-ID: <1469039508.25630.17.camel@buserror.net>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
	 <1468723822-30457-5-git-send-email-oss@buserror.net>
	 <4016699.uYaV8nWfqC@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4016699.uYaV8nWfqC@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@lists.ozlabs.org, Yangbo Lu <yangbo.lu@nxp.com>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> >=20
> > From: yangbo lu <yangbo.lu@nxp.com>
> >=20
> > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a com=
mon
> > header file.=C2=A0=C2=A0This SVR numberspace is used on some ARM ch=
ips as well as
> > PPC, and even to check for a PPC SVR multi-arch drivers would other=
wise
> > need to ifdef the header inclusion and all references to the SVR sy=
mbols.
> >=20
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > Acked-by: Joerg Roedel <jroedel@suse.de>
> > [scottwood: update description]
> > Signed-off-by: Scott Wood <oss@buserror.net>
> >=20
> As discussed before, please don't introduce yet another vendor specif=
ic
> way to match a SoC ID from a device driver.
>=20
> I've posted a patch for an extension to the soc_device infrastructure
> to allow comparing the running SoC to a table of devices, use that
> instead.

As I asked before, in which relevant maintainership capacity are you NA=
CKing
this?

-Scott
