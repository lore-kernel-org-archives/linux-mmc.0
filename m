From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/2] mmc: sdhci-esdhc-imx: remove D3CD check from SDHCI_HOST_CONTROL
 write
Date: Fri, 25 Jan 2013 07:46:09 +0100
Message-ID: <51022A31.4060908@de.bosch.com>
References: <1358264213-3611-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from imta22.fe.bosch.de ([139.15.243.26]:56117 "EHLO
	imta22.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751185Ab3AYGzs (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 25 Jan 2013 01:55:48 -0500
Received: from smtp6-v.fe.bosch.de (imta24.fe.bosch.de [139.15.243.27])
	by imta22.fe.bosch.de (Postfix) with ESMTP id 6479E8405FD
	for <linux-mmc@vger.kernel.org>; Fri, 25 Jan 2013 07:49:57 +0100 (CET)
In-Reply-To: <1358264213-3611-1-git-send-email-shawn.guo@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>

On 15.01.2013 16:36, Shawn Guo wrote:
> SDHCI_CTRL_D3CD is not a standard SDHCI_HOST_CONTROL, so there is no
> need to check it in SDHCI_HOST_CONTROL write at all.  Remove it.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Tested on i.MX6.

Thanks

Dirk

> ---
>  drivers/mmc/host/sdhci-esdhc-imx.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
> index ac6f971..322eabf 100644
> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
> @@ -297,10 +297,8 @@ static void esdhc_writeb_le(struct sdhci_host *host, u8 val, int reg)
>  		 */
>  		return;
>  	case SDHCI_HOST_CONTROL:
> -		/* FSL messed up here, so we can just keep those three */
> -		new_val = val & (SDHCI_CTRL_LED | \
> -				SDHCI_CTRL_4BITBUS | \
> -				SDHCI_CTRL_D3CD);
> +		/* FSL messed up here, so we need to manually compose it. */
> +		new_val = val & (SDHCI_CTRL_LED | SDHCI_CTRL_4BITBUS);
>  		/* ensure the endianness */
>  		new_val |= ESDHC_HOST_CONTROL_LE;
>  		/* bits 8&9 are reserved on mx25 */
