From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH v2] mxcmmc: use dmaengine API
Date: Sun, 20 Feb 2011 19:31:36 +0000
Message-ID: <20110220193136.GA13266@void.printf.net>
References: <20110218092109.GG24426@pengutronix.de> <201102181437.02943.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:58430 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754256Ab1BTTbn (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sun, 20 Feb 2011 14:31:43 -0500
Content-Disposition: inline
In-Reply-To: <201102181437.02943.arnd@arndb.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Sascha Hauer <s.hauer@pengutronix.de>, linux-mmc@vger.kernel.org

Hi Sascha,

On Fri, Feb 18, 2011 at 02:37:02PM +0100, Arnd Bergmann wrote:
> On Friday 18 February 2011, Sascha Hauer wrote:
> > This switches the mxcmmc driver to use the dmaengine API. Unlike
> > the old one this one is always present in the tree, even if no DMA
> > is implemented, hence we can remove all the #ifdefs in from the driver.
> > The driver automatically switches to PIO mode if no DMA support or no
> > suitable channel is available.
> > 
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> The patch looks good to me, but shouldn't you also add a Kconfig
> dependency or select on CONFIG_DMA_ENGINE? I don't see where that
> gets set.
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

I've pushed this to mmc-next now, but please do reply to Arnd's Kconfig
question.

Thanks,

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
