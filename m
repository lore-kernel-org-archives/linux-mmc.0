From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 1/5] mmc: tmio: Cache interrupt masks
Date: Tue, 16 Aug 2011 17:03:39 +0900
Message-ID: <20110816080338.GC12097@verge.net.au>
References: <1313460499-3377-1-git-send-email-horms@verge.net.au>
 <1313460499-3377-2-git-send-email-horms@verge.net.au>
 <Pine.LNX.4.64.1108160857420.13154@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.1108160857420.13154@axis700.grange>
Sender: linux-sh-owner@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnus.damm@gmail.com>, Paul Mundt <lethal@linux-sh.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Aug 16, 2011 at 09:19:12AM +0200, Guennadi Liakhovetski wrote:
> On Tue, 16 Aug 2011, Simon Horman wrote:
> 
> > This avoids the need to look up the masks each time an interrupt
> > is handled.
> 
> Yes, almost... But I think, we can use the mask-caches even more 
> extensively. In your patch you actually hardly gain anything, you continue 
> reading the mask register instead of using the cache. Namely:

Sure.
