From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH] mmc: sdhci: clear interrupt when retune interrupt
 received
Date: Fri, 9 Jun 2017 15:46:55 +0300
Message-ID: <9b1a2764-e348-b032-a61b-e2c09286aa0a@intel.com>
References: <1496947916-15785-1-git-send-email-troy.kisky@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:35269 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751573AbdFIMwz (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Fri, 9 Jun 2017 08:52:55 -0400
In-Reply-To: <1496947916-15785-1-git-send-email-troy.kisky@boundarydevices.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Troy Kisky <troy.kisky@boundarydevices.com>, aisheng.dong@nxp.com
Cc: ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, fabio.estevam@nxp.com, gary.bisson@boundarydevices.com

On 08/06/17 21:51, Troy Kisky wrote:
> This lets the loop exit before max_loops reaches 0.

Needs more explanation.

> 
> Fixes: f37b20ebc4bc ("mmc: sdhci: add standard hw auto retuning support")
> 
> Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
> ---
>  drivers/mmc/host/sdhci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index ecd0d43..e104194 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2687,7 +2687,7 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  
>  		/* Clear selected interrupts. */
>  		mask = intmask & (SDHCI_INT_CMD_MASK | SDHCI_INT_DATA_MASK |
> -				  SDHCI_INT_BUS_POWER);
> +				  SDHCI_INT_BUS_POWER | SDHCI_INT_RETUNE);

SDHCI_INT_RETUNE is defined to be read-only so why write to it.

>  		sdhci_writel(host, mask, SDHCI_INT_STATUS);
>  
>  		if (intmask & (SDHCI_INT_CARD_INSERT | SDHCI_INT_CARD_REMOVE)) {
> 

