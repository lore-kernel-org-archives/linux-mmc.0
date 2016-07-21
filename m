From: Scott Wood <oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>
Subject: Re: [PATCH v11 4/5] powerpc/fsl: move mpc85xx.h to include/linux/fsl
Date: Thu, 21 Jul 2016 11:45:26 -0500
Message-ID: <1469119526.25630.42.camel@buserror.net>
References: <1468723822-30457-1-git-send-email-oss@buserror.net>
	 <1468723822-30457-5-git-send-email-oss@buserror.net>
	 <4016699.uYaV8nWfqC@wuerfel> <1469039508.25630.17.camel@buserror.net>
	 <146909676646.16700.8383344640490662952@concordia>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <146909676646.16700.8383344640490662952@concordia>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 2016-07-21 at 20:26 +1000, Michael Ellerman wrote:
> Quoting Scott Wood (2016-07-21 04:31:48)
> >=20
> > On Wed, 2016-07-20 at 13:24 +0200, Arnd Bergmann wrote:
> > >=20
> > > On Saturday, July 16, 2016 9:50:21 PM CEST Scott Wood wrote:
> > > >=20
> > > >=20
> > > > From: yangbo lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
> > > >=20
> > > > Move mpc85xx.h to include/linux/fsl and rename it to svr.h as a=
 common
> > > > header file.=C2=A0=C2=A0This SVR numberspace is used on some AR=
M chips as well
> > > > as
> > > > PPC, and even to check for a PPC SVR multi-arch drivers would
> > > > otherwise
> > > > need to ifdef the header inclusion and all references to the SV=
R
> > > > symbols.
> > > >=20
> > > > Signed-off-by: Yangbo Lu <yangbo.lu-3arQi8VN3Tc@public.gmane.org>
> > > > Acked-by: Wolfram Sang <wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org>
> > > > Acked-by: Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
> > > > Acked-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > > > [scottwood: update description]
> > > > Signed-off-by: Scott Wood <oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>
> > > >=20
> > > As discussed before, please don't introduce yet another vendor sp=
ecific
> > > way to match a SoC ID from a device driver.
> > >=20
> > > I've posted a patch for an extension to the soc_device infrastruc=
ture
> > > to allow comparing the running SoC to a table of devices, use tha=
t
> > > instead.
> > As I asked before, in which relevant maintainership capacity are yo=
u
> > NACKing
> > this?
> I'll nack the powerpc part until you guys can agree.

OK, I've pulled these patches out.

=46or the MMC issue I suggest using ifdef CONFIG_PPC and mfspr(SPRN_SVR=
) like
the clock driver does[1] and we can revisit the issue if/when we need t=
o do
something similar on an ARM chip.

-Scott

[1] One of the issues with Arnd's approach is that it wouldn't have wor=
ked for
early things like the clock driver, and he didn't seem to mind using if=
def and
mfspr() there.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
