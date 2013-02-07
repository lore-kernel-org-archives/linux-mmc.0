From: Paul Mundt <lethal@linux-sh.org>
Subject: Re: [PATCH v3 13/13] mmc: tmio: add barriers to IO operations
Date: Thu, 7 Feb 2013 18:51:42 +0900
Message-ID: <20130207095141.GD13371@linux-sh.org>
References: <1360180020-18555-1-git-send-email-g.liakhovetski@gmx.de>
 <1360180020-18555-14-git-send-email-g.liakhovetski@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from linux-sh.org ([111.68.239.195]:44930 "EHLO linux-sh.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755436Ab3BGJwA (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 7 Feb 2013 04:52:00 -0500
Content-Disposition: inline
In-Reply-To: <1360180020-18555-14-git-send-email-g.liakhovetski@gmx.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, linux-sh@vger.kernel.org, Magnus Damm <magnus.damm@gmail.com>, Simon Horman <horms@verge.net.au>

On Wed, Feb 06, 2013 at 08:47:00PM +0100, Guennadi Liakhovetski wrote:
> Without barriers SDIO operations fail with runtime PM enabled.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> Cc: Paul Mundt <lethal@linux-sh.org>
> ---
> 
> v3: use iowrite16_rep() and ioread16_rep() for consistency.
> 
Looks better to me!

Reviewed-by: Paul Mundt <lethal@linux-sh.org>
