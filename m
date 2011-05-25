From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [PATCH 0/3] Make DMA slave ID 0 invalid to simplify platform
 data
Date: Wed, 25 May 2011 08:48:51 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.1105250834250.13724@axis700.grange>
References: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
 <20110525023217.GF14329@linux-sh.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.171]:62897 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752096Ab1EYGtE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 25 May 2011 02:49:04 -0400
In-Reply-To: <20110525023217.GF14329@linux-sh.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

On Wed, 25 May 2011, Paul Mundt wrote:

> On Tue, May 24, 2011 at 12:23:55PM +0200, Guennadi Liakhovetski wrote:
> > Currently platforms, using the SDHI TMIO driver, have to specify negative 
> > DMA slave IDs to force PIO mode. If default 0 is left, the driver 
> > recognises it as a valid DMA slave ID and tries to acquire channels. This 
> > fails then, because the driver cannot allocate two channels with the same 
> > ID, but it would be better to just make 0 an invalid ID to prevent this.
> > 
> I suppose the ordering for this will be adding the invalid IDs for all of
> the CPUs first and then updating the SDHI driver accordingly during -rc2
> or something like that.

Yes, otherwise it would break SDHI DMA on sh7757, where one of the IDs == 
0.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
