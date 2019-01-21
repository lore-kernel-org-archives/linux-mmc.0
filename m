From: Alexander Graf <agraf-l3A5Bk7waGM@public.gmane.org>
Subject: Re: [PATCH 3/4] mmc: bcm2835: Drop pointer to mmc_host from
 bcm2835_host
Date: Mon, 21 Jan 2019 15:20:37 +0100
Message-ID: <461f638c-7bf9-1db2-cdf1-6acfa2c8c51a@suse.de>
References: <9b09dda9817f61a0cfb3991abf11abb1fe7f41c9.1547911374.git.lukas@wunner.de>
 <2140f7852cd0186ec705057d83992a49fbc625f4.1547911374.git.lukas@wunner.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <2140f7852cd0186ec705057d83992a49fbc625f4.1547911374.git.lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Eric Anholt <eric-WhKQ6XTQaPysTnJN9+BGXg@public.gmane.org>, Stefan Wahren <stefan.wahren-eS4NqCHxEME@public.gmane.org>
Cc: Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

On 01/19/2019 04:31 PM, Lukas Wunner wrote:
> The BCM2835 MMC host driver uses a pointer to get from the private
> bcm2835_host structure to the generic mmc_host structure.  However the
> latter is always immediately preceding the former in memory, so compute
> its address with a subtraction (which is cheaper than a dereference) and
> drop the superfluous pointer.
>
> No functional change intended.
>
> Signed-off-by: Lukas Wunner <lukas-JFq808J9C/izQB+pC5nmwQ@public.gmane.org>
> Cc: Frank Pavlic <f.pavlic-XB/JSsFECOqzQB+pC5nmwQ@public.gmane.org>
> ---
>   drivers/mmc/host/bcm2835.c | 20 ++++++++++----------
>   include/linux/mmc/host.h   |  5 +++++
>   2 files changed, 15 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/mmc/host/bcm2835.c b/drivers/mmc/host/bcm2835.c
> index ab8d58a60352..246c8ec24148 100644
> --- a/drivers/mmc/host/bcm2835.c
> +++ b/drivers/mmc/host/bcm2835.c
> @@ -148,7 +148,6 @@ struct bcm2835_host {
>   	void __iomem		*ioaddr;
>   	u32			phys_addr;
>   
> -	struct mmc_host		*mmc;
>   	struct platform_device	*pdev;
>   
>   	int			clock;		/* Current clock speed */
> @@ -618,7 +617,7 @@ static void bcm2835_finish_request(struct bcm2835_host *host)
>   				"failed to terminate DMA (%d)\n", err);
>   	}
>   
> -	mmc_request_done(host->mmc, mrq);
> +	mmc_request_done(mmc_from_priv(host), mrq);
>   }
>   
>   static
> @@ -837,7 +836,7 @@ static void bcm2835_timeout(struct work_struct *work)
>   		dev_err(dev, "timeout waiting for hardware interrupt.\n");
>   		bcm2835_dumpregs(host);
>   
> -		bcm2835_reset(host->mmc);
> +		bcm2835_reset(mmc_from_priv(host));
>   
>   		if (host->data) {
>   			host->data->error = -ETIMEDOUT;
> @@ -1100,6 +1099,7 @@ static void bcm2835_dma_complete_work(struct work_struct *work)
>   
>   static void bcm2835_set_clock(struct bcm2835_host *host, unsigned int clock)
>   {
> +	struct mmc_host *mmc = mmc_from_priv(host);
>   	int div;
>   
>   	/* The SDCDIV register has 11 bits, and holds (div - 2).  But
> @@ -1143,18 +1143,18 @@ static void bcm2835_set_clock(struct bcm2835_host *host, unsigned int clock)
>   		div = SDCDIV_MAX_CDIV;
>   
>   	clock = host->max_clk / (div + 2);
> -	host->mmc->actual_clock = clock;
> +	mmc->actual_clock = clock;
>   
>   	/* Calibrate some delays */
>   
>   	host->ns_per_fifo_word = (1000000000 / clock) *
> -		((host->mmc->caps & MMC_CAP_4_BIT_DATA) ? 8 : 32);
> +		((mmc->caps & MMC_CAP_4_BIT_DATA) ? 8 : 32);
>   
>   	host->cdiv = div;
>   	writel(host->cdiv, host->ioaddr + SDCDIV);
>   
>   	/* Set the timeout to 500ms */
> -	writel(host->mmc->actual_clock / 2, host->ioaddr + SDTOUT);
> +	writel(mmc->actual_clock / 2, host->ioaddr + SDTOUT);
>   }
>   
>   static void bcm2835_request(struct mmc_host *mmc, struct mmc_request *mrq)
> @@ -1264,7 +1264,7 @@ static const struct mmc_host_ops bcm2835_ops = {
>   
>   static int bcm2835_add_host(struct bcm2835_host *host)
>   {
> -	struct mmc_host *mmc = host->mmc;
> +	struct mmc_host *mmc = mmc_from_priv(host);
>   	struct device *dev = &host->pdev->dev;
>   	char pio_limit_string[20];
>   	int ret;
> @@ -1370,7 +1370,6 @@ static int bcm2835_probe(struct platform_device *pdev)
>   
>   	mmc->ops = &bcm2835_ops;
>   	host = mmc_priv(mmc);
> -	host->mmc = mmc;
>   	host->pdev = pdev;
>   	spin_lock_init(&host->lock);
>   
> @@ -1441,8 +1440,9 @@ static int bcm2835_probe(struct platform_device *pdev)
>   static int bcm2835_remove(struct platform_device *pdev)
>   {
>   	struct bcm2835_host *host = platform_get_drvdata(pdev);
> +	struct mmc_host *mmc = mmc_from_priv(host);
>   
> -	mmc_remove_host(host->mmc);
> +	mmc_remove_host(mmc);
>   
>   	writel(SDVDD_POWER_OFF, host->ioaddr + SDVDD);
>   
> @@ -1454,7 +1454,7 @@ static int bcm2835_remove(struct platform_device *pdev)
>   	if (host->dma_chan_rxtx)
>   		dma_release_channel(host->dma_chan_rxtx);
>   
> -	mmc_free_host(host->mmc);
> +	mmc_free_host(mmc);
>   	platform_set_drvdata(pdev, NULL);
>   
>   	return 0;
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index 4d35ff36ceff..26e050799439 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -478,6 +478,11 @@ static inline void *mmc_priv(struct mmc_host *host)
>   	return (void *)host->private;
>   }
>   
> +static inline struct mmc_host *mmc_from_priv(void *priv)
> +{
> +	return priv - offsetof(struct mmc_host, private);

Can you use container_of() instead here?


Alex
