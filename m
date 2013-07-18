From: Daniel Mack <zonque@gmail.com>
Subject: Re: ARM: AM335x: Kernel oops when using EDMA and MMC
Date: Thu, 18 Jul 2013 18:47:10 +0200
Message-ID: <51E81C0E.6070709@gmail.com>
References: <51E6BE84.6080905@newflow.co.uk> <51E6C88B.8090608@ti.com> <51E81A7E.9030805@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ea0-f172.google.com ([209.85.215.172]:43874 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759107Ab3GRQqq (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 18 Jul 2013 12:46:46 -0400
In-Reply-To: <51E81A7E.9030805@ti.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Joel Fernandes <joelf@ti.com>, Mark Jackson <mpfj-list@newflow.co.uk>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Lindgren <tony@atomide.com>, Linux MMC List <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

Hi Balaji,

On 18.07.2013 18:40, Balaji T K wrote:
> With DMA channel info retrieved from dt binding on 3.11rc1,
> unused_chan_list is broken after hwmod cleanup removing mmc sdma
> resource info, hence pdev resource wont have DMA resource populated.
> 
> arch/arm/common/edma.c
> static int prepare_unused_channel_list(struct device *dev, void *data)
> {
> 	struct platform_device *pdev = to_platform_device(dev);
> 	int i, ctlr;
> 
> 	for (i = 0; i < pdev->num_resources; i++) {
> 		if ((pdev->resource[i].flags & IORESOURCE_DMA) &&
> 				(int)pdev->resource[i].start >= 0) {
> 			ctlr = EDMA_CTLR(pdev->resource[i].start);
> 			clear_bit(EDMA_CHAN_SLOT(pdev->resource[i].start),
> 					edma_cc[ctlr]->edma_unused);
> 		}
> 	}
> 
> 	return 0;
> }
> 
> int edma_alloc_channel(int channel,
> 	if (!unused_chan_list_done) {
> 		/*
> 		 * Scan all the platform devices to find out the EDMA channels
> 		 * used and clear them in the unused list, making the rest
> 		 * available for ARM usage.
> 		 */
> 		ret = bus_for_each_dev(&platform_bus_type, NULL, NULL,
> 				prepare_unused_channel_list);
> 		if (ret < 0)
> 			return ret;
> 
> 		unused_chan_list_done = true;
> 	}
> 
> ===========
> 
> with the below hack patch, edma is working fine with mmc on your 3.11rc1+ branch
> 
> diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
> index a432e6c..5a19164 100644
> --- a/arch/arm/common/edma.c
> +++ b/arch/arm/common/edma.c
> @@ -1262,8 +1262,8 @@ int edma_start(unsigned channel)
>   		if (test_bit(channel, edma_cc[ctlr]->edma_unused)) {
>   			pr_debug("EDMA: ESR%d %08x\n", j,
>   				edma_shadow0_read_array(ctlr, SH_ESR, j));
> -			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
> -			return 0;
> +//			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
> +//			return 0;
>   		}
> 
>   		/* EDMA channel with event association */
> 

Yes, this in fact works for me as well. Thanks for the quick reply! What
would be the proper fix for this?


Best,
Daniel


