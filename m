From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 08/12] mmc: sh_mobile_sdhi: Convert to
 clk_prepare/unprepare
Date: Sat, 14 Dec 2013 10:05:02 +0900
Message-ID: <20131214010502.GE12584@verge.net.au>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <23114596.UeGyAebmZh@avalon>
 <87a9g67t63.fsf@octavius.laptop.org>
 <4390506.Q1di3yUE6Z@avalon>
 <87mwk66c1m.fsf@octavius.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:46894 "EHLO
	kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752652Ab3LNBFF (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Dec 2013 20:05:05 -0500
Content-Disposition: inline
In-Reply-To: <87mwk66c1m.fsf@octavius.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, linux-arm-kernel@lists.infradead.org, linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org

On Wed, Dec 11, 2013 at 09:25:09PM -0500, Chris Ball wrote:
> Hi Laurent,
> 
> On Wed, Dec 11 2013, Laurent Pinchart wrote:
> >> I'm sorry about the delay -- it's in mmc-next for 3.14 now.
> >
> > Thanks a lot and sorry about shouting. Don't worry about the delay, I only 
> > wanted to make sure the patch would get in v3.14.
> 
> No worries, it was deserved yelling.  :-)
> 
> > [PATCH v3 1/3] mmc: sh_mmcif: Factorize DMA channel request and configuration 
> > code
> > [PATCH v3 2/3] mmc: sh_mmcif: Fix compilation warning on 64-bit platforms
> 
> These two are in mmc-next now too.  (I usually wait for someone with
> SH hardware to ACK, but I understand that Guennadi's not around as
> much anymore.)

I believe I can provide such Acks going forwards.
