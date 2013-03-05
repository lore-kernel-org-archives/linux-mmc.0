From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2 0/3] omap_hsmmc DT DMA Client support
Date: Tue, 5 Mar 2013 21:26:01 +0000
Message-ID: <201303052126.01572.arnd@arndb.de>
References: <1362518004-7083-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362518004-7083-1-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Balaji T K <balajitk@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Dan Williams <djbw@fb.com>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 05 March 2013, Matt Porter wrote:
> Changes since v1:
>         - rebase to 3.9-rc1, previous dependencies upstream
> 
> This series adds DT DMA Engine Client support to the omap_hsmmc.
> It leverages the generic DMA OF helpers in -next and the
> dma_request_slave_channel_compat() wrapper introduced in the
> AM33XX DMA Engine series to support DMA in omap_hsmmc on platforms
> booting via DT. These platforms include omap2/3/4/5 and am33xx.
> 
> These patches were split out from the v5 version of the AM33XX DMA
> series and split from the EDMA-specific omap_hsmmc changes.
> 

The description seems stale, but the patches all look good to me.

I guess they can now get merged in any order.

Acked-by: Arnd Bergmann <arnd@arndb.de>
