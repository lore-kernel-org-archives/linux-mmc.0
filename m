From: Will Newton <will.newton@gmail.com>
Subject: Re: [PATCH 2/5] mmc: dw-mmc: ensure that the card is not busy when
 changing clock.
Date: Thu, 23 Aug 2012 13:33:36 +0100
Message-ID: <CAFbHwiRm3niUF+Kds0-+XOUzCu8F5hkY9NJi+jKg_PtFrhQ+CQ@mail.gmail.com>
References: <503614A5.5090906@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:40801 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753915Ab2HWMdh (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 Aug 2012 08:33:37 -0400
Received: by qcro28 with SMTP id o28so419041qcr.19
        for <linux-mmc@vger.kernel.org>; Thu, 23 Aug 2012 05:33:36 -0700 (PDT)
In-Reply-To: <503614A5.5090906@samsung.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Kyungmin Park <kyungmin.park@samsung.com>, Will Newton <will.newton@imgtec.com>, James Hogan <james.hogan@imgtec.com>

On Thu, Aug 23, 2012 at 12:31 PM, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> To avoid glitches in the card clock output,
> need to check whether card is busy or not.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  drivers/mmc/host/dw_mmc.c |   30 ++++++++++++++++++++++++------
>  drivers/mmc/host/dw_mmc.h |    1 +
>  2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 36f98c0..8bef3c2 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -623,6 +623,27 @@ static void mci_send_cmd(struct dw_mci_slot *slot, u32 cmd, u32 arg)
>                 cmd, arg, cmd_status);
>  }
>
> +static void dw_mci_inform_ciu(struct dw_mci_slot *slot)
> +{
> +       struct dw_mci *host = slot->host;
> +       unsigned long timeout = jiffies + msecs_to_jiffies(500);

Is there a reason why this timeout value was chosen? It seems quite long.

> +       u32 ctrl, status;
> +
> +       do {
> +               status = mci_readl(host, STATUS);
> +               if (!(status & SDMMC_DATA_BUSY))
> +                       break;
> +               ctrl = mci_readl(host, CTRL);
> +               ctrl |= SDMMC_CTRL_RESET;
> +               mci_writel(host, CTRL, ctrl);
> +       } while (time_before(jiffies, timeout));
> +
> +       if (status & SDMMC_DATA_BUSY)
> +               dev_err(&slot->mmc->class_dev,"Card is busy..!\n");

The two periods in this message do not need to be there.
