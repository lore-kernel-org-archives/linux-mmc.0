From: Will Newton <will.newton@gmail.com>
Subject: Re: [RESEND PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
Date: Wed, 8 Dec 2010 13:14:11 +0000
Message-ID: <AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wy0-f174.google.com ([74.125.82.174]:41751 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752247Ab0LHNON convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 8 Dec 2010 08:14:13 -0500
In-Reply-To: <20101208115510.GD10998@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>

On Wed, Dec 8, 2010 at 11:55 AM, Matt Fleming <matt@console-pimps.org> =
wrote:
> On Mon, Dec 06, 2010 at 03:53:10PM +0000, Will Newton wrote:
>> This adds the mmc host driver for the Synopsys DesignWare mmc
>> host controller, found in a number of embedded SoC designs.
>>
>> Signed-off-by: Will Newton <will.newton@imgtec.com>
>
> Comments below..

Thanks for the review!

>> +static void dw_mci_init_debugfs(struct dw_mci_slot *slot)
>> +{
>> + =A0 =A0 struct mmc_host *mmc =3D slot->mmc;
>> + =A0 =A0 struct dw_mci *host =3D slot->host;
>> + =A0 =A0 struct dentry *root;
>> + =A0 =A0 struct dentry *node;
>> +
>> + =A0 =A0 root =3D mmc->debugfs_root;
>> + =A0 =A0 if (!root)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>> +
>> + =A0 =A0 node =3D debugfs_create_file("regs", S_IRUSR, root, host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &dw_mci_regs_fops);
>> + =A0 =A0 if (IS_ERR(node))
>> + =A0 =A0 =A0 =A0 =A0 =A0 return;
>
> Should this be a goto err instead of return? I'm guessing this is
> meant to catch -ENODEV being returned when debugfs is not enabled in
> the kernel, but if we've compiled this code with CONFIG_DEBUG_FS then
> we probably want to know when this call fails.

I've removed that check, I don't think debugfs_create_file will return =
an error
other than NULL with CONFIG_DEBUG_FS enabled.

>> +static void dw_mci_set_timeout(struct dw_mci *host)
>> +{
>> + =A0 =A0 mci_writel(host, TMOUT, 0xffffffff); /* timeout (maximum) =
*/
>> +}
>> +
>
> Could do with an explicit 'inline'? Especially as it only has one
> callsite.

gcc is always going to inline it so I'd rather leave out the explicit
inline. That way if the code gets changed in future the inline hint
isn't going to become out of date.

>> +static void dw_mci_start_request(struct dw_mci *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
dw_mci_slot *slot)
>> +{
>> + =A0 =A0 struct mmc_request *mrq;
>> + =A0 =A0 struct mmc_command *cmd;
>> + =A0 =A0 struct mmc_data *data;
>> + =A0 =A0 u32 cmdflags;
>> +
>> + =A0 =A0 mrq =3D slot->mrq;
>> + =A0 =A0 /* no select the proper slot */
>> + =A0 =A0 if (host->pdata->select_slot)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->pdata->select_slot(slot->id);
>> +
>> + =A0 =A0 /* Slot specific timing and width adjustment */
>> + =A0 =A0 dw_mci_setup_bus(slot);
>> +
>> + =A0 =A0 host->cur_slot =3D slot;
>> + =A0 =A0 host->mrq =3D mrq;
>> +
>> + =A0 =A0 host->pending_events =3D 0;
>> + =A0 =A0 host->completed_events =3D 0;
>> + =A0 =A0 host->data_status =3D 0;
>> +
>> + =A0 =A0 data =3D mrq->data;
>> + =A0 =A0 if (data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_set_timeout(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, BYTCNT, data->blksz*data-=
>blocks);
>> + =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, BLKSIZ, data->blksz);
>> + =A0 =A0 }
>> +
>> + =A0 =A0 cmd =3D mrq->cmd;
>> + =A0 =A0 cmdflags =3D dw_mci_prepare_command(slot->mmc, cmd);
>> +
>> + =A0 =A0 /* this is the first command, lets send the initialization=
 clock */
>> + =A0 =A0 if (unlikely(
>> + =A0 =A0 =A0 =A0 =A0 =A0 test_and_clear_bit(DW_MMC_CARD_NEED_INIT, =
&slot->flags))) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmdflags |=3D SDMMC_CMD_INIT;
>> + =A0 =A0 }
>
> This unlikely seems a bit over the top and forces an unfortunate brea=
k
> in the line to keep within 80 cols. Maybe delete it?

Removed.

>> +static irqreturn_t dw_mci_interrupt(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct dw_mci *host =3D dev_id;
>> + =A0 =A0 u32 status, =A0pending;
>> + =A0 =A0 unsigned int pass_count =3D 0;
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 status =3D mci_readl(host, RINTSTS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 pending =3D mci_readl(host, MINTSTS);/* re=
ad only mask reg */
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* DTO fix - version 2.10a and below, an=
d only if internal DMA
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0* is configured.
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & DW_MCI_QUIRK_IDMAC_DTO)=
 {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!pending &&
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ((mci_readl(host, =
STATUS) >> 17) & 0x1fff))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pending |=3D=
 SDMMC_INT_DATA_OVER;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!pending)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pending & DW_MCI_CMD_ERROR_FLAGS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, RINTSTS, =
DW_MCI_CMD_ERROR_FLAGS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->cmd_status =3D statu=
s;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_wmb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EVENT_CMD_COMPLETE=
, &host->pending_events);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&host->ta=
sklet);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pending & DW_MCI_DATA_ERROR_FLAGS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* if there is an error, l=
ets report DATA_ERROR */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, RINTSTS, =
DW_MCI_DATA_ERROR_FLAGS);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data_status =3D stat=
us;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_wmb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EVENT_DATA_ERROR, =
&host->pending_events);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&host->ta=
sklet);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pending & SDMMC_INT_DATA_OVER) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, RINTSTS, =
SDMMC_INT_DATA_OVER);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->data_status)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data=
_status =3D status;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 smp_wmb();
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->dir_status =3D=3D=
 DW_MCI_RECV_STATUS) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->=
sg !=3D NULL)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dw_mci_read_data_pio(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EVENT_DATA_COMPLET=
E, &host->pending_events);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&host->ta=
sklet);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pending & SDMMC_INT_RXDR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, RINTSTS, =
SDMMC_INT_RXDR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->sg)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_rea=
d_data_pio(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pending & SDMMC_INT_TXDR) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, RINTSTS, =
SDMMC_INT_TXDR);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->sg)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_wri=
te_data_pio(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pending & SDMMC_INT_CMD_DONE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, RINTSTS, =
SDMMC_INT_CMD_DONE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_cmd_interrupt(host,=
 status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (pending & SDMMC_INT_CD) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_writel(host, RINTSTS, =
SDMMC_INT_CD);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 tasklet_schedule(&host->ca=
rd_tasklet);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 } while (pass_count++ < 5);
>
> This could do with a comment, explaining why it's necessary to loop 5
> times.

I'm not sure where that number comes from so I can't really add much
unfortunately. :-/

>> +static int __init dw_mci_init_slot(struct dw_mci *host, unsigned in=
t id)
>> +{
>> + =A0 =A0 struct mmc_host *mmc;
>> + =A0 =A0 struct dw_mci_slot *slot;
>> +
>> + =A0 =A0 mmc =3D mmc_alloc_host(sizeof(struct dw_mci_slot), &host->=
pdev->dev);
>> + =A0 =A0 if (!mmc)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> +
>> + =A0 =A0 slot =3D mmc_priv(mmc);
>> + =A0 =A0 slot->id =3D id;
>> + =A0 =A0 slot->mmc =3D mmc;
>> + =A0 =A0 slot->host =3D host;
>> +
>> + =A0 =A0 mmc->ops =3D &dw_mci_ops;
>> + =A0 =A0 mmc->f_min =3D DIV_ROUND_UP(host->bus_hz, 510);
>
> Is that really supposed to be 510, and not 512?

The maximum divider is 255*2 so 510 is the correct number. Strange but =
true.

>> +#ifndef _DW_MMC_H_
>> +#define _DW_MMC_H_
>> +
>> +#define MCI_SLOT =A0 =A0 =A0 =A0 =A0 =A0 0
>
> This appears to be unused.

Yep, removed.

I'll respin the patch and post a v2.
