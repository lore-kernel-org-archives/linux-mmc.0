From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v3 3/3] spi: spi-davinci: convert to DMA engine API
Date: Fri, 31 Aug 2012 21:32:18 +0530
Message-ID: <5040E00A.3080600@ti.com>
References: <1345684176-21472-1-git-send-email-mporter@ti.com>
	<1345684176-21472-4-git-send-email-mporter@ti.com>
	<503F75C0.1050507@ti.com> <20120830144307.GA26737@beef>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120830144307.GA26737@beef>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>Linux, List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

Hi Matt,

On 8/30/2012 8:13 PM, Matt Porter wrote:
> On Thu, Aug 30, 2012 at 07:46:32PM +0530, Sekhar Nori wrote:
>> Hi Matt,
>>
>> On 8/23/2012 6:39 AM, Matt Porter wrote:
>>> Removes use of the DaVinci EDMA private DMA API and replaces
>>> it with use of the DMA engine API.
>>>
>>> Signed-off-by: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
>>
>> I tried testing this patch on my OMAP-L138 EVM, but SPI fails to 
>> initialize after applying the patch.
>>
>> root@arago:~# dmesg | grep -i spi                                               
>> spi_davinci spi_davinci.1: request RX DMA channel failed                        
> 
> Hi Sekhar,
> 
> Most likely CONFIG_TI_EDMA is off as it defaults to off in the v3
> series. Try enabling this and if it's the problem then this error
> path can be fixed to properly fallback to PIO only or fail to
> initialize as needed.

Yes, this was the problem. Since the SPI driver now depends on
CONFIG_TI_EDMA for basic operation may be select CONFIG_TI_EDMA in
Kconfig if SPI is enabled? That should do until the fallback to PIO is
implemented.

With that fixed, I tested SPI on OMAP-L138 EVM and it works great.
Tested a JFFS2 mount as well as some raw chardev read/write tests.

Tested-by: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>

Thanks,
Sekhar

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
