From: Scott Wood <scottwood@freescale.com>
Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon support for DCFG node
Date: Wed, 9 Dec 2015 11:01:42 -0600
Message-ID: <1449680502.15946.178.camel@freescale.com>
References: <1448594417-22515-1-git-send-email-yangbo.lu@freescale.com>
	 <1448594417-22515-5-git-send-email-yangbo.lu@freescale.com>
	 <1449596781.15946.126.camel@freescale.com>
	 <BLUPR0301MB2065B5878A43F66982D6B30BF2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
	 <1449635607.15946.165.camel@freescale.com>
	  <BLUPR0301MB2065A179DCAF428EB79785B7F2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bl2on0120.outbound.protection.outlook.com ([65.55.169.120]:5536
	"EHLO na01-bl2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752288AbbLIRBv (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 9 Dec 2015 12:01:51 -0500
In-Reply-To: <BLUPR0301MB2065A179DCAF428EB79785B7F2E80@BLUPR0301MB2065.namprd03.prod.outlook.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lu Yangbo-B47093 <yangbo.lu@freescale.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
Cc: Xie Xiaobo-R63061 <X.Xie@freescale.com>, Li Yang-Leo-R58472 <LeoLi@freescale.com>

On Wed, 2015-12-09 at 03:29 -0600, Lu Yangbo-B47093 wrote:
> > -----Original Message-----
> > From: Lu Yangbo-B47093
> > Sent: Wednesday, December 09, 2015 5:05 PM
> > To: Wood Scott-B07421; linux-mmc@vger.kernel.org; ulf.hansson@linar=
o.org
> > Cc: Xie Xiaobo-R63061; Li Yang-Leo-R58472
> > Subject: RE: [v3, 4/5] powerpc: dts: t4240: add syscon support for =
DCFG
> > node
> >=20
> > > -----Original Message-----
> > > From: Wood Scott-B07421
> > > Sent: Wednesday, December 09, 2015 12:33 PM
> > > To: Lu Yangbo-B47093; linux-mmc@vger.kernel.org;
> > > ulf.hansson@linaro.org
> > > Cc: Xie Xiaobo-R63061; Li Yang-Leo-R58472
> > > Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon support fo=
r
> > > DCFG node
> > >=20
> > > On Tue, 2015-12-08 at 22:30 -0600, Lu Yangbo-B47093 wrote:
> > > > > -----Original Message-----
> > > > > From: Wood Scott-B07421
> > > > > Sent: Wednesday, December 09, 2015 1:46 AM
> > > > > To: Lu Yangbo-B47093; linux-mmc@vger.kernel.org;
> > > > > ulf.hansson@linaro.org
> > > > > Cc: Xie Xiaobo-R63061; Li Yang-Leo-R58472
> > > > > Subject: Re: [v3, 4/5] powerpc: dts: t4240: add syscon suppor=
t for
> > > > > DCFG node
> > > > >=20
> > > > > On Fri, 2015-11-27 at 11:20 +0800, Yangbo Lu wrote:
> > > > > > Add syscon support for DCFG node, so that the driver could =
use
> > > > > > syscon regmap interface to access the device config module
> > > registers.
> > > > > > And the CONFIG_MFD_SYSCON should be enabled for this.
> > > > > >=20
> > > > > > Signed-off-by: Yangbo Lu <yangbo.lu@freescale.com>
> > > > > > ---
> > > > > > Changes for v2:
> > > > > > 	- None
> > > > > > Changes for v3:
> > > > > > 	- Added this patch
> > > > > > ---
> > > > > >  arch/powerpc/boot/dts/fsl/t4240si-post.dtsi | 4 +++-
> > > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > > >=20
> > > > > > diff --git a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > > > > > b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > > > > > index 68c4ead..5f148b2 100644
> > > > > > --- a/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > > > > > +++ b/arch/powerpc/boot/dts/fsl/t4240si-post.dtsi
> > > > > > @@ -941,7 +941,9 @@
> > > > > >  /include/ "qoriq-mpic4.3.dtsi"
> > > > > >=20
> > > > > >  	guts: global-utilities@e0000 {
> > > > > > -		compatible =3D "fsl,t4240-device-config",
> > > > > > "fsl,qoriq
> > > > > > -device
> > > > > > -config-2.0";
> > > > > > +		compatible =3D "fsl,t4240-device-config",
> > > > > > +				"fsl,qoriq-device-config-2.0",
> > > > > > +				"syscon";
> > > > >=20
> > > > >=20
> > > > > I really don't like changing the device tree based on Linux
> > internals.
> > > > > It also means that the workaround wouldn't work for users tha=
t
> > > > > don't upgrade their device tree.  I definitely don't like one
> > > > > QorIQ chip having "syscon" on the dcfg node but others not ha=
ving
> > it.
> > > > >=20
> > > > > The guts driver should just maintain a list of compatibles to=
 match.
> > > > > Why do we need to use syscon, rather than a guts driver that
> > > > > exports an
> > > > > fsl_get_svr() function?
> > > > >=20
> > > > > -Scott
> > > >=20
> > > > [Lu Yangbo-B47093] I think the only difference between fsl_get_=
svr()
> > > > and syscon is that we don=E2=80=99t need to change dts with fsl=
_get_svr(),
> > > right?
> > >=20
> > > That is one difference.  It also would simplify callers, and avoi=
d the
> > > need to depend on the overcomplicated and difficult-to-follow reg=
map
> > > code in order to accomplish something very simple.
> > >=20
> > > > The syscon has considered the endianess, and we don=E2=80=99t n=
eed to add
> > > > more code to use it and only add 'syscon' in the node.
> > >=20
> > > Dealing with the endianess in a common guts driver would be trivi=
al.
> > >=20
> > > > This patchset only enables syscon in T4240 DFCG node since it h=
as an
> > > > erratum to use it.
> > >=20
> > > The device tree describes the hardware, not what you want to use =
it for.
> > > The existence of an erratum in the esdhc block says nothing about=
 what
> > > the dcfg node is.
> > >=20
> > > > The fsl_get_svr() you suggested is also an idea for this.
> > > > Then, may I know is there a guts driver in kernel?
> > > > Thanks a lot.
> > >=20
> > > There isn't, but there should be.
> > >=20
> > > -Scott
> >=20
> > [Lu Yangbo-B47093] Ok, I'd like to try. But can you suggest where w=
e
> > should put the guts driver in kernel?
> > Thanks.
> >=20
> [Lu Yangbo-B47093] Actually, most platforms would need to be added 's=
yscon'
> compatible in DFCG node later if we use SYSCON in eSDHC.
> Because most of eSDHC errata only could be identified by SVR.
> But for this patchset, for this T4240 eSDHC erratum, I only add 'sysc=
on' for
> T4240.
>=20
> What about adding 'syscon' in all platforms although there is some wo=
rkload?

Please just add a guts driver.

-Scott

