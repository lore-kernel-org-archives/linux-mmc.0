From: Scott Branden <sbranden@broadcom.com>
Subject: Re: [PATCH 2/5 RFC] mmc: sdhci-iproc: Actually enable the clock
Date: Mon, 18 Jan 2016 13:35:12 -0800
Message-ID: <569D5A90.1050705@broadcom.com>
References: <1453042744-16196-1-git-send-email-stefan.wahren@i2se.com>
 <1453042744-16196-3-git-send-email-stefan.wahren@i2se.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-gw3-out.broadcom.com ([216.31.210.64]:9988 "EHLO
	mail-gw3-out.broadcom.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756530AbcARVfX (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 18 Jan 2016 16:35:23 -0500
In-Reply-To: <1453042744-16196-3-git-send-email-stefan.wahren@i2se.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>, Ray Jui <rjui@broadcom.com>, Jon Mason <jonmason@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Eric Anholt <eric@anholt.net>
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, Ulf Hansson <ulf.hansson@linaro.org>, kernel@martin.sperl.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com

This patch looks good as well.

On 16-01-17 06:59 AM, Stefan Wahren wrote:
> The RPi firmware-based clocks driver can actually disable
> unused clocks, so when switching to use it we ended up losing
> our MMC clock once all devices were probed.
>
> This patch adopts the changes from 1e5a0a9a58e2 ("mmc: sdhci-bcm2835:
> Actually enable the clock") to sdhci-iproc.
>
> Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Acked-by: Scott Branden <sbranden@broadcom.com>

> ---
>   drivers/mmc/host/sdhci-iproc.c |    9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-iproc.c b/drivers/mmc/host/sdhci-iproc.c
> index e22060a..55bc348 100644
> --- a/drivers/mmc/host/sdhci-iproc.c
> +++ b/drivers/mmc/host/sdhci-iproc.c
> @@ -207,6 +207,11 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>   		ret = PTR_ERR(pltfm_host->clk);
>   		goto err;
>   	}
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable host clk\n");
> +		goto err;
> +	}
>
>   	if (iproc_host->data->pdata->quirks & SDHCI_QUIRK_MISSING_CAPS) {
>   		host->caps = iproc_host->data->caps;
> @@ -215,10 +220,12 @@ static int sdhci_iproc_probe(struct platform_device *pdev)
>
>   	ret = sdhci_add_host(host);
>   	if (ret)
> -		goto err;
> +		goto err_clk;
>
>   	return 0;
>
> +err_clk:
> +	clk_disable_unprepare(pltfm_host->clk);
>   err:
>   	sdhci_pltfm_free(pdev);
>   	return ret;
>

