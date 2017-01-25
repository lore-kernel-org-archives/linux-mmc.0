From: Jan Glauber <jan.glauber@caviumnetworks.com>
Subject: Re: [PATCH] mmc: core: Pass node pointer to mmc_of_parse
Date: Wed, 25 Jan 2017 14:47:48 +0100
Message-ID: <20170125134748.GD3033@hardcore>
References: <20170121105956.13020-1-jglauber@cavium.com>
 <CAPDyKFo+q=eT9fWOkBVFtyHD0Nw1YgH7x4MMTNn_9UPK+FDPww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFo+q=eT9fWOkBVFtyHD0Nw1YgH7x4MMTNn_9UPK+FDPww@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On Tue, Jan 24, 2017 at 09:56:55AM +0100, Ulf Hansson wrote:
> On 21 January 2017 at 11:59, Jan Glauber <jglauber@cavium.com> wrote:
> > Extend mmc_of_parse to get the device node pointer as an
> > additional argument instead of using the device node of the
> > mmc device.
> >
> > While this has no effect for the current users it allows
> > mmc_of_parse to be used by mmc controllers with multiple slots
> > per device. These controllers can then pass the child node of the
> > slot.
> >
> > Signed-off-by: Jan Glauber <jglauber@cavium.com>
> > ---
> >  drivers/mmc/core/host.c            | 8 +++-----
> >  drivers/mmc/host/davinci_mmc.c     | 2 +-
> >  drivers/mmc/host/dw_mmc.c          | 2 +-
> >  drivers/mmc/host/meson-gx-mmc.c    | 2 +-
> >  drivers/mmc/host/mmci.c            | 2 +-
> >  drivers/mmc/host/moxart-mmc.c      | 2 +-
> >  drivers/mmc/host/mtk-sd.c          | 2 +-
> >  drivers/mmc/host/mvsdio.c          | 2 +-
> >  drivers/mmc/host/mxcmmc.c          | 2 +-
> >  drivers/mmc/host/mxs-mmc.c         | 2 +-
> >  drivers/mmc/host/omap_hsmmc.c      | 2 +-
> >  drivers/mmc/host/sdhci-bcm-kona.c  | 2 +-
> >  drivers/mmc/host/sdhci-brcmstb.c   | 2 +-
> >  drivers/mmc/host/sdhci-cadence.c   | 2 +-
> >  drivers/mmc/host/sdhci-dove.c      | 2 +-
> >  drivers/mmc/host/sdhci-esdhc-imx.c | 2 +-
> >  drivers/mmc/host/sdhci-iproc.c     | 2 +-
> >  drivers/mmc/host/sdhci-msm.c       | 2 +-
> >  drivers/mmc/host/sdhci-of-arasan.c | 2 +-
> >  drivers/mmc/host/sdhci-of-at91.c   | 2 +-
> >  drivers/mmc/host/sdhci-of-esdhc.c  | 2 +-
> >  drivers/mmc/host/sdhci-pic32.c     | 2 +-
> >  drivers/mmc/host/sdhci-pxav3.c     | 2 +-
> >  drivers/mmc/host/sdhci-s3c.c       | 2 +-
> >  drivers/mmc/host/sdhci-st.c        | 2 +-
> >  drivers/mmc/host/sdhci-tegra.c     | 2 +-
> >  drivers/mmc/host/sdhci_f_sdh30.c   | 2 +-
> >  drivers/mmc/host/sh_mmcif.c        | 2 +-
> >  drivers/mmc/host/sunxi-mmc.c       | 2 +-
> >  drivers/mmc/host/tmio_mmc_pio.c    | 2 +-
> >  drivers/mmc/host/usdhi6rol0.c      | 2 +-
> >  include/linux/mmc/host.h           | 2 +-
> >  32 files changed, 34 insertions(+), 36 deletions(-)
> >
> > diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> > index 98f25ff..444faac 100644
> > --- a/drivers/mmc/core/host.c
> > +++ b/drivers/mmc/core/host.c
> > @@ -171,25 +171,23 @@ static void mmc_retune_timer(unsigned long data)
> >  /**
> >   *     mmc_of_parse() - parse host's device-tree node
> >   *     @host: host whose node should be parsed.
> > + *     @np: node that should be parsed.
> >   *
> >   * To keep the rest of the MMC subsystem unaware of whether DT has been
> >   * used to to instantiate and configure this host instance or not, we
> >   * parse the properties and set respective generic mmc-host flags and
> >   * parameters.
> >   */
> > -int mmc_of_parse(struct mmc_host *host)
> > +int mmc_of_parse(struct mmc_host *host, struct device_node *np)
> >  {
> > -       struct device_node *np;
> >         u32 bus_width;
> >         int ret;
> >         bool cd_cap_invert, cd_gpio_invert = false;
> >         bool ro_cap_invert, ro_gpio_invert = false;
> >
> > -       if (!host->parent || !host->parent->of_node)
> > +       if (!np)
> >                 return 0;
> >
> > -       np = host->parent->of_node;
> > -
> 
> This doesn't work because of mmc_of_parse() calls the below functions,
> which uses the parent device associated with the mmc host.
> 
> 1) mmc_gpiod_request_cd()
> 2) mmc_gpiod_request_ro()
> 3) mmc_pwrseq_alloc()
> 
> Please have a look to see how we can change these first.

Yes, I've missed these. While 3) would be easy to adopt
I don't see how we can change 1) and 2) to parse the child nodes.

Both functions call devm_gpiod_get_index() which is agnostic to
DT nodes but uses the struct device *. So I think this kills my plan of
adopting mmc_of_parse, looks like I really need to create one device per
child node.

thanks,
Jan

> One way that might help to simplify the implementation could be to
> optionally store the of_node in the mmc host, while it's being
> allocated. When it's set, it could indicate we have a child/slot-node.
> Just an idea...
> 
> Kind regards
> Uffe
