From: Jain Priyanka-B32167 <B32167@freescale.com>
Subject: Latency Issue due to patch; ESDHC: Workaround for data crc error on
 p1010rdb
Date: Wed, 28 Mar 2012 11:15:29 +0000
Message-ID: <AC83832D6324604BB08FAE5A33553F190BD85D@039-SN2MPN1-011.039d.mgd.msft.net>
References: <1328688356-17510-1-git-send-email-r66093@freescale.com>
	<m21uq52wk8.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C01F304@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2mx8pkqxy.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C021A89@039-SN1MPN1-002.039d.mgd.msft.net>
	<m2ty2vjr11.fsf@bob.laptop.org> <m2pqdjjqo2.fsf@bob.laptop.org>
	<110EED8CC96DFC488B7E717A2027A27C021CB2@039-SN1MPN1-002.039d.mgd.msft.net>
 <m2d39ijwez.fsf@bob.laptop.org>
 <110EED8CC96DFC488B7E717A2027A27C022DF3@039-SN1MPN1-002.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe003.messaging.microsoft.com ([216.32.180.13]:7326 "EHLO
	va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758122Ab2C1LPg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Mar 2012 07:15:36 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>, Chris Ball <cjb@laptop.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi,

I am facing latency issue due to below implementation.
The function 'mmc_rescan' is getting called at regular intervals which =
is calling 'of_find_comaptible_node which is adding to the latency. Tra=
ce:=20

=3D> of_find_compatible_node
=3D> esdhc_of_set_clock
=3D> sdhci_set_clock
=3D> sdhci_set_ios
=3D> mmc_power_up
=3D> mmc_rescan

'of_find_compatible_node' function call is required only once at Linux =
boot time.=20


If I change the implementation to :=20

static void esdhc_of_set_clock(struct sdhci_host *host, unsigned int cl=
ock)
{
=A0=A0=A0=A0=A0=A0=A0 static int reduce_clock_flag, check_only_once_fla=
g;
=A0=A0=A0=A0=A0=A0=A0 /* Workaround to reduce the clock frequency for p=
1010 esdhc */
=A0=A0=A0=A0=A0=A0=A0 if (check_only_once_flag =3D=3D 0)
=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (of_find_compatible_no=
de(NULL, NULL, "fsl,p1010-esdhc"))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r=
educe_clock_flag =3D 1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 check_only_once_flag =3D =
1;
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 if (reduce_clock_flag =3D=3D 1)
=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (clock > 20000000)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
lock -=3D 5000000;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (clock > 40000000)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 c=
lock -=3D 5000000;
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0 /* Set the clock */
=A0=A0=A0=A0=A0=A0=A0 esdhc_set_clock(host, clock);
}


It works fine. No more latency issue. Please review this approach. If t=
here is a better way, please do suggest.

Thanks=20
Priyanka Jain

-----Original Message-----
=46rom: Huang Changming-R66093=20
Sent: Tuesday, February 14, 2012 11:41 AM
To: Chris Ball
Cc: linux-mmc@vger.kernel.org; Jain Priyanka-B32167
Subject: RE: [PATCH v7] ESDHC: Workaround for data crc error on p1010rd=
b



Thanks
Jerry Huang


> -----Original Message-----
> From: Chris Ball [mailto:cjb@laptop.org]
> Sent: Tuesday, February 14, 2012 4:44 AM
> To: Huang Changming-R66093
> Cc: linux-mmc@vger.kernel.org; Jain Priyanka-B32167
> Subject: Re: [PATCH v7] ESDHC: Workaround for data crc error on=20
> p1010rdb
>=20
> Hi,
>=20
> On Mon, Feb 13 2012, Huang Changming-R66093 wrote:
> >> Actually, I think I'm still missing something.=A0 Why doesn't this=
 work?
> >>
> >> +static void esdhc_of_set_clock(struct sdhci_host *host, unsigned=20
> >> +int
> >> +clock) {
> >> +=A0=A0=A0=A0=A0=A0 /* Workaround to reduce the clock frequency fo=
r p1010 esdhc */
> >> +=A0=A0=A0=A0=A0=A0 if (of_find_compatible_node(NULL, NULL, "fsl,p=
1010-esdhc")) {
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (clock > 20000000)
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 clock -=3D 5000000;
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (clock > 40000000)
> >> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 clock -=3D 5000000;
> >> +=A0=A0=A0=A0=A0=A0 }
> >> +
> >> +=A0=A0=A0=A0=A0=A0 /* Set the clock */
> >> +=A0=A0=A0=A0=A0=A0 esdhc_set_clock(host, clock); }
> >>
> > These codes can work, too.
> > I forget the clock will be reduced 5M/10M only when the clock is=20
> > greater than 20MHz/45MHz.
> > So I should not test the clock in this function.
>=20
> Great, thanks -- please test and submit a patch with the code above,=20
> and I'll merge it.


Thanks, Chris.
I have sent it again.


Jerry Huang

