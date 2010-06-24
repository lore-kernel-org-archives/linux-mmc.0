From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Thu, 24 Jun 2010 17:34:06 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030DF4E8F8@dbde02.ent.ti.com>
References: <009a01cad1ee$e3bbae70$544ff780@am.dhcp.ti.com>
	<20100407114938.GF7153@atomide.com>
	<003801cad73e$86841df0$544ff780@am.dhcp.ti.com>
	<20100427182111.GE7225@atomide.com>	<20100428192322.GG7225@atomide.com>
	<006801cae709$e136fe40$544ff780@am.dhcp.ti.com>
	<20100428194553.GH7225@atomide.com>
	<006f01cae886$38da6920$544ff780@am.dhcp.ti.com>
	<20100505182727.GA29604@atomide.com>
	<00a501caecbc$761ded40$544ff780@am.dhcp.ti.com>
	<20100506153044.GL29604@atomide.com>
	<000901caee2b$e30ec1c0$544ff780@am.dhcp.ti.com>
	<AANLkTim5A1tlfDzFTb4A1KdmYJJeH1diVOmmpRiDduF3@mail.gmail.com>
	<2A3DCF3DA181AD40BDE86A3150B27B6B030DED2A3B@dbde02.ent.ti.com>
 <AANLkTiks3HfE6iYN8nWDXnfNqncK-ETFLbtwTiHrW0Mn@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:48808 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755273Ab0FXMEN convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 24 Jun 2010 08:04:13 -0400
In-Reply-To: <AANLkTiks3HfE6iYN8nWDXnfNqncK-ETFLbtwTiHrW0Mn@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>
Cc: "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>



> -----Original Message-----
> From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
> Sent: Thursday, June 24, 2010 4:26 PM
> To: Ghorai, Sukumar
> Cc: Chikkature Rajashekar, Madhusudhan; Tony Lindgren; Menon, Nishant=
h;
> linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
>=20
> On Tue, Jun 22, 2010 at 7:43 PM, Ghorai, Sukumar <s-ghorai@ti.com> wr=
ote:
> >
> >
> >> -----Original Message-----
> >> From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
> >> Sent: Tuesday, June 22, 2010 4:51 PM
> >> To: Chikkature Rajashekar, Madhusudhan
> >> Cc: Tony Lindgren; Menon, Nishanth; Ghorai, Sukumar; linux-
> >> omap@vger.kernel.org; linux-mmc@vger.kernel.org
> >> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
> >>
> >> On Sat, May 8, 2010 at 5:25 AM, Madhusudhan <madhu.cr@ti.com> wrot=
e:
> >> >
> >> >
> >> >> -----Original Message-----
> >> >> From: Tony Lindgren [mailto:tony@atomide.com]
> >> >> Sent: Thursday, May 06, 2010 10:31 AM
> >> >> To: Madhusudhan
> >> >> Cc: 'Nishanth Menon'; 'Ghorai, Sukumar'; linux-omap@vger.kernel=
=2Eorg;
> >> >> linux-mmc@vger.kernel.org
> >> >> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
> >> >>
> >> >> * Madhusudhan <madhu.cr@ti.com> [100505 18:31]:
> >> >> >
> >> >> >
> >> >> > > -----Original Message-----
> >> >> > > From: Tony Lindgren [mailto:tony@atomide.com]
> >> >> >
> >> >> > > And what about this "Simulate multi mmc card as one big" pa=
tch?
> >> >> > >
> >> >> > Did not get you, what patch are you referring to?
> >> >>
> >> >> Oops sorry forgot the link:
> >> >>
> >> >> https://patchwork.kernel.org/patch/87944/
> >> >>
> >> > This will not help. I don't know the history of the patch but wh=
at
> this
> >> is
> >> > intended for is to support multiple MMC cards connected to a sin=
gle
> >> > controller. But on the Zoom the eMMC we are talking about is
> connected
> >> to
> >> > MMC2.
> >> >
> >> > Regards,
> >> > Madhu
> >> >
> >> >> Tony
> >> >
> >> > --
> >> > To unsubscribe from this list: send the line "unsubscribe linux-=
mmc"
> in
> >> > the body of a message to majordomo@vger.kernel.org
> >> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.=
html
> >> >
> >>
> >> Hi, Guys
> >>
> >> Just wander whether 16G Micron eMMC works on your platform.
> >> I also have such issue, 16G Micron emmc can not work with read and
> >> write, with data timeout.
> >> While 8G Micron eMMC workable.
> >> Do you have the same issue?
> >
> > [Ghorai] we have 16G eMMC in ZOOM3 and 3630-SDP and its working fin=
e.
> Let me know what board you are using.
> > mmc1: new high speed MMC card at address 0001
> > PM: Adding info for mmc:mmc1:0001
> > mmcblk0: mmc1:0001 STM16G 14.8 GiB
> > PM: Adding info for No Bus:mmcblk0
> > =A0mmcblk0: p1 p2
> >>
> >> Thanks
> >
>=20
> Hi, Ghorai
>=20
> Thanks for your valueable info.
> We also enabled Micron 16G eMMC, two issues stuck us before.
> 1. The bus_width should be inited otherwise read ext_csd would be fai=
l.
> 2. The emmc may stay in boot partition and kernel should switch to
> user partition, where filesystem is located.
[Ghorai]=20
1. If my understanding is not wrong, then the same problem exists in ex=
ternal MMC card too.=20
2. So, can you share your eMMC log, just to check if I have any clue! O=
r let me know how I can reproduce the issue.

>=20
> Thanks
