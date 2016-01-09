From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH v2 1/2] mmc: atmel-mci: restore dma on AVR32
Date: Sat, 9 Jan 2016 20:32:07 +0100
Message-ID: <20160109193207.GA21906@samfundet.no>
References: <1452343511-11164-1-git-send-email-mans@mansr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1452343511-11164-1-git-send-email-mans@mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mans Rullgard <mans@mansr.com>
Cc: Haavard Skinnemoen <hskinnemoen@gmail.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Around Sat 09 Jan 2016 12:45:10 +0000 or thereabout, Mans Rullgard wrote:
> Commit ecb89f2f5f3e7 ("mmc: atmel-mci: remove compat for non DT board
> when requesting dma chan") broke dma on AVR32 and any other boards not
> using DT.  This restores a fallback mechanism for such cases.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> Changes:
> - rebase onto v4.4-rc8: no change to this patch
> ---
>  arch/avr32/mach-at32ap/at32ap700x.c | 16 ++++++++++++++++
>  drivers/mmc/host/atmel-mci.c        | 17 +++++++++++++++++
>  include/linux/atmel-mci.h           |  2 ++
>  3 files changed, 35 insertions(+)

<snipp diff>

Thank you for the patch. I have added this to the for-linux branch in the
linux-avr32 tree.

Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>

-- 
Best regards, HC
