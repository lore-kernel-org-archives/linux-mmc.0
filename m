From: Balaji T K <balajitk@ti.com>
Subject: Re: [PATCH v3 0/2] omap_hsmmc DT DMA Client support
Date: Fri, 5 Apr 2013 18:28:36 +0530
Message-ID: <515ECA7C.4080604@ti.com>
References: <1362579128-5312-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1362579128-5312-1-git-send-email-mporter@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>, Chris Ball <cjb@laptop.org>
Cc: Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-mmc@vger.kernel.org

On Wednesday 06 March 2013 07:42 PM, Matt Porter wrote:
> Changes since v2:
> 	- dropped skip platform_get_resource_byname() patch
> Changes since v1:
> 	- rebase to 3.9-rc1, previous dependencies upstream
>
> This series adds DT DMA Engine Client support to the omap_hsmmc.
> It leverages the generic DMA OF helpers and the
> dma_request_slave_channel_compat() wrapper to support DMA in
> omap_hsmmc on platforms booting via DT. These platforms include
> omap2/3/4/5 and am33xx.
>
> These patches were split out from the v5 version of the AM33XX DMA
> series and split from the EDMA-specific omap_hsmmc changes.
>
> Matt Porter (2):
>    mmc: omap_hsmmc: convert to dma_request_slave_channel_compat()
>    mmc: omap_hsmmc: add generic DMA request support to the DT binding
>

Looks good to me
Acked-by: Balaji T K <balajitk@ti.com>

>   .../devicetree/bindings/mmc/ti-omap-hsmmc.txt      |   26 +++++++++++++++++++-
>   drivers/mmc/host/omap_hsmmc.c                      |   10 ++++++--
>   2 files changed, 33 insertions(+), 3 deletions(-)
>
