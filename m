From: Bough Chen <haibo.chen@nxp.com>
Subject: RE: [PATCH V4 10/11] mmc: cqhci: support for command queue enabled
 host
Date: Mon, 24 Jul 2017 08:52:32 +0000
Message-ID: <AM4PR0401MB2324C6913207B78E8A71C24190BB0@AM4PR0401MB2324.eurprd04.prod.outlook.com>
References: <1500630584-22852-1-git-send-email-adrian.hunter@intel.com>
 <1500630584-22852-11-git-send-email-adrian.hunter@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-he1eur01on0062.outbound.protection.outlook.com ([104.47.0.62]:31664
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752610AbdGXIwg (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Mon, 24 Jul 2017 04:52:36 -0400
In-Reply-To: <1500630584-22852-11-git-send-email-adrian.hunter@intel.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Alex Lemberg <alex.lemberg@sandisk.com>, Mateusz Nowak <mateusz.nowak@intel.com>, Yuliy Izrailov <Yuliy.Izrailov@sandisk.com>, Jaehoon Chung <jh80.chung@samsung.com>, Dong Aisheng <dongas86@gmail.com>, Das Asutosh <asutoshd@codeaurora.org>, Zhangfei Gao <zhangfei.gao@gmail.com>, Dorfman Konstantin <kdorfman@codeaurora.org>, David Griego <david.griego@linaro.org>, Sahitya Tummala <stummala@codeaurora.org>, Harjani Ritesh <riteshh@codeaurora.org>, Venu Byravarasu <vbyravarasu@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Shawn Lin <shawn.lin@rock-chips.com>

[...]

> -----Original Message-----
> From: Adrian Hunter [mailto:adrian.hunter@intel.com]
> Sent: Friday, July 21, 2017 5:50 PM
> To: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: linux-mmc <linux-mmc@vger.kernel.org>; Bough Chen
> <haibo.chen@nxp.com>; Alex Lemberg <alex.lemberg@sandisk.com>;
> Mateusz Nowak <mateusz.nowak@intel.com>; Yuliy Izrailov
> <Yuliy.Izrailov@sandisk.com>; Jaehoon Chung <jh80.chung@samsung.com>;
> Dong Aisheng <dongas86@gmail.com>; Das Asutosh
> <asutoshd@codeaurora.org>; Zhangfei Gao <zhangfei.gao@gmail.com>;
> Dorfman Konstantin <kdorfman@codeaurora.org>; David Griego
> <david.griego@linaro.org>; Sahitya Tummala <stummala@codeaurora.org>;
> Harjani Ritesh <riteshh@codeaurora.org>; Venu Byravarasu
> <vbyravarasu@nvidia.com>; Linus Walleij <linus.walleij@linaro.org>; Shawn=
 Lin
> <shawn.lin@rock-chips.com>
> Subject: [PATCH V4 10/11] mmc: cqhci: support for command queue enabled
> host
>=20
> From: Venkat Gopalakrishnan <venkatg@codeaurora.org>
>=20
> This patch adds CMDQ support for command-queue compatible hosts.
>=20
> Command queue is added in eMMC-5.1 specification. This enables the
> controller to process upto 32 requests at a time.
>=20
> Adrian Hunter contributed renaming to cqhci, recovery, suspend and resume=
,
> cqhci_off, cqhci_wait_for_idle, and external timeout handling.
>=20
> Signed-off-by: Asutosh Das <asutoshd@codeaurora.org>
> Signed-off-by: Sujit Reddy Thumma <sthumma@codeaurora.org>
> Signed-off-by: Konstantin Dorfman <kdorfman@codeaurora.org>
> Signed-off-by: Venkat Gopalakrishnan <venkatg@codeaurora.org>
> Signed-off-by: Subhash Jadavani <subhashj@codeaurora.org>
> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
> ---
>  drivers/mmc/host/Kconfig  |   13 +
>  drivers/mmc/host/Makefile |    1 +
>  drivers/mmc/host/cqhci.c  | 1146
> +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/mmc/host/cqhci.h  |  240 ++++++++++
>  4 files changed, 1400 insertions(+)
>  create mode 100644 drivers/mmc/host/cqhci.c  create mode 100644
> drivers/mmc/host/cqhci.h
>=20
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig index
> 2242633550df..3a164a03f2bc 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -834,6 +834,19 @@ config MMC_SUNXI
>  	  This selects support for the SD/MMC Host Controller on
>  	  Allwinner sunxi SoCs.
>=20
> +config MMC_CQHCI
> +	tristate "Command Queue Host Controller Interface support"
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
>  config MMC_TOSHIBA_PCI
>  	tristate "Toshiba Type A SD/MMC Card Interface Driver"
>  	depends on PCI
> diff --git a/drivers/mmc/host/Makefile b/drivers/mmc/host/Makefile index
> 8c46766c000c..3ae71e006890 100644
> --- a/drivers/mmc/host/Makefile
> +++ b/drivers/mmc/host/Makefile
> @@ -88,6 +88,7 @@ obj-$(CONFIG_MMC_SDHCI_MSM)		+=3D
> sdhci-msm.o
>  obj-$(CONFIG_MMC_SDHCI_ST)		+=3D sdhci-st.o
>  obj-$(CONFIG_MMC_SDHCI_MICROCHIP_PIC32)	+=3D sdhci-pic32.o
>  obj-$(CONFIG_MMC_SDHCI_BRCMSTB)		+=3D sdhci-brcmstb.o
> +obj-$(CONFIG_MMC_CQHCI)			+=3D cqhci.o
>=20
>  ifeq ($(CONFIG_CB710_DEBUG),y)
>  	CFLAGS-cb710-mmc	+=3D -DDEBUG
> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c new file
> mode 100644 index 000000000000..302421a26230
> --- /dev/null
> +++ b/drivers/mmc/host/cqhci.c
> @@ -0,0 +1,1146 @@

<SNIP>

> +
> +static int cqhci_request(struct mmc_host *mmc, struct mmc_request *mrq)
> +{
> +	int err =3D 0;
> +	u64 data =3D 0;
> +	u64 *task_desc =3D NULL;
> +	int tag =3D cqhci_tag(mrq);
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	unsigned long flags;
> +
> +	if (!cq_host->enabled) {
> +		pr_err("%s: cqhci: not enabled\n", mmc_hostname(mmc));
> +		return -EINVAL;
> +	}
> +
> +	/* First request after resume has to re-enable */
> +	if (!cq_host->activated)
> +		__cqhci_enable(cq_host);
> +
> +	if (!mmc->cqe_on) {
> +		cqhci_writel(cq_host, 0, CQHCI_CTL);
> +		mmc->cqe_on =3D true;
> +		pr_debug("%s: cqhci: CQE on\n", mmc_hostname(mmc));
> +		if (cqhci_readl(cq_host, CQHCI_CTL) && CQHCI_HALT) {
> +			pr_err("%s: cqhci: CQE failed to exit halt state\n",
> +			       mmc_hostname(mmc));
> +		}
> +		if (cq_host->ops->enable)
> +			cq_host->ops->enable(mmc);
> +	}
> +
> +	if (mrq->data) {
> +		task_desc =3D (__le64 __force *)get_desc(cq_host, tag);
> +		cqhci_prep_task_desc(mrq, &data, 1);
> +		*task_desc =3D cpu_to_le64(data);
> +		err =3D cqhci_prep_tran_desc(mrq, cq_host, tag);
> +		if (err) {
> +			pr_err("%s: cqhci: failed to setup tx desc: %d\n",
> +			       mmc_hostname(mmc), err);
> +			return err;
> +		}
> +	} else {
> +		cqhci_prep_dcmd_desc(mmc, mrq);
> +	}
> +
Hi Adrian,

For cqhci data request, I think we need to also config SDHCI_TRNS_BLK_CNT_E=
N and SDHCI_TRNS_DMA,  just like function sdhci_set_transfer_mode(): set SD=
HCI_TRNS_BLK_CNT_EN and SDHCI_TRNS_DMA in every request.=20

Currently, we do not do this for cqhci request, if support Runtime PM, when=
 runtime resume,=20
sdhci_runtime_resume_host() --> sdhci_init(host, 0) --> sdhci_do_reset(host=
, SDHCI_RESET_ALL)
sdhci_reset() will do software reset for all, this will clear some SDHCI re=
gister, including SDHCI_TRNS_BLK_CNT_EN and SDHCI_TRNS_DMA, then when use c=
qhci request, error happens. I meet cqhci wait timeout error on our i.MX8. =
After set these two bits, this issue gone.

Best Regards,
Haibo Chen

> +	spin_lock_irqsave(&cq_host->lock, flags);
> +
> +	if (cq_host->recovery_halt) {
> +		err =3D -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	cq_host->slot[tag].mrq =3D mrq;
> +	cq_host->slot[tag].flags =3D 0;
> +
> +	cq_host->qcnt +=3D 1;
> +
> +	cqhci_writel(cq_host, 1 << tag, CQHCI_TDBR);
> +	if (!(cqhci_readl(cq_host, CQHCI_TDBR) & (1 << tag)))
> +		pr_debug("%s: cqhci: doorbell not set for tag %d\n",
> +			 mmc_hostname(mmc), tag);
> +out_unlock:
> +	spin_unlock_irqrestore(&cq_host->lock, flags);
> +
> +	if (err)
> +		cqhci_post_req(mmc, mrq);
> +
> +	return err;
> +}
> +
> +static void cqhci_recovery_needed(struct mmc_host *mmc, struct
> mmc_request *mrq,
> +				  bool notify)
> +{
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +
> +	if (!cq_host->recovery_halt) {
> +		cq_host->recovery_halt =3D true;
> +		pr_debug("%s: cqhci: recovery needed\n",
> mmc_hostname(mmc));
> +		wake_up(&cq_host->wait_queue);
> +		if (notify && mmc->cqe_recovery_notifier)
> +			mmc->cqe_recovery_notifier(mmc, mrq);
> +	}
> +}
> +
> +static unsigned int cqhci_error_flags(int error1, int error2) {
> +	int error =3D error1 ? error1 : error2;
> +
> +	switch (error) {
> +	case -EILSEQ:
> +		return CQHCI_HOST_CRC;
> +	case -ETIMEDOUT:
> +		return CQHCI_HOST_TIMEOUT;
> +	default:
> +		return CQHCI_HOST_OTHER;
> +	}
> +}
> +
> +static void cqhci_error_irq(struct mmc_host *mmc, u32 status, int cmd_er=
ror,
> +			    int data_error)
> +{
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	struct cqhci_slot *slot;
> +	u32 terri;
> +	int tag;
> +
> +	spin_lock(&cq_host->lock);
> +
> +	terri =3D cqhci_readl(cq_host, CQHCI_TERRI);
> +
> +	pr_debug("%s: cqhci: error IRQ status: 0x%08x cmd error %d data
> error %d TERRI: 0x%08x\n",
> +		 mmc_hostname(mmc), status, cmd_error, data_error, terri);
> +
> +	/* Forget about errors when recovery has already been triggered */
> +	if (cq_host->recovery_halt)
> +		goto out_unlock;
> +
> +	if (!cq_host->qcnt) {
> +		WARN_ONCE(1, "%s: cqhci: error when idle. IRQ status: 0x%08x
> cmd error %d data error %d TERRI: 0x%08x\n",
> +			  mmc_hostname(mmc), status, cmd_error, data_error,
> +			  terri);
> +		goto out_unlock;
> +	}
> +
> +	if (CQHCI_TERRI_C_VALID(terri)) {
> +		tag =3D CQHCI_TERRI_C_TASK(terri);
> +		slot =3D &cq_host->slot[tag];
> +		if (slot->mrq) {
> +			slot->flags =3D cqhci_error_flags(cmd_error, data_error);
> +			cqhci_recovery_needed(mmc, slot->mrq, true);
> +		}
> +	}
> +
> +	if (CQHCI_TERRI_D_VALID(terri)) {
> +		tag =3D CQHCI_TERRI_D_TASK(terri);
> +		slot =3D &cq_host->slot[tag];
> +		if (slot->mrq) {
> +			slot->flags =3D cqhci_error_flags(data_error, cmd_error);
> +			cqhci_recovery_needed(mmc, slot->mrq, true);
> +		}
> +	}
> +
> +	if (!cq_host->recovery_halt) {
> +		/*
> +		 * The only way to guarantee forward progress is to mark at
> +		 * least one task in error, so if none is indicated, pick one.
> +		 */
> +		for (tag =3D 0; tag < NUM_SLOTS; tag++) {
> +			slot =3D &cq_host->slot[tag];
> +			if (!slot->mrq)
> +				continue;
> +			slot->flags =3D cqhci_error_flags(data_error, cmd_error);
> +			cqhci_recovery_needed(mmc, slot->mrq, true);
> +			break;
> +		}
> +	}
> +
> +out_unlock:
> +	spin_unlock(&cq_host->lock);
> +}
> +
> +static void cqhci_finish_mrq(struct mmc_host *mmc, unsigned int tag) {
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	struct cqhci_slot *slot =3D &cq_host->slot[tag];
> +	struct mmc_request *mrq =3D slot->mrq;
> +	struct mmc_data *data;
> +
> +	if (!mrq) {
> +		WARN_ONCE(1, "%s: cqhci: spurious TCN for tag %d\n",
> +			  mmc_hostname(mmc), tag);
> +		return;
> +	}
> +
> +	/* No completions allowed during recovery */
> +	if (cq_host->recovery_halt) {
> +		slot->flags |=3D CQHCI_COMPLETED;
> +		return;
> +	}
> +
> +	slot->mrq =3D NULL;
> +
> +	cq_host->qcnt -=3D 1;
> +
> +	data =3D mrq->data;
> +	if (data) {
> +		if (data->error)
> +			data->bytes_xfered =3D 0;
> +		else
> +			data->bytes_xfered =3D data->blksz * data->blocks;
> +	}
> +
> +	mmc_cqe_request_done(mmc, mrq);
> +}
> +
> +irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
> +		      int data_error)
> +{
> +	u32 status;
> +	unsigned long tag =3D 0, comp_status;
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +
> +	status =3D cqhci_readl(cq_host, CQHCI_IS);
> +	cqhci_writel(cq_host, status, CQHCI_IS);
> +
> +	pr_debug("%s: cqhci: IRQ status: 0x%08x\n", mmc_hostname(mmc),
> +status);
> +
> +	if ((status & CQHCI_IS_RED) || cmd_error || data_error)
> +		cqhci_error_irq(mmc, status, cmd_error, data_error);
> +
> +	if (status & CQHCI_IS_TCC) {
> +		/* read TCN and complete the request */
> +		comp_status =3D cqhci_readl(cq_host, CQHCI_TCN);
> +		cqhci_writel(cq_host, comp_status, CQHCI_TCN);
> +		pr_debug("%s: cqhci: TCN: 0x%08lx\n",
> +			 mmc_hostname(mmc), comp_status);
> +
> +		spin_lock(&cq_host->lock);
> +
> +		for_each_set_bit(tag, &comp_status, cq_host->num_slots) {
> +			/* complete the corresponding mrq */
> +			pr_debug("%s: cqhci: completing tag %lu\n",
> +				 mmc_hostname(mmc), tag);
> +			cqhci_finish_mrq(mmc, tag);
> +		}
> +
> +		if (cq_host->waiting_for_idle && !cq_host->qcnt) {
> +			cq_host->waiting_for_idle =3D false;
> +			wake_up(&cq_host->wait_queue);
> +		}
> +
> +		spin_unlock(&cq_host->lock);
> +	}
> +
> +	if (status & CQHCI_IS_TCL)
> +		wake_up(&cq_host->wait_queue);
> +
> +	if (status & CQHCI_IS_HAC)
> +		wake_up(&cq_host->wait_queue);
> +
> +	return IRQ_HANDLED;
> +}
> +EXPORT_SYMBOL(cqhci_irq);
> +
> +static bool cqhci_is_idle(struct cqhci_host *cq_host, int *ret) {
> +	unsigned long flags;
> +	bool is_idle;
> +
> +	spin_lock_irqsave(&cq_host->lock, flags);
> +	is_idle =3D !cq_host->qcnt || cq_host->recovery_halt;
> +	*ret =3D cq_host->recovery_halt ? -EBUSY : 0;
> +	cq_host->waiting_for_idle =3D !is_idle;
> +	spin_unlock_irqrestore(&cq_host->lock, flags);
> +
> +	return is_idle;
> +}
> +
> +static int cqhci_wait_for_idle(struct mmc_host *mmc) {
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	int ret;
> +
> +	wait_event(cq_host->wait_queue, cqhci_is_idle(cq_host, &ret));
> +
> +	return ret;
> +}
> +
> +static bool cqhci_timeout(struct mmc_host *mmc, struct mmc_request *mrq,
> +			  bool *recovery_needed)
> +{
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	int tag =3D cqhci_tag(mrq);
> +	struct cqhci_slot *slot =3D &cq_host->slot[tag];
> +	unsigned long flags;
> +	bool timed_out;
> +
> +	spin_lock_irqsave(&cq_host->lock, flags);
> +	timed_out =3D slot->mrq =3D=3D mrq;
> +	if (timed_out) {
> +		slot->flags |=3D CQHCI_EXTERNAL_TIMEOUT;
> +		cqhci_recovery_needed(mmc, mrq, false);
> +		*recovery_needed =3D cq_host->recovery_halt;
> +	}
> +	spin_unlock_irqrestore(&cq_host->lock, flags);
> +
> +	if (timed_out) {
> +		pr_err("%s: cqhci: timeout for tag %d\n",
> +		       mmc_hostname(mmc), tag);
> +		cqhci_dumpregs(cq_host);
> +	}
> +
> +	return timed_out;
> +}
> +
> +static bool cqhci_tasks_cleared(struct cqhci_host *cq_host) {
> +	return !(cqhci_readl(cq_host, CQHCI_CTL) &
> CQHCI_CLEAR_ALL_TASKS); }
> +
> +static bool cqhci_clear_all_tasks(struct mmc_host *mmc, unsigned int
> +timeout) {
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	bool ret;
> +	u32 ctl;
> +
> +	cqhci_set_irqs(cq_host, CQHCI_IS_TCL);
> +
> +	ctl =3D cqhci_readl(cq_host, CQHCI_CTL);
> +	ctl |=3D CQHCI_CLEAR_ALL_TASKS;
> +	cqhci_writel(cq_host, ctl, CQHCI_CTL);
> +
> +	wait_event_timeout(cq_host->wait_queue,
> cqhci_tasks_cleared(cq_host),
> +			   msecs_to_jiffies(timeout) + 1);
> +
> +	cqhci_set_irqs(cq_host, 0);
> +
> +	ret =3D cqhci_tasks_cleared(cq_host);
> +
> +	if (!ret)
> +		pr_debug("%s: cqhci: Failed to clear tasks\n",
> +			 mmc_hostname(mmc));
> +
> +	return ret;
> +}
> +
> +static bool cqhci_halted(struct cqhci_host *cq_host) {
> +	return cqhci_readl(cq_host, CQHCI_CTL) & CQHCI_HALT; }
> +
> +static bool cqhci_halt(struct mmc_host *mmc, unsigned int timeout) {
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	bool ret;
> +	u32 ctl;
> +
> +	if (cqhci_halted(cq_host))
> +		return true;
> +
> +	cqhci_set_irqs(cq_host, CQHCI_IS_HAC);
> +
> +	ctl =3D cqhci_readl(cq_host, CQHCI_CTL);
> +	ctl |=3D CQHCI_HALT;
> +	cqhci_writel(cq_host, ctl, CQHCI_CTL);
> +
> +	wait_event_timeout(cq_host->wait_queue, cqhci_halted(cq_host),
> +			   msecs_to_jiffies(timeout) + 1);
> +
> +	cqhci_set_irqs(cq_host, 0);
> +
> +	ret =3D cqhci_halted(cq_host);
> +
> +	if (!ret)
> +		pr_debug("%s: cqhci: Failed to halt\n", mmc_hostname(mmc));
> +
> +	return ret;
> +}
> +
> +/*
> + * After halting we expect to be able to use the command line. We
> +interpret the
> + * failure to halt to mean the data lines might still be in use (and
> +the upper
> + * layers will need to send a STOP command), so we set the timeout
> +based on a
> + * generous command timeout.
> + */
> +#define CQHCI_START_HALT_TIMEOUT	5
> +
> +static void cqhci_recovery_start(struct mmc_host *mmc) {
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +
> +	pr_debug("%s: cqhci: %s\n", mmc_hostname(mmc), __func__);
> +
> +	WARN_ON(!cq_host->recovery_halt);
> +
> +	cqhci_halt(mmc, CQHCI_START_HALT_TIMEOUT);
> +
> +	if (cq_host->ops->disable)
> +		cq_host->ops->disable(mmc, true);
> +
> +	mmc->cqe_on =3D false;
> +}
> +
> +static int cqhci_error_from_flags(unsigned int flags) {
> +	if (!flags)
> +		return 0;
> +
> +	/* CRC errors might indicate re-tuning so prefer to report that */
> +	if (flags & CQHCI_HOST_CRC)
> +		return -EILSEQ;
> +
> +	if (flags & (CQHCI_EXTERNAL_TIMEOUT | CQHCI_HOST_TIMEOUT))
> +		return -ETIMEDOUT;
> +
> +	return -EIO;
> +}
> +
> +static void cqhci_recover_mrq(struct cqhci_host *cq_host, unsigned int
> +tag) {
> +	struct cqhci_slot *slot =3D &cq_host->slot[tag];
> +	struct mmc_request *mrq =3D slot->mrq;
> +	struct mmc_data *data;
> +
> +	if (!mrq)
> +		return;
> +
> +	slot->mrq =3D NULL;
> +
> +	cq_host->qcnt -=3D 1;
> +
> +	data =3D mrq->data;
> +	if (data) {
> +		data->bytes_xfered =3D 0;
> +		data->error =3D cqhci_error_from_flags(slot->flags);
> +	} else {
> +		mrq->cmd->error =3D cqhci_error_from_flags(slot->flags);
> +	}
> +
> +	mmc_cqe_request_done(cq_host->mmc, mrq); }
> +
> +static void cqhci_recover_mrqs(struct cqhci_host *cq_host) {
> +	int i;
> +
> +	for (i =3D 0; i < cq_host->num_slots; i++)
> +		cqhci_recover_mrq(cq_host, i);
> +}
> +
> +/*
> + * By now the command and data lines should be unused so there is no
> +reason for
> + * CQHCI to take a long time to halt, but if it doesn't halt there
> +could be
> + * problems clearing tasks, so be generous.
> + */
> +#define CQHCI_FINISH_HALT_TIMEOUT	20
> +
> +/* CQHCI could be expected to clear it's internal state pretty quickly *=
/
> +#define CQHCI_CLEAR_TIMEOUT		20
> +
> +static void cqhci_recovery_finish(struct mmc_host *mmc) {
> +	struct cqhci_host *cq_host =3D mmc->cqe_private;
> +	unsigned long flags;
> +	u32 cqcfg;
> +	bool ok;
> +
> +	pr_debug("%s: cqhci: %s\n", mmc_hostname(mmc), __func__);
> +
> +	WARN_ON(!cq_host->recovery_halt);
> +
> +	ok =3D cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
> +
> +	if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
> +		ok =3D false;
> +
> +	/*
> +	 * The specification contradicts itself, by saying that tasks cannot be
> +	 * cleared if CQHCI does not halt, but if CQHCI does not halt, it shoul=
d
> +	 * be disabled/re-enabled, but not to disable before clearing tasks.
> +	 * Have a go anyway.
> +	 */
> +	if (!ok) {
> +		pr_debug("%s: cqhci: disable / re-enable\n",
> mmc_hostname(mmc));
> +		cqcfg =3D cqhci_readl(cq_host, CQHCI_CFG);
> +		cqcfg &=3D ~CQHCI_ENABLE;
> +		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +		cqcfg |=3D CQHCI_ENABLE;
> +		cqhci_writel(cq_host, cqcfg, CQHCI_CFG);
> +		/* Be sure that there are no tasks */
> +		ok =3D cqhci_halt(mmc, CQHCI_FINISH_HALT_TIMEOUT);
> +		if (!cqhci_clear_all_tasks(mmc, CQHCI_CLEAR_TIMEOUT))
> +			ok =3D false;
> +		WARN_ON(!ok);
> +	}
> +
> +	cqhci_recover_mrqs(cq_host);
> +
> +	WARN_ON(cq_host->qcnt);
> +
> +	spin_lock_irqsave(&cq_host->lock, flags);
> +	cq_host->qcnt =3D 0;
> +	cq_host->recovery_halt =3D false;
> +	mmc->cqe_on =3D false;
> +	spin_unlock_irqrestore(&cq_host->lock, flags);
> +
> +	/* Ensure all writes are done before interrupts are re-enabled */
> +	wmb();
> +
> +	cqhci_writel(cq_host, CQHCI_IS_HAC | CQHCI_IS_TCL, CQHCI_IS);
> +
> +	cqhci_set_irqs(cq_host, CQHCI_IS_MASK);
> +
> +	pr_debug("%s: cqhci: recovery done\n", mmc_hostname(mmc)); }
> +
> +static const struct mmc_cqe_ops cqhci_cqe_ops =3D {
> +	.cqe_enable =3D cqhci_enable,
> +	.cqe_disable =3D cqhci_disable,
> +	.cqe_request =3D cqhci_request,
> +	.cqe_post_req =3D cqhci_post_req,
> +	.cqe_off =3D cqhci_off,
> +	.cqe_wait_for_idle =3D cqhci_wait_for_idle,
> +	.cqe_timeout =3D cqhci_timeout,
> +	.cqe_recovery_start =3D cqhci_recovery_start,
> +	.cqe_recovery_finish =3D cqhci_recovery_finish, };
> +
> +struct cqhci_host *cqhci_pltfm_init(struct platform_device *pdev) {
> +	struct cqhci_host *cq_host;
> +	struct resource *cqhci_memres =3D NULL;
> +
> +	/* check and setup CMDQ interface */
> +	cqhci_memres =3D platform_get_resource_byname(pdev,
> IORESOURCE_MEM,
> +						   "cqhci_mem");
> +	if (!cqhci_memres) {
> +		dev_dbg(&pdev->dev, "CMDQ not supported\n");
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	cq_host =3D devm_kzalloc(&pdev->dev, sizeof(*cq_host), GFP_KERNEL);
> +	if (!cq_host)
> +		return ERR_PTR(-ENOMEM);
> +	cq_host->mmio =3D devm_ioremap(&pdev->dev,
> +				     cqhci_memres->start,
> +				     resource_size(cqhci_memres));
> +	if (!cq_host->mmio) {
> +		dev_err(&pdev->dev, "failed to remap cqhci regs\n");
> +		return ERR_PTR(-EBUSY);
> +	}
> +	dev_dbg(&pdev->dev, "CMDQ ioremap: done\n");
> +
> +	return cq_host;
> +}
> +EXPORT_SYMBOL(cqhci_pltfm_init);
> +
> +static unsigned int cqhci_ver_major(struct cqhci_host *cq_host) {
> +	return CQHCI_VER_MAJOR(cqhci_readl(cq_host, CQHCI_VER)); }
> +
> +static unsigned int cqhci_ver_minor(struct cqhci_host *cq_host) {
> +	u32 ver =3D cqhci_readl(cq_host, CQHCI_VER);
> +
> +	return CQHCI_VER_MINOR1(ver) * 10 + CQHCI_VER_MINOR2(ver); }
> +
> +int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc,
> +	      bool dma64)
> +{
> +	int err;
> +
> +	cq_host->dma64 =3D dma64;
> +	cq_host->mmc =3D mmc;
> +	cq_host->mmc->cqe_private =3D cq_host;
> +
> +	cq_host->num_slots =3D NUM_SLOTS;
> +	cq_host->dcmd_slot =3D DCMD_SLOT;
> +
> +	mmc->cqe_ops =3D &cqhci_cqe_ops;
> +
> +	mmc->cqe_qdepth =3D NUM_SLOTS;
> +	if (mmc->caps2 & MMC_CAP2_CQE_DCMD)
> +		mmc->cqe_qdepth -=3D 1;
> +
> +	cq_host->slot =3D devm_kcalloc(mmc_dev(mmc), cq_host->num_slots,
> +				     sizeof(*cq_host->slot), GFP_KERNEL);
> +	if (!cq_host->slot) {
> +		err =3D -ENOMEM;
> +		goto out_err;
> +	}
> +
> +	spin_lock_init(&cq_host->lock);
> +
> +	init_completion(&cq_host->halt_comp);
> +	init_waitqueue_head(&cq_host->wait_queue);
> +
> +	pr_info("%s: CQHCI version %u.%02u\n",
> +		mmc_hostname(mmc), cqhci_ver_major(cq_host),
> +		cqhci_ver_minor(cq_host));
> +
> +	return 0;
> +
> +out_err:
> +	pr_err("%s: CQHCI version %u.%02u failed to initialize, error %d\n",
> +	       mmc_hostname(mmc), cqhci_ver_major(cq_host),
> +	       cqhci_ver_minor(cq_host), err);
> +	return err;
> +}
> +EXPORT_SYMBOL(cqhci_init);
> +
> +MODULE_AUTHOR("Venkat Gopalakrishnan <venkatg@codeaurora.org>");
> +MODULE_DESCRIPTION("Command Queue Host Controller Interface driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h new file
> mode 100644 index 000000000000..2d39d361b322
> --- /dev/null
> +++ b/drivers/mmc/host/cqhci.h
> @@ -0,0 +1,240 @@
> +/* Copyright (c) 2015, The Linux Foundation. All rights reserved.
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 and
> + * only version 2 as published by the Free Software Foundation.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + */
> +#ifndef LINUX_MMC_CQHCI_H
> +#define LINUX_MMC_CQHCI_H
> +
> +#include <linux/compiler.h>
> +#include <linux/bitops.h>
> +#include <linux/spinlock_types.h>
> +#include <linux/types.h>
> +#include <linux/completion.h>
> +#include <linux/wait.h>
> +#include <linux/irqreturn.h>
> +#include <asm/io.h>
> +
> +/* registers */
> +/* version */
> +#define CQHCI_VER			0x00
> +#define CQHCI_VER_MAJOR(x)		(((x) & GENMASK(11, 8)) >> 8)
> +#define CQHCI_VER_MINOR1(x)		(((x) & GENMASK(7, 4)) >> 4)
> +#define CQHCI_VER_MINOR2(x)		((x) & GENMASK(3, 0))
> +
> +/* capabilities */
> +#define CQHCI_CAP			0x04
> +/* configuration */
> +#define CQHCI_CFG			0x08
> +#define CQHCI_DCMD			0x00001000
> +#define CQHCI_TASK_DESC_SZ		0x00000100
> +#define CQHCI_ENABLE			0x00000001
> +
> +/* control */
> +#define CQHCI_CTL			0x0C
> +#define CQHCI_CLEAR_ALL_TASKS		0x00000100
> +#define CQHCI_HALT			0x00000001
> +
> +/* interrupt status */
> +#define CQHCI_IS			0x10
> +#define CQHCI_IS_HAC			BIT(0)
> +#define CQHCI_IS_TCC			BIT(1)
> +#define CQHCI_IS_RED			BIT(2)
> +#define CQHCI_IS_TCL			BIT(3)
> +
> +#define CQHCI_IS_MASK (CQHCI_IS_TCC | CQHCI_IS_RED)
> +
> +/* interrupt status enable */
> +#define CQHCI_ISTE			0x14
> +
> +/* interrupt signal enable */
> +#define CQHCI_ISGE			0x18
> +
> +/* interrupt coalescing */
> +#define CQHCI_IC			0x1C
> +#define CQHCI_IC_ENABLE			BIT(31)
> +#define CQHCI_IC_RESET			BIT(16)
> +#define CQHCI_IC_ICCTHWEN		BIT(15)
> +#define CQHCI_IC_ICCTH(x)		((x & 0x1F) << 8)
> +#define CQHCI_IC_ICTOVALWEN		BIT(7)
> +#define CQHCI_IC_ICTOVAL(x)		(x & 0x7F)
> +
> +/* task list base address */
> +#define CQHCI_TDLBA			0x20
> +
> +/* task list base address upper */
> +#define CQHCI_TDLBAU			0x24
> +
> +/* door-bell */
> +#define CQHCI_TDBR			0x28
> +
> +/* task completion notification */
> +#define CQHCI_TCN			0x2C
> +
> +/* device queue status */
> +#define CQHCI_DQS			0x30
> +
> +/* device pending tasks */
> +#define CQHCI_DPT			0x34
> +
> +/* task clear */
> +#define CQHCI_TCLR			0x38
> +
> +/* send status config 1 */
> +#define CQHCI_SSC1			0x40
> +
> +/* send status config 2 */
> +#define CQHCI_SSC2			0x44
> +
> +/* response for dcmd */
> +#define CQHCI_CRDCT			0x48
> +
> +/* response mode error mask */
> +#define CQHCI_RMEM			0x50
> +
> +/* task error info */
> +#define CQHCI_TERRI			0x54
> +
> +#define CQHCI_TERRI_C_INDEX(x)		((x) & GENMASK(5, 0))
> +#define CQHCI_TERRI_C_TASK(x)		(((x) & GENMASK(12, 8)) >> 8)
> +#define CQHCI_TERRI_C_VALID(x)		((x) & BIT(15))
> +#define CQHCI_TERRI_D_INDEX(x)		(((x) & GENMASK(21, 16)) >> 16)
> +#define CQHCI_TERRI_D_TASK(x)		(((x) & GENMASK(28, 24)) >> 24)
> +#define CQHCI_TERRI_D_VALID(x)		((x) & BIT(31))
> +
> +/* command response index */
> +#define CQHCI_CRI			0x58
> +
> +/* command response argument */
> +#define CQHCI_CRA			0x5C
> +
> +#define CQHCI_INT_ALL			0xF
> +#define CQHCI_IC_DEFAULT_ICCTH		31
> +#define CQHCI_IC_DEFAULT_ICTOVAL	1
> +
> +/* attribute fields */
> +#define CQHCI_VALID(x)			((x & 1) << 0)
> +#define CQHCI_END(x)			((x & 1) << 1)
> +#define CQHCI_INT(x)			((x & 1) << 2)
> +#define CQHCI_ACT(x)			((x & 0x7) << 3)
> +
> +/* data command task descriptor fields */
> +#define CQHCI_FORCED_PROG(x)		((x & 1) << 6)
> +#define CQHCI_CONTEXT(x)		((x & 0xF) << 7)
> +#define CQHCI_DATA_TAG(x)		((x & 1) << 11)
> +#define CQHCI_DATA_DIR(x)		((x & 1) << 12)
> +#define CQHCI_PRIORITY(x)		((x & 1) << 13)
> +#define CQHCI_QBAR(x)			((x & 1) << 14)
> +#define CQHCI_REL_WRITE(x)		((x & 1) << 15)
> +#define CQHCI_BLK_COUNT(x)		((x & 0xFFFF) << 16)
> +#define CQHCI_BLK_ADDR(x)		((x & 0xFFFFFFFF) << 32)
> +
> +/* direct command task descriptor fields */
> +#define CQHCI_CMD_INDEX(x)		((x & 0x3F) << 16)
> +#define CQHCI_CMD_TIMING(x)		((x & 1) << 22)
> +#define CQHCI_RESP_TYPE(x)		((x & 0x3) << 23)
> +
> +/* transfer descriptor fields */
> +#define CQHCI_DAT_LENGTH(x)		((x & 0xFFFF) << 16)
> +#define CQHCI_DAT_ADDR_LO(x)		((x & 0xFFFFFFFF) << 32)
> +#define CQHCI_DAT_ADDR_HI(x)		((x & 0xFFFFFFFF) << 0)
> +
> +struct cqhci_host_ops;
> +struct mmc_host;
> +struct cqhci_slot;
> +
> +struct cqhci_host {
> +	const struct cqhci_host_ops *ops;
> +	void __iomem *mmio;
> +	struct mmc_host *mmc;
> +
> +	spinlock_t lock;
> +
> +	/* relative card address of device */
> +	unsigned int rca;
> +
> +	/* 64 bit DMA */
> +	bool dma64;
> +	int num_slots;
> +	int qcnt;
> +
> +	u32 dcmd_slot;
> +	u32 caps;
> +#define CQHCI_TASK_DESC_SZ_128		0x1
> +
> +	u32 quirks;
> +#define CQHCI_QUIRK_SHORT_TXFR_DESC_SZ	0x1
> +
> +	bool enabled;
> +	bool halted;
> +	bool init_done;
> +	bool activated;
> +	bool waiting_for_idle;
> +	bool recovery_halt;
> +
> +	size_t desc_size;
> +	size_t data_size;
> +
> +	u8 *desc_base;
> +
> +	/* total descriptor size */
> +	u8 slot_sz;
> +
> +	/* 64/128 bit depends on CQHCI_CFG */
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
> +	wait_queue_head_t wait_queue;
> +	struct cqhci_slot *slot;
> +};
> +
> +struct cqhci_host_ops {
> +	void (*dumpregs)(struct mmc_host *mmc);
> +	void (*write_l)(struct cqhci_host *host, u32 val, int reg);
> +	u32 (*read_l)(struct cqhci_host *host, int reg);
> +	void (*enable)(struct mmc_host *mmc);
> +	void (*disable)(struct mmc_host *mmc, bool recovery); };
> +
> +static inline void cqhci_writel(struct cqhci_host *host, u32 val, int
> +reg) {
> +	if (unlikely(host->ops->write_l))
> +		host->ops->write_l(host, val, reg);
> +	else
> +		writel_relaxed(val, host->mmio + reg); }
> +
> +static inline u32 cqhci_readl(struct cqhci_host *host, int reg) {
> +	if (unlikely(host->ops->read_l))
> +		return host->ops->read_l(host, reg);
> +	else
> +		return readl_relaxed(host->mmio + reg); }
> +
> +struct platform_device;
> +
> +irqreturn_t cqhci_irq(struct mmc_host *mmc, u32 intmask, int cmd_error,
> +		      int data_error);
> +int cqhci_init(struct cqhci_host *cq_host, struct mmc_host *mmc, bool
> +dma64); struct cqhci_host *cqhci_pltfm_init(struct platform_device
> +*pdev); int cqhci_suspend(struct mmc_host *mmc); int
> +cqhci_resume(struct mmc_host *mmc);
> +
> +#endif
> --
> 1.9.1

