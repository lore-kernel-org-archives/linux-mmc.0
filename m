From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 3/3 v2] at91/atmel-mci: inclusion of sd/mmc driver in
 at91sam9g45 chip and board
Date: Mon, 02 Nov 2009 18:14:20 +0100
Message-ID: <4AEF136C.8020005@atmel.com>
References: <20090930155557.7dae503b@hskinnemoen-d830> <a3b1332815576dc4d496937b8a5ab69d36818d00.1256314995.git.nicolas.ferre@atmel.com> <4AE55A93.1080106@visionsystems.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.atmel.fr ([81.80.104.162]:40766 "EHLO atmel-es2.atmel.fr"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751868AbZKBRP5 (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 2 Nov 2009 12:15:57 -0500
In-Reply-To: <4AE55A93.1080106@visionsystems.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: yegor_sub1@visionsystems.de, linux-mmc@vger.kernel.org
Cc: haavard.skinnemoen@atmel.com, akpm@linux-foundation.org, kernel@avr32linux.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Yegor Yefremov :
> Nicolas Ferre wrote:
>> This adds the support of atmel-mci sd/mmc driver in at91sam9g45 devices and
>> board files. This also configures the DMA controller slave interface for
>> at_hdmac dmaengine driver.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

[..]

>> +	/* DMA slave channel configuration */
>> +	slave->sdata.dma_dev = &at_hdmac_device.dev;
>> +	slave->sdata.reg_width = DW_DMA_SLAVE_WIDTH_32BIT;
> 
> slave->sdata.reg_width = AT_DMA_SLAVE_WIDTH_32BIT;
> 
>> +	slave->sdata.cfg = ATC_FIFOCFG_HALFFIFO
>> +			 | ATC_SRC_H2SEL_HW | ATC_DST_H2SEL_HW;

Queued for v3 of this patch (I will dissociate if from the patch series).


> Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Ok, I will add.

Thanks a lot.

Best regards,
-- 
Nicolas Ferre

