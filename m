From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Lower max_seg_size if too high for DMA
Date: Thu, 29 Nov 2018 21:11:17 +0100
Message-ID: <CAPDyKFpgOjr1Zp=31b-_+KVOnvRnXXdXt5e8b0X1pGNVAihtyA@mail.gmail.com>
References: <20181031155738.18367-1-tony@atomide.com>
 <CAPDyKFqtMHRjHsJXcKTTzGYSsyab=2SfWdYiETS4Bo2f7Zw2CQ@mail.gmail.com>
 <20181129191332.GY53235@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181129191332.GY53235@atomide.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Kishon <kishon@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Russell King <rmk+kernel@armlinux.org.uk>, linux-omap <linux-omap@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org

On Thu, 29 Nov 2018 at 20:13, Tony Lindgren <tony@atomide.com> wrote:
>
> * Ulf Hansson <ulf.hansson@linaro.org> [181119 12:09]:
> > On 31 October 2018 at 16:57, Tony Lindgren <tony@atomide.com> wrote:
> > > With CONFIG_DMA_API_DEBUG_SG a device may produce the following warning:
> > >
> > > "DMA-API: mapping sg segment longer than device claims to support"
> > >
> > > We default to 64KiB if a DMA engine driver does not initialize dma_parms
> > > and call dma_set_max_seg_size(). This may be lower that what many MMC
> > > drivers do with mmc->max_seg_size = mmc->max_blk_size * mmc->max_blk_count.
> > >
> > > Let's do a sanity check for max_seg_size being higher than what DMA
> > > supports in mmc_add_host() and lower it as needed.
> > >
> > > Cc: Kishon Vijay Abraham I <kishon@ti.com>
> > > Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> > > Cc: Russell King <rmk+kernel@armlinux.org.uk>
> > > Reported-by: Russell King <rmk+kernel@armlinux.org.uk>
> > > Signed-off-by: Tony Lindgren <tony@atomide.com>
> > > ---
> > >  drivers/mmc/core/host.c | 16 ++++++++++++++++
> > >  1 file changed, 16 insertions(+)
> > >
> > > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > > --- a/drivers/mmc/core/host.c
> > > +++ b/drivers/mmc/core/host.c
> > > @@ -13,6 +13,7 @@
> > >   */
> > >
> > >  #include <linux/device.h>
> > > +#include <linux/dma-mapping.h>
> > >  #include <linux/err.h>
> > >  #include <linux/idr.h>
> > >  #include <linux/of.h>
> > > @@ -415,6 +416,19 @@ struct mmc_host *mmc_alloc_host(int extra, struct device *dev)
> > >
> > >  EXPORT_SYMBOL(mmc_alloc_host);
> > >
> > > +static void mmc_check_max_seg_size(struct mmc_host *host)
> > > +{
> > > +       unsigned int max_seg_size = dma_get_max_seg_size(mmc_dev(host));
> >
> > Is dma_get_max_seg_size() really intended to be called for any struct
> > device (representing the mmc controller) like this?
> >
> > My understanding is that the dma_get_max_seg_size() is supposed to be
> > called by using the DMA engine device, no?
>
> Oh good catch sounds like I'm calling it for the wrong device,
> need to check. In that case sounds like this can't be generic?

No, I don't think so as it's only the mmc host driver that knows about
the DMA engine device.

Kind regards
Uffe
