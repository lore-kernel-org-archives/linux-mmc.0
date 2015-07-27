From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] mmc: atmel-mci: allow DMA transfers for AVR32
Date: Mon, 27 Jul 2015 17:45:34 +0300
Message-ID: <1438008334.29746.92.camel@linux.intel.com>
References: <1437998010-12036-1-git-send-email-andriy.shevchenko@linux.intel.com>
	 <7193821.HACahuU2Fv@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:19387 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752074AbbG0Oph (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 27 Jul 2015 10:45:37 -0400
In-Reply-To: <7193821.HACahuU2Fv@wuerfel>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On Mon, 2015-07-27 at 14:24 +0200, Arnd Bergmann wrote:
> On Monday 27 July 2015 14:53:30 you wrote:
> > The commit ecb89f2f5f3e (mmc: atmel-mci: remove compat for non DT 
> > board when
> > requesting dma chan) removes compat transfer which breaks DMA
> > support for ATNGW100. This patch returns back that functionality.
> > 
> > Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> 
> How about moving that filter function into arch/avr32 to make the
> mmc driver independent of the underlying dma engine implementation
> at the same time?

It might be a good idea, but I'm neither an expert in avr32 nor have
time right now to do this better. Consider this a bug report with a
work around which works for me. I can test any better solution someone
proposes.

> 
> 	Arnd

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
