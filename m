From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] mmc: sdhci-bcm2835: Actually enable the clock
Date: Fri, 29 May 2015 09:35:41 +0100
Message-ID: <20150529083541.GH2067@n2100.arm.linux.org.uk>
References: <1432857792-7421-1-git-send-email-eric@anholt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from pandora.arm.linux.org.uk ([78.32.30.218]:50662 "EHLO
	pandora.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754337AbbE2If5 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 29 May 2015 04:35:57 -0400
Content-Disposition: inline
In-Reply-To: <1432857792-7421-1-git-send-email-eric@anholt.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Eric Anholt <eric@anholt.net>
Cc: linux-arm-kernel@lists.infradead.org, Ulf Hansson <ulf.hansson@linaro.org>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rpi-kernel@lists.infradead.org

On Thu, May 28, 2015 at 05:03:12PM -0700, Eric Anholt wrote:
> We're currently using a fixed frequency clock specified in the DT, so
> enabling is a no-op.  However, the RPi firmware-based clocks driver
> can actually disable unused clocks, so when switching to use it we
> ended up losing our MMC clock once all devices were probed.
> 
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  drivers/mmc/host/sdhci-bcm2835.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-bcm2835.c b/drivers/mmc/host/sdhci-bcm2835.c
> index 0ef0343..09aff3a 100644
> --- a/drivers/mmc/host/sdhci-bcm2835.c
> +++ b/drivers/mmc/host/sdhci-bcm2835.c
> @@ -172,6 +172,11 @@ static int bcm2835_sdhci_probe(struct platform_device *pdev)
>  		ret = PTR_ERR(pltfm_host->clk);
>  		goto err;
>  	}
> +	ret = clk_prepare_enable(pltfm_host->clk);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to enable host clk\n");
> +		goto err;
> +	}
>  
>  	return sdhci_add_host(host);

Where's the error clean-up path for a failed sdhci_add_host()?

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
