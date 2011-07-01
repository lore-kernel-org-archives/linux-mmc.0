From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Fri, 1 Jul 2011 23:46:29 +0800
Message-ID: <20110701154628.GD8631@S2100-06.ap.freescale.net>
References: <BANLkTi==Y_MJ2H_u15DzunWusUb=GsotWg@mail.gmail.com>
 <BANLkTinKcb-=m3sURawdEjR=vTt=ApBKaQ@mail.gmail.com>
 <20110630145507.GG1997@pengutronix.de>
 <20110701091753.GE1922@pengutronix.de>
 <BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
 <20110701122709.GJ1922@pengutronix.de>
 <BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
 <20110701144409.GA3825@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from va3ehsobe006.messaging.microsoft.com ([216.32.180.16]:19164
	"EHLO VA3EHSOBE007.bigfish.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751523Ab1GAPkV (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 1 Jul 2011 11:40:21 -0400
Content-Disposition: inline
In-Reply-To: <20110701144409.GA3825@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Koen Beel <koen.beel.barco@gmail.com>, linux-mmc@vger.kernel.org

On Fri, Jul 01, 2011 at 04:44:09PM +0200, Wolfram Sang wrote:
> Hi,
> 
> On Fri, Jul 01, 2011 at 03:26:39PM +0200, Koen Beel wrote:
> > I send the patch as attachment for now.
> 
> Fine with me in this case...
> 
> > But I'll have to look into another way of doing this. Corporate mail
> > system is adding stupid disclaimers, gmail web ui is not working ok
> > and corporate firewalls avoid using a different smtp server...
> 
> Good luck with that!
> 
> About the patch itself: I didn't verify the formulas, but it does solve one
> special problem here. Thanks a lot! So:
> 
> Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> @chris: If Shawn also likes the patch, I think this is a stable candidate.
> 
Thanks for the fixing, Koen.

Acked-by: Shawn Guo <shawn.guo@freescale.com>

-- 
Regards,
Shawn

