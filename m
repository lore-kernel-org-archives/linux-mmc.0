From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v2 08/24] mmc: sdhci: avoid unnecessary mapping/unmapping
 of align buffer
Date: Mon, 4 Jan 2016 13:41:27 +0200
Message-ID: <568A5A67.3090908@intel.com>
References: <20151221113956.GA3712@n2100.arm.linux.org.uk>
 <E1aAypq-00016e-Lv@rmk-PC.arm.linux.org.uk> <56828E46.5090600@intel.com>
 <20160102122919.GX8644@n2100.arm.linux.org.uk>
 <20160102143123.GA5396@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:48484 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512AbcADLou (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 4 Jan 2016 06:44:50 -0500
In-Reply-To: <20160102143123.GA5396@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Marcin Wojtas <mw@semihalf.com>, Gregory CLEMENT <gregory.clement@free-electrons.com>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, linux-mmc@vger.kernel.org

On 02/01/16 16:31, Russell King - ARM Linux wrote:
> On Sat, Jan 02, 2016 at 12:29:19PM +0000, Russell King - ARM Linux wrote:
>> On Tue, Dec 29, 2015 at 03:44:38PM +0200, Adrian Hunter wrote:
>>> On 21/12/15 13:41, Russell King wrote:
>>>> Unnecessarily mapping and unmapping the align buffer for SD cards is
>>>> expensive: performance measurements on iMX6 show that this gives a hit
>>>> of 10% on hdparm buffered disk reads.
>>>>
>>>> MMC/SD card IO comes from the mm/vfs which gives us page based IO, so
>>>> for this case, the align buffer is not going to be used.  However, we
>>>> still map and unmap this buffer.
>>>>
>>>> Eliminate this by switching the align buffer to be a DMA coherent
>>>> buffer, which needs no DMA maintenance to access the buffer.
>>>
>>> Did you consider putting the align buffer in the same allocation
>>> as the adma_table?
>>
>> It's not clear whether host->adma_table_sz would be appropriately
>> aligned.
> 
> Looking at this closer, it would not be appropriately aligned to place
> the alignment buffer after the adma table, but placing the alignment
> buffer in the allocation first would give appropriate alignment.
> 
> The buffer sizes are:
> 
> Table		32-bit	64-bit
> alignment	512	1024		(entry sz * 128)
> adma		2056	3084		(desc sz * (128 * 2 + 1))
> 
> Allocating the two together gives advantages and disadvantages:
> 
> * for 32-bit address sizes, instead of allocating two order-0 pages,
>   we end up allocating one order-0 page, so halve the coherent DMA
>   allocation of the driver.
> 
> * for 64-bit address sizes, we allocate one order-1 page instead,
>   which may be more prone to failure with a 4k page size, and it
>   also means the ADMA table will overlap a page boundary.  I've no
>   idea whether that is an issue for any SDHCI controllers or not.
> 
> I could add additional complexity to do different allocations in the
> 32-bit and 64-bit paths, but that results in a _far_ more complicated
> cleanup path, and much more prone to errors.
> 
> In any case, such a patch should be entirely separate from _this_
> patch given that such a change may cause breakage and could need
> to be reworked as a result.  Indeed, it's a _separate_ change in
> itself, for a different purpose from _this_ patch.

Agreed.

