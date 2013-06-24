From: Joel A Fernandes <agnel.joel-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v12 05/11] edma: config: Enable config options for EDMA
Date: Mon, 24 Jun 2013 09:48:37 -0500
Message-ID: <CAD=GYpYrkE--Snc-MoEdJRkUy5TfMY992kd0L--E6yPpMoRaxQ@mail.gmail.com>
References: <1371762407-24544-1-git-send-email-joelagnel@ti.com>
	<201306212044.26677.arnd@arndb.de>
	<CAD=GYpY4koXd9f6_ijQfDHsiULD4d53cdu=9X421WXSAit_YQg@mail.gmail.com>
	<201306220014.16427.arnd@arndb.de>
	<CAD=GYpabakChmN-TEJbLn6p=BwX2wsK5KWsc5gH9-cAA+yWcEA@mail.gmail.com>
	<51C83348.6040905@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <51C83348.6040905-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Cc: Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Koen Kooi <koen-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Jason Kridner <jkridner-hcmAuCOw+vXj4SYmN/TMmA@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Joel A Fernandes <joelagnel-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Andrew
List-Id: linux-mmc@vger.kernel.org

On Mon, Jun 24, 2013 at 6:53 AM, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org> wrote:
> On 6/22/2013 8:23 AM, Joel A Fernandes wrote:
>>>>> config TI_EDMA
>>>>>         tristate "TI EDMA support"
>>>>>         default m if 'ARCH_DAVINCI || ARCH_OMAP1 || ARCH_OMAP2
>>>>>         select DMA_ENGINE
>>>>>         select DMA_VIRTUAL_CHANNELS
>>>>
>>>>
>>>> MMC depends on EDMA specially on AM33xx there's no PIO mode AFAIK. The
>>>> 'm' option will require some initramfs to load the module when needing
>>>> to MMC boot, I suggest lets leave it as y.
>>>>
>>>
>>> Ah, right: you still export a filter function from the edma driver
>>> and use it in slave drivers:
>>>
>>> drivers/mmc/host/davinci_mmc.c:         dma_request_slave_channel_compat(mask, edma_filter_fn,
>>> drivers/mmc/host/davinci_mmc.c:         dma_request_slave_channel_compat(mask, edma_filter_fn,
>>> drivers/spi/spi-davinci.c:      dspi->dma_rx = dma_request_channel(mask, edma_filter_fn,
>>> drivers/spi/spi-davinci.c:      dspi->dma_tx = dma_request_channel(mask, edma_filter_fn,
>>>
>>> As long as this is the case, you have to be careful with the dependencies
>>> to make sure that davinci_mmc and spi-davinci either depend on TI_EDMA, or
>>> edma_filter_fn gets defined to NULL when you are building for a DT-only platform.
>>
>> Yes sure, right now they are defined  as follows in include/linux/edma.h:
>>
>> #if defined(CONFIG_TI_EDMA) || defined(CONFIG_TI_EDMA_MODULE)
>> bool edma_filter_fn(struct dma_chan *, void *);
>> #else
>> static inline bool edma_filter_fn(struct dma_chan *chan, void *param)
>> {
>> return false;
>> }
>> #endif
>>
>> This also has the side effect of causing DMA requests to fail if
>> TI_EDMA is not built, causing frustration for a lot of people some of
>> whom don't want to deal with DMA so I think it is OK to build the
>> driver in by default as it is (and will be) used by a lot of
>> OMAP2PLUS.
>
> Solution for this is to enable TI_EDMA in relevant defconfigs. Most
> folks who would get frustrated by such issues would be using defconfigs
> and for those who are building their configuration from scratch this
> will be pretty low in their list of worries.

Yes, it is not in omap2plus_defconfig either. I will post a patch to
add it to the same, and we can ignore the Kconfig defaults and select
patches.

Thanks,
Joel

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
