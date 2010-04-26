From: Venkatraman S <svenkatr@ti.com>
Subject: Re: [PATCH v2] omap_hsmmc: improve interrupt synchronisation
Date: Mon, 26 Apr 2010 14:30:44 +0530
Message-ID: <p2r618f0c911004260200vb501a429m8ad243826c05d367@mail.gmail.com>
References: <4BD19BBB.40701@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:47031 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752368Ab0DZJAp convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 26 Apr 2010 05:00:45 -0400
In-Reply-To: <4BD19BBB.40701@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-omap Mailing List <linux-omap@vger.kernel.org>

Adrian Hunter <adrian.hunter@nokia.com> wrote:
> From ad2e1cd024ccf9144b6620cfe808893719db738f Mon Sep 17 00:00:00 200=
1
> From: Adrian Hunter <adrian.hunter@nokia.com>
> Date: Wed, 14 Apr 2010 16:26:45 +0300
> Subject: [PATCH] omap_hsmmc: improve interrupt synchronisation
>
> The following changes were needed:
> =A0 =A0 =A0 =A0- do not use in_interrupt() because it will not work
> =A0 =A0 =A0 =A0with threaded interrupts
>
> In addition, the following improvements were made:
> =A0 =A0 =A0 =A0- ensure DMA is unmapped only after the final DMA inte=
rrupt
> =A0 =A0 =A0 =A0- ensure a request is completed only after the final D=
MA interrupt
> =A0 =A0 =A0 =A0- disable controller interrupts when a request is not =
in progress
> =A0 =A0 =A0 =A0- remove the spin-lock protecting the start of a new r=
equest from
> =A0 =A0 =A0 =A0an unexpected interrupt because the locking was compli=
cated and
> =A0 =A0 =A0 =A0a 'req_in_progress' flag suffices (since the spin-lock=
 only defers
> =A0 =A0 =A0 =A0the unexpected interrupts anyway)
> =A0 =A0 =A0 =A0- instead use the spin-lock to protect the MMC interru=
pt handler
> =A0 =A0 =A0 =A0from the DMA interrupt handler
> =A0 =A0 =A0 =A0- remove the semaphore preventing DMA from being start=
ed while
> =A0 =A0 =A0 =A0the previous DMA is still in progress - the other chan=
ges make that
> =A0 =A0 =A0 =A0impossible, so it is now a BUG_ON condition
> =A0 =A0 =A0 =A0- ensure the controller interrupt status is clear befo=
re exiting
> =A0 =A0 =A0 =A0the interrrupt handler
>
> In general, these changes make the code safer but do not fix any spec=
ific
> bugs so backporting is not necessary.
>
> Signed-off-by: Adrian Hunter <adrian.hunter@nokia.com>
> ---
>
>
> Changes from version 1:
> =A0 =A0 =A0 =A0- use a spin-lock to protect the MMC interrupt handler
> =A0 =A0 =A0 =A0from the DMA interrupt handler
> =A0 =A0 =A0 =A0- use do {} while loop instead of goto in omap_hsmmc_i=
rq
>
> S Venkatraman's request to use omap_hsmmc_dma_cleanup(host, 0) in
> omap_hsmmc_dma_cb() was not done because the code was not
> sufficiently the same.
>
>
> drivers/mmc/host/omap_hsmmc.c | =A0262
> +++++++++++++++++++++--------------------
> 1 files changed, 134 insertions(+), 128 deletions(-)
>
> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hs=
mmc.c
> index c0b5021..cc0272d 100644
> --- a/drivers/mmc/host/omap_hsmmc.c
> +++ b/drivers/mmc/host/omap_hsmmc.c
> @@ -157,12 +157,10 @@ struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0struct =A0regulator =A0 =A0 =A0 *vcc;
> =A0 =A0 =A0 =A0struct =A0regulator =A0 =A0 =A0 *vcc_aux;
> - =A0 =A0 =A0 struct =A0semaphore =A0 =A0 =A0 sem;
> =A0 =A0 =A0 =A0struct =A0work_struct =A0 =A0 mmc_carddetect_work;
> =A0 =A0 =A0 =A0void =A0 =A0__iomem =A0 =A0 =A0 =A0 *base;
> =A0 =A0 =A0 =A0resource_size_t =A0 =A0 =A0 =A0 mapbase;
> =A0 =A0 =A0 =A0spinlock_t =A0 =A0 =A0 =A0 =A0 =A0 =A0irq_lock; /* Pre=
vent races with irq handler
> */
> - =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 flags;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0id;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0dma_len;
> =A0 =A0 =A0 =A0unsigned int =A0 =A0 =A0 =A0 =A0 =A0dma_sg_idx;
> @@ -183,6 +181,7 @@ struct omap_hsmmc_host {
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 protect_ca=
rd;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reqs_block=
ed;
> =A0 =A0 =A0 =A0int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 use_reg;
> + =A0 =A0 =A0 int =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req_in_prog=
ress;
>
> =A0 =A0 =A0 =A0struct =A0omap_mmc_platform_data =A0*pdata;
> };
> @@ -480,6 +479,27 @@ static void omap_hsmmc_stop_clock(struct
> omap_hsmmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc), "MMC Clock=
 is not stoped\n");
> }
>
> +static void omap_hsmmc_enable_irq(struct omap_hsmmc_host *host)
> +{
> + =A0 =A0 =A0 unsigned int irq_mask;
> +
> + =A0 =A0 =A0 if (host->use_dma)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_mask =3D INT_EN_MASK & ~(BRR_ENABLE=
 | BWR_ENABLE);
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 irq_mask =3D INT_EN_MASK;
> +
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, irq_mask);
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, irq_mask);
> +}
> +
> +static void omap_hsmmc_disable_irq(struct omap_hsmmc_host *host)
> +{
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, 0);
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, 0);
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> +}
> +
> #ifdef CONFIG_PM
>
> /*
> @@ -548,9 +568,7 @@ static int omap_hsmmc_context_restore(struct
> omap_hsmmc_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&& time_before(jiffies, timeout))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0;
>
> - =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> - =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> - =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> + =A0 =A0 =A0 omap_hsmmc_disable_irq(host);
>
> =A0 =A0 =A0 =A0/* Do not initialize card-specific things if the power=
 is off */
> =A0 =A0 =A0 =A0if (host->power_mode =3D=3D MMC_POWER_OFF)
> @@ -653,6 +671,8 @@ static void send_init_stream(struct omap_hsmmc_ho=
st
> *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0disable_irq(host->irq);
> +
> + =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, CON,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_READ(host->base, CON) | INI=
T_STREAM);
> =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, CMD, INIT_STREAM_CMD);
> @@ -718,17 +738,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host =
*host,
> struct mmc_command *cmd,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_hostname(host->mmc), cmd->opcode, =
cmd->arg);
> =A0 =A0 =A0 =A0host->cmd =3D cmd;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Clear status bits and enable interrupts
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, STAT, STAT_CLEAR);
> - =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> -
> - =A0 =A0 =A0 if (host->use_dma)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0INT_=
EN_MASK & ~(BRR_ENABLE | BWR_ENABLE));
> - =A0 =A0 =A0 else
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, INT_EN=
_MASK);
> + =A0 =A0 =A0 omap_hsmmc_enable_irq(host);
>
> =A0 =A0 =A0 =A0host->response_busy =3D 0;
> =A0 =A0 =A0 =A0if (cmd->flags & MMC_RSP_PRESENT) {
> @@ -762,13 +772,7 @@ omap_hsmmc_start_command(struct omap_hsmmc_host =
*host,
> struct mmc_command *cmd,
> =A0 =A0 =A0 =A0if (host->use_dma)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmdreg |=3D DMA_EN;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* In an interrupt context (i.e. STOP command), the s=
pinlock is
> unlocked
> - =A0 =A0 =A0 =A0* by the interrupt handler, otherwise (i.e. for a ne=
w request) it
> is
> - =A0 =A0 =A0 =A0* unlocked here.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!in_interrupt())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(&host->irq_lock,=
 host->flags);
> + =A0 =A0 =A0 host->req_in_progress =3D 1;
>
> =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, ARG, cmd->arg);
> =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, CMD, cmdreg);
> @@ -783,6 +787,23 @@ omap_hsmmc_get_dma_dir(struct omap_hsmmc_host *h=
ost,
> struct mmc_data *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return DMA_FROM_DEVICE;
> }
>
> +static void omap_hsmmc_request_done(struct omap_hsmmc_host *host, st=
ruct
> mmc_request *mrq)
> +{
> + =A0 =A0 =A0 int dma_ch;
> +
> + =A0 =A0 =A0 spin_lock(&host->irq_lock);
> + =A0 =A0 =A0 host->req_in_progress =3D 0;
> + =A0 =A0 =A0 dma_ch =3D host->dma_ch;
> + =A0 =A0 =A0 spin_unlock(&host->irq_lock);
> +
> + =A0 =A0 =A0 omap_hsmmc_disable_irq(host);
> + =A0 =A0 =A0 /* Do not complete the request if DMA is still in progr=
ess */
> + =A0 =A0 =A0 if (mrq->data && host->use_dma && dma_ch !=3D -1)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 host->mrq =3D NULL;
> + =A0 =A0 =A0 mmc_request_done(host->mmc, mrq);
> +}
> +
> /*
> =A0* Notify the transfer complete to MMC core
> =A0*/
> @@ -799,25 +820,19 @@ omap_hsmmc_xfer_done(struct omap_hsmmc_host *ho=
st,
> struct mmc_data *data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mrq =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_request_done(host->mmc, mrq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_request_done(host, mrq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0host->data =3D NULL;
>
> - =A0 =A0 =A0 if (host->use_dma && host->dma_ch !=3D -1)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->=
sg, host->dma_len,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_get_dma_dir(=
host, data));
> -
> =A0 =A0 =A0 =A0if (!data->error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->bytes_xfered +=3D data->blocks *=
 (data->blksz);
> =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0data->bytes_xfered =3D 0;
>
> =A0 =A0 =A0 =A0if (!data->stop) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mrq =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_request_done(host->mmc, data->mrq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_request_done(host, data->mrq=
);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0omap_hsmmc_start_command(host, data->stop, NULL);
> @@ -843,10 +858,8 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *host=
,
> struct mmc_command *cmd)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd->resp[0] =3D OMAP_=
HSMMC_READ(host->base, RSP10);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 if ((host->data =3D=3D NULL && !host->response_busy) ||=
 cmd->error) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mrq =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_request_done(host->mmc, cmd->mrq);
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 if ((host->data =3D=3D NULL && !host->response_busy) ||=
 cmd->error)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_request_done(host, cmd->mrq)=
;
> }
>
> /*
> @@ -854,14 +867,19 @@ omap_hsmmc_cmd_done(struct omap_hsmmc_host *hos=
t,
> struct mmc_command *cmd)
> =A0*/
> static void omap_hsmmc_dma_cleanup(struct omap_hsmmc_host *host, int =
errno)
> {
> + =A0 =A0 =A0 int dma_ch;
> +
> =A0 =A0 =A0 =A0host->data->error =3D errno;
>
> - =A0 =A0 =A0 if (host->use_dma && host->dma_ch !=3D -1) {
> + =A0 =A0 =A0 spin_lock(&host->irq_lock);
> + =A0 =A0 =A0 dma_ch =3D host->dma_ch;
> + =A0 =A0 =A0 host->dma_ch =3D -1;
> + =A0 =A0 =A0 spin_unlock(&host->irq_lock);
> +
> + =A0 =A0 =A0 if (host->use_dma && dma_ch !=3D -1) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dma_unmap_sg(mmc_dev(host->mmc), host-=
>data->sg,
> host->dma_len,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_get_dma_dir=
(host, host->data));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(host->dma_ch);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ch =3D -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&host->sem);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(dma_ch);
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0host->data =3D NULL;
> }
> @@ -923,28 +941,21 @@ static inline void
> omap_hsmmc_reset_controller_fsm(struct omap_hsmmc_host *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> }
>
> -/*
> - * MMC controller IRQ handler
> - */
> -static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
> +static void omap_hsmmc_do_irq(struct omap_hsmmc_host *host, int stat=
us)
> {
> - =A0 =A0 =A0 struct omap_hsmmc_host *host =3D dev_id;
> =A0 =A0 =A0 =A0struct mmc_data *data;
> - =A0 =A0 =A0 int end_cmd =3D 0, end_trans =3D 0, status;
> -
> - =A0 =A0 =A0 spin_lock(&host->irq_lock);
> -
> - =A0 =A0 =A0 if (host->mrq =3D=3D NULL) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, STAT,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_READ(host->b=
ase, STAT));
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Flush posted write */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_READ(host->base, STAT);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->irq_lock);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return IRQ_HANDLED;
> + =A0 =A0 =A0 int end_cmd =3D 0, end_trans =3D 0;
> +
> + =A0 =A0 =A0 if (!host->req_in_progress) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->=
base, STAT, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Flush posted write *=
/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D OMAP_HSMMC_R=
EAD(host->base, STAT);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } while (status & INT_EN_MASK);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0data =3D host->data;
> - =A0 =A0 =A0 status =3D OMAP_HSMMC_READ(host->base, STAT);
> =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc), "IRQ Status is %x\n", stat=
us);
>
> =A0 =A0 =A0 =A0if (status & ERR) {
> @@ -997,15 +1008,27 @@ static irqreturn_t omap_hsmmc_irq(int irq, voi=
d
> *dev_id)
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host->base, STAT, status);
> - =A0 =A0 =A0 /* Flush posted write */
> - =A0 =A0 =A0 OMAP_HSMMC_READ(host->base, STAT);
>
> =A0 =A0 =A0 =A0if (end_cmd || ((status & CC) && host->cmd))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_cmd_done(host, host->cmd);
> =A0 =A0 =A0 =A0if ((end_trans || (status & TC)) && host->mrq)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0omap_hsmmc_xfer_done(host, data);
> +}
>
> - =A0 =A0 =A0 spin_unlock(&host->irq_lock);
> +/*
> + * MMC controller IRQ handler
> + */
> +static irqreturn_t omap_hsmmc_irq(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct omap_hsmmc_host *host =3D dev_id;
> + =A0 =A0 =A0 int status;
> +
> + =A0 =A0 =A0 status =3D OMAP_HSMMC_READ(host->base, STAT);
> + =A0 =A0 =A0 do {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_do_irq(host, status);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Flush posted write */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D OMAP_HSMMC_READ(host->base, =
STAT);
> + =A0 =A0 =A0 } while (status & INT_EN_MASK);
>
> =A0 =A0 =A0 =A0return IRQ_HANDLED;
> }
> @@ -1205,31 +1228,47 @@ static void omap_hsmmc_config_dma_params(stru=
ct
> omap_hsmmc_host *host,
> /*
> =A0* DMA call back function
> =A0*/
> -static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *data)
> +static void omap_hsmmc_dma_cb(int lch, u16 ch_status, void *cb_data)
> {
> - =A0 =A0 =A0 struct omap_hsmmc_host *host =3D data;
> + =A0 =A0 =A0 struct omap_hsmmc_host *host =3D cb_data;
> + =A0 =A0 =A0 struct mmc_data *data =3D host->mrq->data;
> + =A0 =A0 =A0 int dma_ch, req_in_progress;
>
> =A0 =A0 =A0 =A0if (ch_status & OMAP2_DMA_MISALIGNED_ERR_IRQ)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(mmc_dev(host->mmc), "MISALIGNE=
D_ADRS_ERR\n");
>
> - =A0 =A0 =A0 if (host->dma_ch < 0)
> + =A0 =A0 =A0 spin_lock(&host->irq_lock);
> + =A0 =A0 =A0 if (host->dma_ch < 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->irq_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0host->dma_sg_idx++;
> =A0 =A0 =A0 =A0if (host->dma_sg_idx < host->dma_len) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Fire up the next transfer. */
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_config_dma_params(host, host=
->data,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0host->data->sg +
> host->dma_sg_idx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_config_dma_params(host, data=
,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0data->sg + host->dma_sg_idx);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock(&host->irq_lock);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 omap_free_dma(host->dma_ch);
> + =A0 =A0 =A0 dma_unmap_sg(mmc_dev(host->mmc), data->sg, host->dma_le=
n,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_get_dma_dir(host, data));
> +
> + =A0 =A0 =A0 req_in_progress =3D host->req_in_progress;
> + =A0 =A0 =A0 dma_ch =3D host->dma_ch;
> =A0 =A0 =A0 =A0host->dma_ch =3D -1;
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* DMA Callback: run in interrupt context.
> - =A0 =A0 =A0 =A0* mutex_unlock will throw a kernel warning if used.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 up(&host->sem);
> + =A0 =A0 =A0 spin_unlock(&host->irq_lock);
> +
> + =A0 =A0 =A0 omap_free_dma(dma_ch);
> +
> + =A0 =A0 =A0 /* If DMA has finished after TC, complete the request *=
/
> + =A0 =A0 =A0 if (!req_in_progress) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct mmc_request *mrq =3D host->mrq;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->mrq =3D NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_request_done(host->mmc, mrq);
> + =A0 =A0 =A0 }
> }
>
> /*
> @@ -1238,7 +1277,7 @@ static void omap_hsmmc_dma_cb(int lch, u16 ch_s=
tatus,
> void *data)
> static int omap_hsmmc_start_dma_transfer(struct omap_hsmmc_host *host=
,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0struct mmc_request *req)
> {
> - =A0 =A0 =A0 int dma_ch =3D 0, ret =3D 0, err =3D 1, i;
> + =A0 =A0 =A0 int dma_ch =3D 0, ret =3D 0, i;
> =A0 =A0 =A0 =A0struct mmc_data *data =3D req->data;
>
> =A0 =A0 =A0 =A0/* Sanity check: all the SG entries must be aligned by=
 block size. */
> @@ -1255,23 +1294,7 @@ static int omap_hsmmc_start_dma_transfer(struc=
t
> omap_hsmmc_host *host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* If for some reason the DMA transfer is still activ=
e,
> - =A0 =A0 =A0 =A0* we wait for timeout period and free the dma
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (host->dma_ch !=3D -1) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_current_state(TASK_UNINTERRUPTIBLE)=
;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 schedule_timeout(100);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (down_trylock(&host->sem)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_free_dma(host->dma=
_ch);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->dma_ch =3D -1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 up(&host->sem);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 } else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (down_trylock(&host->sem))
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 BUG_ON(host->dma_ch !=3D -1);
>
> =A0 =A0 =A0 =A0ret =3D omap_request_dma(omap_hsmmc_get_dma_sync_dev(h=
ost, data),
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "MMC/SD",=
 omap_hsmmc_dma_cb, host, &dma_ch);
> @@ -1371,37 +1394,27 @@ static void omap_hsmmc_request(struct mmc_hos=
t *mmc,
> struct mmc_request *req)
> =A0 =A0 =A0 =A0struct omap_hsmmc_host *host =3D mmc_priv(mmc);
> =A0 =A0 =A0 =A0int err;
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Prevent races with the interrupt handler because o=
f unexpected
> - =A0 =A0 =A0 =A0* interrupts, but not if we are already in interrupt=
 context i.e.
> - =A0 =A0 =A0 =A0* retries.
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (!in_interrupt()) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_lock_irqsave(&host->irq_lock, host=
->flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Protect the card from I/O if there=
 is a possibility
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* it can be removed.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->protect_card) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->reqs_blocked =
< 3) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* En=
sure the controller is left in a
> consistent
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* st=
ate by resetting the command and data
> state
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* ma=
chines.
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hs=
mmc_reset_controller_fsm(host, SRD);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hs=
mmc_reset_controller_fsm(host, SRC);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->r=
eqs_blocked +=3D 1;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd->error =3D -EB=
ADF;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req->data)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->da=
ta->error =3D -EBADF;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(=
&host->irq_lock,
> host->flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_request_done(mmc, r=
eq);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else if (host->reqs_blocked)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->reqs_blocked =3D =
0;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 BUG_ON(host->req_in_progress);
> + =A0 =A0 =A0 BUG_ON(host->dma_ch !=3D -1);
> + =A0 =A0 =A0 if (host->protect_card) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->reqs_blocked < 3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Ensure the control=
ler is left in a consistent
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* state by resetting=
 the command and data state
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* machines.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_reset_contro=
ller_fsm(host, SRD);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_reset_contro=
ller_fsm(host, SRC);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->reqs_blocked +=3D=
 1;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd->error =3D -EBADF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (req->data)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->data->error =3D -E=
BADF;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 req->cmd->retries =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmc_request_done(mmc, req);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 } else if (host->reqs_blocked)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->reqs_blocked =3D 0;
> =A0 =A0 =A0 =A0WARN_ON(host->mrq !=3D NULL);
> =A0 =A0 =A0 =A0host->mrq =3D req;
> =A0 =A0 =A0 =A0err =3D omap_hsmmc_prepare_data(host, req);
> @@ -1410,8 +1423,6 @@ static void omap_hsmmc_request(struct mmc_host =
*mmc,
> struct mmc_request *req)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (req->data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req->data->error =3D e=
rr;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mrq =3D NULL;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!in_interrupt())
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 spin_unlock_irqrestore(=
&host->irq_lock,
> host->flags);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_request_done(mmc, req);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0}
> @@ -1980,7 +1991,6 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0mmc->f_min =A0 =A0 =A0=3D 400000;
> =A0 =A0 =A0 =A0mmc->f_max =A0 =A0 =A0=3D 52000000;
>
> - =A0 =A0 =A0 sema_init(&host->sem, 1);
> =A0 =A0 =A0 =A0spin_lock_init(&host->irq_lock);
>
> =A0 =A0 =A0 =A0host->iclk =3D clk_get(&pdev->dev, "ick");
> @@ -2126,8 +2136,7 @@ static int __init omap_hsmmc_probe(struct
> platform_device *pdev)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, ISE, INT_EN_MASK);
> - =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->base, IE, INT_EN_MASK);
> + =A0 =A0 =A0 omap_hsmmc_disable_irq(host);
>
> =A0 =A0 =A0 =A0mmc_host_lazy_disable(host->mmc);
>
> @@ -2247,10 +2256,7 @@ static int omap_hsmmc_suspend(struct platform_=
device
> *pdev, pm_message_t state)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_host_enable(host->mmc);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D mmc_suspend_host(host->mmc, st=
ate);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ret =3D=3D 0) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->=
base, ISE, 0);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 OMAP_HSMMC_WRITE(host->=
base, IE, 0);
> -
> -
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 omap_hsmmc_disable_irq(=
host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_HSMMC_WRITE(host-=
>base, HCTL,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OMAP_H=
SMMC_READ(host->base, HCTL) & ~SDBP);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmc_host_disable(host-=
>mmc);
> --
> 1.6.3.3
> --

This looks good and I don't have any other comments.
     I have tested, on MMC and SD cards which I have,
a) Basic file read / write
b) boot with filesystem on ext3 partition on SD card
 on OMAP3 and OMAP4 SDP.

So you can add,
Tested-by: Venkatraman S <svenkatr@ti.com>
