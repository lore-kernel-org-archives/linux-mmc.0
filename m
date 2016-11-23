From: Jisheng Zhang <jszhang@marvell.com>
Subject: Re: [PATCH 5/5] sdhci: Add quirk for delayed IRQ ACK
Date: Wed, 23 Nov 2016 11:36:47 +0800
Message-ID: <20161123113647.0b3deac0@xhacker>
References: <1479863388-23678-1-git-send-email-jeremymc@redhat.com>
        <1479863388-23678-6-git-send-email-jeremymc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:52960 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755727AbcKWDl1 (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 22 Nov 2016 22:41:27 -0500
In-Reply-To: <1479863388-23678-6-git-send-email-jeremymc@redhat.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jeremy McNicoll <jeremymc@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, andy.gross@linaro.org, sboyd@codeaurora.org, robh@kernel.org, arnd@arndb.de, bjorn.andersson@linaro.org, riteshh@codeaurora.org

On Tue, 22 Nov 2016 17:09:48 -0800
Jeremy McNicoll <jeremymc@redhat.com> wrote:

> On msm8992 it has been observed that IRQs were not getting
> ACK'd correctly when clocked at speeds greater than 400KHz.
> 
> Signed-off-by: Jeremy McNicoll <jeremymc@redhat.com>
> ---
>  drivers/mmc/host/sdhci-msm.c |  7 +++++++
>  drivers/mmc/host/sdhci.c     | 12 ++++++++++--
>  drivers/mmc/host/sdhci.h     |  2 ++
>  3 files changed, 19 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
> index 1fcda96..459003c 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -1303,6 +1303,13 @@ static int sdhci_msm_probe(struct platform_device *pdev)
>  			       CORE_VENDOR_SPEC_CAPABILITIES0);
>  	}
>  
> +	/* Enable delayed IRQ handling workaround on 8992 */
> +	if (core_major == 1 && core_minor == 0x3e) {
> +		/* Add 40us delay in interrupt handler when operating
> +		 * at initialization frequency of 400KHz. */
> +		host->quirks2 |= SDHCI_QUIRK2_SLOW_INT_CLR;
> +	}
> +
>  	/* Setup IRQ for handling power/voltage tasks with PMIC */
>  	msm_host->pwr_irq = platform_get_irq_byname(pdev, "pwr_irq");
>  	if (msm_host->pwr_irq < 0) {
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
> index 5911f98..c1aae22 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -2703,11 +2703,19 @@ static irqreturn_t sdhci_irq(int irq, void *dev_id)
>  			result = IRQ_WAKE_THREAD;
>  		}
>  
> -		if (intmask & SDHCI_INT_CMD_MASK)
> +		if (intmask & SDHCI_INT_CMD_MASK) {
> +			if ((host->quirks2 & SDHCI_QUIRK2_SLOW_INT_CLR) && (host->clock <= 400000)) {
> +				udelay(40);
> +			}
>  			sdhci_cmd_irq(host, intmask & SDHCI_INT_CMD_MASK);
> +		}
>  
> -		if (intmask & SDHCI_INT_DATA_MASK)
> +		if (intmask & SDHCI_INT_DATA_MASK) {
> +			if ((host->quirks2 & SDHCI_QUIRK2_SLOW_INT_CLR) && (host->clock <= 400000)) {
> +				udelay(40);
> +			}
>  			sdhci_data_irq(host, intmask & SDHCI_INT_DATA_MASK);
> +		}
>  
>  		if (intmask & SDHCI_INT_BUS_POWER)
>  			pr_err("%s: Card is consuming too much power!\n",
> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
> index c055e24..5f8301e 100644
> --- a/drivers/mmc/host/sdhci.h
> +++ b/drivers/mmc/host/sdhci.h
> @@ -24,6 +24,8 @@
>   * Controller registers
>   */
>  
> +#define SDHCI_QUIRK2_SLOW_INT_CLR	(1<<5)

IIRC, new quirk isn't allowed now.

Thanks,
Jisheng

