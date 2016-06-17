From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH RFC 07/10] mmc: cmdq: support for command queue enabled
 host
Date: Fri, 17 Jun 2016 16:45:17 +0800
Message-ID: <dc27f302-96ac-6eab-be20-343e0270cb12@rock-chips.com>
References: <1465995674-15816-1-git-send-email-riteshh@codeaurora.org>
 <1465995674-15816-8-git-send-email-riteshh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.132]:56120 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752337AbcFQIpp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Jun 2016 04:45:45 -0400
In-Reply-To: <1465995674-15816-8-git-send-email-riteshh@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ritesh Harjani <riteshh@codeaurora.org>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@rock-chips.com, adrian.hunter@intel.com, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, jh80.chung@samsung.com, dongas86@gmail.com, asutoshd@codeaurora.org, zhangfei.gao@gmail.com, sthumma@codeaurora.org, kdorfman@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, Subhash Jadavani <subhashj@codeaurora.org>

=D4=DA 2016/6/15 21:01, Ritesh Harjani =D0=B4=B5=C0:
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>
> This patch adds CMDQ support for command-queue compatible
> hosts.
>
> Command queue is added in eMMC-5.1 specification. This
> enables the controller to process upto 32 requests at
> a time.
>
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> [subhashj@codeaurora.org: fixed trivial merge conflicts]
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> [riteshh@codeaurora.org: fixed merge conflicts]
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> ---
>  drivers/mmc/host/Kconfig    |  13 +
>  drivers/mmc/host/Makefile   |   1 +
>  drivers/mmc/host/cmdq_hci.c | 656 ++++++++++++++++++++++++++++++++++=
++++++++++
>  drivers/mmc/host/cmdq_hci.h | 211 ++++++++++++++
>  include/linux/mmc/host.h    |  12 +
>  5 files changed, 893 insertions(+)
>  create mode 100644 drivers/mmc/host/cmdq_hci.c
>  create mode 100644 drivers/mmc/host/cmdq_hci.h
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e657af0..f1b5433 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -774,6 +774,19 @@ config MMC_SUNXI
>  	  This selects support for the SD/MMC Host Controller on
>  	  Allwinner sunxi SoCs.
>
> +config MMC_CQ_HCI
> +	tristate "Command Queue Support"
> +	depends on HAS_DMA
> +	help
> +	  This selects the Command Queue Host Controller Interface (CQHCI)
> +	  support present in host controllers of Qualcomm Technologies, Inc
> +	  amongst others.
> +	  This controller supports eMMC devices with command queue support.
> +
> +	  If you have a controller with this interface, say Y or M here.
> +
> +	  If unsure, say N.
> +

well, my 5.1 controller support HW cmdq, but I think it should be bette=
r
to enable it by defualt if finding MMC_CAP2_CMD_QUEUE.

>  config MMC_TOSHIBA_PCI
>  	tristate "Toshiba Type A SD/MMC Card Interface Driver"
>  	depends on PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile
> index af918d2..3715f73 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -76,6 +76,7 @@ obj-$(CONFIG_MMC_SDHCI_IPROC)		+=3D sdhci-iproc.o
>  obj-$(CONFIG_MMC_SDHCI_MSM)		+=3D sdhci-msm.o
>  obj-$(CONFIG_MMC_SDHCI_ST)		+=3D sdhci-st.o
>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+=3D sdhci-pic32.o
> +obj-$(CONFIG_MMC_CQ_HCI)		+=3D cmdq_hci.o
>
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>  	CFLAGS-cb710-mmc	+=3D -DDEBUG
> diff --git a/drivers/mmc/host/cmdq_hci.c b/drivers/mmc/host/cmdq_hci.=
c
> new file mode 100644
> index 0000000..68c8e03
> --- /dev/null
> +++ b/drivers/mmc/host/cmdq_hci.c
> @@ -0,0 +1,656 @@
> +/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/highmem.h>
> +#include <linux/io.h>
> +#include <linux/module.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/scatterlist.h>
> +#include <linux/platform_device.h>
> +#include <linux/blkdev.h>
> +
> +#include <linux/mmc/mmc.h>
> +#include <linux/mmc/host.h>
> +#include <linux/mmc/card.h>
> +
> +#include "cmdq_hci.h"
> +
> +#define DCMD_SLOT 31
> +#define NUM_SLOTS 32
> +
> +static inline u8 *get_desc(struct cmdq_host *cq_host, u8 tag)
> +{
> +	return cq_host->desc_base + (tag * cq_host->slot_sz);
> +}
> +
> +static inline u8 *get_link_desc(struct cmdq_host *cq_host, u8 tag)
> +{
> +	u8 *desc =3D get_desc(cq_host, tag);
> +
> +	return desc + cq_host->task_desc_len;
> +}
> +
> +static inline dma_addr_t get_trans_desc_dma(struct cmdq_host *cq_hos=
t, u8 tag)
> +{
> +	return cq_host->trans_desc_dma_base +
> +		(cq_host->mmc->max_segs * tag *
> +		 cq_host->trans_desc_len);
> +}
> +
> +static inline u8 *get_trans_desc(struct cmdq_host *cq_host, u8 tag)
> +{
> +	return cq_host->trans_desc_base +
> +		(cq_host->trans_desc_len * cq_host->mmc->max_segs * tag);
> +}
> +
> +static void setup_trans_desc(struct cmdq_host *cq_host, u8 tag)
> +{
> +	u8 *link_temp;
> +	dma_addr_t trans_temp;
> +
> +	link_temp =3D get_link_desc(cq_host, tag);
> +	trans_temp =3D get_trans_desc_dma(cq_host, tag);
> +
> +	memset(link_temp, 0, cq_host->link_desc_len);
> +	if (cq_host->link_desc_len > 8)
> +		*(link_temp + 8) =3D 0;
> +
> +	if (tag =3D=3D DCMD_SLOT) {
> +		*link_temp =3D VALID(0) | ACT(0) | END(1);
> +		return;
> +	}
> +
> +	*link_temp =3D VALID(1) | ACT(0x6) | END(0);
> +
> +	if (cq_host->dma64) {
> +		__le64 *data_addr =3D (__le64 __force *)(link_temp + 4);
> +		data_addr[0] =3D cpu_to_le64(trans_temp);
> +	} else {
> +		__le32 *data_addr =3D (__le32 __force *)(link_temp + 4);
> +		data_addr[0] =3D cpu_to_le32(trans_temp);
> +	}
> +}
> +
> +static void cmdq_clear_set_irqs(struct cmdq_host *cq_host, u32 clear=
, u32 set)
> +{
> +	u32 ier;
> +
> +	ier =3D cmdq_readl(cq_host, CQISTE);
> +	ier &=3D ~clear;
> +	ier |=3D set;
> +	cmdq_writel(cq_host, ier, CQISTE);
> +	cmdq_writel(cq_host, ier, CQISGE);
> +	/* ensure the writes are done */
> +	mb();
> +}
> +
> +
> +#define DRV_NAME "cmdq-host"
> +
> +static void cmdq_dump_debug_ram(struct cmdq_host *cq_host)
> +{
> +	int i =3D 0;
> +
> +	pr_err("---- Debug RAM dump ----\n");
> +	pr_err(DRV_NAME ": Debug RAM wrap-around: 0x%08x | Debug RAM overla=
p: 0x%08x\n",
> +	       cmdq_readl(cq_host, CQ_CMD_DBG_RAM_WA),
> +	       cmdq_readl(cq_host, CQ_CMD_DBG_RAM_OL));]

well, it beyonds the scope of standard cmdq engine.

> +
> +	while (i < 16) {
> +		pr_err(DRV_NAME ": Debug RAM dump [%d]: 0x%08x\n", i,
> +		       cmdq_readl(cq_host, CQ_CMD_DBG_RAM + (0x4 * i)));
> +		i++;
> +	}
> +	pr_err("-------------------------\n");
> +}
> +
> +static void cmdq_dumpregs(struct cmdq_host *cq_host)
> +{
> +	struct mmc_host *mmc =3D cq_host->mmc;
> +
> +	pr_info(DRV_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D REGISTER DUMP (%=
s)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n",
> +		mmc_hostname(mmc));
> +
> +	pr_info(DRV_NAME ": Caps: 0x%08x	  | Version:  0x%08x\n",
> +		cmdq_readl(cq_host, CQCAP),
> +		cmdq_readl(cq_host, CQVER));
> +	pr_info(DRV_NAME ": Queing config: 0x%08x | Queue Ctrl:  0x%08x\n",
> +		cmdq_readl(cq_host, CQCFG),
> +		cmdq_readl(cq_host, CQCTL));
> +	pr_info(DRV_NAME ": Int stat: 0x%08x	  | Int enab:  0x%08x\n",
> +		cmdq_readl(cq_host, CQIS),
> +		cmdq_readl(cq_host, CQISTE));
> +	pr_info(DRV_NAME ": Int sig: 0x%08x	  | Int Coal:  0x%08x\n",
> +		cmdq_readl(cq_host, CQISGE),
> +		cmdq_readl(cq_host, CQIC));
> +	pr_info(DRV_NAME ": TDL base: 0x%08x	  | TDL up32:  0x%08x\n",
> +		cmdq_readl(cq_host, CQTDLBA),
> +		cmdq_readl(cq_host, CQTDLBAU));
> +	pr_info(DRV_NAME ": Doorbell: 0x%08x	  | Comp Notif:  0x%08x\n",
> +		cmdq_readl(cq_host, CQTDBR),
> +		cmdq_readl(cq_host, CQTCN));
> +	pr_info(DRV_NAME ": Dev queue: 0x%08x	  | Dev Pend:  0x%08x\n",
> +		cmdq_readl(cq_host, CQDQS),
> +		cmdq_readl(cq_host, CQDPT));
> +	pr_info(DRV_NAME ": Task clr: 0x%08x	  | Send stat 1:  0x%08x\n",
> +		cmdq_readl(cq_host, CQTCLR),
> +		cmdq_readl(cq_host, CQSSC1));
> +	pr_info(DRV_NAME ": Send stat 2: 0x%08x	  | DCMD resp:  0x%08x\n",
> +		cmdq_readl(cq_host, CQSSC2),
> +		cmdq_readl(cq_host, CQCRDCT));
> +	pr_info(DRV_NAME ": Resp err mask: 0x%08x | Task err:  0x%08x\n",
> +		cmdq_readl(cq_host, CQRMEM),
> +		cmdq_readl(cq_host, CQTERRI));
> +	pr_info(DRV_NAME ": Resp idx 0x%08x	  | Resp arg:  0x%08x\n",
> +		cmdq_readl(cq_host, CQCRI),
> +		cmdq_readl(cq_host, CQCRA));
> +	pr_info(DRV_NAME ": =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D\n");
> +
> +	cmdq_dump_debug_ram(cq_host);
> +	if (cq_host->ops->dump_vendor_regs)
> +		cq_host->ops->dump_vendor_regs(mmc);
> +}
> +
> +/**
> + * The allocated descriptor table for task, link & transfer descrito=
rs
> + * looks like:
> + * |----------|
> + * |task desc |  |->|----------|
> + * |----------|  |  |trans desc|
> + * |link desc-|->|  |----------|
> + * |----------|          .
> + *      .                .
> + *  no. of slots      max-segs
> + *      .           |----------|
> + * |----------|
> + * The idea here is to create the [task+trans] table and mark & poin=
t the
> + * link desc to the transfer desc table on a per slot basis.
> + */
> +static int cmdq_host_alloc_tdl(struct cmdq_host *cq_host)
> +{
> +
> +	size_t desc_size;
> +	size_t data_size;
> +	int i =3D 0;
> +
> +	/* task descriptor can be 64/128 bit irrespective of arch */
> +	if (cq_host->caps & CMDQ_TASK_DESC_SZ_128) {
> +		cmdq_writel(cq_host, cmdq_readl(cq_host, CQCFG) |
> +			       CQ_TASK_DESC_SZ, CQCFG);
> +		cq_host->task_desc_len =3D 16;
> +	} else {
> +		cq_host->task_desc_len =3D 8;
> +	}
> +
> +	/*
> +	 * 96 bits length of transfer desc instead of 128 bits which means
> +	 * ADMA would expect next valid descriptor at the 96th bit
> +	 * or 128th bit
> +	 */
> +	if (cq_host->dma64) {
> +		if (cq_host->quirks & CMDQ_QUIRK_SHORT_TXFR_DESC_SZ)
> +			cq_host->trans_desc_len =3D 12;
> +		else
> +			cq_host->trans_desc_len =3D 16;
> +		cq_host->link_desc_len =3D 16;
> +	} else {
> +		cq_host->trans_desc_len =3D 8;
> +		cq_host->link_desc_len =3D 8;
> +	}
> +
> +	/* total size of a slot: 1 task & 1 transfer (link) */
> +	cq_host->slot_sz =3D cq_host->task_desc_len + cq_host->link_desc_le=
n;
> +
> +	desc_size =3D cq_host->slot_sz * cq_host->num_slots;
> +
> +	data_size =3D cq_host->trans_desc_len * cq_host->mmc->max_segs *
> +		(cq_host->num_slots - 1);
> +
> +	pr_info("%s: desc_size: %d data_sz: %d slot-sz: %d\n", __func__,
> +		(int)desc_size, (int)data_size, cq_host->slot_sz);
> +
> +	/*
> +	 * allocate a dma-mapped chunk of memory for the descriptors
> +	 * allocate a dma-mapped chunk of memory for link descriptors
> +	 * setup each link-desc memory offset per slot-number to
> +	 * the descriptor table.
> +	 */
> +	cq_host->desc_base =3D dmam_alloc_coherent(mmc_dev(cq_host->mmc),
> +						 desc_size,
> +						 &cq_host->desc_dma_base,
> +						 GFP_KERNEL);
> +	cq_host->trans_desc_base =3D dmam_alloc_coherent(mmc_dev(cq_host->m=
mc),
> +					      data_size,
> +					      &cq_host->trans_desc_dma_base,
> +					      GFP_KERNEL);
> +	if (!cq_host->desc_base || !cq_host->trans_desc_base)
> +		return -ENOMEM;
> +
> +	pr_info("desc-base: 0x%p trans-base: 0x%p\n desc_dma 0x%llx trans_d=
ma: 0x%llx\n",
> +		 cq_host->desc_base, cq_host->trans_desc_base,
> +		(unsigned long long)cq_host->desc_dma_base,
> +		(unsigned long long) cq_host->trans_desc_dma_base);
> +
> +	for (; i < (cq_host->num_slots); i++)
> +		setup_trans_desc(cq_host, i);
> +
> +	return 0;
> +}
> +
> +static int cmdq_enable(struct mmc_host *mmc)
> +{
> +	int err =3D 0;
> +	u32 cqcfg;
> +	bool dcmd_enable;
> +	struct cmdq_host *cq_host =3D mmc_cmdq_private(mmc);
> +
> +	if (!cq_host || !mmc->card || !mmc_card_cmdq(mmc->card)) {
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (cq_host->enabled)
> +		goto out;
> +
> +	cqcfg =3D cmdq_readl(cq_host, CQCFG);
> +	if (cqcfg & 0x1) {
> +		pr_info("%s: %s: cq_host is already enabled\n",
> +				mmc_hostname(mmc), __func__);
> +		WARN_ON(1);
> +		goto out;
> +	}
> +
> +	if (cq_host->quirks & CMDQ_QUIRK_NO_DCMD)

Why you need it, DCMD should be certainly suppoted.
Have you find any vendor's CQE that doesn't support
it when fetching TD in slot#31?

> +		dcmd_enable =3D false;
> +	else
> +		dcmd_enable =3D true;
> +
> +	cqcfg =3D ((cq_host->caps & CMDQ_TASK_DESC_SZ_128 ? CQ_TASK_DESC_SZ=
 : 0) |
> +			(dcmd_enable ? CQ_DCMD : 0));
> +
> +	cmdq_writel(cq_host, cqcfg, CQCFG);
> +	/* enable CQ_HOST */
> +	cmdq_writel(cq_host, cmdq_readl(cq_host, CQCFG) | CQ_ENABLE,
> +		    CQCFG);
> +
> +	if (!cq_host->desc_base ||
> +			!cq_host->trans_desc_base) {
> +		err =3D cmdq_host_alloc_tdl(cq_host);
> +		if (err)
> +			goto out;
> +		cmdq_writel(cq_host, lower_32_bits(cq_host->desc_dma_base),
> +				CQTDLBA);
> +		cmdq_writel(cq_host, upper_32_bits(cq_host->desc_dma_base),
> +				CQTDLBAU);
> +		cmdq_dumpregs(cq_host);
> +	}
> +
> +	/*
> +	 * disable all vendor interrupts
> +	 * enable CMDQ interrupts
> +	 * enable the vendor error interrupts
> +	 */
> +	if (cq_host->ops->clear_set_irqs)
> +		cq_host->ops->clear_set_irqs(mmc, true);
> +
> +	cmdq_clear_set_irqs(cq_host, 0x0, CQ_INT_ALL);
> +
> +	/* cq_host would use this rca to address the card */
> +	cmdq_writel(cq_host, mmc->card->rca, CQSSC2);
> +
> +	/* send QSR at lesser intervals than the default */
> +	cmdq_writel(cq_host, cmdq_readl(cq_host, CQSSC1) | SEND_QSR_INTERVA=
L,
> +				CQSSC1);
> +
> +	/* ensure the writes are done before enabling CQE */
> +	mb();
> +
> +	cq_host->enabled =3D true;
> +
> +	if (cq_host->ops->set_block_size)
> +		cq_host->ops->set_block_size(cq_host->mmc);
> +
> +	if (cq_host->ops->set_data_timeout)
> +		cq_host->ops->set_data_timeout(mmc, 0xf);
> +
> +	if (cq_host->ops->clear_set_dumpregs)
> +		cq_host->ops->clear_set_dumpregs(mmc, 1);
> +
> +out:
> +	return err;
> +}
> +
> +static void cmdq_disable(struct mmc_host *mmc, bool soft)
> +{
> +	struct cmdq_host *cq_host =3D (struct cmdq_host *)mmc_cmdq_private(=
mmc);
> +
> +	if (soft) {
> +		cmdq_writel(cq_host, cmdq_readl(
> +				    cq_host, CQCFG) & ~(CQ_ENABLE),
> +			    CQCFG);
> +	}
> +

No need { }

> +	cq_host->enabled =3D false;
> +}
> +
> +static void cmdq_prep_task_desc(struct mmc_request *mrq,
> +					u64 *data, bool intr, bool qbr)
> +{
> +	struct mmc_cmdq_req *cmdq_req =3D mrq->cmdq_req;
> +	u32 req_flags =3D cmdq_req->cmdq_req_flags;
> +
> +	pr_debug("%s: %s: data-tag: 0x%08x - dir: %d - prio: %d - cnt: 0x%0=
8x -	addr: 0x%llx\n",
> +		 mmc_hostname(mrq->host), __func__,
> +		 !!(req_flags & DAT_TAG), !!(req_flags & DIR),
> +		 !!(req_flags & PRIO), cmdq_req->data.blocks,
> +		 (u64)mrq->cmdq_req->blk_addr);
> +
> +	*data =3D VALID(1) |
> +		END(1) |
> +		INT(intr) |
> +		ACT(0x5) |
> +		FORCED_PROG(!!(req_flags & FORCED_PRG)) |
> +		CONTEXT(mrq->cmdq_req->ctx_id) |
> +		DATA_TAG(!!(req_flags & DAT_TAG)) |
> +		DATA_DIR(!!(req_flags & DIR)) |
> +		PRIORITY(!!(req_flags & PRIO)) |
> +		QBAR(qbr) |
> +		REL_WRITE(!!(req_flags & REL_WR)) |
> +		BLK_COUNT(mrq->cmdq_req->data.blocks) |
> +		BLK_ADDR((u64)mrq->cmdq_req->blk_addr);
> +}
> +
> +static int cmdq_dma_map(struct mmc_host *host, struct mmc_request *m=
rq)
> +{
> +	int sg_count;
> +	struct mmc_data *data =3D mrq->data;
> +
> +	if (!data)
> +		return -EINVAL;
> +
> +	sg_count =3D dma_map_sg(mmc_dev(host), data->sg,
> +			      data->sg_len,
> +			      (data->flags & MMC_DATA_WRITE) ?
> +			      DMA_TO_DEVICE : DMA_FROM_DEVICE);
> +	if (!sg_count) {
> +		pr_err("%s: sg-len: %d\n", __func__, data->sg_len);
> +		return -ENOMEM;
> +	}
> +
> +	return sg_count;
> +}
> +
> +static void cmdq_set_tran_desc(u8 *desc,
> +				 dma_addr_t addr, int len, bool end)
> +{
> +	__le64 *dataddr =3D (__le64 __force *)(desc + 4);
> +	__le32 *attr =3D (__le32 __force *)desc;
> +
> +	*attr =3D (VALID(1) |
> +		 END(end ? 1 : 0) |
> +		 INT(0) |
> +		 ACT(0x4) |
> +		 DAT_LENGTH(len));
> +
> +	dataddr[0] =3D cpu_to_le64(addr);
> +}
> +
> +static int cmdq_prep_tran_desc(struct mmc_request *mrq,
> +			       struct cmdq_host *cq_host, int tag)
> +{
> +	struct mmc_data *data =3D mrq->data;
> +	int i, sg_count, len;
> +	bool end =3D false;
> +	dma_addr_t addr;
> +	u8 *desc;
> +	struct scatterlist *sg;
> +
> +	sg_count =3D cmdq_dma_map(mrq->host, mrq);
> +	if (sg_count < 0) {
> +		pr_err("%s: %s: unable to map sg lists, %d\n",
> +				mmc_hostname(mrq->host), __func__, sg_count);
> +		return sg_count;
> +	}
> +
> +	desc =3D get_trans_desc(cq_host, tag);
> +	memset(desc, 0, cq_host->trans_desc_len * cq_host->mmc->max_segs);
> +
> +	for_each_sg(data->sg, sg, sg_count, i) {
> +		addr =3D sg_dma_address(sg);
> +		len =3D sg_dma_len(sg);
> +
> +		if ((i+1) =3D=3D sg_count)
> +			end =3D true;
> +		cmdq_set_tran_desc(desc, addr, len, end);
> +		desc +=3D cq_host->trans_desc_len;
> +	}
> +
> +	pr_debug("%s: req: 0x%p tag: %d calc_trans_des: 0x%p sg-cnt: %d\n",
> +		__func__, mrq->req, tag, desc, sg_count);
> +
> +	return 0;
> +}
> +
> +static void cmdq_prep_dcmd_desc(struct mmc_host *mmc,
> +				   struct mmc_request *mrq)
> +{
> +	u64 *task_desc =3D NULL;
> +	u64 data =3D 0;
> +	u8 resp_type;
> +	u8 *desc;
> +	__le64 *dataddr;
> +	struct cmdq_host *cq_host =3D mmc_cmdq_private(mmc);
> +	u8 timing;
> +
> +	if (!(mrq->cmd->flags & MMC_RSP_PRESENT)) {
> +		resp_type =3D 0x0;
> +		timing =3D 0x1;
> +	} else {
> +		if (mrq->cmd->flags & MMC_RSP_R1B) {
> +			resp_type =3D 0x3;
> +			timing =3D 0x0;
> +		} else {
> +			resp_type =3D 0x2;
> +			timing =3D 0x1;
> +		}
> +	}
> +
> +	task_desc =3D (__le64 __force *)get_desc(cq_host, cq_host->dcmd_slo=
t);
> +	memset(task_desc, 0, cq_host->task_desc_len);
> +	data |=3D (VALID(1) |
> +		 END(1) |
> +		 INT(1) |
> +		 QBAR(1) |
> +		 ACT(0x5) |
> +		 CMD_INDEX(mrq->cmd->opcode) |
> +		 CMD_TIMING(timing) | RESP_TYPE(resp_type));
> +	*task_desc |=3D data;
> +	desc =3D (u8 *)task_desc;
> +	pr_debug("cmdq: dcmd: cmd: %d timing: %d resp: %d\n",
> +		mrq->cmd->opcode, timing, resp_type);
> +	dataddr =3D (__le64 __force *)(desc + 4);
> +	dataddr[0] =3D cpu_to_le64((u64)mrq->cmd->arg);
> +
> +}
> +
> +static int cmdq_request(struct mmc_host *mmc, struct mmc_request *mr=
q)
> +{
> +	int err;
> +	u64 data =3D 0;
> +	u64 *task_desc =3D NULL;
> +	u32 tag =3D mrq->cmdq_req->tag;
> +	struct cmdq_host *cq_host =3D (struct cmdq_host *)mmc_cmdq_private(=
mmc);
> +
> +	if (!cq_host->enabled) {
> +		pr_err("%s: CMDQ host not enabled yet !!!\n",
> +		       mmc_hostname(mmc));
> +		err =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	if (mrq->cmdq_req->cmdq_req_flags & DCMD) {
> +		cmdq_prep_dcmd_desc(mmc, mrq);
> +		cq_host->mrq_slot[DCMD_SLOT] =3D mrq;
> +		cmdq_writel(cq_host, 1 << DCMD_SLOT, CQTDBR);
> +		return 0;
> +	}
> +
> +	task_desc =3D (__le64 __force *)get_desc(cq_host, tag);
> +
> +	cmdq_prep_task_desc(mrq, &data, 1,
> +			    (mrq->cmdq_req->cmdq_req_flags & QBR));
> +	*task_desc =3D cpu_to_le64(data);
> +
> +	err =3D cmdq_prep_tran_desc(mrq, cq_host, tag);
> +	if (err) {
> +		pr_err("%s: %s: failed to setup tx desc: %d\n",
> +		       mmc_hostname(mmc), __func__, err);
> +		return err;
> +	}
> +
> +	BUG_ON(cmdq_readl(cq_host, CQTDBR) & (1 << tag));
> +
> +	cq_host->mrq_slot[tag] =3D mrq;
> +	if (cq_host->ops->set_tranfer_params)
> +		cq_host->ops->set_tranfer_params(mmc);
> +
> +	cmdq_writel(cq_host, 1 << tag, CQTDBR);
> +
> +out:
> +	return err;
> +}
> +
> +static void cmdq_finish_data(struct mmc_host *mmc, unsigned int tag)
> +{
> +	struct mmc_request *mrq;
> +	struct cmdq_host *cq_host =3D (struct cmdq_host *)mmc_cmdq_private(=
mmc);
> +
> +	mrq =3D cq_host->mrq_slot[tag];
> +	mrq->done(mrq);
> +}
> +
> +irqreturn_t cmdq_irq(struct mmc_host *mmc, u32 intmask)
> +{
> +	u32 status;
> +	unsigned long tag =3D 0, comp_status;
> +	struct cmdq_host *cq_host =3D (struct cmdq_host *)mmc_cmdq_private(=
mmc);
> +
> +	status =3D cmdq_readl(cq_host, CQIS);
> +	cmdq_writel(cq_host, status, CQIS);
> +

I don't think it's good to ignore the TERR here if finding
a invalid task desc..


> +	if (status & CQIS_TCC) {
> +		/* read QCTCN and complete the request */
> +		comp_status =3D cmdq_readl(cq_host, CQTCN);
> +		if (!comp_status)
> +			goto out;
> +
> +		for_each_set_bit(tag, &comp_status, cq_host->num_slots) {
> +			/* complete the corresponding mrq */
> +			pr_debug("%s: completing tag -> %lu\n",
> +				 mmc_hostname(mmc), tag);
> +			cmdq_finish_data(mmc, tag);
> +		}
> +		cmdq_writel(cq_host, comp_status, CQTCN);
> +	}
> +
> +	if (status & CQIS_RED) {
> +		/* task response has an error */
> +		pr_err("%s: RED error %d !!!\n", mmc_hostname(mmc), status);
> +		cmdq_dumpregs(cq_host);
> +	}
> +
> +out:
> +	return IRQ_HANDLED;
> +}
> +EXPORT_SYMBOL(cmdq_irq);
> +
> +static void cmdq_post_req(struct mmc_host *host, struct mmc_request =
*mrq,
> +			  int err)
> +{
> +	struct mmc_data *data =3D mrq->data;
> +
> +	if (data) {
> +		data->error =3D err;
> +		dma_unmap_sg(mmc_dev(host), data->sg, data->sg_len,
> +			     (data->flags & MMC_DATA_READ) ?
> +			     DMA_FROM_DEVICE : DMA_TO_DEVICE);
> +		if (err)
> +			data->bytes_xfered =3D 0;
> +		else
> +			data->bytes_xfered =3D blk_rq_bytes(mrq->req);
> +	}
> +}
> +
> +static const struct mmc_cmdq_host_ops cmdq_host_ops =3D {
> +	.enable =3D cmdq_enable,
> +	.disable =3D cmdq_disable,
> +	.request =3D cmdq_request,
> +	.post_req =3D cmdq_post_req,
> +};
> +
> +struct cmdq_host *cmdq_pltfm_init(struct platform_device *pdev)
> +{
> +	struct cmdq_host *cq_host;
> +	struct resource *cmdq_memres =3D NULL;
> +
> +	/* check and setup CMDQ interface */
> +	cmdq_memres =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +						   "cmdq_mem");

My cmdq engine is appended after the mmio of sdhci, so may I map the
whole when probing sdhci and give the offset of the CMDQ engine to hci?

> +	if (!cmdq_memres) {
> +		dev_dbg(&pdev->dev, "CMDQ not supported\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	cq_host =3D kzalloc(sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host) {
> +		dev_err(&pdev->dev, "failed to allocate memory for CMDQ\n");
> +		return ERR_PTR(-ENOMEM);
> +	}
> +	cq_host->mmio =3D devm_ioremap(&pdev->dev,
> +				     cmdq_memres->start,
> +				     resource_size(cmdq_memres));
> +	if (!cq_host->mmio) {
> +		dev_err(&pdev->dev, "failed to remap cmdq regs\n");
> +		kfree(cq_host);
> +		return ERR_PTR(-EBUSY);
> +	}
> +	dev_dbg(&pdev->dev, "CMDQ ioremap: done\n");
> +
> +	return cq_host;
> +}
> +EXPORT_SYMBOL(cmdq_pltfm_init);
> +
> +int cmdq_init(struct cmdq_host *cq_host, struct mmc_host *mmc,
> +	      bool dma64)
> +{
> +	int err =3D 0;
> +
> +	cq_host->dma64 =3D dma64;
> +	cq_host->mmc =3D mmc;
> +	cq_host->mmc->cmdq_private =3D cq_host;
> +
> +	cq_host->num_slots =3D NUM_SLOTS;
> +	cq_host->dcmd_slot =3D DCMD_SLOT;
> +
> +	mmc->cmdq_ops =3D &cmdq_host_ops;
> +
> +	cq_host->mrq_slot =3D kzalloc(sizeof(cq_host->mrq_slot) *
> +				    cq_host->num_slots, GFP_KERNEL);
> +	if (!cq_host->mrq_slot)
> +		return -ENOMEM;
> +
> +	init_completion(&cq_host->halt_comp);
> +	return err;
> +}
> +EXPORT_SYMBOL(cmdq_init);
> diff --git a/drivers/mmc/host/cmdq_hci.h b/drivers/mmc/host/cmdq_hci.=
h
> new file mode 100644
> index 0000000..e7f5a15
> --- /dev/null
> +++ b/drivers/mmc/host/cmdq_hci.h
> @@ -0,0 +1,211 @@
> +/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or mod=
ify
> + * it under the terms of the GNU General Public License version 2 an=
d
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifndef LINUX_MMC_CQ_HCI_H
> +#define LINUX_MMC_CQ_HCI_H
> +#include <linux/mmc/core.h>
> +
> +/* registers */
> +/* version */
> +#define CQVER		0x00
> +/* capabilities */
> +#define CQCAP		0x04
> +/* configuration */
> +#define CQCFG		0x08
> +#define CQ_DCMD		0x00001000
> +#define CQ_TASK_DESC_SZ 0x00000100
> +#define CQ_ENABLE	0x00000001
> +
> +/* control */
> +#define CQCTL		0x0C
> +#define CLEAR_ALL_TASKS 0x00000100
> +#define HALT		0x00000001
> +
> +/* interrupt status */
> +#define CQIS		0x10
> +#define CQIS_HAC	(1 << 0)
> +#define CQIS_TCC	(1 << 1)
> +#define CQIS_RED	(1 << 2)
> +#define CQIS_TCL	(1 << 3)
> +

okay, I check all these definitions and it seems
ok but I think it's better to use BIT(x) instead of
(1 << x). And the space and tab is mixed here.

> +/* interrupt status enable */
> +#define CQISTE		0x14
> +
> +/* interrupt signal enable */
> +#define CQISGE		0x18
> +
> +/* interrupt coalescing */
> +#define CQIC		0x1C
> +#define CQIC_ENABLE	(1 << 31)
> +#define CQIC_RESET	(1 << 16)
> +#define CQIC_ICCTHWEN	(1 << 15)
> +#define CQIC_ICCTH(x)	((x & 0x1F) << 8)
> +#define CQIC_ICTOVALWEN (1 << 7)
> +#define CQIC_ICTOVAL(x) (x & 0x7F)
> +
> +/* task list base address */
> +#define CQTDLBA		0x20
> +
> +/* task list base address upper */
> +#define CQTDLBAU	0x24
> +
> +/* door-bell */
> +#define CQTDBR		0x28
> +
> +/* task completion notification */
> +#define CQTCN		0x2C
> +
> +/* device queue status */
> +#define CQDQS		0x30
> +
> +/* device pending tasks */
> +#define CQDPT		0x34
> +
> +/* task clear */
> +#define CQTCLR		0x38
> +
> +/* send status config 1 */
> +#define CQSSC1		0x40
> +/*
> + * Value n means CQE would send CMD13 during the transfer of data bl=
ock
> + * BLOCK_CNT-n
> + */
> +#define SEND_QSR_INTERVAL 0x70000
> +
> +/* send status config 2 */
> +#define CQSSC2		0x44
> +
> +/* response for dcmd */
> +#define CQCRDCT		0x48
> +
> +/* response mode error mask */
> +#define CQRMEM		0x50
> +
> +/* task error info */
> +#define CQTERRI		0x54
> +
> +/* command response index */
> +#define CQCRI		0x58
> +
> +/* command response argument */
> +#define CQCRA		0x5C
> +
> +#define CQ_INT_ALL	0xF
> +#define CQIC_DEFAULT_ICCTH 31
> +#define CQIC_DEFAULT_ICTOVAL 1
> +
> +#define CQ_CMD_DBG_RAM	0x158
> +#define CQ_CMD_DBG_RAM_WA 0x198
> +#define CQ_CMD_DBG_RAM_OL 0x19C
> +
> +/* attribute fields */
> +#define VALID(x)	((x & 1) << 0)
> +#define END(x)		((x & 1) << 1)
> +#define INT(x)		((x & 1) << 2)
> +#define ACT(x)		((x & 0x7) << 3)
> +
> +/* data command task descriptor fields */
> +#define FORCED_PROG(x)	((x & 1) << 6)
> +#define CONTEXT(x)	((x & 0xF) << 7)
> +#define DATA_TAG(x)	((x & 1) << 11)
> +#define DATA_DIR(x)	((x & 1) << 12)
> +#define PRIORITY(x)	((x & 1) << 13)
> +#define QBAR(x)		((x & 1) << 14)
> +#define REL_WRITE(x)	((x & 1) << 15)
> +#define BLK_COUNT(x)	((x & 0xFFFF) << 16)
> +#define BLK_ADDR(x)	((x & 0xFFFFFFFF) << 32)
> +
> +/* direct command task descriptor fields */
> +#define CMD_INDEX(x)	((x & 0x3F) << 16)
> +#define CMD_TIMING(x)	((x & 1) << 22)
> +#define RESP_TYPE(x)	((x & 0x3) << 23)
> +
> +/* transfer descriptor fields */
> +#define DAT_LENGTH(x)	((x & 0xFFFF) << 16)
> +#define DAT_ADDR_LO(x)	((x & 0xFFFFFFFF) << 32)
> +#define DAT_ADDR_HI(x)	((x & 0xFFFFFFFF) << 0)
> +
> +struct cmdq_host {
> +	const struct cmdq_host_ops *ops;
> +	void __iomem *mmio;
> +	struct mmc_host *mmc;
> +
> +	/* 64 bit DMA */
> +	bool dma64;
> +	int num_slots;
> +
> +	u32 dcmd_slot;
> +	u32 caps;
> +#define CMDQ_TASK_DESC_SZ_128 0x1
> +
> +	u32 quirks;
> +#define CMDQ_QUIRK_SHORT_TXFR_DESC_SZ 0x1
> +#define CMDQ_QUIRK_NO_DCMD	0x2
> +
> +	bool enabled;
> +	bool halted;
> +	bool init_done;
> +
> +	u8 *desc_base;
> +
> +	/* total descriptor size */
> +	u8 slot_sz;
> +
> +	/* 64/128 bit depends on CQCFG */
> +	u8 task_desc_len;
> +
> +	/* 64 bit on 32-bit arch, 128 bit on 64-bit */
> +	u8 link_desc_len;
> +
> +	u8 *trans_desc_base;
> +	/* same length as transfer descriptor */
> +	u8 trans_desc_len;
> +
> +	dma_addr_t desc_dma_base;
> +	dma_addr_t trans_desc_dma_base;
> +
> +	struct completion halt_comp;
> +	struct mmc_request **mrq_slot;
> +	void *private;
> +};
> +
> +struct cmdq_host_ops {
> +	void (*set_tranfer_params)(struct mmc_host *mmc);
> +	void (*set_data_timeout)(struct mmc_host *mmc, u32 val);
> +	void (*clear_set_irqs)(struct mmc_host *mmc, bool clear);
> +	void (*set_block_size)(struct mmc_host *mmc);
> +	void (*dump_vendor_regs)(struct mmc_host *mmc);
> +	void (*write_l)(struct cmdq_host *host, u32 val, int reg);
> +	u32 (*read_l)(struct cmdq_host *host, int reg);
> +	void (*clear_set_dumpregs)(struct mmc_host *mmc, bool set);
> +};
> +
> +static inline void cmdq_writel(struct cmdq_host *host, u32 val, int =
reg)
> +{
> +	if (unlikely(host->ops->write_l))
> +		host->ops->write_l(host, val, reg);
> +	else
> +		writel_relaxed(val, host->mmio + reg);
> +}
> +
> +static inline u32 cmdq_readl(struct cmdq_host *host, int reg)
> +{
> +	if (unlikely(host->ops->read_l))
> +		return host->ops->read_l(host, reg);
> +	else
> +		return readl_relaxed(host->mmio + reg);
> +}
> +
> +extern irqreturn_t cmdq_irq(struct mmc_host *mmc, u32 intmask);
> +extern int cmdq_init(struct cmdq_host *cq_host, struct mmc_host *mmc=
,
> +		     bool dma64);
> +extern struct cmdq_host *cmdq_pltfm_init(struct platform_device *pde=
v);
> +#endif
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index dfe094a..135a83e 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -420,6 +420,13 @@ struct mmc_host {
>  	u32			dsr;	/* optional driver stage (DSR) value */
>
>  	struct mmc_cmdq_context_info	cmdq_ctx;
> +	/*
> +	 * several cmdq supporting host controllers are extensions
> +	 * of legacy controllers. This variable can be used to store
> +	 * a reference to the cmdq extension of the existing host
> +	 * controller.
> +	 */
> +	void *cmdq_private;
>  	unsigned long		private[0] ____cacheline_aligned;
>  };
>
> @@ -434,6 +441,11 @@ static inline void *mmc_priv(struct mmc_host *ho=
st)
>  	return (void *)host->private;
>  }
>
> +static inline void *mmc_cmdq_private(struct mmc_host *host)
> +{
> +	return host->cmdq_private;
> +}
> +
>  #define mmc_host_is_spi(host)	((host)->caps & MMC_CAP_SPI)
>
>  #define mmc_dev(x)	((x)->parent)
>


--=20
Best Regards
Shawn Lin

