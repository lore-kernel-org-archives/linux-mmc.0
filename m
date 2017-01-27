From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 04/13] mmc: bcm2835: add bcm2835_check_data_error
Date: Fri, 27 Jan 2017 10:05:25 +0800
Message-ID: <3876dea7-cd61-e7cf-e838-8bab6927c8fb@rock-chips.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-5-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485473846-24537-5-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2017/1/27 7:37, Gerd Hoffmann wrote:
> Factor out common code.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/mmc/host/bcm2835.c | 30 ++++++++++++------------------
>  1 file changed, 12 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index 6f9fb12..d25b85a 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -951,6 +951,16 @@ static void bcm2835_timeout(unsigned long data)
>  	spin_unlock_irqrestore(&host->lock, flags);
>  }
>
> +static void bcm2835_check_data_error(struct bcm2835_host *host, u32 intmask)
> +{
> +	if (!host->data)
> +		return;
> +	if (intmask & (SDHSTS_CRC16_ERROR | SDHSTS_FIFO_ERROR))
> +		host->data->error = -EILSEQ;
> +	if (intmask & SDHSTS_REW_TIME_OUT)
> +		host->data->error = -ETIMEDOUT;
> +}
> +
>  static void bcm2835_busy_irq(struct bcm2835_host *host, u32 intmask)
>  {
>  	struct device *dev = &host->pdev->dev;
> @@ -1007,15 +1017,7 @@ static void bcm2835_data_irq(struct bcm2835_host *host, u32 intmask)
>  	if (!host->data)
>  		return;
>

remove this check, !host->data, as well.

> -	if (intmask & (SDHSTS_CRC16_ERROR |
> -		       SDHSTS_FIFO_ERROR |
> -		       SDHSTS_REW_TIME_OUT)) {
> -		if (intmask & (SDHSTS_CRC16_ERROR |
> -			       SDHSTS_FIFO_ERROR))
> -			host->data->error = -EILSEQ;
> -		else
> -			host->data->error = -ETIMEDOUT;
> -	}
> +	bcm2835_check_data_error(host, intmask);
>
>  	if (host->data->error) {
>  		bcm2835_finish_data(host);
> @@ -1043,15 +1045,7 @@ static void bcm2835_block_irq(struct bcm2835_host *host, u32 intmask)
>  		return;
>  	}
>
> -	if (intmask & (SDHSTS_CRC16_ERROR |
> -		       SDHSTS_FIFO_ERROR |
> -		       SDHSTS_REW_TIME_OUT)) {
> -		if (intmask & (SDHSTS_CRC16_ERROR |
> -			       SDHSTS_FIFO_ERROR))
> -			host->data->error = -EILSEQ;
> -		else
> -			host->data->error = -ETIMEDOUT;
> -	}
> +	bcm2835_check_data_error(host, intmask);
>
>  	if (!host->dma_desc) {
>  		WARN_ON(!host->blocks);
>


-- 
Best Regards
Shawn Lin
