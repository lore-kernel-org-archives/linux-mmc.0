From: Michal Simek <michal.simek@xilinx.com>
Subject: Re: [PATCH 2/2] mmc/host/sdhci-of-arasan.c: Skip EPROBE_DEFER error
 messages
Date: Thu, 23 Oct 2014 13:47:45 +0200
Message-ID: <40072ff932074ee189999faf5dc0a434@BL2FFO11FD037.protection.gbl>
References: <1414063861-5491-1-git-send-email-mike.looijmans@topic.nl>
 <1414063861-5491-2-git-send-email-mike.looijmans@topic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414063861-5491-2-git-send-email-mike.looijmans@topic.nl>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: michal.simek@xilinx.com, chris@printf.net, ulf.hansson@linaro.org
List-Id: linux-mmc@vger.kernel.org

Hi Chris,

On 10/23/2014 01:31 PM, Mike Looijmans wrote:
> When the error code is -EPROBE_DEFER, this will already be reported
> so don't emit an error message in that case.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
>  drivers/mmc/host/sdhci-of-arasan.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index 7ac6718..d5812a0 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -161,7 +161,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  	host = sdhci_pltfm_init(pdev, &sdhci_arasan_pdata, 0);
>  	if (IS_ERR(host)) {
>  		ret = PTR_ERR(host);
> -		dev_err(&pdev->dev, "platform init failed (%d)\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "platform init failed (%d)\n", ret);
>  		goto clk_disable_all;
>  	}
>  
> @@ -172,7 +173,8 @@ static int sdhci_arasan_probe(struct platform_device *pdev)
>  
>  	ret = sdhci_add_host(host);
>  	if (ret) {
> -		dev_err(&pdev->dev, "platform register failed (%d)\n", ret);
> +		if (ret != -EPROBE_DEFER)
> +			dev_err(&pdev->dev, "platform register failed (%d)\n", ret);
>  		goto err_pltfm_free;
>  	}


I checked other drivers and they are not reporting these bugs. I have briefly looked
at sdhci_add_host and sdhci_platfm_init and they are pretty good error description
+ core itself should report if driver probe failed.
That's why I think that it is just reasonable to remove these both dev_err completely.

What do you think?

Thanks,
Michal
