From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 0/3] omap_hsmmc DT DMA Client support
Date: Mon, 11 Feb 2013 12:34:15 -0500
Message-ID: <87y5eupxew.fsf@octavius.laptop.org>
References: <1359752479-29427-1-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1359752479-29427-1-git-send-email-mporter@ti.com> (Matt Porter's
	message of "Fri, 1 Feb 2013 16:01:16 -0500")
Sender: linux-kernel-owner@vger.kernel.org
To: Matt Porter <mporter@ti.com>
Cc: Venkatraman S <svenkatr@ti.com>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, Vinod Koul <vinod.koul@intel.com>, Tony Lindgren <tony@atomide.com>, Devicetree Discuss <devicetree-discuss@lists.ozlabs.org>, Linux OMAP List <linux-omap@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MMC List <linux-mmc@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Dan Williams <djbw@fb.com>, Jon Hunter <jon-hunter@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-mmc@vger.kernel.org

Hi Matt,

On Fri, Feb 01 2013, Matt Porter wrote:
> This series adds DT DMA Engine Client support to the omap_hsmmc.
> It leverages the generic DMA OF helpers in -next and the
> dma_request_slave_channel_compat() wrapper introduced in the
> AM33XX DMA Engine series to support DMA in omap_hsmmc on platforms
> booting via DT. These platforms include omap2/3/4/5 and am33xx.
>
> These patches were split out from the v5 version of the AM33XX DMA
> series and split from the EDMA-specific omap_hsmmc changes.

Thanks, pushed to mmc-next for 3.9.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
