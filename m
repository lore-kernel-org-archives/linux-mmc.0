From: Andrei Warkentin <andreiw@motorola.com>
Subject: Re: [PATCH 2/2] mmc: tmio: use PIO for short transfers
Date: Mon, 7 Mar 2011 16:51:16 -0600
Message-ID: <AANLkTi=rCU-SGi6VbE_AO4oEp0R8Pd6Tc7VW9=p1nWVv@mail.gmail.com>
References: <Pine.LNX.4.64.1103071417340.29543@axis700.grange>
	<Pine.LNX.4.64.1103071429420.29543@axis700.grange>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from exprod5og107.obsmtp.com ([64.18.0.184]:37756 "EHLO
	exprod5og107.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756445Ab1CGWxJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 7 Mar 2011 17:53:09 -0500
In-Reply-To: <Pine.LNX.4.64.1103071429420.29543@axis700.grange>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: linux-sh@vger.kernel.org, linux-mmc@vger.kernel.org, Ian Molton <ian@mnementh.co.uk>, Chris Ball <cjb@laptop.org>

On Mon, Mar 7, 2011 at 7:30 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:
> This patch allows transferring of some requests in PIO and some in DM=
A
> mode and defaults to using DMA only for transfers longer than 8 bytes=
=2E
> This is especially useful with SDIO, which can have lots of 2- and 4-=
byte
> transfers, creating unnecessary high overhead, when executed in DMA.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
> ---
> =A0drivers/mmc/host/tmio_mmc.c | =A0 33 +++++++++++++++++++++++------=
----
> =A01 files changed, 23 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/tmio_mmc.c b/drivers/mmc/host/tmio_mmc.=
c
> index aa384ba..f5ec5e6 100644
> --- a/drivers/mmc/host/tmio_mmc.c
> +++ b/drivers/mmc/host/tmio_mmc.c
> @@ -100,6 +100,8 @@
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0TMIO_STAT_CARD_REMOVE | TMIO_STAT_CARD=
_INSERT)
> =A0#define TMIO_MASK_IRQ =A0 =A0 (TMIO_MASK_READOP | TMIO_MASK_WRITEO=
P | TMIO_MASK_CMD)
>
> +#define TMIO_MIN_DMA_LEN 8
> +
> =A0#define enable_mmc_irqs(host, i) \
> =A0 =A0 =A0 =A0do { \
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0u32 mask;\
> @@ -147,6 +149,7 @@ struct tmio_mmc_host {
> =A0 =A0 =A0 =A0struct platform_device *pdev;
>
> =A0 =A0 =A0 =A0/* DMA support */
> + =A0 =A0 =A0 bool =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0force_pio;
> =A0 =A0 =A0 =A0struct dma_chan =A0 =A0 =A0 =A0 *chan_rx;
> =A0 =A0 =A0 =A0struct dma_chan =A0 =A0 =A0 =A0 *chan_tx;
> =A0 =A0 =A0 =A0struct tasklet_struct =A0 dma_complete;
> @@ -384,6 +387,7 @@ static void tmio_mmc_reset_work(struct work_struc=
t *work)
> =A0 =A0 =A0 =A0host->cmd =3D NULL;
> =A0 =A0 =A0 =A0host->data =3D NULL;
> =A0 =A0 =A0 =A0host->mrq =3D NULL;
> + =A0 =A0 =A0 host->force_pio =3D false;
>
> =A0 =A0 =A0 =A0spin_unlock_irqrestore(&host->lock, flags);
>
> @@ -403,6 +407,7 @@ tmio_mmc_finish_request(struct tmio_mmc_host *hos=
t)
> =A0 =A0 =A0 =A0host->mrq =3D NULL;
> =A0 =A0 =A0 =A0host->cmd =3D NULL;
> =A0 =A0 =A0 =A0host->data =3D NULL;
> + =A0 =A0 =A0 host->force_pio =3D false;
>
> =A0 =A0 =A0 =A0cancel_delayed_work(&host->delayed_reset_work);
>
> @@ -484,7 +489,7 @@ static void tmio_mmc_pio_irq(struct tmio_mmc_host=
 *host)
> =A0 =A0 =A0 =A0unsigned int count;
> =A0 =A0 =A0 =A0unsigned long flags;
>
> - =A0 =A0 =A0 if (host->chan_tx || host->chan_rx) {
> + =A0 =A0 =A0 if ((host->chan_tx || host->chan_rx) && !host->force_pi=
o) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("PIO IRQ in DMA mode!\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0} else if (!data) {
> @@ -550,15 +555,11 @@ static void tmio_mmc_do_data_irq(struct tmio_mm=
c_host *host)
> =A0 =A0 =A0 =A0 */
>
> =A0 =A0 =A0 =A0if (data->flags & MMC_DATA_READ) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->chan_rx)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_mmc_irqs(host, =
TMIO_MASK_READOP);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->chan_rx && !host->force_pio)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmio_check_bounce_buff=
er(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&host->pdev->dev, "Complete Rx=
 request %p\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mrq);
> =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->chan_tx)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_mmc_irqs(host, =
TMIO_MASK_WRITEOP);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_dbg(&host->pdev->dev, "Complete Tx=
 request %p\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mrq);
> =A0 =A0 =A0 =A0}
> @@ -582,7 +583,7 @@ static void tmio_mmc_data_irq(struct tmio_mmc_hos=
t *host)
> =A0 =A0 =A0 =A0if (!data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out;
>
> - =A0 =A0 =A0 if (host->chan_tx && (data->flags & MMC_DATA_WRITE)) {
> + =A0 =A0 =A0 if (host->chan_tx && (data->flags & MMC_DATA_WRITE) && =
!host->force_pio) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * Has all data been written out yet? =
Testing on SuperH showed,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 * that in most cases the first interr=
upt comes already with the
> @@ -595,11 +596,12 @@ static void tmio_mmc_data_irq(struct tmio_mmc_h=
ost *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_mmc_irqs(host,=
 TMIO_STAT_DATAEND);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tasklet_schedule(&host=
->dma_complete);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 } else if (host->chan_rx && (data->flags & MMC_DATA_REA=
D)) {
> + =A0 =A0 =A0 } else if (host->chan_rx && (data->flags & MMC_DATA_REA=
D) && !host->force_pio) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0disable_mmc_irqs(host, TMIO_STAT_DATAE=
ND);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tasklet_schedule(&host->dma_complete);
> =A0 =A0 =A0 =A0} else {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0tmio_mmc_do_data_irq(host);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 disable_mmc_irqs(host, TMIO_MASK_READOP=
 | TMIO_MASK_WRITEOP);
> =A0 =A0 =A0 =A0}
> =A0out:
> =A0 =A0 =A0 =A0spin_unlock(&host->lock);
> @@ -648,12 +650,12 @@ static void tmio_mmc_cmd_irq(struct tmio_mmc_ho=
st *host,
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if (host->data && !cmd->error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (host->data->flags & MMC_DATA_READ)=
 {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->chan_rx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->force_pio || =
!host->chan_rx)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enable=
_mmc_irqs(host, TMIO_MASK_READOP);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0taskle=
t_schedule(&host->dma_issue);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0} else {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!host->chan_tx)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->force_pio || =
!host->chan_tx)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enable=
_mmc_irqs(host, TMIO_MASK_WRITEOP);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0taskle=
t_schedule(&host->dma_issue);
> @@ -811,6 +813,11 @@ static void tmio_mmc_start_dma_rx(struct tmio_mm=
c_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto pio;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (sg->length < TMIO_MIN_DMA_LEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->force_pio =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0disable_mmc_irqs(host, TMIO_STAT_RXRDY);
>
> =A0 =A0 =A0 =A0/* The only sg element can be unaligned, use our bounc=
e buffer then */
> @@ -886,6 +893,11 @@ static void tmio_mmc_start_dma_tx(struct tmio_mm=
c_host *host)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto pio;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 if (sg->length < TMIO_MIN_DMA_LEN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 host->force_pio =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0disable_mmc_irqs(host, TMIO_STAT_TXRQ);
>
> =A0 =A0 =A0 =A0/* The only sg element can be unaligned, use our bounc=
e buffer then */
> @@ -1132,6 +1144,7 @@ static void tmio_mmc_request(struct mmc_host *m=
mc, struct mmc_request *mrq)
>
> =A0fail:
> =A0 =A0 =A0 =A0host->mrq =3D NULL;
> + =A0 =A0 =A0 host->force_pio =3D false;
> =A0 =A0 =A0 =A0mrq->cmd->error =3D ret;
> =A0 =A0 =A0 =A0mmc_request_done(mmc, mrq);
> =A0}
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

This is probably a good idea for other controllers too, no? I mean to
implement something similar for other controllers...
