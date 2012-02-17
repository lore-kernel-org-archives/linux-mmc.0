From: Jae hoon Chung <jh80.chung@gmail.com>
Subject: Re: [PATCH] mmc: dw_mmc: remove EVENT_DATA_COMPLETE in idma mode
Date: Fri, 17 Feb 2012 22:19:30 +0900
Message-ID: <CAELcNGRqnS4Ea2sU+NhoYtTD+WRine+R2Nd1RTAh5F+Z+v_RxA@mail.gmail.com>
References: <1329474982-5278-1-git-send-email-hyeonsu.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39299 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab2BQNTc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 17 Feb 2012 08:19:32 -0500
Received: by bkcjm19 with SMTP id jm19so3012450bkc.19
        for <linux-mmc@vger.kernel.org>; Fri, 17 Feb 2012 05:19:30 -0800 (PST)
In-Reply-To: <1329474982-5278-1-git-send-email-hyeonsu.kim@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Hyeonsu Kim <hyeonsu.kim@samsung.com>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org, kyungmin.park@samsung.com, jh80.chung@samsung.com, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

Hi.

I added James and Will to CC.

Best Regards,
Jaehoon Chung

2012/2/17  <Hyeonsu@vger.kernel.org>:
> From: Hyeonsu Kim <hyeonsu.kim@samsung.com>
>
> Why need to set EVENT_DATA_COMPLETE bit in here?
> I think this is duplication bit-set.
> because The bit is already set when occur SDMMC_INT_DATA_OVER interru=
pt.
>
> In my case (I use dw_mmc for sd card), the bit brings about data tran=
sfer fault.
> So I want to know your idea about the bit-set.
>
> Signed-off-by: Hyeonsu Kim <hyeonsu.kim@samsung.com>
> ---
> =A0drivers/mmc/host/dw_mmc.c | =A0 =A01 -
> =A01 files changed, 0 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 0e34279..edc60d1 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -1550,7 +1550,6 @@ static irqreturn_t dw_mci_interrupt(int irq, vo=
id *dev_id)
> =A0 =A0 =A0 =A0if (pending & (SDMMC_IDMAC_INT_TI | SDMMC_IDMAC_INT_RI=
)) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mci_writel(host, IDSTS, SDMMC_IDMAC_IN=
T_TI | SDMMC_IDMAC_INT_RI);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mci_writel(host, IDSTS, SDMMC_IDMAC_IN=
T_NI);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 set_bit(EVENT_DATA_COMPLETE, &host->pen=
ding_events);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0host->dma_ops->complete(host);
> =A0 =A0 =A0 =A0}
> =A0#endif
> --
> 1.7.5.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
