From: "Madhusudhan" <madhu.cr@ti.com>
Subject: RE: sdio irq hack for omap_hsmmc.c (was: Re: [PATCH] OMAP35xx:SDIO IRQ Support for OMAP35xx)
Date: Wed, 27 Jan 2010 17:14:52 -0600
Message-ID: <008001ca9fa6$87dc26e0$544ff780@am.dhcp.ti.com>
References: <4b73d43f1001260904m212d2c53gde6328ad9b9bb14e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from comal.ext.ti.com ([198.47.26.152]:53014 "EHLO comal.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755257Ab0A0XPB (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jan 2010 18:15:01 -0500
In-Reply-To: <4b73d43f1001260904m212d2c53gde6328ad9b9bb14e@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'John Rigby' <jcrigby@gmail.com>, 'Mike Rapoport' <mike@compulab.co.il>
Cc: 'Dirk Behme' <dirk.behme@googlemail.com>, 'Phaneendra Kumar Alapati' <phani@embwise.com>, linux-omap@vger.kernel.org, linux-mmc@vger.kernel.org, 'Adrian Hunter' <adrian.hunter@nokia.com>, "'Paasikivi Teemu.3 (EXT-Ixonos/Tampere)'" <ext-teemu.3.paasikivi@nokia.com>

It is hard to comment on what is happening here without a patch. Is it a
performance issue or that SDIO functionality failure with PM enabled?

The MMC controller supports wakeup capability on the dat1 line using a GPIO
for a SDIO interrupt. I guess that should help.

Regards,
Madhu

> -----Original Message-----
> From: John Rigby [mailto:jcrigby@gmail.com]
> Sent: Tuesday, January 26, 2010 11:05 AM
> To: Mike Rapoport
> Cc: Dirk Behme; Phaneendra Kumar Alapati; linux-omap@vger.kernel.org;
> Madhusudhan Chikkature; linux-mmc@vger.kernel.org; Adrian Hunter;
> Paasikivi Teemu.3 (EXT-Ixonos/Tampere)
> Subject: sdio irq hack for omap_hsmmc.c (was: Re: [PATCH] OMAP35xx:SDIO
> IRQ Support for OMAP35xx)
> 
> Attached is a hacked omap_hsmmc.c which works with libertas on my
> board (very similar to beagle).  This is not intended to be a solution
> but points in the direction of the problem.  I ripped out the
> CONFIG_PM code and turned off all the enable/disable stuff.  I also
> explicitly turn on the fclk at probe time.  I get about 11 Mbits/sec
> throughput with this.
> 
> Again this is a hack but it shows that the likely problem has
> something to do with the enable/disable code.  I appears that the
> controller is disabled (fclk turned off) and sdio irqs get dropped as
> a result.

