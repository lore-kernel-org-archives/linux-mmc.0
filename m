From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] Disable the non working eMMC on Zoom2/3
Date: Fri, 7 May 2010 16:25:59 -0500
Message-ID: <000901caee2b$e30ec1c0$544ff780@am.dhcp.ti.com>
References: <009a01cad1ee$e3bbae70$544ff780@am.dhcp.ti.com> <20100407114938.GF7153@atomide.com> <003801cad73e$86841df0$544ff780@am.dhcp.ti.com> <20100427182111.GE7225@atomide.com> <20100428192322.GG7225@atomide.com> <006801cae709$e136fe40$544ff780@am.dhcp.ti.com> <20100428194553.GH7225@atomide.com> <006f01cae886$38da6920$544ff780@am.dhcp.ti.com> <20100505182727.GA29604@atomide.com> <00a501caecbc$761ded40$544ff780@am.dhcp.ti.com> <20100506153044.GL29604@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:49963 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752798Ab0EGV0E (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Fri, 7 May 2010 17:26:04 -0400
In-Reply-To: <20100506153044.GL29604@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: 'Nishanth Menon' <nm@ti.com>, "'Ghorai, Sukumar'" <s-ghorai@ti.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Thursday, May 06, 2010 10:31 AM
> To: Madhusudhan
> Cc: 'Nishanth Menon'; 'Ghorai, Sukumar'; linux-omap@vger.kernel.org;
> linux-mmc@vger.kernel.org
> Subject: Re: [PATCH] Disable the non working eMMC on Zoom2/3
> 
> * Madhusudhan <madhu.cr@ti.com> [100505 18:31]:
> >
> >
> > > -----Original Message-----
> > > From: Tony Lindgren [mailto:tony@atomide.com]
> >
> > > And what about this "Simulate multi mmc card as one big" patch?
> > >
> > Did not get you, what patch are you referring to?
> 
> Oops sorry forgot the link:
> 
> https://patchwork.kernel.org/patch/87944/
> 
This will not help. I don't know the history of the patch but what this is
intended for is to support multiple MMC cards connected to a single
controller. But on the Zoom the eMMC we are talking about is connected to
MMC2.

Regards,
Madhu

> Tony

