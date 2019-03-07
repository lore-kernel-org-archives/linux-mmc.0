From: Robert Jarzmik <robert.jarzmik@free.fr>
Subject: Re: [PATCH] mmc: pxamci: fix enum type confusion
Date: Thu, 07 Mar 2019 20:15:39 +0100
Message-ID: <87mum65wdg.fsf@belgarion.home>
References: <20190307100948.570006-1-arnd@arndb.de>
        <20190307152029.GD20201@archlinux-ryzen>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307152029.GD20201@archlinux-ryzen> (Nathan Chancellor's
        message of "Thu, 7 Mar 2019 08:20:29 -0700")
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Nick Desaulniers <ndesaulniers@google.com>, Daniel Mack <daniel@zonque.org>, Linus Walleij <linus.walleij@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

Nathan Chancellor <natechancellor@gmail.com> writes:

> On Thu, Mar 07, 2019 at 11:09:19AM +0100, Arnd Bergmann wrote:
>> clang points out several instances of mismatched types in this drivers,
>> all coming from a single declaration:
>> 
>> drivers/mmc/host/pxamci.c:193:15: error: implicit conversion from enumeration type 'enum dma_transfer_direction' to
>>       different enumeration type 'enum dma_data_direction' [-Werror,-Wenum-conversion]
>>                 direction = DMA_DEV_TO_MEM;
>>                           ~ ^~~~~~~~~~~~~~
>> drivers/mmc/host/pxamci.c:212:62: error: implicit conversion from enumeration type 'enum dma_data_direction' to
>>       different enumeration type 'enum dma_transfer_direction' [-Werror,-Wenum-conversion]
>>         tx = dmaengine_prep_slave_sg(chan, data->sg, host->dma_len, direction,
>> 
>> The behavior is correct, so this must be a simply typo from
>> dma_data_direction and dma_transfer_direction being similarly named
>> types with a similar purpose.
>> 
>> Fixes: 6464b7140951 ("mmc: pxamci: switch over to dmaengine use")
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
