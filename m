From: Shawn Guo <shawn.guo@freescale.com>
Subject: Re: [PATCH] mxs-mmc: fix clock rate setting
Date: Sun, 3 Jul 2011 19:54:19 +0800
Message-ID: <20110703115418.GB9938@S2100-06.ap.freescale.net>
References: <20110630145507.GG1997@pengutronix.de>
 <20110701091753.GE1922@pengutronix.de>
 <BANLkTi=cTigrnAHY3sDNC04aNpmZOQpUsA@mail.gmail.com>
 <20110701122709.GJ1922@pengutronix.de>
 <BANLkTim5aHJHbtbw-ZWnqdjdj_nxWZuwog@mail.gmail.com>
 <20110701144409.GA3825@pengutronix.de>
 <20110701154628.GD8631@S2100-06.ap.freescale.net>
 <20110702131225.GA5478@pengutronix.de>
 <20110703092850.GA9938@S2100-06.ap.freescale.net>
 <20110703103124.GA1333@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:32026
	"EHLO AM1EHSOBE002.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752565Ab1GCLsN (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 3 Jul 2011 07:48:13 -0400
Content-Disposition: inline
In-Reply-To: <20110703103124.GA1333@pengutronix.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Wolfram Sang <w.sang@pengutronix.de>
Cc: Koen Beel <koen.beel.barco@gmail.com>, linux-mmc@vger.kernel.org

On Sun, Jul 03, 2011 at 12:31:24PM +0200, Wolfram Sang wrote:
> On Sun, Jul 03, 2011 at 05:28:52PM +0800, Shawn Guo wrote:
> > On Sat, Jul 02, 2011 at 03:12:25PM +0200, Wolfram Sang wrote:
> > > On Fri, Jul 01, 2011 at 11:46:29PM +0800, Shawn Guo wrote:
> > > > On Fri, Jul 01, 2011 at 04:44:09PM +0200, Wolfram Sang wrote:
> > > > > Hi,
> > > > > 
> > > > > On Fri, Jul 01, 2011 at 03:26:39PM +0200, Koen Beel wrote:
> > > > > > I send the patch as attachment for now.
> > > > > 
> > > > > Fine with me in this case...
> > > > > 
> > > > > > But I'll have to look into another way of doing this. Corporate mail
> > > > > > system is adding stupid disclaimers, gmail web ui is not working ok
> > > > > > and corporate firewalls avoid using a different smtp server...
> > > > > 
> > > > > Good luck with that!
> > > > > 
> > > > > About the patch itself: I didn't verify the formulas, but it does solve one
> > > > > special problem here. Thanks a lot! So:
> > > > > 
> > > > > Tested-by: Wolfram Sang <w.sang@pengutronix.de>
> > > > > 
> > > > > @chris: If Shawn also likes the patch, I think this is a stable candidate.
> > > > > 
> > > > Thanks for the fixing, Koen.
> > > > 
> > > > Acked-by: Shawn Guo <shawn.guo@freescale.com>
> > > 
> > > Well, maybe not. My colleague complained and I think he is right that we are
> > > mapping div2 from the range 0 to 256 (inclusive!) to an 8-bit range. This must
> > > be wrong for one value per se.
> > > 
> > If you look at the context of the patch, you will find it's 'div2 - 1'
> > than 'div2' gets written into register.
> 
> Exactly. The '- 1' is why Koen changed the upper limit from < 256 to <= 256.
> The lower limit fix is currently 'if (div2 == 0) div2 == 1', which is a 2:1
> mapping. Not good, or?
> 
So you are saying the patch is a right fix but not the most optimal
one?  In that case, it does not concern me.  I acked it as an valid
fix. 

-- 
Regards,
Shawn

