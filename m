From: Tushar Behera <tushar.behera@linaro.org>
Subject: Re: [PATCH 2/2] mmc: only support voltage (vdd) that regulator agree's
 with
Date: Fri, 09 Nov 2012 15:20:37 +0530
Message-ID: <509CD1ED.5050402@linaro.org>
References: <prakity@marvell.com> <1339183573-21688-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:44834 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750976Ab2KIJuJ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 9 Nov 2012 04:50:09 -0500
Received: by mail-da0-f46.google.com with SMTP id n41so1601736dak.19
        for <linux-mmc@vger.kernel.org>; Fri, 09 Nov 2012 01:50:08 -0800 (PST)
In-Reply-To: <1339183573-21688-1-git-send-email-prakity@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: cjb@laptop.org, linux-mmc@vger.kernel.org, aaron.lu@amd.com, mark.brown314@gmail.com, Philip Rakity <prakity@marvell.com>

On 06/09/2012 12:56 AM, philipspatches@gmail.com wrote:
> From: Philip Rakity <prakity@marvell.com>
> 
> If we are using a regulator the SD Host Controller and the
> regulator should agree about the voltages supported.  Use
> the common subset that is supported.
> 
> Signed-off-by: Philip Rakity <prakity@marvell.com>
> ---
>  drivers/mmc/host/sdhci.c |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 248f68b..78be427 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2894,6 +2894,21 @@ int sdhci_add_host(struct sdhci_host *host)
>  	 * register is set. The actual current value is 4 times the register
>  	 * value.
>  	 */
> +	if (host->vmmc) {
> +		ret = regulator_is_supported_voltage(host->vmmc, 3300000,
> +			3300000);
> +		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_330)))
> +			caps[0] &= ~SDHCI_CAN_VDD_330;
> +		ret = regulator_is_supported_voltage(host->vmmc, 3000000,
> +			3000000);
> +		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_300)))
> +			caps[0] &= ~SDHCI_CAN_VDD_300;
> +		ret = regulator_is_supported_voltage(host->vmmc, 1800000,
> +			1800000);
> +		if ((ret <= 0) || (!(caps[0] & SDHCI_CAN_VDD_180)))
> +			caps[0] &= ~SDHCI_CAN_VDD_180;
> +	}
> +
>  	max_current_caps = sdhci_readl(host, SDHCI_MAX_CURRENT);
>  	if (!max_current_caps && host->vmmc) {
>  		u32 curr = regulator_get_current_limit(host->vmmc);
> 

Does the above code mean that 2.8V for vmmc regulator is not a valid value?

Currently I am working on a board for which vmmc regulator voltage is
set as 2.8V and the SD/MMC card is working fine (by not defining vmmc in
platform code).

-- 
Tushar Behera
