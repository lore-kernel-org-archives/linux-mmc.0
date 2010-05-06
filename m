From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
 	autoloading feature
Date: Thu, 6 May 2010 14:58:19 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387467@dbde02.ent.ti.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com>
	 <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C5387398@dbde02.ent.ti.com>
 <p2l618f0c911005060156oba391f39i4757b4e839e77448@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <p2l618f0c911005060156oba391f39i4757b4e839e77448@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-mmc@vger.kernel.org



> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of S, Venkatraman
> Sent: Thursday, May 06, 2010 2:27 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; Chikkature Rajashekar, Madhusudhan; Adrian
> Hunter; Kadiyala, Kishore; Tony Lindgren; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor autoloading feature
>
> Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
> >> -----Original Message-----
> >> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of Venkatraman S
> >> Sent: Wednesday, May 05, 2010 9:49 PM
> >> To: Shilimkar, Santosh
> >> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm-
> kernel@lists.arm.linux.org.uk;
> >> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Kadiyala, Kishore; Tony Lindgren
> >> Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor autoloading feature
> >>
> >> [Long sections have been trimmed to the context of discussion]
> >> Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
> >> >
> >> >> -----Original Message-----
> >> >> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of Venkatraman S
> >> >> Sent: Thursday, April 29, 2010 11:05 PM
> >> >> To: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm-
> kernel@lists.arm.linux.org.uk
> >> >> Cc: Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Kadiyala, Kishore; Shilimkar, Santosh;
> Tony
> >> >> Lindgren
> >> >> Subject: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor autoloading feature
> >> >>
> >> >> From 1c63dd42fc6c563c931168779ce73401332faa52 Mon Sep 17 00:00:00 2001
> >> >> From: Venkatraman S <svenkatr@ti.com>
> >> >> Date: Thu, 29 Apr 2010 22:43:31 +0530
> >> >> Subject: [PATCH 2/2] omap hsmmc: adaptation of sdma descriptor
> >> >> autoloading feature
> >> >>
> >> >> Start to use the sDMA descriptor autoloading feature.
> >> >> For large datablocks, the MMC driver has to repeatedly setup,
> >> >> program and teardown the dma channel for each element of the
> >> >> sglist received in omap_hsmmc_request.
> >> >>
> >> >> By using descriptor autoloading, transfers from / to each element of
> >> >> the sglist is pre programmed into a linked list. The sDMA driver
> >> >> completes the entire transaction and provides a single interrupt.
> >> >>
> >> >> Due to this, number of dma interrupts for a typical 100MB transfer on the MMC is
> >> >> reduced from 25000 to about 400 (approximate). Transfer speeds are
> >> >> improved by ~5%.
> >> >> (Though it varies on the size of read / write & improves on huge transfers)
> >> >>
> >> >> Descriptor autoloading is available only in 3630 and 4430 (as of now).
> >> >> Hence normal DMA mode is also retained.
> >> >>
> >> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> >> >> CC: Adrian Hunter <adrian.hunter@nokia.com>
> >> >> CC: Madhusudhan C <madhu.cr@ti.com>
> >> >> CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
> >> >> CC: Tony Lindgren <tony@atomide.com>
> >> >> ---
> >> >>  Changes since previous version
> >> >>   * Rebased to Adrian Hunter's interrupt syncronisation patch
> >> >>              https://patchwork.kernel.org/patch/94670/
> >> >>   * Rename ICR name definition
> >> >>  drivers/mmc/host/omap_hsmmc.c |  148 ++++++++++++++++++++++++++++++++++------
> >> >>  1 files changed, 125 insertions(+), 23 deletions(-)
> >> >>
> >> >> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
> >> >> index 65093d4..095fd94 100644
> >> >> --- a/drivers/mmc/host/omap_hsmmc.c
> >> >> +++ b/drivers/mmc/host/omap_hsmmc.c
> >> >> @@ -102,6 +102,8 @@
> >> >>  #define SRD                  (1 << 26)
> >> >>  #define SOFTRESET            (1 << 1)
> >> >>  #define RESETDONE            (1 << 0)
> >> >> +/* End of superblock indicator for sglist transfers */
> >> >> +#define DMA_ICR_SGLIST_END   0x4D00
> >> >>
> >> >>  /*
> >> >>   * FIXME: Most likely all the data using these _DEVID defines should come
> >> >> @@ -118,6 +120,12 @@
> >> >>  #define OMAP_MMC_MASTER_CLOCK        96000000
> >> >>  #define DRIVER_NAME          "mmci-omap-hs"
> >> >>
> >> >> +#define DMA_TYPE_NODMA       0
> >> > " DMA_TYPE_NODMA" doesn't make sense
> >> >> +#define DMA_TYPE_SDMA        1
> >> >> +#define DMA_TYPE_SDMA_DLOAD 2
> >> >
> >> > How about ??
> >> > #define TRANSFER_NODMA                  0
> >> > #define TRANSFER_SDMA_NORMAL            1
> >> > #define TRANSFER_SDMA_DESCRIPTOR        2
> >> > I think ADMA is also in pipeline, so it can become then
> >> > #define TRANSFER_ADMA_DESCRIPTOR        3
> >>
> >> Yes  I was planning to use 3 for ADMA, but the names don't
> >> make a big difference.
> >>
> > Good. Name does makes the difference when somebody reads the code.
> > " DMA_TYPE_NODMA" what you make out from this if somebody has no
> > background of what patch is doing.
>
> How about DMA_TYPE_NONE ?
>
Better
> >
> >> >> +
> >> >> +#define DMA_CTRL_BUF_SIZE    (PAGE_SIZE * 3)
> >> >> +
> >> >>  /* Timeouts for entering power saving states on inactivity, msec */
> >> >>  #define OMAP_MMC_DISABLED_TIMEOUT    100
> >> >>  #define OMAP_MMC_SLEEP_TIMEOUT               1000
> >> >> @@ -170,7 +178,11 @@ struct omap_hsmmc_host {
> >> >>       u32                     bytesleft;
> >> >>       int                     suspended;
> >> >>       int                     irq;
> >> >> -     int                     use_dma, dma_ch;
> >> >> +     int                     dma_caps;
> >> >> +     int                     dma_in_use;
> >> > This flag isn't necessary. What you are doing is
> >> > just renaming it. Can't you avoid that ??
> >> > Inudertand the intent behind "dma_in_use " instead
> >> > of "use_dma", but you can surely avoid this change.
> >>
> >> Actually there is a shift in the meaning of these variables
> >> so I believe the change is necessary.
> >> With my changes, the type of DMA to use (SDMA, SDMA_DESC_LOAD)
> >> [and in the future NODMA, ADMA] can vary on a per transfer basis.
> >> Previously use_dma was a static capability variable of whether DMA
> >> was available. That has been move to dma_caps. The dma_in_use,
> >> as the name more intuitively suggests, keeps track of the type of transfer
> >> used in the current transaction.
> >>
> > I still feel it's no necessary considering the no. of lines gets changed because
> > of this.
> > You take a call. I am fine with it.
> >>
> >> >>  {
> >> >>       unsigned int irq_mask;
> >> >>
> >> >> -     if (host->use_dma)
> >> >> +     if (host->dma_in_use)
> >> > This will go with no flag change.
> >>
> >> Explanation as above
> >>
> >> >>               irq_mask = INT_EN_MASK & ~(BRR_ENABLE | BWR_ENABLE);
> >> >>       else
> >> >>               irq_mask = INT_EN_MASK;
> >> >> @@ -813,7 +825,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
> >> >> *host, struct mmc_command *cmd,
> >> >>                       cmdreg &= ~(DDIR);
> >> >>       }
> >> >>
> >> >> -     if (host->use_dma)
> >> >> +     if (host->dma_in_use)
> >> > ditto
> >> >>               cmdreg |= DMA_EN;
> >> >>
> >> >>       host->req_in_progress = 1;
> > <snip ..>
> >
> >
> >> >> +static int omap_hsmmc_configure_sdma_sglist(struct omap_hsmmc_host *host,
> >> >> +             struct mmc_request *req)
> >> >> +{
> >> >> +     int i;
> >> >> +     struct omap_dma_sglist_node *sglist, *snode;
> >> >> +     struct mmc_data *data = req->data;
> >> >> +     int blksz;
> >> >> +     int dmadir = omap_hsmmc_get_dma_dir(host, data);
> >> >> +     struct omap_dma_sglist_type2a_params *t2p;
> >> >> +
> >> >> +     sglist = (struct omap_dma_sglist_node *) host->dma_ctrl_buf;
> >> >> +     snode = sglist;
> >> >> +     blksz = host->data->blksz;
> >> >> +
> >> >> +     if ((host->dma_len * sizeof(*snode)) > DMA_CTRL_BUF_SIZE) {
> >> >> +             dev_err(mmc_dev(host->mmc), "not enough sglist memory %d\n",
> >> >> +                     host->dma_len);
> >> >> +             return -ENOMEM;
> >> >> +     }
> >> >> +     for (i = 0; i < host->dma_len; snode++, i++) {
> >> >> +             snode->desc_type = OMAP_DMA_SGLIST_DESCRIPTOR_TYPE2a;
> >> >> +             snode->num_of_elem = blksz / 4;
> >> >> +             t2p = &snode->sg_node.t2a;
> >> >> +
> >> >> +             if (dmadir == DMA_FROM_DEVICE) {
> >> >> +                     t2p->src_addr = host->mapbase + OMAP_HSMMC_DATA;
> >> >> +                     t2p->dst_addr = sg_dma_address(data->sg + i);
> >> >> +             } else {
> >> >> +                     t2p->dst_addr = host->mapbase + OMAP_HSMMC_DATA;
> >> >> +                     t2p->src_addr = sg_dma_address(data->sg + i);
> >> >> +             }
> >> >> +             snode->flags =
> >> >> +                     OMAP_DMA_LIST_DST_VALID | OMAP_DMA_LIST_SRC_VALID;
> >> >> +
> >> >> +             t2p->cfn_fn = sg_dma_len(data->sg + i) / host->data->blksz;
> >> >> +             t2p->cicr = DMA_ICR_SGLIST_END;
> >> >> +
> >> >> +             t2p->dst_frame_idx_or_pkt_size = 0;
> >> >> +             t2p->src_frame_idx_or_pkt_size = 0;
> >> >> +             t2p->dst_elem_idx = 0;
> >> >> +             t2p->src_elem_idx = 0;
> >> >> +     }
> >> >> +     dev_dbg(mmc_dev(host->mmc), "new sglist %x len =%d\n",
> >> >> +                     host->dma_ctrl_buf_phy, i);
> >> >> +     omap_set_dma_sglist_mode(host->dma_ch, sglist,
> >> >> +                     host->dma_ctrl_buf_phy, i, NULL);
> >> >> +     omap_dma_set_sglist_fastmode(host->dma_ch, 1);
> >> >
> >> > You should check for return value of above two. If any one of above fails
> >> > the transfer will fail BADLY
> >>
> >> These functions have no return code (Similar to omap_start_dma, which doesn't
> >> have return code either)
> >
> > Are you sure ? Here is the function body.
> >
> > +int omap_set_dma_sglist_mode(int lch, struct omap_dma_sglist_node *sgparams,
> > +       dma_addr_t padd, int nelem, struct omap_dma_channel_params *chparams)
> > +{
> > +       struct omap_dma_list_config_params *lcfg;
> > +       int l = DMA_LIST_CDP_LISTMODE; /* Enable Linked list mode in CDP */
> > +
> > +       if ((dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT) == 0) {
> > +               printk(KERN_ERR "omap DMA: sglist feature not supported\n");
> > +               return -EPERM;
> > +       }
> > +       if (dma_chan[lch].flags & OMAP_DMA_ACTIVE) {
> > +               printk(KERN_ERR "omap DMA: configuring active DMA channel\n");
> > +               return -EPERM;
> > +       }
> > +
> > +       if (padd == 0) {
> > +               printk(KERN_ERR "omap DMA: sglist invalid dma_addr\n");
> > +               return -EINVAL;
> > +       }
> > +       lcfg = &dma_chan[lch].list_config;
> > +
> > +       lcfg->sghead = sgparams;
> > +       lcfg->num_elem = nelem;
> > +       lcfg->sgheadphy = padd;
> > +       lcfg->pausenode = -1;
> > +
> > +
> > +       if (NULL == chparams)
> > +               l |= DMA_LIST_CDP_FASTMODE;
> > +       else
> > +               omap_set_dma_params(lch, chparams);
> > +
> > +       dma_write(l, CDP(lch));
> > +       dma_write(0, CCDN(lch)); /* Reset List index numbering */
> > +       /* Initialize frame and element counters to invalid values */
> > +       dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(lch));
> > +       dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(lch));
> > +
> > +       return dma_sglist_set_phy_params(sgparams, lcfg->sgheadphy,
> > +                       nelem, dma_read(CICR(lch)));
> > +
> > +}
> >
>  OK. I missed that.
> >
> >>
> >> >> +     return 0;
> >> >> +}
> >> >> +
> >> >>  static void set_data_timeout(struct omap_hsmmc_host *host,
> >> >>                            unsigned int timeout_ns,
> >> >>                            unsigned int timeout_clks)
> >> >> @@ -1420,14 +1492,23 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_host
> >> >> *host, struct mmc_request *req)
> >> >>                                       | (req->data->blocks << 16));
> >> >>       set_data_timeout(host, req->data->timeout_ns, req->data->timeout_clks);
> >> >>
> >> >> -     if (host->use_dma) {
> >> >> -             ret = omap_hsmmc_start_dma_transfer(host, req);
> >> >> -             if (ret != 0) {
> >> >> -                     dev_dbg(mmc_dev(host->mmc), "MMC start dma failure\n");
> >> >> +     if (host->dma_caps & DMA_TYPE_SDMA) {
> >> >> +             ret = omap_hsmmc_configure_sdma(host, req);
> >> >> +             if (ret)
> >> >>                       return ret;
> >> >> -             }
> >> >> +             host->dma_in_use = DMA_TYPE_SDMA;
> >> >>       }
> >> >> -     return 0;
> >> >> +     if ((host->dma_caps & DMA_TYPE_SDMA_DLOAD) &&
> >> >> +             host->data->sg_len > 4) {
> >> >> +             ret = omap_hsmmc_configure_sdma_sglist(host, req);
> >> >> +             if (ret)
> >> >> +                     return ret;
> >> >> +             host->dma_in_use = DMA_TYPE_SDMA_DLOAD;
> >> >> +
> >> >> +     }
> >> >> +     ret = omap_hsmmc_start_dma_transfer(host);
> >> >> +     return ret;
> >> >> +
> >> >>  }
> >> >>
> >> >>  /*
> >> >> @@ -2007,7 +2088,9 @@ static int __init omap_hsmmc_probe(struct
> >> >> platform_device *pdev)
> >> >>       host->mmc       = mmc;
> >> >>       host->pdata     = pdata;
> >> >>       host->dev       = &pdev->dev;
> >> >> -     host->use_dma   = 1;
> >> >> +     host->dma_caps  = DMA_TYPE_SDMA;
> >> >> +     host->dma_in_use        = DMA_TYPE_NODMA;
> >> >> +     host->dma_ctrl_buf = NULL;
> >> >>       host->dev->dma_mask = &pdata->dma_mask;
> >> >>       host->dma_ch    = -1;
> >> >>       host->irq       = irq;
> >> >> @@ -2088,6 +2171,15 @@ static int __init omap_hsmmc_probe(struct
> >> >> platform_device *pdev)
> >> >>                                                       " clk failed\n");
> >> >>       }
> >> >>
> >> >> +     if (cpu_is_omap44xx() || cpu_is_omap3630()) {
> >> > Can we avoid above by passing this part of platform data??
> >> > devices.c
> >>
> >> I am not clear about the method. The board files export the
> >> omap_mmc_platform_data.
> >> Does it imply that all board files have to change and export
> >> the capability so that it can be queried ?
> > No. You don't have to modify the board files. This would need
> > change in devices.c which common for all omap boards.
> >
> > I don't have a strong opinion on this point but just put forth an
> > alternate way to avoid such SOC specific check in drivers.
> > You can take call on this
>
> Thanks. I will go with Madhu's vote now. With ADMA and other features
> coming in, I'll think of a generic way to export the capabilities
> from the platform data.
>
One of the problem with such approaches is ones the code get merged it's not
revisited from improvements.
If Tony is ok with this I am fine too.

Regards,
Santosh

.
