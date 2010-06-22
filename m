From: "Ghorai, Sukumar" <s-ghorai@ti.com>
Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Tue, 22 Jun 2010 17:13:41 +0530
Message-ID: <2A3DCF3DA181AD40BDE86A3150B27B6B030DED2A3B@dbde02.ent.ti.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <AANLkTim5A1tlfDzFTb4A1KdmYJJeH1diVOmmpRiDduF3@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: zhangfei gao <zhangfei.gao@gmail.com>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, "Menon, Nishanth" <nm@ti.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: zhangfei gao [mailto:zhangfei.gao@gmail.com]
> Sent: Tuesday, June 22, 2010 4:51 PM
> To: Chikkature Rajashekar, Madhusudhan
> Cc: Tony Lindgren; Menon, Nishanth; Ghorai, Sukumar; linux-
> omap@vger.kernel.org; linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
>=20
> On Sat, May 8, 2010 at 5:25 AM, Madhusudhan <madhu.cr@ti.com> wrote:
> >
> >
> >> -----Original Message-----
> >> From: Tony Lindgren [mailto:tony@atomide.com]
> >> Sent: Thursday, May 06, 2010 10:31 AM
> >> To: Madhusudhan
> >> Cc: 'Nishanth Menon'; 'Ghorai, Sukumar'; linux-omap@vger.kernel.or=
g;
> >> linux-mmc@vger.kernel.org
> >> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
> >>
> >> * Madhusudhan <madhu.cr@ti.com> [100505 18:31]:
> >> >
> >> >
> >> > > -----Original Message-----
> >> > > From: Tony Lindgren [mailto:tony@atomide.com]
> >> >
> >> > > And what about this "Simulate multi mmc card as one big" patch=
?
> >> > >
> >> > Did not get you, what patch are you referring to?
> >>
> >> Oops sorry forgot the link:
> >>
> >> https://patchwork.kernel.org/patch/87944/
> >>
> > This will not help. I don't know the history of the patch but what =
this
> is
> > intended for is to support multiple MMC cards connected to a single
> > controller. But on the Zoom the eMMC we are talking about is connec=
ted
> to
> > MMC2.
> >
> > Regards,
> > Madhu
> >
> >> Tony
> >
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-mmc=
" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at =A0http://vger.kernel.org/majordomo-info.htm=
l
> >
>=20
> Hi, Guys
>=20
> Just wander whether 16G Micron eMMC works on your platform.
> I also have such issue, 16G Micron emmc can not work with read and
> write, with data timeout.
> While 8G Micron eMMC workable.
> Do you have the same issue?

[Ghorai] we have 16G eMMC in ZOOM3 and 3630-SDP and its working fine. L=
et me know what board you are using.
mmc1: new high speed MMC card at address 0001
PM: Adding info for mmc:mmc1:0001
mmcblk0: mmc1:0001 STM16G 14.8 GiB
PM: Adding info for No Bus:mmcblk0
 mmcblk0: p1 p2
>=20
> Thanks
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
