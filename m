From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
Subject: Re: [PATCH] arch/avr32: Fix build failure for avr32 caused by typo
Date: Mon, 28 Dec 2009 10:59:30 +0100
Message-ID: <200912281059.30450.PeterHuewe@gmx.de>
References: <200912252008.45602.PeterHuewe@gmx.de> <20091228091318.454c4713@hcegtvedt.norway.atmel.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:46352 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751906AbZL1J7q (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 28 Dec 2009 04:59:46 -0500
In-Reply-To: <20091228091318.454c4713@hcegtvedt.norway.atmel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Haavard Skinnemoen <hskinnemoen@atmel.com>, Andrew Morton <akpm@linux-foundation.org>, Peter Ma <pma@mediamatech.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org

Am Montag 28 Dezember 2009 09:13:18 schrieb Hans-Christian Egtvedt:
> On Fri, 25 Dec 2009 20:08:45 +0100
> 
> Peter Huewe <PeterHuewe@gmx.de> wrote:
> > This patch fixes a build failure introduced by the patch
> >   atmel-mci: change use of dma slave interface by Nicolas Ferre
> > by changing mci_dma_slave to the correct name of mci_dma_data
> >
> > This should make the avr32 tree build again.
> 
> Ah, great, I have not gotten around to test this yet. Thanks for the
> patch. I've done some minor changes and also fixed the kzalloc/kfree
> error handling. Please see the inlined patch below.
> 

> @@ -1344,7 +1344,7 @@ at32_add_device_mci(unsigned int id, struct
>  mci_platform_data *data) ARRAY_SIZE(atmel_mci0_resource)))
>  		goto fail;
> 
> -	slave = kzalloc(sizeof(struct mci_dma_slave), GFP_KERNEL);
> +	slave = kzalloc(sizeof(struct mci_dma_data), GFP_KERNEL);
> 
>  	slave->sdata.dma_dev = &dw_dmac0_device.dev;
>  	slave->sdata.reg_width = DW_DMA_SLAVE_WIDTH_32BIT;


Great, thanks for the update.
The only thing that still catches my eye is that the kzalloc line can fail, so 
you should perhaps add something like
if (!slave) {
	printk(KERN_ERR "No memory left for at32ap700x: at32_add_device_mc");
	goto fail;
}

(not tested :)


Apart from that:
Acked-By: Peter Huewe <peterhuewe@gmx.de>


Thanks and best regards,
Peter
