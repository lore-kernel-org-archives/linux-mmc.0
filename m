From: Daniel Mack <zonque@gmail.com>
Subject: omap_hsmmc: race between omap_hsmmc_start_command() and DMA callback
Date: Thu, 18 Jul 2013 18:06:19 +0200
Message-ID: <51E8127B.9090903@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Sender: linux-omap-owner@vger.kernel.org
To: Balaji T K <balajitk@ti.com>
Cc: Linux MMC List <linux-mmc@vger.kernel.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>
List-Id: linux-mmc@vger.kernel.org

Hi,

I'm facing a NULL pointer dereference in omap_hsmmc_start_command() on
an AM33xx board running 3.11-rc1 (DMA enabled).

A quick debug session showed that DMA engine timing leads to a very
reproducable race condition. In omap_hsmmc_request(), we have:

        host->mrq = req;
        omap_hsmmc_prepare_data()
		omap_hsmmc_start_dma_transfer()
			tx->callback = omap_hsmmc_dma_callback;

	[*]

	omap_hsmmc_start_command()
		if (cmd == host->mrq->stop) [<-- oops]
			...

It turns out that omap_hsmmc_dma_callback() (which sets host->mrq =
NULL) is entered just after the DMA submission, and *before*
omap_hsmmc_start_command() is called, consequently leading to an Oops.

I can debug this in more depth, but maybe someone has an idea already?


Thanks,
Daniel

