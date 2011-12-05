From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH 1/4] SDHCI: add sdhci_get_cd callback to detect the card
Date: Mon, 5 Dec 2011 10:48:50 -0800
Message-ID: <F2681397-0395-43F7-902F-9A575EDD843B@marvell.com>
References: <1323077026-12071-1-git-send-email-r66093@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:57385 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750951Ab1LESsz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Mon, 5 Dec 2011 13:48:55 -0500
In-Reply-To: <1323077026-12071-1-git-send-email-r66093@freescale.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "<r66093@freescale.com> <r66093@freescale.com>" <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jerry Huang <Chang-Ming.Huang@freescale.com>


On Dec 5, 2011, at 1:23 AM, <r66093@freescale.com> <r66093@freescale.com> wrote:

> From: Jerry Huang <Chang-Ming.Huang@freescale.com>
> 
> Add callback function sdhci_get_cd to detect the card.
> In order to check if the card is present, we will read the PRESENT STATE
> register and check the bit13(Card detect pin level) and bit15(CINS).
> 
> Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
> ---
> drivers/mmc/host/sdhci.c |   20 ++++++++++++++++++++
> drivers/mmc/host/sdhci.h |    1 +
> 2 files changed, 21 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 6d8eea3..66afd82 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2,6 +2,7 @@
>  *  linux/drivers/mmc/host/sdhci.c - Secure Digital Host Controller Interface driver
>  *
>  *  Copyright (C) 2005-2008 Pierre Ossman, All Rights Reserved.
> + *  Copyright (C) 2011 Freescale Semiconductor Inc.


Lots of folks have made mods to this code and they have not added a copyright name.
What is the rule Chris ?

>  *
>  * This program is free software; you can redistribute it and/or modify
>  * it under the terms of the GNU General Public License as published by
> @@ -1518,6 +1519,24 @@ static int sdhci_get_ro(struct mmc_host *mmc)
> 	return ret;
> }
> 
> +static int sdhci_get_cd(struct mmc_host *mmc)
> +{
> +	struct sdhci_host *host = mmc_priv(mmc);
> +	unsigned long flags;
> +	int present;
> +
> +	spin_lock_irqsave(&host->lock, flags);
> +
> +	if (host->flags & SDHCI_DEVICE_DEAD)
> +		present = 0;
> +	else
> +		present = sdhci_readl(host, SDHCI_PRESENT_STATE);
> +
> +	spin_unlock_irqrestore(&host->lock, flags);
> +
> +	return (present & (SDHCI_CARD_PRESENT | SDHCI_CARD_CDPL));
> +}
> +
> static void sdhci_enable_sdio_irq_nolock(struct sdhci_host *host, int enable)
> {
> 	if (host->flags & SDHCI_DEVICE_DEAD)
> @@ -1884,6 +1903,7 @@ static const struct mmc_host_ops sdhci_ops = {
> 	.request	= sdhci_request,
> 	.set_ios	= sdhci_set_ios,
> 	.get_ro		= sdhci_get_ro,
> +	.get_cd		= sdhci_get_cd,


A better approach would be to define a callback into platform specific code and use that.  For your
chip reading present state works but for other chips this will not be sufficient so a more general
solution would be better.



> 	.hw_reset	= sdhci_hw_reset,
> 	.enable_sdio_irq = sdhci_enable_sdio_irq,
> 	.start_signal_voltage_switch	= sdhci_start_signal_voltage_switch,
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index 0a5b654..8ea7e00 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -69,6 +69,7 @@
> #define  SDHCI_SPACE_AVAILABLE	0x00000400
> #define  SDHCI_DATA_AVAILABLE	0x00000800
> #define  SDHCI_CARD_PRESENT	0x00010000
> +#define  SDHCI_CARD_CDPL	0x00040000
> #define  SDHCI_WRITE_PROTECT	0x00080000
> #define  SDHCI_DATA_LVL_MASK	0x00F00000
> #define   SDHCI_DATA_LVL_SHIFT	20
> -- 
> 1.7.5.4
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

