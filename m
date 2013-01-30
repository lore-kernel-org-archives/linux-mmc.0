From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH/RFC v2 06/11] mmc: tmio-mmc: define device-tree bindings
Date: Wed, 30 Jan 2013 15:07:03 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1301301453110.3113@axis700.grange>
References: <1358955158-1510-1-git-send-email-g.liakhovetski@gmx.de>
 <1358955158-1510-7-git-send-email-g.liakhovetski@gmx.de>
 <Pine.LNX.4.64.1301241630160.7826@axis700.grange> <87pq0uh9ob.fsf@laptop.org>
 <Pine.LNX.4.64.1301241649560.7826@axis700.grange> <87k3r2h8lg.fsf@laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <87k3r2h8lg.fsf@laptop.org>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

On Thu, 24 Jan 2013, Chris Ball wrote:

> Hi,
> 
> On Thu, Jan 24 2013, Guennadi Liakhovetski wrote:
> > I tried to keep this binding similar to others, that I proposed in "mmc: 
> > add DT bindings for more MMC capability flags." Actually, the above is 
> > indeed wrong, I would call it "cap-sdio-irq." And in that patch I tried to 
> > keep binding names resembling as closely as possible respective MMC_CAP_* 
> > flags. I think, it would have been better if "enable-sdio-wakeup" and 
> > "keep-power-in-suspend" were also named, following the same rule, but it's 
> > too late now. Anyway, I'm not too concerned about the names. We can use 
> > "enable-sdio-irq" too if you like.
> 
> I see.  Okay, let's go with your proposed cap-* for each MMC_CAP_*, and
> the pm_caps can stay as they are.

Thanks, let's do that. But in fact, in a recent discussion it has been 
pointed out to me, that this property

+- toshiba,mmc-cap-sdio-irq	: SDIO IRQ signalling should be used, if
+	supported by the hardware, i.e. set MMC_CAP_SDIO_IRQ if
+	TMIO_MMC_SDIO_IRQ is also set

should be common for all MMC drivers: it should be possible to decide per 
SD interface, whether SDIO IRQ signalling should be enabled. What do you 
think? Shall we add a global "cap-sdio-irq" DT property instead of a 
toshiba-specific one?

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
