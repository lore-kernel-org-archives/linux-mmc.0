From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH 0/3] Make DMA slave ID 0 invalid to simplify platform data
Date: Wed, 25 May 2011 11:32:17 +0900
Message-ID: <20110525023217.GF14329@linux-sh.org>
References: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:48915 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab1EYCco (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 24 May 2011 22:32:44 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1105241147010.31628@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Simon Horman <horms@verge.net.au>, Magnus Damm <damm@opensource.se>, Ian Molton <ian@mnementh.co.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>

On Tue, May 24, 2011 at 12:23:55PM +0200, Guennadi Liakhovetski wrote:
> Currently platforms, using the SDHI TMIO driver, have to specify negative 
> DMA slave IDs to force PIO mode. If default 0 is left, the driver 
> recognises it as a valid DMA slave ID and tries to acquire channels. This 
> fails then, because the driver cannot allocate two channels with the same 
> ID, but it would be better to just make 0 an invalid ID to prevent this.
> 
I suppose the ordering for this will be adding the invalid IDs for all of
the CPUs first and then updating the SDHI driver accordingly during -rc2
or something like that.
