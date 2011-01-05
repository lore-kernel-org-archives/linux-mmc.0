From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/3] mmc: tmio: merge the private header into the driver
Date: Wed, 5 Jan 2011 19:50:16 +0000
Message-ID: <20110105195016.GC9198@void.printf.net>
References: <Pine.LNX.4.64.1011231711240.25676@axis700.grange> <Pine.LNX.4.64.1011231718500.25676@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:42389 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751379Ab1AETuR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 5 Jan 2011 14:50:17 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1011231718500.25676@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Samuel Ortiz <sameo@linux.intel.com>

On Tue, Nov 23, 2010 at 05:24:11PM +0100, Guennadi Liakhovetski wrote:
> drivers/mmc/host/tmio_mmc.h is only used by drivers/mmc/host/tmio_mmc.c, this
> needlessly complicates source-code handling.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

Ouch; but fixing it needlessly complicates patch handling, because now
all future patches apply or don't based on whether they saw this patch.
I think this decision should just be made once and lived with, without
a stronger reason than this one to change it.

I'll apply it since it's become a dependency now.  Pushed to mmc-next.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
