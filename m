From: Tony Prisk <linux@prisktech.co.nz>
Subject: Re: [PATCH 1/1] mmc: wmt-sdmmc: Fix NULL pointer dereference
Date: Fri, 13 Sep 2013 06:43:05 +1200
Message-ID: <52320B39.3080306@prisktech.co.nz>
References: <1378974078-15416-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from server.prisktech.co.nz ([115.188.14.127]:57541 "EHLO
	server.prisktech.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754562Ab3ILSm7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 Sep 2013 14:42:59 -0400
In-Reply-To: <1378974078-15416-1-git-send-email-sachin.kamat@linaro.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-mmc@vger.kernel.org, cjb@laptop.org

On 12/09/13 20:21, Sachin Kamat wrote:
> 'of_id' is dereferenced before NULL pointer check. Move it to
> after the check.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
> Compile tested.
> ---
>   drivers/mmc/host/wmt-sdmmc.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/wmt-sdmmc.c b/drivers/mmc/host/wmt-sdmmc.c
> index 34231d5..3523a72 100644
> --- a/drivers/mmc/host/wmt-sdmmc.c
> +++ b/drivers/mmc/host/wmt-sdmmc.c
> @@ -771,7 +771,7 @@ static int wmt_mci_probe(struct platform_device *pdev)
>   	struct device_node *np = pdev->dev.of_node;
>   	const struct of_device_id *of_id =
>   		of_match_device(wmt_mci_dt_ids, &pdev->dev);
> -	const struct wmt_mci_caps *wmt_caps = of_id->data;
> +	const struct wmt_mci_caps *wmt_caps;
>   	int ret;
>   	int regular_irq, dma_irq;
>   
> @@ -780,6 +780,8 @@ static int wmt_mci_probe(struct platform_device *pdev)
>   		return -EFAULT;
>   	}
>   
> +	wmt_caps = of_id->data;
> +
>   	if (!np) {
>   		dev_err(&pdev->dev, "Missing SDMMC description in devicetree\n");
>   		return -EFAULT;

While I don't mind either way, this can never fail anyway. arch-vt8500 
is devicetree only, so the only way the driver will get probed is 
through a compatible-match, and .data must be (and is) specified.

I guess it's still good housekeeping to test it to protect future 
changes so:

Acked-by: Tony Prisk <linux@prisktech.co.nz>

Regards
Tony P
