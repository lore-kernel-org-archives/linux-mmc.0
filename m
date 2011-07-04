From: Kyungmin Park <kmpark@infradead.org>
Subject: Re: mmc: dw_mmc: Add the function call for board-specific initialization.
Date: Mon, 4 Jul 2011 16:49:47 +0900
Message-ID: <CAH9JG2UV2vwDF7p1MivJOa93woTRD3NYjnd++rQWv76K2NqJTg@mail.gmail.com>
References: <1309763279-29862-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:33838 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752612Ab1GDHtt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 4 Jul 2011 03:49:49 -0400
Received: by vxb39 with SMTP id 39so3446416vxb.19
        for <linux-mmc@vger.kernel.org>; Mon, 04 Jul 2011 00:49:48 -0700 (PDT)
In-Reply-To: <1309763279-29862-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Will Newton <will.newton@imgtec.com>, Jaehoon Chung <jh80.chung@samsung.com>, James Hogan <james.hogan@imgtec.com>

Hi,

Yes it's defined and checked, but not used.
Can you describe the reason why init call is required?
and If required, what's the meaning?

Thank you,
Kyungmin Park

On Mon, Jul 4, 2011 at 4:07 PM, Seungwon Jeon <tgih.jun@samsung.com> wr=
ote:
> Need to call init() function of dw_mci_board.
> It seems to be omitted to call this function.
>
> Signed-off-by: Seungwon Jeon <tgih.jun@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 11 +++++++++++
> =A01 files changed, 11 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index a524416..688d58a 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1585,6 +1585,15 @@ static void dw_mci_work_routine_card(struct wo=
rk_struct *work)
> =A0 =A0 =A0 =A0}
> =A0}
>
> +static irqreturn_t dw_mci_detect_interrupt(int irq, void *dev_id)
> +{
> + =A0 =A0 =A0 struct dw_mci_slot *slot =3D dev_id;
> +
> + =A0 =A0 =A0 queue_work(dw_mci_card_workqueue, &slot->host->card_wor=
k);
> +
> + =A0 =A0 =A0 return IRQ_HANDLED;
> +}
> +
> =A0static int __init dw_mci_init_slot(struct dw_mci *host, unsigned i=
nt id)
> =A0{
> =A0 =A0 =A0 =A0struct mmc_host *mmc;
> @@ -1657,6 +1666,8 @@ static int __init dw_mci_init_slot(struct dw_mc=
i *host, unsigned int id)
> =A0 =A0 =A0 =A0} else
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0regulator_enable(host->vmmc);
>
> + =A0 =A0 =A0 host->pdata->init(id, dw_mci_detect_interrupt, host);
> +
> =A0 =A0 =A0 =A0if (dw_mci_get_cd(mmc))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0set_bit(DW_MMC_CARD_PRESENT, &slot->fl=
ags);
> =A0 =A0 =A0 =A0else
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
