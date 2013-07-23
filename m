From: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH fix for v3.11 (repost)] dmaengine: shdma: fix a build
 failure on platforms with no DMA support
Date: Mon, 22 Jul 2013 19:41:12 -0700
Message-ID: <20130723024112.GA15637@quad.lixom.net>
References: <20130717235058.GA10683@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pb0-f45.google.com ([209.85.160.45]:51475 "EHLO
	mail-pb0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754917Ab3GWClK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 22 Jul 2013 22:41:10 -0400
Received: by mail-pb0-f45.google.com with SMTP id mc8so7776468pbc.4
        for <linux-mmc@vger.kernel.org>; Mon, 22 Jul 2013 19:41:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20130717235058.GA10683@verge.net.au>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: Vinod Koul <vinod.koul@intel.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Kevin Hilman <khilman@linaro.org>, Dan Murphy <dmurphy@ti.com>, linux-mmc@vger.kernel.org, linux-sh@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Chris Ball <cjb@laptop.org>, Magnus Damm <magnusdamm@gmail.com>

On Thu, Jul 18, 2013 at 08:50:58AM +0900, Simon Horman wrote:
> From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> 
> On platforms with no support for the shdma dmaengine driver build is
> currently failing with
> 
> drivers/built-in.o: In function `sh_mobile_sdhi_probe':
> drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to`shdma_chan_filter'
> 
> Fix the breakage by defining shdma_chan_filter to NULL in such
> configurations.
> 
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski+renesas@gmail.com>
> [horms+renesas@verge.net.au: Apply change to shdma-base.h instead of sh_dma.h]
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
> ---
>  include/linux/shdma-base.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> Hi Vinod,
> 
> please consider this fix from Guennadi for v3.11 which I have rebased on top of
> next-20130709. It fixes a build problem on a number of shmobile defconfigs
> including bockw.
> 
> Alternatively, I would be happy to take this through the renesas tree.
> 
> I posted this patch last week but I'm wondering if you missed it somehow.
> This patch resolves a regression in v3.11-rc1.

As mentioned on the other thread, I have applied this in the arm-soc fixes
branch for 3.11 now.


-Olof
