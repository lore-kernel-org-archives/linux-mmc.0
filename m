From: Vinod Koul <vinod.koul-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [PATCH v2 3/3] spi: spi-davinci: convert to DMA engine API
Date: Wed, 22 Aug 2012 09:15:22 +0530
Message-ID: <1345607122.1895.44.camel@vkoul-udesk3>
References: <1345574589-24757-1-git-send-email-mporter@ti.com>
	<1345574589-24757-4-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1345574589-24757-4-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, 2012-08-21 at 14:43 -0400, Matt Porter wrote:
> Removes use of the DaVinci EDMA private DMA API and replaces
> it with use of the DMA engine API.
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
> ---

> +		struct dma_slave_config dma_rx_conf = {
> +			.direction = DMA_DEV_TO_MEM,
> +			.src_addr = (unsigned long)dspi->pbase + SPIBUF,
> +			.src_addr_width = data_type,
> +			.src_maxburst = 1,
what does 1 mean in this context? We define as number of units that
needs to be transfered, so are you sure that you want only one unit to
be dma'ed in a single burst. that seems like killing your dmac,
shouldn't you be using larger bursts for a better dma performance?


-- 
~Vinod


------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
