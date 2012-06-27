From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: only support voltage (vdd) that regulator agree's with
Date: Wed, 27 Jun 2012 12:46:05 -0400
Message-ID: <871ul08zzm.fsf@octavius.laptop.org>
References: <prakity@marvell.com>
	<1339183573-21688-1-git-send-email-prakity@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:48742 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754627Ab2F0QqM (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 27 Jun 2012 12:46:12 -0400
In-Reply-To: <1339183573-21688-1-git-send-email-prakity@marvell.com>
	(philipspatches@gmail.com's message of "Fri, 8 Jun 2012 12:26:13
	-0700")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: philipspatches@gmail.com
Cc: linux-mmc@vger.kernel.org, aaron.lu@amd.com, mark.brown314@gmail.com, Philip Rakity <prakity@marvell.com>

Hi,

On Fri, Jun 08 2012, philipspatches@gmail.com wrote:
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

Thanks, pushed to mmc-next for 3.6.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
