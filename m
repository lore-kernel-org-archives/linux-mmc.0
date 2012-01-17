From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/2] mmc: sh_mmcif: simplify platform DMA configuration
Date: Tue, 17 Jan 2012 17:39:55 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1201171738390.21882@axis700.grange>
References: <Pine.LNX.4.64.1108301819150.19151@axis700.grange>
 <20110905041553.GB22142@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20110905041553.GB22142@linux-sh.org>
Sender: linux-sh-owner@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Chris Ball <cjb@laptop.org>
List-Id: linux-mmc@vger.kernel.org

Hi Paul

On Mon, 5 Sep 2011, Paul Mundt wrote:

> On Tue, Aug 30, 2011 at 06:26:34PM +0200, Guennadi Liakhovetski wrote:
> > A simple cosmetic clean-up, no functional changes. Patch 2/2 depends on 
> > patch 1/2 and can wait until 3.3. Paul, would you be able to put it under 
> > the carpet somewhere until then or shall I resend it after 3.2-rc1 is out? 
> > After both these patches have been applied, we can remove struct 
> > sh_mmcif_plat_data::dma around 3.4 or 4.0 or whatever;-)
> > 
> It's not a problem, I'll just flag it as awaiting upstream in the
> tracker. Anything flagged as such I generally give a once over after each
> merge window to see if their dependencies have been worked out.

You certainly haven't forgotten about this patch;-), in which case it's 
just me, unable to find it in your git branches. Could you give me a hint 
where it can be?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
