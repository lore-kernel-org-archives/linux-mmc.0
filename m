From: James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: make sure of clearing HLE interrupt
Date: Wed, 28 Nov 2012 10:45:12 +0000
Message-ID: <50B5EB38.9030401@imgtec.com>
References: <001c01cdcd52$e58a2260$b09e6720$%jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from multi.imgtec.com ([194.200.65.239]:56902 "EHLO multi.imgtec.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754230Ab2K1KqR (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 28 Nov 2012 05:46:17 -0500
In-Reply-To: <001c01cdcd52$e58a2260$b09e6720$%jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, 'Chris Ball' <cjb@laptop.org>, 'Will Newton' <will.newton@imgtec.com>, 'Jaehoon Chung' <jh80.chung@samsung.com>

Hi,

On 28/11/12 10:26, Seungwon Jeon wrote:
> Even though HLE interrupt is enabled, there is no touch.
> This patch clears HLE interrupt which is not unhandled.

It's not entirely clear from this description what the patch is trying
to do. I presume from the patch you're trying to say something like:
"Even though the HLE interrupt is enabled, it isn't handled, so handle
the HLE interrupt by printing an error message."

According to the TRM though, in the section Error Handling (HLE is also
mentioned elsewhere):
>  Hardware locked error =E2=80=93 Set when the DWC_mobile_storage cann=
ot load a command issued by
> software. When software sets the start_cmd bit in the CMD register, t=
he DWC_mobile_storage tries
> to load the command. If the command buffer is already filled with a c=
ommand, this error is raised.
> The software then has to reload the command.

So it sounds like the last command should be reloaded (either on
interrupt or the interrupt status should be checked after starting a
command). Is this done elsewhere already?

Cheers
James

>=20
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
>=20
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 6785d62..b6db0ae 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1009,6 +1009,11 @@ static void dw_mci_tasklet_func(unsigned long =
priv)
>  	state =3D host->state;
>  	data =3D host->data;
> =20
> +	if (host->cmd_status & SDMMC_INT_HLE) {
> +		dev_err(host->dev, "hardware locked write error\n");
> +		goto unlock;
> +	}
> +
>  	do {
>  		prev_state =3D state;
> =20
> @@ -1577,6 +1582,12 @@ static irqreturn_t dw_mci_interrupt(int irq, v=
oid *dev_id)
>  		if (!pending)
>  			break;
> =20
> +		if (pending & SDMMC_INT_HLE) {
> +			mci_writel(host, RINTSTS, SDMMC_INT_HLE);
> +			host->cmd_status =3D pending;
> +			tasklet_schedule(&host->tasklet);
> +		}
> +
>  		if (pending & DW_MCI_CMD_ERROR_FLAGS) {
>  			mci_writel(host, RINTSTS, DW_MCI_CMD_ERROR_FLAGS);
>  			host->cmd_status =3D pending;
>=20

