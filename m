From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH 2/3] mmc: atmel-mci: stop using specific initcall
Date: Thu, 20 Nov 2014 15:18:55 +0100
Message-ID: <20141120141855.GJ3639@ldesroches-Latitude-E6320>
References: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com>
 <2176441.d1sGy4JguN@wuerfel>
 <20141120140125.GI3639@ldesroches-Latitude-E6320>
 <2872000.LCAfuO7RlQ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.242]:50058 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751161AbaKTOSh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 09:18:37 -0500
Content-Disposition: inline
In-Reply-To: <2872000.LCAfuO7RlQ@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, chris@printf.net

On Thu, Nov 20, 2014 at 03:13:30PM +0100, Arnd Bergmann wrote:
> On Thursday 20 November 2014 15:01:25 Ludovic Desroches wrote:
> > On Thu, Nov 20, 2014 at 12:10:25PM +0100, Arnd Bergmann wrote:
> > > On Thursday 20 November 2014 11:07:54 Ludovic Desroches wrote:
> > > > No more use late initcall to manage probing order. Use probe deferring
> > > > if needed. Then use module_platform_driver and clean init/exit
> > > > attributes.
> > > > 
> > > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > > 
> > > 
> > > Do we need this backported into stable kernels? It seems that
> > > the __init/__exit annotations will break things if you ever
> > > tried to unbind the device or run into deferred probing on
> > > earlier kernels.
> > 
> > Well, it is a bit complicated, if we backport it, then the mci driver
> > could be probed before the dma controller. Requesting dma chan will fail
> > and it will switch to pio mode.
> > 
> > So it has to be backported with the probe deferring. The issue is
> > that probe deferring patch is based on other patches removing non-dt
> > support which become useless only ine 3.19.
> > 
> 
> Should we just have the __init/__exit removal in backports then?

Yes. Do you want me to split this patch in order to have ony one for
__init/__exit removal and another one for late_initcall removal?


Ludovic
