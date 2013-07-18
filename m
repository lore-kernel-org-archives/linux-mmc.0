From: Balaji T K <balajitk@ti.com>
Subject: Re: omap_hsmmc: race between omap_hsmmc_start_command() and DMA callback
Date: Thu, 18 Jul 2013 22:00:51 +0530
Message-ID: <51E8183B.5060100@ti.com>
References: <51E8127B.9090903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:33231 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932315Ab3GRQbP (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 18 Jul 2013 12:31:15 -0400
In-Reply-To: <51E8127B.9090903@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Daniel Mack <zonque@gmail.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>, Mark Jackson <mpfj-list@newflow.co.uk>, Joel Fernandes <joelf@ti.com>

On Thursday 18 July 2013 09:36 PM, Daniel Mack wrote:
> Hi,
>
> I'm facing a NULL pointer dereference in omap_hsmmc_start_command() on
> an AM33xx board running 3.11-rc1 (DMA enabled).
>
> A quick debug session showed that DMA engine timing leads to a very
> reproducable race condition. In omap_hsmmc_request(), we have:
>
>          host->mrq = req;
>          omap_hsmmc_prepare_data()
> 		omap_hsmmc_start_dma_transfer()
> 			tx->callback = omap_hsmmc_dma_callback;
>
> 	[*]
>
> 	omap_hsmmc_start_command()
> 		if (cmd == host->mrq->stop) [<-- oops]
> 			...
>
> It turns out that omap_hsmmc_dma_callback() (which sets host->mrq =
> NULL) is entered just after the DMA submission, and *before*
> omap_hsmmc_start_command() is called, consequently leading to an Oops.
>
> I can debug this in more depth, but maybe someone has an idea already?
>

Can you check with this hack patch in addition to other dependent patch
for adding edma nodes to dt[1] and slave sg limit [2]

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index a432e6c..5a19164 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1262,8 +1262,8 @@ int edma_start(unsigned channel)
  		if (test_bit(channel, edma_cc[ctlr]->edma_unused)) {
  			pr_debug("EDMA: ESR%d %08x\n", j,
  				edma_shadow0_read_array(ctlr, SH_ESR, j));
-			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
-			return 0;
+//			edma_shadow0_write_array(ctlr, SH_ESR, j, mask);
+//			return 0;
  		}

  		/* EDMA channel with event association */
-- 

[1] https://lkml.org/lkml/2013/6/18/49
[2] https://patchwork.kernel.org/patch/2228041/

>
> Thanks,
> Daniel
>

