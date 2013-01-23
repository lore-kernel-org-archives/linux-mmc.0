From: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>
Subject: Re: [PATCH v5 07/14] dmaengine: add dma_request_slave_channel_compat()
Date: Wed, 23 Jan 2013 22:28:46 +0000
Message-ID: <201301232228.46716.arnd@arndb.de>
References: <1358281974-8411-1-git-send-email-mporter@ti.com>
	<1358281974-8411-8-git-send-email-mporter@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1358281974-8411-8-git-send-email-mporter-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=spi-devel-general>
List-Post: <mailto:spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/spi-devel-general>,
	<mailto:spi-devel-general-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: spi-devel-general-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Matt Porter <mporter-l0cyMroinI0@public.gmane.org>
Cc: Linux DaVinci Kernel List <davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>, Linux OMAP List <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Benoit Cousson <b-cousson-l0cyMroinI0@public.gmane.org>, Linux Documentation List <linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Linux MMC List <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Devicetree Discuss <devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, Mark Brown <broonie-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>, Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Rob Landley <rob-VoJi6FS/r0vR7s880joybQ@public.gmane.org>, Dan Williams <djbw-b10kYP2dOMg@public.gmane.org>, Linux SPI Devel List <spi-devel-general-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, Chris Ball <cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org>, Linux ARM Kernel List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On Tuesday 15 January 2013, Matt Porter wrote:
> Adds a dma_request_slave_channel_compat() wrapper which accepts
> both the arguments from dma_request_channel() and
> dma_request_slave_channel(). Based on whether the driver is
> instantiated via DT, the appropriate channel request call will be
> made.
> 
> This allows for a much cleaner migration of drivers to the
> dmaengine DT API as platforms continue to be mixed between those
> that boot using DT and those that do not.

I noticed today some drivers in linux-next that rely on this patch,
but the patch itself still missing from -next.

> --- a/include/linux/dmaengine.h
> +++ b/include/linux/dmaengine.h
> @@ -1047,6 +1047,16 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
>  struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
>  struct dma_chan *net_dma_find_channel(void);
>  #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
> +static inline struct dma_chan
> +*dma_request_slave_channel_compat(dma_cap_mask_t mask, dma_filter_fn fn,
> +                                 void *fn_param, struct device *dev,
> +                                 char *name)
> +{
> +       if (dev->of_node)
> +               return dma_request_slave_channel(dev, name);
> +       else
> +               return dma_request_channel(mask, fn, fn_param);
> +}

Hmm, dma_request_channel is actually a macro that passes mask by reference,
presumably because it can get modified by the filter function. Also, there
may be cases where we do have an of_node but don't use the dma binding
yet, or where dma_request_slave_channel doesn't actually use DT information
but rather one of the other methods that Vinod was talking about adding.

I think what it should look like instead is the below.

	Arnd

diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index bfcdecb..b6ffd7d 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -993,6 +993,19 @@ static inline void dma_release_channel(struct dma_chan *chan)
 }
 #endif
 
+static inline struct dma_chan *__dma_request_slave_channel_compat(dma_cap_mask_t *mask,
+				dma_filter_fn fn, void *fn_param, struct device *dev,
+				 char *name)
+{
+	struct dma_chan *chan;
+
+	chan = dma_request_slave_channel(dev, name);
+	if (chan)
+		return chan;
+
+	return __dma_request_channel(mask, fn, fn_param);
+}
+
 /* --- DMA device --- */
 
 int dma_async_device_register(struct dma_device *device);
@@ -1001,6 +1014,8 @@ void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
 struct dma_chan *dma_find_channel(enum dma_transaction_type tx_type);
 struct dma_chan *net_dma_find_channel(void);
 #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
+#define dma_request_slave_channel_compat(mask, x, y, dev, name) \
+	 __dma_request_slave_channel_compat(&(mask), x, y, dev, name)
 
 /* --- Helper iov-locking functions --- */
 

------------------------------------------------------------------------------
Master Visual Studio, SharePoint, SQL, ASP.NET, C# 2012, HTML5, CSS,
MVC, Windows 8 Apps, JavaScript and much more. Keep your skills current
with LearnDevNow - 3,200 step-by-step video tutorials by Microsoft
MVPs and experts. ON SALE this month only -- learn more at:
http://p.sf.net/sfu/learnnow-d2d
