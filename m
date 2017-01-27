From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 12/13] mmc: bcm2835: move timeout to thread context
Date: Fri, 27 Jan 2017 10:08:53 +0800
Message-ID: <6ba37cf8-7fbb-3067-1b5a-b8e01ffff532@rock-chips.com>
References: <1485473846-24537-1-git-send-email-kraxel@redhat.com>
 <1485473846-24537-13-git-send-email-kraxel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1485473846-24537-13-git-send-email-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Gerd Hoffmann <kraxel@redhat.com>, linux-rpi-kernel@lists.infradead.org
Cc: Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, "maintainer:BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE..." <bcm-kernel-feedback-list@broadcom.com>, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 2017/1/27 7:37, Gerd Hoffmann wrote:
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  drivers/mmc/host/bcm2835.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index fc2d02f..82caddc 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -147,7 +147,7 @@ struct bcm2835_host {
>  	u32			pio_timeout;	/* In jiffies */
>  	int			clock;		/* Current clock speed */
>  	unsigned int		max_clk;	/* Max possible freq */
> -	struct timer_list	timer;		/* Timer for timeouts */
> +	struct delayed_work     timeout_work;   /* Timer for timeouts */
>  	struct sg_mapping_iter	sg_miter;	/* SG state for PIO */
>  	unsigned int		blocks;		/* remaining PIO blocks */
>  	int			irq;		/* Device IRQ */
> @@ -669,12 +669,11 @@ bool bcm2835_send_command(struct bcm2835_host *host,
>  		return false;
>  	}
>
> -	timeout = jiffies;
>  	if (!cmd->data && cmd->busy_timeout > 9000)
> -		timeout += DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;
> +		timeout = DIV_ROUND_UP(cmd->busy_timeout, 1000) * HZ + HZ;

You should elaborate more to help folks understand
what you want to do here...


>  	else
> -		timeout += 10 * HZ;
> -	mod_timer(&host->timer, timeout);
> +		timeout = 10 * HZ;
> +	schedule_delayed_work(&host->timeout_work, timeout);
>
>  	host->cmd = cmd;
>
> @@ -912,9 +911,11 @@ static void bcm2835_finish_command(struct bcm2835_host *host)
>  	}
>  }
>
> -static void bcm2835_timeout(unsigned long data)
> +static void bcm2835_timeout(struct work_struct *work)
>  {
> -	struct bcm2835_host *host = (struct bcm2835_host *)data;
> +	struct delayed_work *d = to_delayed_work(work);
> +	struct bcm2835_host *host =
> +		container_of(d, struct bcm2835_host, timeout_work);
>  	struct device *dev = &host->pdev->dev;
>
>  	mutex_lock(&host->mutex);
> @@ -1303,7 +1304,7 @@ static void bcm2835_finish_request(struct bcm2835_host *host)
>  	struct dma_chan *terminate_chan = NULL;
>  	struct mmc_request *mrq;
>
> -	del_timer(&host->timer);
> +	cancel_delayed_work(&host->timeout_work);
>
>  	mrq = host->mrq;
>
> @@ -1387,8 +1388,7 @@ int bcm2835_add_host(struct bcm2835_host *host)
>  	/* report supported voltage ranges */
>  	mmc->ocr_avail = MMC_VDD_32_33 | MMC_VDD_33_34;
>
> -	setup_timer(&host->timer, bcm2835_timeout,
> -		    (unsigned long)host);
> +	INIT_DELAYED_WORK(&host->timeout_work, bcm2835_timeout);
>
>  	/* Set interrupt enables */
>  	host->hcfg = SDHCFG_BUSY_IRPT_EN;
> @@ -1523,7 +1523,7 @@ static int bcm2835_remove(struct platform_device *pdev)
>
>  	free_irq(host->irq, host);
>
> -	del_timer_sync(&host->timer);
> +	cancel_delayed_work_sync(&host->timeout_work);
>
>  	mmc_free_host(host->mmc);
>  	platform_set_drvdata(pdev, NULL);
>


-- 
Best Regards
Shawn Lin
