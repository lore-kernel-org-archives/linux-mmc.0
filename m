From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 1/1] mmc: omap_hsmmc: DMA unmap only once in case of MMC error
Date: Mon, 07 Nov 2011 13:41:33 -0500
Message-ID: <m2pqh3zsf6.fsf@bob.laptop.org>
References: <1320683111-12577-1-git-send-email-balajitk@ti.com>
	<20111107182939.GF15294@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:46694 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751231Ab1KGSlx (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 7 Nov 2011 13:41:53 -0500
In-Reply-To: <20111107182939.GF15294@n2100.arm.linux.org.uk> (Russell King's
	message of "Mon, 7 Nov 2011 18:29:39 +0000")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Balaji T K <balajitk@ti.com>, linux-mmc@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Per Forlin <per.forlin@linaro.org>

Hi,

On Mon, Nov 07 2011, Russell King - ARM Linux wrote:
> On Mon, Nov 07, 2011 at 09:55:11PM +0530, Balaji T K wrote:
>> From: Per Forlin <per.forlin@linaro.org>
>> 
>> Reported by Russell King:
>> mmcblk0: error -84 transferring data, sector 149201, nr 64,
>> cmd response 0x900, card status 0xb00
>> mmcblk0: retrying using single block read
>> 
>> WARNING: at lib/dma-debug.c:811 check_unmap
>> omap_hsmmc omap_hsmmc.0: DMA-API: device driver tries to free DMA memory
>> it has not allocated [device address=0x0000000080933000] [size=20480 bytes]
>> 
>> In case of an error dma_unmap() is issued in omap_hsmmc_dma_cleanup()
>> and then again in omap_hsmmc_post_req(). Resolve this by clearing the
>> host_cookie to indicate there is no DMA mapped memory to unmap.
>> 
>> Signed-off-by: Per Forlin <per.forlin@linaro.org>
>> Tested-by: Balaji T K <balajitk@ti.com>
>> ---
>> Repost with my Tested-by
>
> Thanks.
>
> Tested-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks, pushed to mmc-next for 3.2.

-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
