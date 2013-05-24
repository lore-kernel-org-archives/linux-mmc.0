From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH 2/2] mmc: sdhci-s3c: Added set_power handler to platdata
Date: Fri, 24 May 2013 12:57:51 +0900
Message-ID: <519EE53F.6010005@samsung.com>
References: <1369244832-23868-1-git-send-email-eu@felipetonello.com>
 <1369244832-23868-3-git-send-email-eu@felipetonello.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:28471 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759956Ab3EXD5p (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 23 May 2013 23:57:45 -0400
In-reply-to: <1369244832-23868-3-git-send-email-eu@felipetonello.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Felipe F. Tonello" <eu@felipetonello.com>
Cc: linux-mmc@vger.kernel.org, ben-linux@fluff.org, cjb@laptop.org, arnd@arndb.de, linux-kernel@vger.kernel.org

Hi Felipe,

I didn't understand this patch, why need to add set_power?
We can use to control the power with the fixed regulator.
Then we can also use the regulator framework.
And i know also control the module like wifi with rfkill.
In set_power, what is it controlled?

Best Regards,
Jaehoon Chung
On 05/23/2013 02:47 AM, Felipe F. Tonello wrote:
> From: "Felipe F. Tonello" <eu@felipetonello.com>
> 
> This is useful to turn off peripherals that are related to the mmc host. One
> common case is when the wifi module is connected as an mmc card to the host.
> 
> Signed-off-by: Felipe F. Tonello <eu@felipetonello.com>
> ---
>  drivers/mmc/host/sdhci-s3c.c                | 8 ++++++++
>  include/linux/platform_data/mmc-sdhci-s3c.h | 1 +
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/mmc/host/sdhci-s3c.c b/drivers/mmc/host/sdhci-s3c.c
> index c6f6246..f7e740c 100644
> --- a/drivers/mmc/host/sdhci-s3c.c
> +++ b/drivers/mmc/host/sdhci-s3c.c
> @@ -360,11 +360,19 @@ static int sdhci_s3c_platform_bus_width(struct sdhci_host *host, int width)
>  	return 0;
>  }
>  
> +static void sdhci_s3c_set_power(struct sdhci_host *host, bool power)
> +{
> +	struct sdhci_s3c *ourhost = to_s3c(host);
> +	if (ourhost->pdata->set_power)
> +		ourhost->pdata->set_power(power);
> +}
> +
>  static struct sdhci_ops sdhci_s3c_ops = {
>  	.get_max_clock		= sdhci_s3c_get_max_clk,
>  	.set_clock		= sdhci_s3c_set_clock,
>  	.get_min_clock		= sdhci_s3c_get_min_clock,
>  	.platform_bus_width	= sdhci_s3c_platform_bus_width,
> +	.set_power		= sdhci_s3c_set_power,
>  };
>  
>  static void sdhci_s3c_notify_change(struct platform_device *dev, int state)
> diff --git a/include/linux/platform_data/mmc-sdhci-s3c.h b/include/linux/platform_data/mmc-sdhci-s3c.h
> index 249f023..55be925 100644
> --- a/include/linux/platform_data/mmc-sdhci-s3c.h
> +++ b/include/linux/platform_data/mmc-sdhci-s3c.h
> @@ -50,6 +50,7 @@ struct s3c_sdhci_platdata {
>  						      int state));
>  
>  	void	(*cfg_gpio)(struct platform_device *dev, int width);
> +	void	(*set_power)(bool power);
>  };
>  
>  
> 

