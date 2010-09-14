From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH V8] mmc : Add i.MX21 support to mxcmmc driver
Date: Tue, 14 Sep 2010 04:03:20 +0100
Message-ID: <20100914030318.GA10782@void.printf.net>
References: <20100909220110.12456.14417.stgit@srv002.fuzzey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:36246 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab0INDD1 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 13 Sep 2010 23:03:27 -0400
Content-Disposition: inline
In-Reply-To: <20100909220110.12456.14417.stgit@srv002.fuzzey.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Martin Fuzzey <mfuzzey@gmail.com>
Cc: Pavel Pisa <ppisa@pikron.com>, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org, Pierre Ossman <pierre@ossman.eu>, linux-arm-kernel@lists.infradead.org

Hi Pavel, Sascha, 

On Fri, Sep 10, 2010 at 12:02:44AM +0200, Martin Fuzzey wrote:
> Even though the i.MX21 SDHC module has the same revision number as the i.MX27
> one there are a few differences!!
>         Some interrupt enables are inverted.
>         FIFO is only 16 bits wide.
>         The argument is written to 2x16bit registers (vs 1x32).
>         Interrupts must be acknowledged via the INT_CNTR register.
>         Card clock must be enabled for each request.
> 	For writes DMA must be enabled on command response not before.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>
> 
> ---
> Changes from V7 (February 2010):
> Rebased to 2.6.36-rc3
> 
> arch/arm/mach-imx/clock-imx21.c |    4 +
> drivers/mmc/host/mxcmmc.c       |  153 ++++++++++++++++++++++++++++++---------
> 2 files changed, 120 insertions(+), 37 deletions(-)

Any feedback on this patch from Martin?  

https://patchwork.kernel.org/patch/178242/

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
