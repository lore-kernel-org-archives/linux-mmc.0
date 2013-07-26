From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 1/2] mmc: add Device Tree properties for UHS modes
Date: Fri, 26 Jul 2013 22:23:43 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1307262215110.27439@axis700.grange>
References: <Pine.LNX.4.64.1307261747210.22137@axis700.grange>
 <51F2ADA2.2030503@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.186]:54252 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752253Ab3GZUYG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 26 Jul 2013 16:24:06 -0400
In-Reply-To: <51F2ADA2.2030503@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Chris Ball <cjb@laptop.org>, devicetree@vger.kernel.org, Simon Horman <horms@verge.net.au>, Ian Campbell <ian.campbell@citrix.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <Mark.Rutland@arm.com>, Rob Herring <rob.herring@calxeda.com>

Hi Stephen

On Fri, 26 Jul 2013, Stephen Warren wrote:

> On 07/26/2013 09:51 AM, Guennadi Liakhovetski wrote:
> > Add DT properties for UHS SDR12, SDR25, SDR50, SDR104 and DDR50 modes and
> > for supported by the host in DDR mode VccQ values. Adding them to DT will
> > automatically enable respective MMC host capabilities.
> 
> > diff --git a/Documentation/devicetree/bindings/mmc/mmc.txt b/Documentation/devicetree/bindings/mmc/mmc.txt
> 
> > +- uhs-sdr12: the host supports UHS SDR12 mode
> > +- uhs-sdr25: the host supports UHS SDR25 mode
> > +- uhs-sdr50: the host supports UHS SDR50 mode
> > +- uhs-sdr104: the host supports UHS SDR104 mode
> > +- uhs-ddr50: the host supports UHS DDR50 mode
> > +- ddr-1v2: the host can support DDR, using 1.2V VccQ
> > +- ddr-1v8: the host can support DDR, using 1.8V VccQ
> 
> Surely the driver for the host controller already knows this, so there's
> no need to represent it in DT?

Not necessarily. One driver can handle several versions of the same chip, 
and some versions of the chip implement some of those features, others 
don't. So, your choice is really whether to specify a chip version in the 
compatible string or these properties. Now, when you consider that 
multiple drivers have to decide upon those, and sometimes you don't have 
an exact IP version of the SD/MMC controller but only the SoC version, you 
choice becomes: either _standard_ _common_ properties as above, or 
compatibility strings virtually in each driver for each SoC version. 
That's why I decided to use explicit properties for those. Example: 
sh_mmcif driver supports MMCIF IP blocks on various Renesas sh-, r-mobile 
and r-car SuperH and ARM SoCs. On some of them DDR50 is supported, on 
others it isn't.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
