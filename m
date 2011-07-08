From: Will Newton <will.newton@gmail.com>
Subject: Re: mmc: dw_mmc: Add the function call for board-specific initialization.
Date: Fri, 8 Jul 2011 11:19:41 +0100
Message-ID: <CAFbHwiRiVFW4qDJO2QgmpZ3P4WO+j_406402RsD5jWPY=9CkDw@mail.gmail.com>
References: <1309763279-29862-1-git-send-email-tgih.jun@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:54126 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937Ab1GHKTl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 8 Jul 2011 06:19:41 -0400
Received: by pvg12 with SMTP id 12so1038467pvg.19
        for <linux-mmc@vger.kernel.org>; Fri, 08 Jul 2011 03:19:41 -0700 (PDT)
In-Reply-To: <1309763279-29862-1-git-send-email-tgih.jun@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Seungwon Jeon <tgih.jun@samsung.com>
Cc: linux-mmc@vger.kernel.org, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, James Hogan <james.hogan@imgtec.com>

On Mon, Jul 4, 2011 at 8:07 AM, Seungwon Jeon <tgih.jun@samsung.com> wr=
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

Sorry for the delay in replying.

I believe this patch does the correct thing (although for the boards I
have the init function is not defined). The comment I have in some
code here for the init function is:

        /*
         * Used to setup gpio based card detect interrupt handler
         * on a per slot basis, we are using the modules built in
         * card detect functionality, so do nothing (must be implemente=
d).
         */

Although with the current GPIO layer irq handling I would have thought
we could setup a GPIO irq in the board setup code and pass the irq
number in directly. So form that point of view it may be better to
remove this init function entirely?
