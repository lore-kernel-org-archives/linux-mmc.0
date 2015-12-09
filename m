From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon support for DCFG node
Date: Wed, 9 Dec 2015 11:00:19 -0600
Message-ID: <1449680419.15946.176.camel@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	 <1448594417-22515-5-git-send-email-yangbo.lu@freescale.com>
	 <1449596781.15946.126.camel@freescale.com>
	 <BLUPR0301MB2065B5878A43F66982D6B30BF2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
	 <1449635607.15946.165.camel@freescale.com>
	 <BLUPR0301MB206558CB317D48AC5CEF3642F2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-by2on0110.outbound.protection.outlook.com ([207.46.100.110]:12599
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752315AbbLIRAi (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Dec 2015 12:00:38 -0500
In-Reply-To: <BLUPR0301MB206558CB317D48AC5CEF3642F2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: Xie Xiaobo-R63061 <X.Xie@freescale.com>, Li Yang-Leo-R58472 <LeoLi@freescale.com>

On Wed, 2015-12-09 at 03:05 -0600, Lu Yangbo-B47093 wrote:
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Wednesday, December 09, 2015 12:33 PM
> > To: Lu Yangbo-B47093; linux-mmc@vger.kernel.org; ulf.hansson@linaro=
=2Eorg
> > Cc: Xie Xiaobo-R63061; Li Yang-Leo-R58472
> > Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon support for =
DCFG
> > node
> >=20
> > On Tue, 2015-12-08 at 22:30 -0600, Lu Yangbo-B47093 wrote:
> > > > -----Original Message-----
> > > > From: Wood Scott-B07421
> > > > Sent: Wednesday, December 09, 2015 1:46 AM
> > > > To: Lu Yangbo-B47093; linux-mmc@vger.kernel.org;
> > > > ulf.hansson@linaro.org
> > > > Cc: Xie Xiaobo-R63061; Li Yang-Leo-R58472
> > > > Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon support =
for
> > > > DCFG node
> > > >=20
> > > > On Fri, 2015-11-27 at 11:20 +0800, Yangbo Lu wrote:
> > > > > Add syscon support for DCFG node, so that the driver could us=
e
> > > > > syscon regmap interface to access the device config module
> > registers.
> > > > > And the CONFIG_MFD_SYSCON should be enabled for this.
> > > > >=20
> > > > > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > > > > ---
> > > > > Changes for v2:
> > > > > 	- None
> > > > > Changes for v3:
> > > > > 	- Added this patch
> > > > > ---
> > > > >  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >=20
> > > > > diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > > > > b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > > > > index 68c4ead..5f148b2 100644
> > > > > --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > > > > +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > > > > @@ -941,7 +941,9 @@
> > > > >  /include/ "qoriq-mpic4.3.dtsi"
> > > > >=20
> > > > >  	guts: global-utilities@e0000 {
> > > > > -		compatible =3D "fsl,t4240-device-config", "fsl,qoriq
> > > > > -device
> > > > > -config-2.0";
> > > > > +		compatible =3D "fsl,t4240-device-config",
> > > > > +				"fsl,qoriq-device-config-2.0",
> > > > > +				"syscon";
> > > >=20
> > > >=20
> > > > I really don't like changing the device tree based on Linux int=
ernals.
> > > > It also means that the workaround wouldn't work for users that =
don't
> > > > upgrade their device tree.  I definitely don't like one QorIQ c=
hip
> > > > having "syscon" on the dcfg node but others not having it.
> > > >=20
> > > > The guts driver should just maintain a list of compatibles to m=
atch.
> > > > Why do we need to use syscon, rather than a guts driver that ex=
ports
> > > > an
> > > > fsl_get_svr() function?
> > > >=20
> > > > -Scott
> > >=20
> > > [Lu Yangbo-B47093] I think the only difference between fsl_get_sv=
r()
> > > and syscon is that we don=E2=80=99t need to change dts with fsl_g=
et_svr(),
> > right?
> >=20
> > That is one difference.  It also would simplify callers, and avoid =
the
> > need to depend on the overcomplicated and difficult-to-follow regma=
p code
> > in order to accomplish something very simple.
> >=20
> > > The syscon has considered the endianess, and we don=E2=80=99t nee=
d to add more
> > > code to use it and only add 'syscon' in the node.
> >=20
> > Dealing with the endianess in a common guts driver would be trivial=
=2E
> >=20
> > > This patchset only enables syscon in T4240 DFCG node since it has=
 an
> > > erratum to use it.
> >=20
> > The device tree describes the hardware, not what you want to use it=
 for.
> > The existence of an erratum in the esdhc block says nothing about w=
hat
> > the dcfg node is.
> >=20
> > > The fsl_get_svr() you suggested is also an idea for this.
> > > Then, may I know is there a guts driver in kernel?
> > > Thanks a lot.
> >=20
> > There isn't, but there should be.
> >=20
> > -Scott
>=20
> [Lu Yangbo-B47093] Ok, I'd like to try. But can you suggest where we =
should
> put the guts driver in kernel?
> Thanks.

drivers/soc/fsl/

-Scott

