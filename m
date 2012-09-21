From: "S, Venkatraman" <svenkatr-l0cyMroinI0@public.gmane.org>
Subject: Re: [RFC PATCH 08/13] mmc: omap_hsmmc: limit max_segs with the EDMA
	DMAC
Date: Fri, 21 Sep 2012 23:03:42 +0530
Message-ID: <CANfBPZ-q68qqpF0TvrY9HXH4mOjVE2j1T7+J0-aKKpg2ZaR+4g@mail.gmail.com>
References: <1348152226-13588-1-git-send-email-mporter@ti.com>
	<1348152226-13588-9-git-send-email-mporter@ti.com>
	<CANfBPZ81anOy8fWgKM1PgCtB4V2pEp2x1Qi4x1uPsq7QieMN5g@mail.gmail.com>
	<CANfBPZ-h7MD4X_NRYfwOmMnEyOKy0bTNNLNRmdbef2pe=2aHyg@mail.gmail.com>
	<20120921171840.GB10409@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20120921171840.GB10409-S8G//mZuvNWo5Im9Ml3/Zg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: balbi-l0cyMroinI0@public.gmane.org
Cc: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>, Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Fri, Sep 21, 2012 at 10:48 PM, Felipe Balbi <balbi-l0cyMroinI0@public.gmane.org> wrote:
> On Fri, Sep 21, 2012 at 10:47:30PM +0530, S, Venkatraman wrote:
>> On Fri, Sep 21, 2012 at 10:45 PM, S, Venkatraman <svenkatr-l0cyMroinI0@public.gmane.org> wrote:
>> > On Thu, Sep 20, 2012 at 8:13 PM, Matt Porter <mporter-l0cyMroinI0@public.gmane.org> wrote:
>> >> The EDMA DMAC has a hardware limitation that prevents supporting
>> >> scatter gather lists with any number of segments. Since the EDMA
>> >> DMA Engine driver sets the maximum segments to 16, we do the
>> >> same.
>> >>
>> >> Note: this can be removed once the DMA Engine API supports an
>> >> API to query the DMAC's segment limitations.
>> >>
>> >
>> > I wouldn't want to bind the properties of EDMA to omap_hsmmc as this patch
>> > suggests. Why don't we have a max_segs property, which when explicitly specified
>> > in DT, will override the default ?
>>
>> If you are adventurous, this can be a generic mmc DT binding instead
>> of restricting it to OMAP.
>
> I say if it's a limitation in the DMAC, then DMAC's driver should handle
> it, no ? Meaning that in this case you would copy from one multi-segment
> sg into a one-segment sg and when transfer is complete, before calling
> user's callback, copy data the other way around (?)
>

Right ! So even if the property is defined for MMC, Matt will end up coding the
limitation into every peripheral driver that uses EMAC, which doesn't scale.
Your solution is better.

------------------------------------------------------------------------------
Got visibility?
Most devs has no idea what their production app looks like.
Find out how fast your code is with AppDynamics Lite.
http://ad.doubleclick.net/clk;262219671;13503038;y?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
