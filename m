From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 2/2] mmc: atmel: get rid of struct mci_dma_data
Date: Thu, 14 Jan 2016 13:10:07 +0100
Message-ID: <CAPDyKFoMmTvErNYqh2nuMPFATG68u8GnR4ZhqH5_dX_qEs323A@mail.gmail.com>
References: <1452343511-11164-1-git-send-email-mans@mansr.com>
	<1452343511-11164-2-git-send-email-mans@mansr.com>
	<20160109193257.GB21906@samfundet.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160109193257.GB21906@samfundet.no>
Sender: linux-kernel-owner@vger.kernel.org
To: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Cc: Mans Rullgard <mans@mansr.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 9 January 2016 at 20:32, Hans-Christian Noren Egtvedt
<egtvedt@samfundet.no> wrote:
> Around Sat 09 Jan 2016 12:45:11 +0000 or thereabout, Mans Rullgard wrote:
>> As struct mci_dma_data is now only used by AVR32, it is nothing but
>> pointless indirection.  Replace it with struct dw_dma_slave in the
>> AVR32 platform code and with a void pointer elsewhere.
>>
>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>> ---
>> Changes:
>> - rebase onto v4.4-rc8: some members of struct dw_dma_slave had been
>>   renamed in an unsubmitted patch
>> ---
>>  arch/avr32/mach-at32ap/at32ap700x.c         | 21 ++++++++++-----------
>>  drivers/mmc/host/atmel-mci.c                |  1 -
>>  include/linux/atmel-mci.h                   |  2 +-
>>  include/linux/platform_data/mmc-atmel-mci.h | 22 ----------------------
>>  4 files changed, 11 insertions(+), 35 deletions(-)
>>  delete mode 100644 include/linux/platform_data/mmc-atmel-mci.h
>
> <snipp diff>
>
> Thank you for the patch. I have added this to my for-linus branch in the
> linux-avr32 tree.

Again, I suppose that means you will send this as fix for 4.5 rc?

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

>
> Acked-by: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
>
> --
> Best regards, HC.
