From: Seungwon Jeon <tgih.jun@samsung.com>
Subject: RE: [RFC PATCH] MAINTAINERS: Add an orphaned entry for the dw_mmc
 driver.
Date: Mon, 14 Jan 2013 17:46:15 +0900
Message-ID: <001301cdf233$9cf2bca0$d6d835e0$%jun@samsung.com>
References: <CAFbHwiRX19Zm=O2dNZrbTDGZxnXDOx0zJ3pvTkfC1q8m5DBFug@mail.gmail.com>
 <87wqvjmxt6.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=Windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout2.samsung.com ([203.254.224.25]:32154 "EHLO
	mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752333Ab3ANIqR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 14 Jan 2013 03:46:17 -0500
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MGL00ECIXOWK3G0@mailout2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Jan 2013 17:46:15 +0900 (KST)
Received: from DOTGIHJUN01 ([12.23.118.161])
 by mmp2.samsung.com (Oracle Communications Messaging Server 7u4-24.01
 (7.0.4.24.0) 64bit (built Nov 17 2011))
 with ESMTPA id <0MGL00MRTXP3M020@mmp2.samsung.com> for
 linux-mmc@vger.kernel.org; Mon, 14 Jan 2013 17:46:15 +0900 (KST)
In-reply-to: <87wqvjmxt6.fsf@laptop.org>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@gmail.com>
Cc: linux-mmc@vger.kernel.org, 'Thomas Abraham' <thomas.abraham@linaro.org>, 'Jaehoon Chung' <jh80.chung@samsung.com>, 'James Hogan' <james.hogan@imgtec.com>

On Saturday, January 12, 2013, Chris Ball wrote:
> Hi,
> 
> On Fri, Jan 11 2013, Will Newton wrote:
> > I submitted this driver but will shortly no longer have access
> > to hardware that uses it. The driver is quite widely used so
> > there may be someone out there that feels strongly enough to
> > step up and maintain it.
> > ---
> >  MAINTAINERS |    6 ++++++
> >  1 files changed, 6 insertions(+), 0 deletions(-)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index f940e81..88329bc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6558,6 +6558,12 @@ F:	include/linux/dw_dmac.h
> >  F:	drivers/dma/dw_dmac_regs.h
> >  F:	drivers/dma/dw_dmac.c
> >
> > +SYNOPSYS DESIGNWARE MMC/SD/SDIO DRIVER
> > +L:	linux-mmc@vger.kernel.org
> > +S:	Orphaned
> > +F:	include/linux/mmc/dw_mmc.h
> > +F:	drivers/mmc/host/dw_mmc*
> > +
> >  TIMEKEEPING, NTP
> >  M:	John Stultz <johnstul@us.ibm.com>
> >  M:	Thomas Gleixner <tglx@linutronix.de>
> 
> Thanks for your work on the driver, Will!  I'm CC'ing some recent
> committers so they can volunteer to take over if they're interested.
Will, Thank you for your efforts.
It's interesting to me. I am ready to volunteer to maintain 'dw_mmc*' driver.
I would appreciate it if you let me know what you think.

Thanks,
Seungwon Jeon.
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child

