From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/3] mmc: atmel-mci: stop using specific initcall
Date: Thu, 20 Nov 2014 15:13:30 +0100
Message-ID: <2872000.LCAfuO7RlQ@wuerfel>
References: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com> <2176441.d1sGy4JguN@wuerfel> <20141120140125.GI3639@ldesroches-Latitude-E6320>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.13]:53302 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751418AbaKTOOE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 20 Nov 2014 09:14:04 -0500
In-Reply-To: <20141120140125.GI3639@ldesroches-Latitude-E6320>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, nicolas.ferre@atmel.com, chris@printf.net

On Thursday 20 November 2014 15:01:25 Ludovic Desroches wrote:
> On Thu, Nov 20, 2014 at 12:10:25PM +0100, Arnd Bergmann wrote:
> > On Thursday 20 November 2014 11:07:54 Ludovic Desroches wrote:
> > > No more use late initcall to manage probing order. Use probe deferring
> > > if needed. Then use module_platform_driver and clean init/exit
> > > attributes.
> > > 
> > > Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > 
> > 
> > Do we need this backported into stable kernels? It seems that
> > the __init/__exit annotations will break things if you ever
> > tried to unbind the device or run into deferred probing on
> > earlier kernels.
> 
> Well, it is a bit complicated, if we backport it, then the mci driver
> could be probed before the dma controller. Requesting dma chan will fail
> and it will switch to pio mode.
> 
> So it has to be backported with the probe deferring. The issue is
> that probe deferring patch is based on other patches removing non-dt
> support which become useless only ine 3.19.
> 

Should we just have the __init/__exit removal in backports then?

	Arnd
