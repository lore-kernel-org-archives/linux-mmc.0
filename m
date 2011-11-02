From: Kukjin Kim <kgene.kim@samsung.com>
Subject: RE: [PATCH V6] SDHCI: S3C: Use generic clock names for sdhci bus clock
 options
Date: Wed, 02 Nov 2011 21:12:49 +0900
Message-ID: <005301cc9958$bcf5aa10$36e0fe30$%kim@samsung.com>
References: <1320039876-21148-1-git-send-email-rajeshwari.s@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28090 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752306Ab1KBMMu (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 2 Nov 2011 08:12:50 -0400
In-reply-to: <1320039876-21148-1-git-send-email-rajeshwari.s@samsung.com>
Content-language: ko
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Rajeshwari Shinde' <rajeshwari.s@samsung.com>, linux-mmc@vger.kernel.org, linux-samsung-soc@vger.kernel.org, cjb@laptop.org
Cc: linux-arm-kernel@lists.infradead.org

Rajeshwari Shinde wrote:
> 
> This patch modifies the driver to stop depending on the clock names
> being passed from the platform and switch over to bus clock lookup
> using generic clock names.
> 
> V6 Changes:
> Changed sprintf to snprintf as suggested by Chris Ball.
> 
> Signed-off-by: Rajeshwari Shinde <rajeshwari.s@samsung.com>

Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Hi Chirs,

Could you please pick this up in your tree for this merge window?

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.

> ---
>  drivers/mmc/host/sdhci-s3c.c |    7 ++-----
>  1 files changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index 82709b6..488223c 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -435,14 +435,11 @@ static int __devinit sdhci_s3c_probe(struct
> platform_device *pdev)
> 
>  	for (clks = 0, ptr = 0; ptr < MAX_BUS_CLK; ptr++) {
>  		struct clk *clk;
> -		char *name = pdata->clocks[ptr];
> -
> -		if (name == NULL)
> -			continue;
> +		char name[14];
> 
> +		snprintf(name, 14, "mmc_busclk.%d", ptr);
>  		clk = clk_get(dev, name);
>  		if (IS_ERR(clk)) {
> -			dev_err(dev, "failed to get clock %s\n", name);
>  			continue;
>  		}
> 
> --
> 1.7.4.4

