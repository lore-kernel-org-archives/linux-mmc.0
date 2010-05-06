From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
 	autoloading feature
Date: Thu, 6 May 2010 13:35:06 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C5387398@dbde02.ent.ti.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com>
 <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
Content-Language: en-US
Sender: linux-omap-owner@vger.kernel.org
To: "S, Venkatraman" <svenkatr@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

> -----Original Message-----
> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of Ven=
katraman S
> Sent: Wednesday, May 05, 2010 9:49 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm-=
kernel@lists.arm.linux.org.uk;
> Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Kadiyala, Kishore;=
 Tony Lindgren
> Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor=
 autoloading feature
>=20
> [Long sections have been trimmed to the context of discussion]
> Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
> >
> >> -----Original Message-----
> >> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of =
Venkatraman S
> >> Sent: Thursday, April 29, 2010 11:05 PM
> >> To: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-a=
rm-kernel@lists.arm.linux.org.uk
> >> Cc: Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Kadiyala, K=
ishore; Shilimkar, Santosh; Tony
> >> Lindgren
> >> Subject: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor =
autoloading feature
> >>
> >> From 1c63dd42fc6c563c931168779ce73401332faa52 Mon Sep 17 00:00:00 =
2001
> >> From: Venkatraman S <svenkatr@ti.com>
> >> Date: Thu, 29 Apr 2010 22:43:31 +0530
> >> Subject: [PATCH 2/2] omap hsmmc: adaptation of sdma descriptor
> >> autoloading feature
> >>
> >> Start to use the sDMA descriptor autoloading feature.
> >> For large datablocks, the MMC driver has to repeatedly setup,
> >> program and teardown the dma channel for each element of the
> >> sglist received in omap_hsmmc_request.
> >>
> >> By using descriptor autoloading, transfers from / to each element =
of
> >> the sglist is pre programmed into a linked list. The sDMA driver
> >> completes the entire transaction and provides a single interrupt.
> >>
> >> Due to this, number of dma interrupts for a typical 100MB transfer=
 on the MMC is
> >> reduced from 25000 to about 400 (approximate). Transfer speeds are
> >> improved by ~5%.
> >> (Though it varies on the size of read / write & improves on huge t=
ransfers)
> >>
> >> Descriptor autoloading is available only in 3630 and 4430 (as of n=
ow).
> >> Hence normal DMA mode is also retained.
> >>
> >> Signed-off-by: Venkatraman S <svenkatr@ti.com>
> >> CC: Adrian Hunter <adrian.hunter@nokia.com>
> >> CC: Madhusudhan C <madhu.cr@ti.com>
> >> CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
> >> CC: Tony Lindgren <tony@atomide.com>
> >> ---
> >> =A0Changes since previous version
> >> =A0 * Rebased to Adrian Hunter's interrupt syncronisation patch
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0https://patchwork.kernel.org/patch/9467=
0/
> >> =A0 * Rename ICR name definition
> >> =A0drivers/mmc/host/omap_hsmmc.c | =A0148 ++++++++++++++++++++++++=
++++++++++------
> >> =A01 files changed, 125 insertions(+), 23 deletions(-)
> >>
> >> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap=
_hsmmc.c
> >> index 65093d4..095fd94 100644
> >> --- a/drivers/mmc/host/omap_hsmmc.c
> >> +++ b/drivers/mmc/host/omap_hsmmc.c
> >> @@ -102,6 +102,8 @@
> >> =A0#define SRD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 26)
> >> =A0#define SOFTRESET =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
> >> =A0#define RESETDONE =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
> >> +/* End of superblock indicator for sglist transfers */
> >> +#define DMA_ICR_SGLIST_END =A0 0x4D00
> >>
> >> =A0/*
> >> =A0 * FIXME: Most likely all the data using these _DEVID defines s=
hould come
> >> @@ -118,6 +120,12 @@
> >> =A0#define OMAP_MMC_MASTER_CLOCK =A0 =A0 =A0 =A096000000
> >> =A0#define DRIVER_NAME =A0 =A0 =A0 =A0 =A0"mmci-omap-hs"
> >>
> >> +#define DMA_TYPE_NODMA =A0 =A0 =A0 0
> > " DMA_TYPE_NODMA" doesn't make sense
> >> +#define DMA_TYPE_SDMA =A0 =A0 =A0 =A01
> >> +#define DMA_TYPE_SDMA_DLOAD 2
> >
> > How about ??
> > #define TRANSFER_NODMA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> > #define TRANSFER_SDMA_NORMAL =A0 =A0 =A0 =A0 =A0 =A01
> > #define TRANSFER_SDMA_DESCRIPTOR =A0 =A0 =A0 =A02
> > I think ADMA is also in pipeline, so it can become then
> > #define TRANSFER_ADMA_DESCRIPTOR =A0 =A0 =A0 =A03
>=20
> Yes  I was planning to use 3 for ADMA, but the names don't
> make a big difference.
>=20
Good. Name does makes the difference when somebody reads the code.
" DMA_TYPE_NODMA" what you make out from this if somebody has no
background of what patch is doing.

> >> +
> >> +#define DMA_CTRL_BUF_SIZE =A0 =A0(PAGE_SIZE * 3)
> >> +
> >> =A0/* Timeouts for entering power saving states on inactivity, mse=
c */
> >> =A0#define OMAP_MMC_DISABLED_TIMEOUT =A0 =A0100
> >> =A0#define OMAP_MMC_SLEEP_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 1000
> >> @@ -170,7 +178,11 @@ struct omap_hsmmc_host {
> >> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytesleft;
> >> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspended;
> >> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
> >> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_dma, dma=
_ch;
> >> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_caps;
> >> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_in_use;
> > This flag isn't necessary. What you are doing is
> > just renaming it. Can't you avoid that ??
> > Inudertand the intent behind "dma_in_use " instead
> > of "use_dma", but you can surely avoid this change.
>=20
> Actually there is a shift in the meaning of these variables
> so I believe the change is necessary.
> With my changes, the type of DMA to use (SDMA, SDMA_DESC_LOAD)
> [and in the future NODMA, ADMA] can vary on a per transfer basis.
> Previously use_dma was a static capability variable of whether DMA
> was available. That has been move to dma_caps. The dma_in_use,
> as the name more intuitively suggests, keeps track of the type of tra=
nsfer
> used in the current transaction.
>=20
I still feel it's no necessary considering the no. of lines gets change=
d because
of this.=20
You take a call. I am fine with it.
>=20
> >> =A0{
> >> =A0 =A0 =A0 unsigned int irq_mask;
> >>
> >> - =A0 =A0 if (host->use_dma)
> >> + =A0 =A0 if (host->dma_in_use)
> > This will go with no flag change.
>=20
> Explanation as above
>=20
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_mask =3D INT_EN_MASK & ~(BRR_ENABL=
E | BWR_ENABLE);
> >> =A0 =A0 =A0 else
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_mask =3D INT_EN_MASK;
> >> @@ -813,7 +825,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_hos=
t
> >> *host, struct mmc_command *cmd,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdreg &=3D ~(DDIR);
> >> =A0 =A0 =A0 }
> >>
> >> - =A0 =A0 if (host->use_dma)
> >> + =A0 =A0 if (host->dma_in_use)
> > ditto
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdreg |=3D DMA_EN;
> >>
> >> =A0 =A0 =A0 host->req_in_progress =3D 1;
<snip ..>


> >> +static int omap_hsmmc_configure_sdma_sglist(struct omap_hsmmc_hos=
t *host,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_request *req)
> >> +{
> >> + =A0 =A0 int i;
> >> + =A0 =A0 struct omap_dma_sglist_node *sglist, *snode;
> >> + =A0 =A0 struct mmc_data *data =3D req->data;
> >> + =A0 =A0 int blksz;
> >> + =A0 =A0 int dmadir =3D omap_hsmmc_get_dma_dir(host, data);
> >> + =A0 =A0 struct omap_dma_sglist_type2a_params *t2p;
> >> +
> >> + =A0 =A0 sglist =3D (struct omap_dma_sglist_node *) host->dma_ctr=
l_buf;
> >> + =A0 =A0 snode =3D sglist;
> >> + =A0 =A0 blksz =3D host->data->blksz;
> >> +
> >> + =A0 =A0 if ((host->dma_len * sizeof(*snode)) > DMA_CTRL_BUF_SIZE=
) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc), "not enough =
sglist memory %d\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_len);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> >> + =A0 =A0 }
> >> + =A0 =A0 for (i =3D 0; i < host->dma_len; snode++, i++) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 snode->desc_type =3D OMAP_DMA_SGLIST_DES=
CRIPTOR_TYPE2a;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 snode->num_of_elem =3D blksz / 4;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 t2p =3D &snode->sg_node.t2a;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (dmadir =3D=3D DMA_FROM_DEVICE) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t2p->src_addr =3D host->=
mapbase + OMAP_HSMMC_DATA;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t2p->dst_addr =3D sg_dma=
_address(data->sg + i);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t2p->dst_addr =3D host->=
mapbase + OMAP_HSMMC_DATA;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t2p->src_addr =3D sg_dma=
_address(data->sg + i);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 snode->flags =3D
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_LIST_DST_VALID =
| OMAP_DMA_LIST_SRC_VALID;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->cfn_fn =3D sg_dma_len(data->sg + i)=
 / host->data->blksz;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->cicr =3D DMA_ICR_SGLIST_END;
> >> +
> >> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->dst_frame_idx_or_pkt_size =3D 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->src_frame_idx_or_pkt_size =3D 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->dst_elem_idx =3D 0;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->src_elem_idx =3D 0;
> >> + =A0 =A0 }
> >> + =A0 =A0 dev_dbg(mmc_dev(host->mmc), "new sglist %x len =3D%d\n",
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ctrl_buf_phy, =
i);
> >> + =A0 =A0 omap_set_dma_sglist_mode(host->dma_ch, sglist,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ctrl_buf_phy, =
i, NULL);
> >> + =A0 =A0 omap_dma_set_sglist_fastmode(host->dma_ch, 1);
> >
> > You should check for return value of above two. If any one of above=
 fails
> > the transfer will fail BADLY
>=20
> These functions have no return code (Similar to omap_start_dma, which=
 doesn't
> have return code either)

Are you sure ? Here is the function body.

+int omap_set_dma_sglist_mode(int lch, struct omap_dma_sglist_node *sgp=
arams,
+	dma_addr_t padd, int nelem, struct omap_dma_channel_params *chparams)
+{
+	struct omap_dma_list_config_params *lcfg;
+	int l =3D DMA_LIST_CDP_LISTMODE; /* Enable Linked list mode in CDP */
+
+	if ((dma_caps0_status & DMA_CAPS_SGLIST_SUPPORT) =3D=3D 0) {
+		printk(KERN_ERR "omap DMA: sglist feature not supported\n");
+		return -EPERM;
+	}
+	if (dma_chan[lch].flags & OMAP_DMA_ACTIVE) {
+		printk(KERN_ERR "omap DMA: configuring active DMA channel\n");
+		return -EPERM;
+	}
+
+	if (padd =3D=3D 0) {
+		printk(KERN_ERR "omap DMA: sglist invalid dma_addr\n");
+		return -EINVAL;
+	}
+	lcfg =3D &dma_chan[lch].list_config;
+
+	lcfg->sghead =3D sgparams;
+	lcfg->num_elem =3D nelem;
+	lcfg->sgheadphy =3D padd;
+	lcfg->pausenode =3D -1;
+
+
+	if (NULL =3D=3D chparams)
+		l |=3D DMA_LIST_CDP_FASTMODE;
+	else
+		omap_set_dma_params(lch, chparams);
+
+	dma_write(l, CDP(lch));
+	dma_write(0, CCDN(lch)); /* Reset List index numbering */
+	/* Initialize frame and element counters to invalid values */
+	dma_write(OMAP_DMA_INVALID_FRAME_COUNT, CCFN(lch));
+	dma_write(OMAP_DMA_INVALID_ELEM_COUNT, CCEN(lch));
+
+	return dma_sglist_set_phy_params(sgparams, lcfg->sgheadphy,
+			nelem, dma_read(CICR(lch)));
+
+}


>=20
> >> + =A0 =A0 return 0;
> >> +}
> >> +
> >> =A0static void set_data_timeout(struct omap_hsmmc_host *host,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned in=
t timeout_ns,
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned in=
t timeout_clks)
> >> @@ -1420,14 +1492,23 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_=
host
> >> *host, struct mmc_request *req)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 | (req->data->blocks << 16));
> >> =A0 =A0 =A0 set_data_timeout(host, req->data->timeout_ns, req->dat=
a->timeout_clks);
> >>
> >> - =A0 =A0 if (host->use_dma) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_start_dma_transfer(ho=
st, req);
> >> - =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
> >> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mmc_dev(host->mm=
c), "MMC start dma failure\n");
> >> + =A0 =A0 if (host->dma_caps & DMA_TYPE_SDMA) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_configure_sdma(host, =
req);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> >> - =A0 =A0 =A0 =A0 =A0 =A0 }
> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_in_use =3D DMA_TYPE_SDMA;
> >> =A0 =A0 =A0 }
> >> - =A0 =A0 return 0;
> >> + =A0 =A0 if ((host->dma_caps & DMA_TYPE_SDMA_DLOAD) &&
> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->data->sg_len > 4) {
> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_configure_sdma_sglist=
(host, req);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_in_use =3D DMA_TYPE_SDMA_DLOAD=
;
> >> +
> >> + =A0 =A0 }
> >> + =A0 =A0 ret =3D omap_hsmmc_start_dma_transfer(host);
> >> + =A0 =A0 return ret;
> >> +
> >> =A0}
> >>
> >> =A0/*
> >> @@ -2007,7 +2088,9 @@ static int __init omap_hsmmc_probe(struct
> >> platform_device *pdev)
> >> =A0 =A0 =A0 host->mmc =A0 =A0 =A0 =3D mmc;
> >> =A0 =A0 =A0 host->pdata =A0 =A0 =3D pdata;
> >> =A0 =A0 =A0 host->dev =A0 =A0 =A0 =3D &pdev->dev;
> >> - =A0 =A0 host->use_dma =A0 =3D 1;
> >> + =A0 =A0 host->dma_caps =A0=3D DMA_TYPE_SDMA;
> >> + =A0 =A0 host->dma_in_use =A0 =A0 =A0 =A0=3D DMA_TYPE_NODMA;
> >> + =A0 =A0 host->dma_ctrl_buf =3D NULL;
> >> =A0 =A0 =A0 host->dev->dma_mask =3D &pdata->dma_mask;
> >> =A0 =A0 =A0 host->dma_ch =A0 =A0=3D -1;
> >> =A0 =A0 =A0 host->irq =A0 =A0 =A0 =3D irq;
> >> @@ -2088,6 +2171,15 @@ static int __init omap_hsmmc_probe(struct
> >> platform_device *pdev)
> >> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " clk failed\n");
> >> =A0 =A0 =A0 }
> >>
> >> + =A0 =A0 if (cpu_is_omap44xx() || cpu_is_omap3630()) {
> > Can we avoid above by passing this part of platform data??
> > devices.c
>=20
> I am not clear about the method. The board files export the
> omap_mmc_platform_data.
> Does it imply that all board files have to change and export
> the capability so that it can be queried ?
No. You don't have to modify the board files. This would need
change in devices.c which common for all omap boards.

I don't have a strong opinion on this point but just put forth an
alternate way to avoid such SOC specific check in drivers.
You can take call on this
>=20
> >> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ctrl_buf =3D dma_alloc_coheren=
t(NULL,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 DMA_CTRL_BUF_SIZE,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 &host->dma_ctrl_buf_phy,
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 0);
> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->dma_ctrl_buf !=3D NULL)
> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_caps |=3D DMA_=
TYPE_SDMA_DLOAD;
> >> + =A0 =A0 }
> >> +
> >> =A0 =A0 =A0 /* Since we do only SG emulation, we can have as many =
segs
> >> =A0 =A0 =A0 =A0* as we want. */
> > Not your patch but above commenting style isn't right
> OK
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
