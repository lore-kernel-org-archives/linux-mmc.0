From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 12/13] mmc: mmci: Handle CMD irq before DATA irq
Date: Wed, 12 Feb 2014 14:17:56 +0100
Message-ID: <CAPDyKFoewriChk5roa+LwT2K860R=+Rcobo6_xNstR6b96vu0A@mail.gmail.com>
References: <1391035085-2747-1-git-send-email-ulf.hansson@linaro.org>
	<1391035085-2747-13-git-send-email-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qc0-f174.google.com ([209.85.216.174]:42681 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890AbaBLNR4 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 12 Feb 2014 08:17:56 -0500
Received: by mail-qc0-f174.google.com with SMTP id x13so15332876qcv.33
        for <linux-mmc@vger.kernel.org>; Wed, 12 Feb 2014 05:17:56 -0800 (PST)
In-Reply-To: <1391035085-2747-13-git-send-email-ulf.hansson@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>
Cc: Dong Aisheng <b29396@freescale.com>, Stephen Warren <swarren@nvidia.com>, Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>, Adrian Hunter <adrian.hunter@intel.com>, Ulf Hansson <ulf.hansson@linaro.org>, Johan Rudholm <jrudholm@gmail.com>, Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>

On 29 January 2014 23:38, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> In case of a read operation both MCI_CMDRESPEND and MCI_DATAEND can be
> set in the status register when entering the interrupt handler. This is
> due to that the card start sending data before the host has
> acknowledged the command response.
>
> To resolve the issue for this scenario, we must start by handling the
> CMD irq instead of the DATA irq. The reason is beacuse the completion
> of the DATA irq will not respect the current command and then causing
> it to be garbled.
>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Johan Rudholm <jrudholm@gmail.com>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Hi Russell,

Just wanted to know if you were happy with this patch.

I would prefer if we could let Chris carry this patch, since there are
a dependency. Are you fine with that?

Kind regards
Ulf Hansson

> ---
>  drivers/mmc/host/mmci.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/mmc/host/mmci.c b/drivers/mmc/host/mmci.c
> index f320579..1a4b153 100644
> --- a/drivers/mmc/host/mmci.c
> +++ b/drivers/mmc/host/mmci.c
> @@ -1144,16 +1144,17 @@ static irqreturn_t mmci_irq(int irq, void *dev_id)
>
>                 dev_dbg(mmc_dev(host->mmc), "irq0 (data+cmd) %08x\n", status);
>
> +               cmd = host->cmd;
> +               if (status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|
> +                             MCI_CMDRESPEND) && cmd)
> +                       mmci_cmd_irq(host, cmd, status);
> +
>                 data = host->data;
>                 if (status & (MCI_DATACRCFAIL|MCI_DATATIMEOUT|MCI_STARTBITERR|
>                               MCI_TXUNDERRUN|MCI_RXOVERRUN|MCI_DATAEND|
>                               MCI_DATABLOCKEND) && data)
>                         mmci_data_irq(host, data, status);
>
> -               cmd = host->cmd;
> -               if (status & (MCI_CMDCRCFAIL|MCI_CMDTIMEOUT|MCI_CMDSENT|MCI_CMDRESPEND) && cmd)
> -                       mmci_cmd_irq(host, cmd, status);
> -
>                 ret = 1;
>         } while (status);
>
> --
> 1.7.9.5
>
