From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/4 v3] mmc: sh_mmcif: process requests asynchronously
Date: Mon, 26 Dec 2011 09:44:32 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112260942330.9178@axis700.grange>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
 <1323887514-12650-4-git-send-email-g.liakhovetski@gmx.de> <m2boqxz91n.fsf@bob.laptop.org>
 <Pine.LNX.4.64.1112252105340.22951@axis700.grange> <m2aa6gxog7.fsf@bob.laptop.org>
 <Pine.LNX.4.64.1112252358050.22951@axis700.grange> <m2y5u0w1a2.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <m2y5u0w1a2.fsf@bob.laptop.org>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

On Sun, 25 Dec 2011, Chris Ball wrote:

> Hi,
> 
> On Sun, Dec 25 2011, Guennadi Liakhovetski wrote:
> > Hmmm, that's very weird - I rebased my patch series on top of your 
> > mmc-next from a couple of hours ago. Sorry for asking, but you've also 
> > applied the leading two patches from this series, right? This is what my 
> > log of this driver looks like now:
> 
> Oops, that's it, thanks.
> 
> Now I have:
> 
> 13cb975 (HEAD, mmc-next) mmc: sh_mmcif: cosmetic clean up
> 9e66e1c mmc: sh_mmcif: process error interrupts first
> 9092a17 mmc: convert drivers/mmc/host/* to use module_platform_driver()
> 2736566 mmc: sh_mmcif: simplify clock divisor calculation
> 58f1934 mmc: sh_mmcif: fix clock gating on platforms with a .down_pwr() method
> 88b4767 mmc: Add module.h to drivers/mmc users assuming implicit presence.
> 714c4a6 mmc: sh_mmcif: simplify platform data
> c9b0cef mmc: sh_mmcif: maximize power saving
> 
> But 4/4 ("mmc: sh_mmcif: remove now superfluous sh_mmcif_host::data
> member") isn't applying without fuzz (offset 13 lines).  Any ideas/want
> to resend it?

I can resend it if you like, but in fact that fuzz is harmless - you can 
go ahead with the patch you have at hand. But, please, do let me know if 
you prefer to have an updated patch.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
