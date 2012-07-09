From: Aaron Lu <aaron.lu@amd.com>
Subject: Re: [PATCH] mmc: host: sdhci.  UHS Switch failure - cycle power if
 regulator is used
Date: Mon, 9 Jul 2012 13:46:02 +0800
Message-ID: <4FFA701A.8010100@amd.com>
References: <1340813700-10898-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from am1ehsobe002.messaging.microsoft.com ([213.199.154.205]:46163
	"EHLO am1outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751819Ab2GIGDK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 9 Jul 2012 02:03:10 -0400
In-Reply-To: <1340813700-10898-1-git-send-email-prakity@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, Philip Rakity <prakity@marvell.com>

On 06/28/2012 12:15 AM, philipspatches@gmail.com wrote:
> From: Philip Rakity<prakity@marvell.com>
>
> Power needs to be removed from the card when switching to 1.8v fails.
>
> If a regulator is used to control vmmc we need to turn the
> regulator off and then back on otherwise power will not be removed
> from the card.

Reviewed-by: Aaron Lu <aaron.lu@amd.com>

-Aaron

>
> Signed-off-by: Philip Rakity<prakity@marvell.com>
> ---
>   drivers/mmc/host/sdhci.c |    4 ++++
>   1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index f4b8b4d..ef4231a 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -1663,11 +1663,15 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>   		pwr = sdhci_readb(host, SDHCI_POWER_CONTROL);
>   		pwr&= ~SDHCI_POWER_ON;
>   		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		if (host->vmmc)
> +			regulator_disable(host->vmmc);
>
>   		/* Wait for 1ms as per the spec */
>   		usleep_range(1000, 1500);
>   		pwr |= SDHCI_POWER_ON;
>   		sdhci_writeb(host, pwr, SDHCI_POWER_CONTROL);
> +		if (host->vmmc)
> +			regulator_enable(host->vmmc);
>
>   		pr_info(DRIVER_NAME ": Switching to 1.8V signalling "
>   			"voltage failed, retrying with S18R set to 0\n");


