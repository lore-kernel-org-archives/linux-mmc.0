From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Thu, 21 Jul 2016 20:26:06 +1000
Message-ID: <146909676646.16700.8383344640490662952@concordia>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
 <1468723822-30457-5-git-send-email-oss@buserror.net>
 <4016699.uYaV8nWfqC@wuerfel> <1469039508.25630.17.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from ozlabs.org ([103.22.144.67]:55712 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751588AbcGUK0J convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 21 Jul 2016 06:26:09 -0400
In-Reply-To: <1469039508.25630.17.camel@buserror.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Scott Wood <oss@buserror.net>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mmc@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>

Quoting Scott Wood (2016-07-21 04:31:48)
> On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> > On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> > >=20
> > > From: yangbo lu <yangbo.lu@nxp.com>
> > >=20
> > > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a c=
ommon
> > > header file.=C2=A0=C2=A0This SVR numberspace is used on some ARM =
chips as well as
> > > PPC, and even to check for a PPC SVR multi-arch drivers would oth=
erwise
> > > need to ifdef the header inclusion and all references to the SVR =
symbols.
> > >=20
> > > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > > Acked-by: Wolfram Sang <wsa@the-dreams.de>
> > > Acked-by: Stephen Boyd <sboyd@codeaurora.org>
> > > Acked-by: Joerg Roedel <jroedel@suse.de>
> > > [scottwood: update description]
> > > Signed-off-by: Scott Wood <oss@buserror.net>
> > >=20
> > As discussed before, please don't introduce yet another vendor spec=
ific
> > way to match a SoC ID from a device driver.
> >=20
> > I've posted a patch for an extension to the soc_device infrastructu=
re
> > to allow comparing the running SoC to a table of devices, use that
> > instead.
>=20
> As I asked before, in which relevant maintainership capacity are you =
NACKing
> this?

I'll nack the powerpc part until you guys can agree.

cheers
