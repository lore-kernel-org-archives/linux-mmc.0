From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH v2 2/2] mmc: atmel: get rid of struct mci_dma_data
Date: Sat, 9 Jan 2016 20:32:57 +0100
Message-ID: <20160109193257.GB21906@samfundet.no>
References: <1452343511-11164-1-git-send-email-mans@mansr.com>
 <1452343511-11164-2-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cassarossa.samfundet.no ([193.35.52.29]:54939 "EHLO
	cassarossa.samfundet.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755950AbcAITdC (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sat, 9 Jan 2016 14:33:02 -0500
Content-Disposition: inline
In-Reply-To: <1452343511-11164-2-git-send-email-mans@mansr.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Around Sat 09 Jan 2016 12:45:11 +0000 or thereabout, Mans Rullgard wrote:
> As struct mci_dma_data is now only used by AVR32, it is nothing but
> pointless indirection.  Replace it with struct dw_dma_slave in the
> AVR32 platform code and with a void pointer elsewhere.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> Changes:
> - rebase onto v4.4-rc8: some members of struct dw_dma_slave had been
>   renamed in an unsubmitted patch
> ---
>  arch/avr32/mach-at32ap/at32ap700x.c         | 21 ++++++++++-----------
>  drivers/mmc/host/atmel-mci.c                |  1 -
>  include/linux/atmel-mci.h                   |  2 +-
>  include/linux/platform_data/mmc-atmel-mci.h | 22 ----------------------
>  4 files changed, 11 insertions(+), 35 deletions(-)
>  delete mode 100644 include/linux/platform_data/mmc-atmel-mci.h

<snipp diff>

Thank you for the patch. I have added this to my for-linus branch in the
linux-avr32 tree.

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

-- 
Best regards, HC.
