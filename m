From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH v12 09/11] spi: omap2-mcspi: convert to
	dma_request_slave_channel_compat()
Date: Fri, 21 Jun 2013 16:07:51 +0530
Message-ID: <51C42CFF.10002@ti.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<1371762407-24544-10-git-send-email-joelagnel@ti.com>
	<51C42A71.1090403@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <51C42A71.1090403-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/options/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.davincidsp.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: <davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
Errors-To: davinci-linux-open-source-bounces-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>Linux
List-Id: linux-mmc@vger.kernel.org

Fixing Mark's e-mail.

Mark,

On 6/21/2013 3:56 PM, Sourav Poddar wrote:
> Hi Mark,

> On Friday 21 June 2013 02:36 AM, Joel A Fernandes wrote:
>> From: Matt Porter<mporter-l0cyMroinI0@public.gmane.org>
>>
>> Convert dmaengine channel requests to use
>> dma_request_slave_channel_compat(). This supports the DT case of
>> platforms requiring channel selection from either the OMAP DMA or
>> the EDMA engine. AM33xx only boots from DT and is the only user
>> implementing EDMA so in the !DT case we can default to the OMAP DMA
>> filter.
>>
>> Signed-off-by: Matt Porter<mporter-l0cyMroinI0@public.gmane.org>
>> Acked-by: Mark Brown<broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
>> Signed-off-by: Joel A Fernandes<joelagnel-l0cyMroinI0@public.gmane.org>

[...]

> Acked-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> Tested-by: Sourav Poddar <sourav.poddar-l0cyMroinI0@public.gmane.org>
> 
> This patch can go independently and does not depend on the rest of the
> series.
> Can these patch be pulled?

We can resend the patch if you don't have it from the mailing list.

Thanks,
Sekhar
