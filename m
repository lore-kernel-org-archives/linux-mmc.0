From: Ulf Hansson <ulf.hansson@stericsson.com>
Subject: Re: [PATCH 1/4] mmc: mmci: Bugfix in pio read for small packets
Date: Fri, 7 Oct 2011 15:38:44 +0200
Message-ID: <4E8F00E4.5010702@stericsson.com>
References: <1317109568-17905-1-git-send-email-ulf.hansson@stericsson.com> <20111001160937.GF11710@n2100.arm.linux.org.uk> <4E895F6A.9070203@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog105.obsmtp.com ([207.126.144.119]:60183 "EHLO
	eu1sys200aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752608Ab1JGNjK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 7 Oct 2011 09:39:10 -0400
In-Reply-To: <4E895F6A.9070203@stericsson.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Stefan NILSSON9 <stefan.xk.nilsson@stericsson.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Lee Jones <lee.jones@linaro.org>

Stefan NILSSON9 wrote:
> Hi Russel,
> 
> On 10/01/2011 06:09 PM, Russell King - ARM Linux wrote:
>> Does this even work?  From the MMCI spec, I see no way for the MMCI
>> peripheral to know the size of the read/write on the APB bus.
>>
>> The APB bus signals the MMCI uses are:
>>
>> PCLK - APB bus clock
>> PRESETn - APB bus reset
>> PADDR[11:2] - APB bus address
>> PSEL - APB bus peripheral select
>> PENABLE - APB bus enable
>> PWRITE - APB bus write signal
>> PWDATA[31:0] - APB bus write data
>> PRDATA[31:0] - APB bus read data
>>
>> As you can see, nothing in that set indicates whether it's an 8-bit,
>> 16-bit or 32-bit access.
> 
>> Moreover, if you read the MMCIFifoCnt register writeup:
>>
>>    The MMCIFifoCnt register contains the remaining number of words to be
>>    written to or read from the FIFO. The FIFO counter loads the value
>>    from the data length register (see Data length register, MMCIDataLength
>>    on page 3-11) when the Enable bit is set in the data control register.
>>    If the data length is not word aligned (multiple of 4), the remaining
>>    1 to 3 bytes are regarded as a word.
>>
>> This suggests that we should be reading a 32-bit word and then storing
>> the relevant bytes from it.
> 
> Hmm, that is true. I will try to rework the patch to skip the case and 
> only do 32 bit reads. We do however need a patch since the current 
> "count" calculation is wrong (more info below). But it does in fact work.
> 
>> The other thing which concerns me is that the MMCI (ARM Ltd one at least)
>> only supports power-of-two block sizes.  So requesting a transfer of a
>> single block with a block size of 3 bytes is not supported by the ARM Ltd
>> MMCI.  (The way you end up with 1 to 3 bytes being received with ARM's
>> MMCI is if you're using a streaming transfer.)
> 
> This is true for the standard ARM block. We have however done some 
> modifications of the standard block and added support for SDIO which 
> also implies streaming transfers which can be non power of 2. So with 
> the current implementation:
> 
> 	readsl(base + MMCIFIFO, ptr, count >> 2);
> 
> when we get a request to read 3, 2 or 1 bytes (which our WLAN driver 
> actually requests from time to time), this will result in reading 0 
> words which is not correct. This was the original problem, but I might 
> have "overdone" the solution a bit. I will upload a new patch which 
> solves the original problem in a better way.
> 
>> The last thing I don't like about this patch is that this code is in a
>> really hot path - one which is absolutely critical for things to work -
>> and the need for the condition to be dealt with is only at the end of a
>> transfer, not each time the FIFO needs emptying.

In this hot path we already do a read of the FIFOCNT register for every 
loop in pio_read, won't this sometimes cause caches to flush and 
similar, thus cost quite a lot - at least a lot more than executing a 
switch/if sentence like Stefan added? Or do I miss something?

I were also thinking of a possible optimization of minimizing the total 
numbers of reads of the FIFOCNT register in pio_read. Basically we can 
make use of the RXFIFOHALFFULL irq/status to know when there is a 
"burst" available in the FIFO. Do you think this will be feasible for 
the ARM MMCI Pl18x IP as well? I mean the consequence of using 
RXFIFOHALFFULL will be less numbers of IRQ raised and then when reading 
data from the FIFO it will be done in larger chunks.

>>
>> Bear in mind that there are platforms with the ARM MMCI which must read
>> the data within a certain time or suffer overruns, and which have either
>> totally broken and useless DMA or no DMA capability at all (which are
>> the only platforms I have with a MMCI on.)

We could make use of the "likely" makro to make compiler optimizations 
of the code, is that a way forward do you think?

> 
> I will keep this in mind. We are fortunately blessed with a working DMA 
> in our platform, but for small SDIO transfers there is no point in 
> setting up a DMA job which is when we fall back to PIO mode.
> 
> Best Regards
> 
> Stefan Nilsson
> 

