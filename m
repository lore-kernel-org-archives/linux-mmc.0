From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: mmc0: Invalid maximum block size, assuming 512 bytes
Date: Tue, 2 Feb 2016 13:30:39 +0200
Message-ID: <56B0935F.7080503@intel.com>
References: <569E575A.5070401@free.fr> <569EE03F.9090008@rock-chips.com>
 <56A0F2A1.3060805@free.fr> <56A18EFE.6000900@rock-chips.com>
 <56A1D791.9010803@free.fr> <56AFCEE0.1090005@free.fr>
 <56B06FD0.6000109@intel.com> <56B08106.9090708@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:16518 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754572AbcBBLeJ (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 2 Feb 2016 06:34:09 -0500
In-Reply-To: <56B08106.9090708@free.fr>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mason <slash.tmp@free.fr>, linux-mmc <linux-mmc@vger.kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Michal Simek <michal.simek@xilinx.com>, Soren Brinkmann <soren.brinkmann@xilinx.com>, Suman Tripathi <stripathi@apm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, Sebastian Frias <sf84@laposte.net>, Anton Vorontsov <anton@enomsg.org>, Pierre Ossman <pierre@ossman.eu>

On 02/02/16 12:12, Mason wrote:
> On 02/02/2016 09:58, Adrian Hunter wrote:
>> On 01/02/16 23:32, Mason wrote:
>>> On 22/01/2016 08:17, Mason wrote:
>>>
>>>> On 22/01/2016 03:07, Shawn Lin wrote:
>>>>
>>>>> On 2016/1/21 23:00, Mason wrote:
>>>>>
>>>>>> So that means I have to write code in
>>>>>> drivers/mmc/host/sdhci-of-arasan.c correct?
>>>>>
>>>>> It depends. If you think 512 block size if okay for you, leave it alone.
>>>>> Otherwise, add it in drivers/mmc/host/sdhci-of-arasan.c :)
>>>>
>>>> When I measured the read/write throughput to an attached
>>>> SD card, I got around 16 MB/s, and I thought raising the
>>>> block size might help with throughput?
>>>>
>>>> I'll test and report back.
>>>
>>> Haven't had time to test yet, but I wanted to ask experienced
>>> folks what to expect when raising the block size from 512 to
>>> 2048 bytes?
>>
>> mmc block driver sets block size to 512.
>>
>> What you are looking at is maximum block size.  SDIO uses bigger block
>> sizes, so it is useful for that.
> 
> You're right. I was looking at this block of code:
> 
> 	/*
> 	 * Maximum block size. This varies from controller to controller and
> 	 * is specified in the capabilities register.
> 	 */
> 	if (host->quirks & SDHCI_QUIRK_FORCE_BLK_SZ_2048) {
> 		mmc->max_blk_size = 2;
> 	} else {
> 		mmc->max_blk_size = (caps[0] & SDHCI_MAX_BLOCK_MASK) >>
> 				SDHCI_MAX_BLOCK_SHIFT;
> 		if (mmc->max_blk_size >= 3) {
> 			pr_warn("%s: Invalid maximum block size, assuming 512 bytes\n",
> 				mmc_hostname(mmc));
> 			mmc->max_blk_size = 0;
> 		}
> 	}
> 
> 	mmc->max_blk_size = 512 << mmc->max_blk_size;
> 
> 
> As Shawn pointed out, this was updated by commit 0633f654241
> 
> Author: Anton Vorontsov
> Date:   Tue Mar 17 00:14:03 2009 +0300
> 
>     sdhci: Add quirk for forcing maximum block size to 2048 bytes
>     
>     FSL eSDHC controllers can support maximum block size up to 4096 bytes,
>     the MBL (Maximum Block Length) field in the capabilities register
>     extended by one bit, and is set to 0x3.
>     
>     But the SDHCI core doesn't support blocks of 4096 bytes, and thus
>     forces blksz to the lowest value -- 512 bytes. With this patch we can
>     pin up the blksz to the maximum supported block size, i.e. 2048 bytes.
> 
> 
> But I'm wondering if the 2048-byte limitation in SDHCI core is
> still present?

The block size field of the Block Size register is only 12 bits, so yes.

> 
> I see some drivers apparently setting it to a higher value:
> 
> host/atmel-mci.c:	mmc->max_blk_size = 32768;
> host/dw_mmc.c:		mmc->max_blk_size = 65536;
> host/wbsd.c:		mmc->max_blk_size = 4087;

Sure, but not SDHCI.

