From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH RESEND] mmc: dw_mmc: Support predefined mutiple block transfers
Date: Thu, 22 Dec 2011 11:40:47 +0000
Message-ID: <CAFbHwiSqKQ_VXpDfO6EYCS4eMM0-vNoqbnqRd_fFX-v4fZBd2g@mail.gmail.com>
References: <006901ccc088$4b6aafb0$e2400f10$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <006901ccc088$4b6aafb0$e2400f10$%jun@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, linux-samsung-soc@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org

On Thu, Dec 22, 2011 at 9:01 AM, Seungwon Jeon <tgih.jun@samsung.com> w=
rote:
> This patch adds the support for predefined multiple block r/w.
> dw_mmc can support MMC_CAP_CMD23 capability.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 34 ++++++++++++++++++++++++++++---=
---
> =A01 files changed, 28 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 3aaeb08..04653e8 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -588,11 +588,11 @@ static void dw_mci_setup_bus(struct dw_mci_slot=
 *slot)
> =A0 =A0 =A0 =A0mci_writel(host, CTYPE, (slot->ctype << slot->id));
> =A0}
>
> -static void dw_mci_start_request(struct dw_mci *host,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct dw_mci_slot *slot)
> +static void __dw_mci_start_request(struct dw_mci *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct dw_mci_slot *slot,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
struct mmc_command *cmd)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_request *mrq;
> - =A0 =A0 =A0 struct mmc_command *cmd;
> =A0 =A0 =A0 =A0struct mmc_data *data;
> =A0 =A0 =A0 =A0u32 cmdflags;
>
> @@ -610,14 +610,13 @@ static void dw_mci_start_request(struct dw_mci =
*host,
> =A0 =A0 =A0 =A0host->completed_events =3D 0;
> =A0 =A0 =A0 =A0host->data_status =3D 0;
>
> - =A0 =A0 =A0 data =3D mrq->data;
> + =A0 =A0 =A0 data =3D cmd->data;
> =A0 =A0 =A0 =A0if (data) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dw_mci_set_timeout(host);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mci_writel(host, BYTCNT, data->blksz*d=
ata->blocks);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mci_writel(host, BLKSIZ, data->blksz);
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 cmd =3D mrq->cmd;
> =A0 =A0 =A0 =A0cmdflags =3D dw_mci_prepare_command(slot->mmc, cmd);
>
> =A0 =A0 =A0 =A0/* this is the first command, send the initialization =
clock */
> @@ -635,6 +634,16 @@ static void dw_mci_start_request(struct dw_mci *=
host,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->stop_cmdr =3D dw_mci_prepare_com=
mand(slot->mmc, mrq->stop);
> =A0}
>
> +static void dw_mci_start_request(struct dw_mci *host,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stru=
ct dw_mci_slot *slot)
> +{
> + =A0 =A0 =A0 struct mmc_request *mrq =3D slot->mrq;
> + =A0 =A0 =A0 struct mmc_command *cmd;
> +
> + =A0 =A0 =A0 cmd =3D mrq->sbc ? mrq->sbc : mrq->cmd;
> + =A0 =A0 =A0 __dw_mci_start_request(host, slot, cmd);
> +}
> +
> =A0/* must be called with host->lock held */
> =A0static void dw_mci_queue_request(struct dw_mci *host, struct dw_mc=
i_slot *slot,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struc=
t mmc_request *mrq)
> @@ -889,7 +898,14 @@ static void dw_mci_tasklet_func(unsigned long pr=
iv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cmd =3D host->cmd;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->cmd =3D NULL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_bit(EVENT_CMD_COMP=
LETE, &host->completed_events);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_command_complete=
(host, host->mrq->cmd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_command_complete=
(host, cmd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((cmd =3D=3D host->m=
rq->sbc) && !cmd->error) {

The inner set of parentheses here is not strictly required.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 prev_st=
ate =3D state =3D STATE_SENDING_CMD;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __dw_mc=
i_start_request(host, host->cur_slot,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->mrq->cmd);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto un=
lock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!host->mrq->data |=
| cmd->error) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dw_mci=
_request_end(host, host->mrq);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto u=
nlock;
> @@ -967,6 +983,12 @@ static void dw_mci_tasklet_func(unsigned long pr=
iv)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto u=
nlock;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (host->mrq->sbc && !=
data->error) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->s=
top->error =3D 0;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dw_mci_=
request_end(host, host->mrq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto un=
lock;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0prev_state =3D state =3D=
 STATE_SENDING_STOP;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!data->error)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0send_s=
top_cmd(host, data);
> --
> 1.7.0.4

Otherwise looks ok.

Acked-by: Will Newton <will.newton@imgtec.com>
