From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor
	autoloading feature
Date: Wed, 5 May 2010 21:49:22 +0530
Message-ID: <v2i618f0c911005050919m600f069ex34ba1175315cde5a@mail.gmail.com>
References: <w2y618f0c911004291035qfec16290re9e236ae1e13a970@mail.gmail.com>
	 <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C52D16D2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
To: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.arm.linux.org.uk" <linux-arm-kernel@lists.arm.linux.org.uk>, "Chikkature Rajashekar, Madhusudhan" <madhu.cr@ti.com>, Adrian Hunter <adrian.hunter@nokia.com>, "Kadiyala, Kishore" <kishore.kadiyala@ti.com>, Tony Lindgren <tony@atomide.com>
List-Id: linux-mmc@vger.kernel.org

[Long sections have been trimmed to the context of discussion]
Shilimkar, Santosh <santosh.shilimkar@ti.com> wrote:
>
>> -----Original Message-----
>> From: svenkatr@gmail.com [mailto:svenkatr@gmail.com] On Behalf Of Ve=
nkatraman S
>> Sent: Thursday, April 29, 2010 11:05 PM
>> To: linux-omap@vger.kernel.org; linux-mmc@vger.kernel.org; linux-arm=
-kernel@lists.arm.linux.org.uk
>> Cc: Chikkature Rajashekar, Madhusudhan; Adrian Hunter; Kadiyala, Kis=
hore; Shilimkar, Santosh; Tony
>> Lindgren
>> Subject: [PATCH v8 2/2] omap hsmmc: adaptation of sdma descriptor au=
toloading feature
>>
>> From 1c63dd42fc6c563c931168779ce73401332faa52 Mon Sep 17 00:00:00 20=
01
>> From: Venkatraman S <svenkatr@ti.com>
>> Date: Thu, 29 Apr 2010 22:43:31 +0530
>> Subject: [PATCH 2/2] omap hsmmc: adaptation of sdma descriptor
>> autoloading feature
>>
>> Start to use the sDMA descriptor autoloading feature.
>> For large datablocks, the MMC driver has to repeatedly setup,
>> program and teardown the dma channel for each element of the
>> sglist received in omap_hsmmc_request.
>>
>> By using descriptor autoloading, transfers from / to each element of
>> the sglist is pre programmed into a linked list. The sDMA driver
>> completes the entire transaction and provides a single interrupt.
>>
>> Due to this, number of dma interrupts for a typical 100MB transfer o=
n the MMC is
>> reduced from 25000 to about 400 (approximate). Transfer speeds are
>> improved by ~5%.
>> (Though it varies on the size of read / write & improves on huge tra=
nsfers)
>>
>> Descriptor autoloading is available only in 3630 and 4430 (as of now=
).
>> Hence normal DMA mode is also retained.
>>
>> Signed-off-by: Venkatraman S <svenkatr@ti.com>
>> CC: Adrian Hunter <adrian.hunter@nokia.com>
>> CC: Madhusudhan C <madhu.cr@ti.com>
>> CC: Shilimkar Santosh <santosh.shilimkar@ti.com>
>> CC: Tony Lindgren <tony@atomide.com>
>> ---
>> =A0Changes since previous version
>> =A0 * Rebased to Adrian Hunter's interrupt syncronisation patch
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0https://patchwork.kernel.org/patch/94670/
>> =A0 * Rename ICR name definition
>> =A0drivers/mmc/host/omap_hsmmc.c | =A0148 ++++++++++++++++++++++++++=
++++++++------
>> =A01 files changed, 125 insertions(+), 23 deletions(-)
>>
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_h=
smmc.c
>> index 65093d4..095fd94 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -102,6 +102,8 @@
>> =A0#define SRD =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(1 << 26)
>> =A0#define SOFTRESET =A0 =A0 =A0 =A0 =A0 =A0(1 << 1)
>> =A0#define RESETDONE =A0 =A0 =A0 =A0 =A0 =A0(1 << 0)
>> +/* End of superblock indicator for sglist transfers */
>> +#define DMA_ICR_SGLIST_END =A0 0x4D00
>>
>> =A0/*
>> =A0 * FIXME: Most likely all the data using these _DEVID defines sho=
uld come
>> @@ -118,6 +120,12 @@
>> =A0#define OMAP_MMC_MASTER_CLOCK =A0 =A0 =A0 =A096000000
>> =A0#define DRIVER_NAME =A0 =A0 =A0 =A0 =A0"mmci-omap-hs"
>>
>> +#define DMA_TYPE_NODMA =A0 =A0 =A0 0
> " DMA_TYPE_NODMA" doesn't make sense
>> +#define DMA_TYPE_SDMA =A0 =A0 =A0 =A01
>> +#define DMA_TYPE_SDMA_DLOAD 2
>
> How about ??
> #define TRANSFER_NODMA =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
> #define TRANSFER_SDMA_NORMAL =A0 =A0 =A0 =A0 =A0 =A01
> #define TRANSFER_SDMA_DESCRIPTOR =A0 =A0 =A0 =A02
> I think ADMA is also in pipeline, so it can become then
> #define TRANSFER_ADMA_DESCRIPTOR =A0 =A0 =A0 =A03

Yes  I was planning to use 3 for ADMA, but the names don't
make a big difference.

>> +
>> +#define DMA_CTRL_BUF_SIZE =A0 =A0(PAGE_SIZE * 3)
>> +
>> =A0/* Timeouts for entering power saving states on inactivity, msec =
*/
>> =A0#define OMAP_MMC_DISABLED_TIMEOUT =A0 =A0100
>> =A0#define OMAP_MMC_SLEEP_TIMEOUT =A0 =A0 =A0 =A0 =A0 =A0 =A0 1000
>> @@ -170,7 +178,11 @@ struct omap_hsmmc_host {
>> =A0 =A0 =A0 u32 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 bytesleft;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspended;
>> =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq;
>> - =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_dma, dma_c=
h;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_caps;
>> + =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_in_use;
> This flag isn't necessary. What you are doing is
> just renaming it. Can't you avoid that ??
> Inudertand the intent behind "dma_in_use " instead
> of "use_dma", but you can surely avoid this change.

Actually there is a shift in the meaning of these variables
so I believe the change is necessary.
With my changes, the type of DMA to use (SDMA, SDMA_DESC_LOAD)
[and in the future NODMA, ADMA] can vary on a per transfer basis.
Previously use_dma was a static capability variable of whether DMA
was available. That has been move to dma_caps. The dma_in_use,
as the name more intuitively suggests, keeps track of the type of trans=
fer
used in the current transaction.


>> =A0{
>> =A0 =A0 =A0 unsigned int irq_mask;
>>
>> - =A0 =A0 if (host->use_dma)
>> + =A0 =A0 if (host->dma_in_use)
> This will go with no flag change.

Explanation as above

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_mask =3D INT_EN_MASK & ~(BRR_ENABLE =
| BWR_ENABLE);
>> =A0 =A0 =A0 else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_mask =3D INT_EN_MASK;
>> @@ -813,7 +825,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host
>> *host, struct mmc_command *cmd,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdreg &=3D ~(DDIR);
>> =A0 =A0 =A0 }
>>
>> - =A0 =A0 if (host->use_dma)
>> + =A0 =A0 if (host->dma_in_use)
> ditto
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdreg |=3D DMA_EN;
>>
>> =A0 =A0 =A0 host->req_in_progress =3D 1;
>> @@ -842,7 +854,7 @@ static void omap_hsmmc_request_done(struct
>> omap_hsmmc_host *host, struct mmc_req
>>
>> =A0 =A0 =A0 omap_hsmmc_disable_irq(host);
>> =A0 =A0 =A0 /* Do not complete the request if DMA is still in progre=
ss */
>> - =A0 =A0 if (mrq->data && host->use_dma && dma_ch !=3D -1)
>> + =A0 =A0 if (mrq->data && host->dma_in_use && dma_ch !=3D -1)
> ditto
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 host->mrq =3D NULL;
>> =A0 =A0 =A0 mmc_request_done(host->mmc, mrq);
>> @@ -920,7 +932,7 @@ static void omap_hsmmc_dma_cleanup(struct
>> omap_hsmmc_host *host, int errno)
>> =A0 =A0 =A0 host->dma_ch =3D -1;
>> =A0 =A0 =A0 spin_unlock(&host->irq_lock);
>>
>> - =A0 =A0 if (host->use_dma && dma_ch !=3D -1) {
>> + =A0 =A0 if (host->dma_in_use && dma_ch !=3D -1) {
> ditto
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), host->d=
ata->sg, host->dma_len,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_get_dma_dir(h=
ost, host->data));
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(dma_ch);
>> @@ -1266,7 +1278,6 @@ static void omap_hsmmc_config_dma_params(struc=
t
>> omap_hsmmc_host *host,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_get_dma_sync_=
dev(host, data),
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !(data->flags & MMC_DATA=
_WRITE));
>>
>> - =A0 =A0 omap_start_dma(dma_ch);
>> =A0}
>>
>> =A0/*
>> @@ -1279,21 +1290,23 @@ static void omap_hsmmc_dma_cb(int lch, u16
>> ch_status, void *cb_data)
>> =A0 =A0 =A0 int dma_ch, req_in_progress;
>>
>> =A0 =A0 =A0 if (ch_status & OMAP2_DMA_MISALIGNED_ERR_IRQ)
>> - =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc), "MISALIGNED_AD=
RS_ERR\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc), "Misaligned ad=
dress error\n");
>>
>> =A0 =A0 =A0 spin_lock(&host->irq_lock);
>> =A0 =A0 =A0 if (host->dma_ch < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->irq_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> =A0 =A0 =A0 }
>> -
>> - =A0 =A0 host->dma_sg_idx++;
>> - =A0 =A0 if (host->dma_sg_idx < host->dma_len) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 /* Fire up the next transfer. */
>> - =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_config_dma_params(host, data,
>> + =A0 =A0 if (host->dma_in_use =3D=3D DMA_TYPE_SDMA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_sg_idx++;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->dma_sg_idx < host->dma_len) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Fire up the next transf=
er. */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_config_dma_para=
ms(host, data,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0data->sg + host->dma_sg_idx);
>> - =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->irq_lock);
>> - =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_start_dma(host->dma_c=
h);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->irq_loc=
k);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> =A0 =A0 =A0 }
>>
>> =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_len=
,
>> @@ -1315,10 +1328,19 @@ static void omap_hsmmc_dma_cb(int lch, u16
>> ch_status, void *cb_data)
>> =A0 =A0 =A0 }
>> =A0}
>>
>> +static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *ho=
st)
>> +{
>> + =A0 =A0 if (host->dma_in_use =3D=3D DMA_TYPE_SDMA)
>> + =A0 =A0 =A0 =A0 =A0 =A0 omap_start_dma(host->dma_ch);
>> + =A0 =A0 else if (host->dma_in_use =3D=3D DMA_TYPE_SDMA_DLOAD)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return omap_start_dma_sglist_transfers(hos=
t->dma_ch, -1);
> Instead of "-1" , some macro for "NO_PAUSE" would have been better.
OK

>> +
>> + =A0 =A0 return 0;
>> +}
>> =A0/*
>> - * Routine to configure and start DMA for the MMC card
>> + * Routine to configure DMA for the MMC card
>> =A0 */
>> -static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *ho=
st,
>> +static int omap_hsmmc_configure_sdma(struct omap_hsmmc_host *host,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 struct mmc_request *req)
>> =A0{
>> =A0 =A0 =A0 int dma_ch =3D 0, ret =3D 0, i;
>> @@ -1359,6 +1381,56 @@ static int omap_hsmmc_start_dma_transfer(stru=
ct
>> omap_hsmmc_host *host,
>> =A0 =A0 =A0 return 0;
>> =A0}
>>
>> +static int omap_hsmmc_configure_sdma_sglist(struct omap_hsmmc_host =
*host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_request *req)
>> +{
>> + =A0 =A0 int i;
>> + =A0 =A0 struct omap_dma_sglist_node *sglist, *snode;
>> + =A0 =A0 struct mmc_data *data =3D req->data;
>> + =A0 =A0 int blksz;
>> + =A0 =A0 int dmadir =3D omap_hsmmc_get_dma_dir(host, data);
>> + =A0 =A0 struct omap_dma_sglist_type2a_params *t2p;
>> +
>> + =A0 =A0 sglist =3D (struct omap_dma_sglist_node *) host->dma_ctrl_=
buf;
>> + =A0 =A0 snode =3D sglist;
>> + =A0 =A0 blksz =3D host->data->blksz;
>> +
>> + =A0 =A0 if ((host->dma_len * sizeof(*snode)) > DMA_CTRL_BUF_SIZE) =
{
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(mmc_dev(host->mmc), "not enough sg=
list memory %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_len);
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 }
>> + =A0 =A0 for (i =3D 0; i < host->dma_len; snode++, i++) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 snode->desc_type =3D OMAP_DMA_SGLIST_DESCR=
IPTOR_TYPE2a;
>> + =A0 =A0 =A0 =A0 =A0 =A0 snode->num_of_elem =3D blksz / 4;
>> + =A0 =A0 =A0 =A0 =A0 =A0 t2p =3D &snode->sg_node.t2a;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (dmadir =3D=3D DMA_FROM_DEVICE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t2p->src_addr =3D host->ma=
pbase + OMAP_HSMMC_DATA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t2p->dst_addr =3D sg_dma_a=
ddress(data->sg + i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t2p->dst_addr =3D host->ma=
pbase + OMAP_HSMMC_DATA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 t2p->src_addr =3D sg_dma_a=
ddress(data->sg + i);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 snode->flags =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_DMA_LIST_DST_VALID | =
OMAP_DMA_LIST_SRC_VALID;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->cfn_fn =3D sg_dma_len(data->sg + i) /=
 host->data->blksz;
>> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->cicr =3D DMA_ICR_SGLIST_END;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->dst_frame_idx_or_pkt_size =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->src_frame_idx_or_pkt_size =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->dst_elem_idx =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 t2p->src_elem_idx =3D 0;
>> + =A0 =A0 }
>> + =A0 =A0 dev_dbg(mmc_dev(host->mmc), "new sglist %x len =3D%d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ctrl_buf_phy, i)=
;
>> + =A0 =A0 omap_set_dma_sglist_mode(host->dma_ch, sglist,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ctrl_buf_phy, i,=
 NULL);
>> + =A0 =A0 omap_dma_set_sglist_fastmode(host->dma_ch, 1);
>
> You should check for return value of above two. If any one of above f=
ails
> the transfer will fail BADLY

These functions have no return code (Similar to omap_start_dma, which d=
oesn't
have return code either)

>> + =A0 =A0 return 0;
>> +}
>> +
>> =A0static void set_data_timeout(struct omap_hsmmc_host *host,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int =
timeout_ns,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0unsigned int =
timeout_clks)
>> @@ -1420,14 +1492,23 @@ omap_hsmmc_prepare_data(struct omap_hsmmc_ho=
st
>> *host, struct mmc_request *req)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 | (req->data->blocks << 16));
>> =A0 =A0 =A0 set_data_timeout(host, req->data->timeout_ns, req->data-=
>timeout_clks);
>>
>> - =A0 =A0 if (host->use_dma) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_start_dma_transfer(host=
, req);
>> - =A0 =A0 =A0 =A0 =A0 =A0 if (ret !=3D 0) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(mmc_dev(host->mmc)=
, "MMC start dma failure\n");
>> + =A0 =A0 if (host->dma_caps & DMA_TYPE_SDMA) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_configure_sdma(host, re=
q);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> - =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_in_use =3D DMA_TYPE_SDMA;
>> =A0 =A0 =A0 }
>> - =A0 =A0 return 0;
>> + =A0 =A0 if ((host->dma_caps & DMA_TYPE_SDMA_DLOAD) &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->data->sg_len > 4) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D omap_hsmmc_configure_sdma_sglist(h=
ost, req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_in_use =3D DMA_TYPE_SDMA_DLOAD;
>> +
>> + =A0 =A0 }
>> + =A0 =A0 ret =3D omap_hsmmc_start_dma_transfer(host);
>> + =A0 =A0 return ret;
>> +
>> =A0}
>>
>> =A0/*
>> @@ -2007,7 +2088,9 @@ static int __init omap_hsmmc_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 host->mmc =A0 =A0 =A0 =3D mmc;
>> =A0 =A0 =A0 host->pdata =A0 =A0 =3D pdata;
>> =A0 =A0 =A0 host->dev =A0 =A0 =A0 =3D &pdev->dev;
>> - =A0 =A0 host->use_dma =A0 =3D 1;
>> + =A0 =A0 host->dma_caps =A0=3D DMA_TYPE_SDMA;
>> + =A0 =A0 host->dma_in_use =A0 =A0 =A0 =A0=3D DMA_TYPE_NODMA;
>> + =A0 =A0 host->dma_ctrl_buf =3D NULL;
>> =A0 =A0 =A0 host->dev->dma_mask =3D &pdata->dma_mask;
>> =A0 =A0 =A0 host->dma_ch =A0 =A0=3D -1;
>> =A0 =A0 =A0 host->irq =A0 =A0 =A0 =3D irq;
>> @@ -2088,6 +2171,15 @@ static int __init omap_hsmmc_probe(struct
>> platform_device *pdev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 " clk failed\n");
>> =A0 =A0 =A0 }
>>
>> + =A0 =A0 if (cpu_is_omap44xx() || cpu_is_omap3630()) {
> Can we avoid above by passing this part of platform data??
> devices.c

I am not clear about the method. The board files export the
omap_mmc_platform_data.
Does it imply that all board files have to change and export
the capability so that it can be queried ?

>> + =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ctrl_buf =3D dma_alloc_coherent(=
NULL,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 DMA_CTRL_BUF_SIZE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 &host->dma_ctrl_buf_phy,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->dma_ctrl_buf !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_caps |=3D DMA_TY=
PE_SDMA_DLOAD;
>> + =A0 =A0 }
>> +
>> =A0 =A0 =A0 /* Since we do only SG emulation, we can have as many se=
gs
>> =A0 =A0 =A0 =A0* as we want. */
> Not your patch but above commenting style isn't right
OK
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
