From: Hans-Christian Noren Egtvedt <egtvedt@samfundet.no>
Subject: Re: [PATCH v2 1/2] mmc: atmel-mci: restore dma on AVR32
Date: Thu, 14 Jan 2016 13:43:53 +0100
Message-ID: <20160114124353.GA14996@samfundet.no>
References: <1452343511-11164-1-git-send-email-mans@mansr.com>
 <20160109193207.GA21906@samfundet.no>
 <CAPDyKFqazmLYGFFGg38MTKnbQOqGsMF03M08GsNiG0EFLVm6qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFqazmLYGFFGg38MTKnbQOqGsMF03M08GsNiG0EFLVm6qA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mans Rullgard <mans@mansr.com>, Haavard Skinnemoen <hskinnemoen@gmail.com>, Ludovic Desroches <ludovic.desroches@atmel.com>, Arnd Bergmann <arnd@arndb.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-mmc <linux-mmc@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

Around Thu 14 Jan 2016 13:07:57 +0100 or thereabout, Ulf Hansson wrote:
> On 9 January 2016 at 20:32, Hans-Christian Noren Egtvedt
> <egtvedt@samfundet.no> wrote:
>> Around Sat 09 Jan 2016 12:45:10 +0000 or thereabout, Mans Rullgard wrote:
>>> Commit ecb89f2f5f3e7 ("mmc: atmel-mci: remove compat for non DT board
>>> when requesting dma chan") broke dma on AVR32 and any other boards not
>>> using DT.  This restores a fallback mechanism for such cases.
>>>
>>> Signed-off-by: Mans Rullgard <mans@mansr.com>
>>> ---
>>> Changes:
>>> - rebase onto v4.4-rc8: no change to this patch
>>> ---
>>>  arch/avr32/mach-at32ap/at32ap700x.c | 16 ++++++++++++++++
>>>  drivers/mmc/host/atmel-mci.c        | 17 +++++++++++++++++
>>>  include/linux/atmel-mci.h           |  2 ++
>>>  3 files changed, 35 insertions(+)
>>
>> <snipp diff>
>>
>> Thank you for the patch. I have added this to the for-linux branch in the
>> linux-avr32 tree.
> 
> What does that mean? Do you intend to send this as a fix for 4.5 rc?
> 
> If so, you have my ack for it!
> 
> Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you. I might have been a bit quick to append it to my tree, as it
mostly touches things outside of arch/avr32. I have not asked Linus to pull
yet.

I can append your Acked-by to #1 and #2 in the series and push through my
tree if you are fine with that.

https://git.kernel.org/cgit/linux/kernel/git/egtvedt/linux-avr32.git/log/?h=for-linus

-- 
Best regards, Hans-Christian Egtvedt
