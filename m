From: Jarkko Nikula <jarkko.nikula@bitmer.com>
Subject: Re: [PATCH] mmc: omap: Fix error introduced by fix to release_mem_region()
 path
Date: Tue, 03 Dec 2013 18:16:59 +0000
Message-ID: <529E201B.6030306@bitmer.com>
References: <20131202193459.GL26766@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bitmer.com ([213.157.87.50]:48174 "EHLO bitmer.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753815Ab3LCQRH (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Dec 2013 11:17:07 -0500
In-Reply-To: <20131202193459.GL26766@atomide.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Tony Lindgren <tony@atomide.com>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Jarkko Lavinen <j.lavinen@samsung.com>

On 12/02/2013 07:34 PM, Tony Lindgren wrote:
> Commit 31ee9181eb92: (mmc: omap: Fix DMA configuration to not rely
> on device id) fixed getting of the DMA resources when booted with
> device tree. This patch however changed the handling of the
> free_mem_region() error path by reusing the struct resource *res
> for the DMA resources.
> 
> Fix the error the same way omap_hsmmc.c driver handles it, which
> is to restore the resource before using the values to call
> release_mem_region().
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
I guess my devm_ioremap conversion would have fixed this?

http://www.spinics.net/lists/linux-mmc/msg23317.html

Does not help now but I'm thinking if queuing some of those my patches
(3-5) on top of yours as a fix? Especially fix to NULL pointer dereference:

http://www.spinics.net/lists/linux-mmc/msg23320.html

-- 
Jarkko
