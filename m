From: Ludovic Desroches <ludovic.desroches@atmel.com>
Subject: Re: [PATCH v1 1/1] mmc: atmel-mci: allow DMA transfers for AVR32
Date: Thu, 6 Aug 2015 09:01:56 +0200
Message-ID: <20150806070156.GA19553@odux.rfo.atmel.com>
References: <1437998010-12036-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <7193821.HACahuU2Fv@wuerfel>
 <1438008334.29746.92.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eusmtp01.atmel.com ([212.144.249.243]:19735 "EHLO
	eusmtp01.atmel.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752978AbbHFHBs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 6 Aug 2015 03:01:48 -0400
Content-Disposition: inline
In-Reply-To: <1438008334.29746.92.camel@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

Hi Andy,

Your patch does a bit more than reverting commit ecb89f2f5f3e. I will
split it in order to see well which previous patches have been reverted.

On Mon, Jul 27, 2015 at 05:45:34PM +0300, Andy Shevchenko wrote:
> On Mon, 2015-07-27 at 14:24 +0200, Arnd Bergmann wrote:
> > On Monday 27 July 2015 14:53:30 you wrote:
> > > The commit ecb89f2f5f3e (mmc: atmel-mci: remove compat for non DT 
> > > board when
> > > requesting dma chan) removes compat transfer which breaks DMA
> > > support for ATNGW100. This patch returns back that functionality.
> > > 
> > > Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > 
> > How about moving that filter function into arch/avr32 to make the
> > mmc driver independent of the underlying dma engine implementation
> > at the same time?

It would be great to not keep code which becomes architecture dependant.
If we can move the filter function somewhere in arch/avr32, we will have
to revert commit fda1b26 and use dma_request_slave_channel_compat.

I had a look to the arch/avr32 directory but I don't know where to put
this kind of stuff.

> 
> It might be a good idea, but I'm neither an expert in avr32 nor have
> time right now to do this better. Consider this a bug report with a
> work around which works for me. I can test any better solution someone
> proposes.

Regards

Ludovic
