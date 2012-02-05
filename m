From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 00/11 v2] mmc: tmio/sdhi: hotplug & PM
Date: Sun, 5 Feb 2012 02:36:08 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1202050235050.3770@axis700.grange>
References: <1327406500-7233-1-git-send-email-g.liakhovetski@gmx.de>
 <m2wr82885d.fsf@bob.laptop.org> <Pine.LNX.4.64.1202050147520.3770@axis700.grange>
 <m2ehua84xf.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <m2ehua84xf.fsf@bob.laptop.org>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Sat, 4 Feb 2012, Chris Ball wrote:

> Hi,
> 
> On Sat, Feb 04 2012, Guennadi Liakhovetski wrote:
> > Thanks. Actually, it recently occurred to me, that patches 3 and 10 should 
> > actually be merged into one. So, if you like, I can produce a v3 with that 
> > taken into account. The result would be exactly the same, I literally 
> > would just apply #10 on top of #3 and commit the result with the same 
> > commit description as the v2 of #3.
> 
> Sure.

Ok, will do asap.

> > Shall I also rebase v3 on top of mmx-next and fix the failing patch? The 
> > two ARM patches can be applied separately, but they have to go in after 
> > this series then. Either way is ok with me, pulling all via mmc has the 
> > advantage of not having to synchronise the pulls, but then the conflict 
> > probability rises of course.
> 
> I'm happy to take the ARM patches, but I'll need ACKs from the relevant
> arch maintainers to do that.

Sure, that's what I meant. Sorry for not mentioning explicitly.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
