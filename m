From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v1 1/1] mmc: atmel-mci: allow DMA transfers for AVR32
Date: Mon, 27 Jul 2015 14:24:58 +0200
Message-ID: <7193821.HACahuU2Fv@wuerfel>
References: <1437998010-12036-1-git-send-email-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.10]:56466 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399AbbG0MZG (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 27 Jul 2015 08:25:06 -0400
In-Reply-To: <1437998010-12036-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org

On Monday 27 July 2015 14:53:30 you wrote:
> The commit ecb89f2f5f3e (mmc: atmel-mci: remove compat for non DT board when
> requesting dma chan) removes compat transfer which breaks DMA
> support for ATNGW100. This patch returns back that functionality.
> 
> Cc: Ludovic Desroches <ludovic.desroches@atmel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 

How about moving that filter function into arch/avr32 to make the
mmc driver independent of the underlying dma engine implementation
at the same time?

	Arnd
