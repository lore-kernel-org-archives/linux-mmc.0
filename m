From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH] dw_mmc: Add Synopsys DesignWare mmc host driver.
Date: Thu, 9 Dec 2010 12:11:06 +0000
Message-ID: <AANLkTimMgrawcndvUTYYjq9BGFqs-sbRsZkwVQ0Uvhvb@mail.gmail.com>
References: <AANLkTi=0RtvsGX+Q3goL3mdG6oKeNidYtiudTZ8ZTpRP@mail.gmail.com>
	<20101208115510.GD10998@console-pimps.org>
	<AANLkTi=KqOa-MRQiptCtZGvoafRCgULfE3QFs=hmGpdi@mail.gmail.com>
	<AANLkTi=PpTi1_JO9Q=ph7w9Jim8iXMf9LbCfmEkWuo-h@mail.gmail.com>
	<20101209064751.GA21128@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:44912 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754521Ab0LIMLI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Dec 2010 07:11:08 -0500
In-Reply-To: <20101209064751.GA21128@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, linux-mmc@vger.kernel.org, Matt Fleming <matt@console-pimps.org>

On Thu, Dec 9, 2010 at 6:47 AM, Chris Ball <cjb@laptop.org> wrote:
> Hi Will,
>
> Thanks for the submission (and thanks for the review, Matt!).
>
> Some more comments below, mainly stylistic, and at the bottom I've
> attached an indentation and cleanup patch. =A0It's okay if there are
> some changes in it that you'd rather not make.
>
> On Wed, Dec 08, 2010 at 02:21:05PM +0000, Will Newton wrote:
>> +config MMC_DW_IDMAC
>> + =A0 =A0 depends on MMC_DW
>> + =A0 =A0 bool "Internal DMAC interface"
>> + =A0 =A0 help
>> + =A0 =A0 =A0 This selects support for the internal DMAC block withi=
n the Synopsys
>> + =A0 =A0 =A0 Designware Mobile Storage IP block. This disables the =
external DMA
>> + =A0 =A0 =A0 interface.
>> +
>
> Is there something we could depend on that would stop this driver bei=
ng
> presented to everyone, without being far too specific? =A0At the mome=
nt
> we'd be making x86 desktop users say whether they have this IP, which
> isn't good. =A0Are the architectures that use this IP already upstrea=
m?
> Are they all ARM architectures, for instance?

I don't know of any architectures upstream that use this IP block. Ther=
e is an
SoC from NXP that uses this it but it is not upstream:

http://ics.nxp.com/support/software/lpc313x.bsp.linux/

The architecture we tested and debugged this driver on is not upstream =
either
unfortunately. :-/

>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -0,0 +1,1806 @@
>> +/*
>> + * Synopsys DesignWare Multimedia Card Interface driver
>> + * =A0(Based on NXP driver for lpc 31xx)
>> + *
>
> Is the NXP driver publicly available? =A0If not, we can remove this l=
ine.
> The driver looks like it's based on our atmel-mci.c to me.

Yes, that too. ;-)

The driver is available at the link above, I can add the URL to the com=
ment
if that would be helpful.

> It'd be nice if you kerneldoc'd your data structures in the same styl=
e as
> atmel-mci does, and many of the locking comments in there apply direc=
tly
> to this driver.

Ok, I'll look into that.

>> + * Copyright (C) 2009 NXP Semiconductors
>> + * Copyright (C) 2009, 2010 Imagination Technologies Ltd.
>
> Hm, what's the relationship between NXP and Imagination here? =A0If
> you're submitting a driver with NXP copyright, I think we should have
> a Signed-off-by line from whomever owns the copyright/wrote that code=
=2E
> If that's you, that's fine, but it's unclear to me.

We both have SoCs with this IP block in it, other than that I don't thi=
nk
there has been any communication between NXP and Imagination about this=
 driver.
Hence the lack of SOB from the original authors.

The driver is available publically under the GPL, so it was my
understanding that
no SOB was required as long as we keep appropriate copyright credit in =
the code.

>> + *
>> + * This program is free software; you can redistribute it and/or mo=
dify
>> + * it under the terms of the GNU General Public License as publishe=
d by
>> + * the Free Software Foundation; either version 2 of the License, o=
r
>> + * (at your option) any later version.
>
> My patch snips from here until the end of this comment, to align with=
 the
> rest of MMC. =A0One reason not to include the FSF address in every so=
urce
> file is that it becomes wrong occasionally, like the address below. =A0=
:)

Good idea.

>> +#if defined(CONFIG_DEBUG_FS)
>> +/*
>> + * The debugfs stuff below is mostly optimized away when
>> + * CONFIG_DEBUG_FS is not set.
>> + */
>
> Don't think this comment needs to be here.

Agreed.

>> +static u32 dw_mci_prepare_command(struct mmc_host *mmc,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct=
 mmc_command *cmd)
>> +{
>> + =A0 =A0 struct mmc_data *data;
>> + =A0 =A0 u32 cmdr;
>> + =A0 =A0 cmd->error =3D -EINPROGRESS;
>> +
>> + =A0 =A0 cmdr =3D cmd->opcode;
>> +
>> + =A0 =A0 if (cmdr =3D=3D MMC_STOP_TRANSMISSION)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_STOP;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_PRV_DAT_WAIT;
>> +
>> + =A0 =A0 if (cmd->flags & MMC_RSP_PRESENT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_RESP_EXP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* expect the respond, need to set this bi=
t */
>
> I think the comment's referring to the line above, so it should be
> before it. =A0Also, s/respond/response/, and maybe it could be reword=
ed.

Ok.

>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cmd->flags & MMC_RSP_136)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_RESP_L=
ONG; /* expect long respond */
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (cmd->flags & MMC_RSP_CRC)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_RESP_CRC;
>> +
>> + =A0 =A0 data =3D cmd->data;
>> + =A0 =A0 if (data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_DAT_EXP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (data->flags & MMC_DATA_STREAM)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_STRM_M=
ODE; /* =A0set stream mode */
>
> I think both of these comments can be removed as obvious.

Ok.

>> + =A0 =A0 =A0 =A0 =A0 =A0 if (data->flags & MMC_DATA_WRITE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmdr |=3D SDMMC_CMD_DAT_WR=
;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return cmdr;
>> +}
>> +
>> +static void dw_mci_start_command(struct dw_mci *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct =
mmc_command *cmd, u32 cmd_flags)
>> +{
>> + =A0 =A0 host->cmd =3D cmd;
>> + =A0 =A0 dev_vdbg(&host->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "start command: ARGR=3D0x%=
08x CMDR=3D0x%08x\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->arg, cmd_flags);
>> +
>> + =A0 =A0 /* write to CMDARG register */
>> + =A0 =A0 mci_writel(host, CMDARG, cmd->arg);
>> + =A0 =A0 wmb();
>> +
>> + =A0 =A0 /* write to CMD register */
>> + =A0 =A0 mci_writel(host, CMD, cmd_flags | SDMMC_CMD_START);
>
> Again, these comments aren't very useful. =A0I do approve of comments=
 in
> general, honest, but they're supposed to say something that isn't
> apparent by just looking at the code.

Yes, these should go.

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
>
> Don't understand this comment.

Maybe a typo, "no" for "now"? I'll remove the comment.

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
>
> I think you mean:
> =A0 =A0 =A0 =A0/* If this is the first command, send the initializati=
on clock /*

Done.

>> + =A0 =A0 if (test_and_clear_bit(DW_MMC_CARD_NEED_INIT, &slot->flags=
))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmdflags |=3D SDMMC_CMD_INIT;
>> +
>> + =A0 =A0 /* we may need to move this code to mci_start_command */
>
> Has this question been resolved yet?

I've removed the comment, it doesn't appear to make logical sense to me=
=2E

>> +static int dw_mci_get_ro(struct mmc_host *mmc)
>> +{
>> + =A0 =A0 int read_only;
>> + =A0 =A0 struct dw_mci_slot *slot =3D mmc_priv(mmc);
>> + =A0 =A0 struct dw_mci_board *brd =3D slot->host->pdata;
>> +
>> + =A0 =A0 if (brd->get_ro !=3D NULL) {
>
> !=3D NULL isn't necessary here.

Ok.

>> + =A0 =A0 =A0 =A0 =A0 =A0 read_only =3D brd->get_ro(slot->id);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Try on board write protect */
>> + =A0 =A0 =A0 =A0 =A0 =A0 read_only =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mci_readl(slot->host, WRTP=
RT) & (1 << slot->id) ? 1 : 0;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 dev_dbg(&mmc->class_dev, "card is %s\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 read_only =
? "read-only" : "read-write");
>> +
>> + =A0 =A0 return read_only;
>> +}
>> +
>> +static int dw_mci_get_cd(struct mmc_host *mmc)
>> +{
>> + =A0 =A0 int present;
>> + =A0 =A0 struct dw_mci_slot *slot =3D mmc_priv(mmc);
>> + =A0 =A0 struct dw_mci_board *brd =3D slot->host->pdata;
>> +
>> + =A0 =A0 if (brd->get_cd !=3D NULL)
>
> (Same.)

Ok.

>> + =A0 =A0 =A0 =A0 =A0 =A0 present =3D !brd->get_cd(slot->id);
>> + =A0 =A0 else =A0 =A0/* try onboard card detect */
>> + =A0 =A0 =A0 =A0 =A0 =A0 present =3D (mci_readl(slot->host, CDETECT=
) & (1 << slot->id))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D=3D 0 ?=
 1 : 0;
>> +
>> + =A0 =A0 dev_dbg(&mmc->class_dev, "card is %spresent\n", present ? =
"" : "not ");
>
> I expanded this, since being able to grep for "not present" has some =
value.

Ok.

>> +
>> + =A0 =A0 return present;
>> +}
>> +
>> +static const struct mmc_host_ops dw_mci_ops =3D {
>> + =A0 =A0 .request =A0 =A0 =A0 =A0=3D dw_mci_request,
>> + =A0 =A0 .set_ios =A0 =A0 =A0 =A0=3D dw_mci_set_ios,
>> + =A0 =A0 .get_ro =A0 =A0 =A0 =A0 =3D dw_mci_get_ro,
>> + =A0 =A0 .get_cd =A0 =A0 =A0 =A0 =3D dw_mci_get_cd,
>> +};
>> +
>> +static void dw_mci_request_end(struct dw_mci *host, struct mmc_requ=
est *mrq)
>> + =A0 =A0 __releases(&host->lock)
>> + =A0 =A0 __acquires(&host->lock)
>> +{
>> + =A0 =A0 struct dw_mci_slot *slot;
>> + =A0 =A0 struct mmc_host *prev_mmc =3D host->cur_slot->mmc;
>> +
>> + =A0 =A0 WARN_ON(host->cmd || host->data);
>> +
>> + =A0 =A0 host->cur_slot->mrq =3D NULL;
>> + =A0 =A0 host->mrq =3D NULL;
>> + =A0 =A0 if (!list_empty(&host->queue)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 slot =3D list_entry(host->queue.next,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct dw_=
mci_slot, queue_node);
>> + =A0 =A0 =A0 =A0 =A0 =A0 list_del(&slot->queue_node);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_vdbg(&host->pdev->dev, "list not empty=
: %s is next\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_hostna=
me(slot->mmc));
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->state =3D STATE_SENDING_CMD;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_start_request(host, slot);
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_vdbg(&host->pdev->dev, "list empty\n")=
;
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->state =3D STATE_IDLE;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_unlock(&host->lock);
>> + =A0 =A0 mmc_request_done(prev_mmc, mrq);
>> +
>> + =A0 =A0 spin_lock(&host->lock);
>> +}
>> +
>> +static void dw_mci_command_complete(struct dw_mci *host,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct mmc_command *cmd)
>> +{
>> + =A0 =A0 u32 status =3D host->cmd_status;
>> +
>> + =A0 =A0 host->cmd_status =3D 0;
>> +
>> + =A0 =A0 /* Read the response from the card (up to 16 bytes) */
>> + =A0 =A0 if (cmd->flags & MMC_RSP_PRESENT) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cmd->flags & MMC_RSP_136) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->resp[3] =3D mci_readl=
(host, RESP0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->resp[2] =3D mci_readl=
(host, RESP1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->resp[1] =3D mci_readl=
(host, RESP2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->resp[0] =3D mci_readl=
(host, RESP3);
>
> It'd be nice to have a comment explaining why this is in reverse
> order, yet if RSP_136 is set we use RESP0 instead of RESP3.
>
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->resp[0] =3D mci_readl=
(host, RESP0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->resp[1] =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->resp[2] =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd->resp[3] =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (status & SDMMC_INT_RTO)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmd->error =3D -ETIMEDOUT;
>> + =A0 =A0 else if ((cmd->flags & MMC_RSP_CRC) && (status & SDMMC_INT=
_RCRC))
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmd->error =3D -EILSEQ;
>> + =A0 =A0 else if (status & SDMMC_INT_RESP_ERR)
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmd->error =3D -EIO;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 cmd->error =3D 0;
>> +
>> + =A0 =A0 if (cmd->error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* newer ip versions need a delay between =
retries */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (host->quirks & DW_MCI_QUIRK_RETRY_DELA=
Y)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mdelay(20);
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (cmd->data) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_stop_dma(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 }
>> +}
>> +
>> +static void dw_mci_tasklet_func(unsigned long priv)
>> +{
>> + =A0 =A0 struct dw_mci *host =3D (struct dw_mci *)priv;
>> + =A0 =A0 struct mmc_data *data;
>> + =A0 =A0 struct mmc_command *cmd;
>> + =A0 =A0 enum dw_mci_state state;
>> + =A0 =A0 enum dw_mci_state prev_state;
>> + =A0 =A0 u32 status;
>> +
>> + =A0 =A0 spin_lock(&host->lock);
>> +
>> + =A0 =A0 state =3D host->state;
>> + =A0 =A0 data =3D host->data;
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 prev_state =3D state;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (state) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STATE_IDLE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STATE_SENDING_CMD:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_clear_bit(EV=
ENT_CMD_COMPLETE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &host->pending_events))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cmd =3D host->cmd;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->cmd =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EVENT_CMD_COMPLETE=
, &host->completed_events);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_command_complete(ho=
st, host->mrq->cmd);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->mrq->data || cm=
d->error) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_req=
uest_end(host, host->mrq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unloc=
k;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_state =3D state =3D S=
TATE_SENDING_DATA;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STATE_SENDING_DATA:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (test_and_clear_bit(EVE=
NT_DATA_ERROR,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0&host->pending_events)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_sto=
p_dma(host);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (data->=
stop)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 send_stop_cmd(host, data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D =
STATE_DATA_ERROR;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_clear_bit(EV=
ENT_XFER_COMPLETE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &host->pending_events))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EVENT_XFER_COMPLET=
E, &host->completed_events);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_state =3D state =3D S=
TATE_DATA_BUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STATE_DATA_BUSY:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_clear_bit(EV=
ENT_DATA_COMPLETE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &host->pending_events))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->data =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EVENT_DATA_COMPLET=
E, &host->completed_events);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D host->data_stat=
us;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (unlikely(status & DW_M=
CI_DATA_ERROR_FLAGS)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (status=
 & SDMMC_INT_DTO) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_err(&host->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "data timeout error\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data->error =3D -ETIMEDOUT;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if =
(status & SDMMC_INT_DCRC) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_err(&host->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "data CRC error\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data->error =3D -EILSEQ;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 dev_err(&host->pdev->dev,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "data FIFO error "
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 "(status=3D%08x)\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 status);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 data->error =3D -EIO;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->byte=
s_xfered =3D data->blocks * data->blksz;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->erro=
r =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!data->stop) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_req=
uest_end(host, host->mrq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unloc=
k;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_state =3D state =3D S=
TATE_SENDING_STOP;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!data->error)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 send_stop_=
cmd(host, data);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* fall through */
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STATE_SENDING_STOP:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_clear_bit(EV=
ENT_CMD_COMPLETE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &host->pending_events))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->cmd =3D NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_command_complete(ho=
st, host->mrq->stop);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_request_end(host, h=
ost->mrq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto unlock;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 case STATE_DATA_ERROR:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!test_and_clear_bit(EV=
ENT_XFER_COMPLETE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 &host->pending_events))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 state =3D STATE_DATA_BUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 } while (state !=3D prev_state);
>> +
>> + =A0 =A0 host->state =3D state;
>> +unlock:
>> + =A0 =A0 spin_unlock(&host->lock);
>> +
>> +}
>> +
>> +static void dw_mci_push_data16(struct dw_mci *host, void *buf, int =
cnt)
>> +{
>> + =A0 =A0 u16 *pData =3D (u16 *)buf;
>
> Changed to pdata.

Ok.

>> +static void dw_mci_read_data_pio(struct dw_mci *host)
>> +{
>> + =A0 =A0 struct scatterlist *sg =3D host->sg;
>> + =A0 =A0 void *buf =3D sg_virt(sg);
>> + =A0 =A0 unsigned int offset =3D host->pio_offset;
>> + =A0 =A0 struct mmc_data *data =3D host->data;
>> + =A0 =A0 int shift =3D host->data_shift;
>> + =A0 =A0 u32 status;
>> + =A0 =A0 unsigned int nbytes =3D 0, len, old_len, count =3D 0;
>> +
>> + =A0 =A0 do {
>> + =A0 =A0 =A0 =A0 =A0 =A0 len =3D SDMMC_GET_FCNT(mci_readl(host, STA=
TUS)) << shift;
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (count =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 old_len =3D len;
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (likely(offset + len <=3D sg->length)) =
{
>
> I agree with Matt, the unlikely/likely aren't necessary.

Removed.

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
>
> The "lets" were ungrammatical and didn't add much, so I removed them.

Ok.

>> + =A0 =A0 if (host->pdata->blk_settings) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_segs =3D host->pdata->blk_setting=
s->max_segs;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_size =3D host->pdata->blk_set=
tings->max_blk_size;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D host->pdata->blk_se=
ttings->max_blk_count;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D host->pdata->blk_set=
tings->max_req_size;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_seg_size =3D host->pdata->blk_set=
tings->max_seg_size;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /*useful defaults*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_segs =3D 64;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_size =3D 65536; /* BLKSIZ is =
16 bits */
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_blk_count =3D 512;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_req_size =3D mmc->max_blk_size * =
mmc->max_blk_count;
>> + =A0 =A0 =A0 =A0 =A0 =A0 mmc->max_seg_size =3D mmc->max_req_size;
>> + =A0 =A0 }
>> +#endif /* CONFIG_MMC_DW_IDMAC */
>> +
>> + =A0 =A0 /* Assume card is present initially */
>> + =A0 =A0 if (dw_mci_get_cd(mmc))
>> + =A0 =A0 =A0 =A0 =A0 =A0 set_bit(DW_MMC_CARD_PRESENT, &slot->flags)=
;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 clear_bit(DW_MMC_CARD_PRESENT, &slot->flag=
s);
>
> Hm, does the code actually make that assumption? =A0Won't dw_mci_get_=
cd()
> return an appropriate value, and have the present bit cleared if so?

Yes, comment removed.

>> + =A0 =A0 host->pdev =3D pdev;
>> + =A0 =A0 host->pdata =3D pdata =3D pdev->dev.platform_data;
>> + =A0 =A0 if (!pdata) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Platform data missing=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_freehost;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (((pdata->num_slots > 1) && !(pdata->select_slot))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 || !(pdata->init)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Platform data wrong\n=
");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_freehost;
>> + =A0 =A0 }
>
> "Platform data wrong" is pretty unhelpful -- perhaps you could have t=
he
> first test be (!pdata || !pdata->init), and then the second test can
> explain that num_slots is > 1 without a slot selected.

Yes, that would be clearer.

>> + =A0 =A0 ret =3D request_irq(irq, dw_mci_interrupt, 0, "dw-mci", ho=
st);
>> + =A0 =A0 if (ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_dmaunmap;
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, host);
>> +
>> + =A0 =A0 if (host->pdata->num_slots)
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->num_slots =3D host->pdata->num_slots=
;
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 host->num_slots =3D ((mci_readl(host, HCON=
) >> 1) & 0x1F) + 1;
>> +
>> + =A0 =A0 /* We need at least one slot to succeed ####pd####*/
>
> What does ####pd#### mean?

I expect pd is one of the original authors - I've removed that part of
the comment.

>
> Cleanup patch:

Thanks for the patch, I've applied it and done a couple more minor
changes. I'll send a v3 when it's tested.
