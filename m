From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 3/4 v3] mmc: sh_mmcif: process requests asynchronously
Date: Mon, 26 Dec 2011 00:00:16 +0100 (CET)
Message-ID: <Pine.LNX.4.64.1112252358050.22951@axis700.grange>
References: <Pine.LNX.4.64.1111301553330.22197@axis700.grange>
 <1323887514-12650-4-git-send-email-g.liakhovetski@gmx.de> <m2boqxz91n.fsf@bob.laptop.org>
 <Pine.LNX.4.64.1112252105340.22951@axis700.grange> <m2aa6gxog7.fsf@bob.laptop.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <m2aa6gxog7.fsf@bob.laptop.org>
Sender: linux-sh-owner@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

Hi Chris

On Sun, 25 Dec 2011, Chris Ball wrote:

> Hi Guennadi,
> 
> On Sun, Dec 25 2011, Guennadi Liakhovetski wrote:
> >> This patch (3/4) no longer applies to mmc-next -- mind resending?
> >
> > This one should be ok.
> 
> Seems to be worse, for some reason:
> 
> patching file drivers/mmc/host/sh_mmcif.c
> Hunk #2 succeeded at 189 (offset -5 lines).
> Hunk #3 FAILED at 217.
> Hunk #4 succeeded at 503 (offset -4 lines).
> Hunk #5 FAILED at 780.
> Hunk #6 FAILED at 802.
> Hunk #7 FAILED at 835.
> Hunk #8 succeeded at 908 (offset 6 lines).
> Hunk #9 FAILED at 942.
> Hunk #10 succeeded at 1044 with fuzz 2 (offset 11 lines).
> Hunk #11 succeeded at 1246 (offset 11 lines).
> Hunk #12 succeeded at 1351 (offset 11 lines).
> Hunk #13 FAILED at 1376.
> Hunk #14 succeeded at 1425 (offset 11 lines).
> 6 out of 14 hunks FAILED -- saving rejects to file drivers/mmc/host/sh_mmcif.c.rej

Hmmm, that's very weird - I rebased my patch series on top of your 
mmc-next from a couple of hours ago. Sorry for asking, but you've also 
applied the leading two patches from this series, right? This is what my 
log of this driver looks like now:

6bf5ca1 mmc: sh_mmcif: remove now superfluous sh_mmcif_host::data member
8777cc4 mmc: sh_mmcif: process requests asynchronously
0295d69 mmc: sh_mmcif: cosmetic clean up
74dfec8 mmc: sh_mmcif: process error interrupts first
9092a17 mmc: convert drivers/mmc/host/* to use module_platform_driver()

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
