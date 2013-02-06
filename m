From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/3] omap_hsmmc DT DMA Client support
Date: Wed, 6 Feb 2013 13:38:31 +0000
Message-ID: <201302061338.31241.arnd@arndb.de>
References: <1359752479-29427-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359752479-29427-1-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>, Chris Ball <cjb@laptop.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Dan Williams <djbw@fb.com>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Friday 01 February 2013, Matt Porter wrote:
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
> The series depends on the following patches:
> 
>         - dmaengine DT support and edma dmaengine driver fix from
>           the git://git.infradead.org/users/vkoul/slave-dma.git next
>           branch
>         - dma_request_slave_channel_compat() support
>           https://patchwork.kernel.org/patch/2081671/
> 
> The series with all dependencies can be found at
> https://github.com/ohporter/linux/tree/omap-hsmmc-dt-dmaengine-v1

Nice series,

Acked-by: Arnd Bergmann <arnd@arndb.de>
