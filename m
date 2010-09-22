From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: [PATCH] OMAP4: HSMMC cmd line reset change
Date: Wed, 22 Sep 2010 12:13:51 -0500
Message-ID: <16904B7F1B384B42B8D5F85D0414A47D@am.dhcp.ti.com>
References: <51627.192.168.10.89.1284595091.squirrel@dbdmail.itg.ti.com> <20100917154803.GB29610@atomide.com> <738912BD0A0F48FC9E3159F923571E9E@am.dhcp.ti.com> <20100921144705.GP4611@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53364 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753726Ab0IVRN6 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Sep 2010 13:13:58 -0400
In-Reply-To: <20100921144705.GP4611@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Tony Lindgren' <tony@atomide.com>
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, santosh.shilimkar@ti.com



> -----Original Message-----
> From: Tony Lindgren [mailto:tony@atomide.com]
> Sent: Tuesday, September 21, 2010 9:47 AM
> To: Madhusudhan
> Cc: cjb@laptop.org; linux-mmc@vger.kernel.org; linux-omap@vger.kernel.org;
> santosh.shilimkar@ti.com
> Subject: Re: [PATCH] OMAP4: HSMMC cmd line reset change
> 
> * Madhusudhan <madhu.cr@ti.com> [100920 09:06]:
> > >
> > > Please don't use cpu_is_omapxxxx tests in the drivers, drivers
> > > should be generic.
> > >
> > > Instead, just pass a feature flag in the platform_data for this
> > > feature like HSMMC_REVERSE_RESET_LOGIC or similar.
> > >
> >
> > This is not a feature. It is like an ERRATA fix. I am yet to receive an
> > errata number though. How about dealing with this like an errata fix
> similar
> > to the way in arch/mach-omap2/serial.c done for the uart case?
> 
> Yes setting some HSMMC_ERRATA_XYZ flag works too.
> 
> > The mmc ip revision will not help because it really does not change to
> > distinguish such issues.
> 
> OK. Then I guess your only option is to pass the errata flag in
> the platform_data.
> 
Chris,

Can you please drop this patch? Sorry, I spoke bit too early on this patch.
I need to sort out some stuff internally (seems like it will not be released
as an errata). I will post a revised version a bit later.

Regards,
Madhu

> Regards,
> 
> Tony

