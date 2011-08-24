From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH 0/4 v7] mmc: tmio, sdhi: provide multiple irq handlers
Date: Wed, 24 Aug 2011 14:37:11 +0900
Message-ID: <20110824053711.GB17212@verge.net.au>
References: <1313740642-18307-1-git-send-email-horms@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sh-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1313740642-18307-1-git-send-email-horms@verge.net.au>
Sender: linux-sh-owner@vger.kernel.org
To: linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org
Cc: Chris Ball <cjb@laptop.org>, Paul Mundt <lethal@linux-sh.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Magnus Damm <magnus.damm@gmail.com>
List-Id: linux-mmc@vger.kernel.org

On Fri, Aug 19, 2011 at 04:57:18PM +0900, Simon Horman wrote:
> The SDHI driver already supports making use of up to three interrupt
> sources.
> 
> This series breaks up the existing interrupt handler into three handlers,
> one for card access, one for card detect interrupts, and one for SDIO
> interrupts.  A cover-all handler, which makes use of these new broken-out
> handlers is provided for for the case where there is only one interrupt
> source.
> 
> This series also wires up the broken-out irq handlers in the SDHI driver

Magnus, Guennadi,

when you get a chance could I get an ack or otherwise on these changes.

