From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 1/5 RFC] mmc: sdhci-iproc: Clean up platform allocations
 if shdci init fails
Date: Mon, 18 Jan 2016 13:31:04 -0800
Message-ID: <569D5998.80204@broadcom.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-2-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw2-out.broadcom.com ([216.31.210.63]:46537 "EHLO
	mail-gw2-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530AbcARVbR (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 16:31:17 -0500
In-Reply-To: <1453042744-16196-2-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

This patch looks fine.

On 16-01-17 06:59 AM, Stefan Wahren wrote:
> This patch adopts the changes from 475c9e43bfa7 ("mmc: sdhci-bcm2835:
> Clean up platform allocations if sdhci init fails") to sdhci-iproc.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Scott Branden <sbranden@broadcom.com>

> ---
>   drivers/mmc/host/sdhci-iproc.c |    6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index 3b423b0..e22060a 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -213,7 +213,11 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>   		host->caps1 = iproc_host->data->caps1;
>   	}
>
> -	return sdhci_add_host(host);
> +	ret = sdhci_add_host(host);
> +	if (ret)
> +		goto err;
> +
> +	return 0;
>
>   err:
>   	sdhci_pltfm_free(pdev);
>

