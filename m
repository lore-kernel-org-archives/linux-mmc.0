From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/3] spi: spi-davinci: convert to DMA engine API
Date: Thu, 30 Aug 2012 19:46:32 +0530
Message-ID: <503F75C0.1050507@ti.com>
References: <1345684176-21472-1-git-send-email-mporter@ti.com>
	<1345684176-21472-4-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1345684176-21472-4-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>Linux, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Matt,

On 8/23/2012 6:39 AM, Matt Porter wrote:
> Removes use of the DaVinci EDMA private DMA API and replaces
> it with use of the DMA engine API.
> 
> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>

I tried testing this patch on my OMAP-L138 EVM, but SPI fails to 
initialize after applying the patch.

root@arago:~# dmesg | grep -i spi                                               
spi_davinci spi_davinci.1: request RX DMA channel failed                        

without these 3 patches, SPI flash is detected fine (same kernel 
configuration):

root@arago:~# dmesg | grep spi                                                  
spi_davinci spi_davinci.1: DMA: supported                                       
spi_davinci spi_davinci.1: DMA: RX channel: 18, TX channel: 19, event queue: 0  
spi_davinci spi_davinci.1: master is unqueued, this is deprecated               
m25p80 spi1.0: m25p64 (8192 Kbytes)                                             
spi_davinci spi_davinci.1: Controller at 0xfef0e000                             

Any idea what could be wrong? This is v3.6-rc3 kernel. I can provide 
full bootlogs or any other debug information if that helps.

Thanks,
Sekhar

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
