From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH-next] mmc: core: Fixup delayed work clock gating patch
Date: Tue, 06 Dec 2011 14:22:11 +0530
Message-ID: <4EDDD7BB.5040506@codeaurora.org>
References: <1323109724-30898-1-git-send-email-sboyd@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:12039 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932971Ab1LFIwQ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 03:52:16 -0500
In-Reply-To: <1323109724-30898-1-git-send-email-sboyd@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org

On 12/5/2011 11:58 PM, Stephen Boyd wrote:
> c31b50e (mmc: core: Use delayed work in clock gating framework,
> 2011-11-14) missed a few things during review:
>
>   o A useless pr_info()
>
>   o milliseconds was written as two words
>
>   o The sysfs file had units in its output
>
> Fix all three problems.
>
> Cc: Sujit Reddy Thumma<sthumma@codeaurora.org>
> Signed-off-by: Stephen Boyd<sboyd@codeaurora.org>
> ---
>
> Feel free to squash if desired.
>
>   Documentation/mmc/mmc-dev-attrs.txt |    2 +-
>   drivers/mmc/core/host.c             |    6 +-----
>   2 files changed, 2 insertions(+), 6 deletions(-)

Thanks Stephen.

>
> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
> index b024556..22ae844 100644
> --- a/Documentation/mmc/mmc-dev-attrs.txt
> +++ b/Documentation/mmc/mmc-dev-attrs.txt
> @@ -71,6 +71,6 @@ SD/MMC/SDIO Clock Gating Attribute
>   Read and write access is provided to following attribute.
>   This attribute appears only if CONFIG_MMC_CLKGATE is enabled.
>
> -	clkgate_delay	Tune the clock gating delay with desired value in milli seconds.
> +	clkgate_delay	Tune the clock gating delay with desired value in milliseconds.
>
>   echo<desired delay>  >  /sys/class/mmc_host/mmcX/clkgate_delay
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index 835e86a..c152ce0c 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -58,8 +58,7 @@ static ssize_t clkgate_delay_show(struct device *dev,
>   		struct device_attribute *attr, char *buf)
>   {
>   	struct mmc_host *host = cls_dev_to_mmc_host(dev);
> -	return snprintf(buf, PAGE_SIZE, "%lu millisecs\n",
> -			host->clkgate_delay);
> +	return snprintf(buf, PAGE_SIZE, "%lu\n", host->clkgate_delay);
>   }
>
>   static ssize_t clkgate_delay_store(struct device *dev,
> @@ -74,9 +73,6 @@ static ssize_t clkgate_delay_store(struct device *dev,
>   	spin_lock_irqsave(&host->clk_lock, flags);
>   	host->clkgate_delay = value;
>   	spin_unlock_irqrestore(&host->clk_lock, flags);
> -
> -	pr_info("%s: clock gate delay set to %lu ms\n",
> -			mmc_hostname(host), value);
>   	return count;
>   }
>
