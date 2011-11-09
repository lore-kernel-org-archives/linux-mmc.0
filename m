From: Sujit Reddy Thumma <sthumma@codeaurora.org>
Subject: Re: [PATCH V2] mmc: core: Use delayed work in clock gating framework
Date: Wed, 09 Nov 2011 10:12:36 +0530
Message-ID: <4EBA04BC.2010507@codeaurora.org>
References: <1319699643-30700-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from wolverine02.qualcomm.com ([199.106.114.251]:20889 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755371Ab1KIEmm (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 8 Nov 2011 23:42:42 -0500
In-Reply-To: <1319699643-30700-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, cjb@laptop.org

On 10/27/2011 12:44 PM, Sujit Reddy Thumma wrote:
> Current clock gating framework disables the MCI clock as soon as the
> request is completed and enables it when a request arrives. This aggressive
> clock gating framework, when enabled, cause following issues:
>
> When there are back-to-back requests from the Queue layer, we unnecessarily
> end up disabling and enabling the clocks between these requests since 8MCLK
> clock cycles is a very short duration compared to the time delay between
> back to back requests reaching the MMC layer. This overhead can effect the
> overall performance depending on how long the clock enable and disable
> calls take which is platform dependent. For example on some platforms we
> can have clock control not on the local processor, but on a different
> subsystem and the time taken to perform the clock enable/disable can add
> significant overhead.
>
> Also if the host controller driver decides to disable the host clock too
> when mmc_set_ios function is called with ios.clock=0, it adds additional
> delay and it is highly possible that the next request had already arrived
> and unnecessarily blocked in enabling the clocks. This is seen frequently
> when the processor is executing at high speeds and in multi-core platforms
> thus reduces the overall throughput compared to if clock gating is
> disabled.
>
> Fix this by delaying turning off the clocks by posting request on
> delayed workqueue. Also cancel the unscheduled pending work, if any,
> when there is access to card.
>
> sysfs entry is provided to tune the delay as needed, default
> value set to 200ms.
>
> Signed-off-by: Sujit Reddy Thumma<sthumma@codeaurora.org>
>
> ---
> Changes in v2:
> 	- support for tuning delay via sysfs entry.

Linus/Chris, any comments on this V2 version?

> ---
>   drivers/mmc/core/host.c  |   57 ++++++++++++++++++++++++++++++++++++++++++---
>   include/linux/mmc/host.h |    4 ++-
>   2 files changed, 56 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index ca2e4f5..ba4cc5d 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -53,6 +53,31 @@ static DEFINE_IDR(mmc_host_idr);
>   static DEFINE_SPINLOCK(mmc_host_lock);
>
>   #ifdef CONFIG_MMC_CLKGATE
> +static ssize_t clkgate_delay_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct mmc_host *host = cls_dev_to_mmc_host(dev);
> +	return snprintf(buf, PAGE_SIZE, "%lu millisecs\n",
> +			host->clkgate_delay);
> +}
> +
> +static ssize_t clkgate_delay_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct mmc_host *host = cls_dev_to_mmc_host(dev);
> +	unsigned long flags, value;
> +
> +	if (kstrtoul(buf, 0,&value))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&host->clk_lock, flags);
> +	host->clkgate_delay = value;
> +	spin_unlock_irqrestore(&host->clk_lock, flags);
> +
> +	pr_info("%s: clock gate delay set to %lu ms\n",
> +			mmc_hostname(host), value);
> +	return count;
> +}
>
>   /*
>    * Enabling clock gating will make the core call out to the host
> @@ -113,7 +138,7 @@ static void mmc_host_clk_gate_delayed(struct mmc_host *host)
>   static void mmc_host_clk_gate_work(struct work_struct *work)
>   {
>   	struct mmc_host *host = container_of(work, struct mmc_host,
> -					      clk_gate_work);
> +					      clk_gate_work.work);
>
>   	mmc_host_clk_gate_delayed(host);
>   }
> @@ -130,6 +155,8 @@ void mmc_host_clk_hold(struct mmc_host *host)
>   {
>   	unsigned long flags;
>
> +	/* cancel any clock gating work scheduled by mmc_host_clk_release() */
> +	cancel_delayed_work_sync(&host->clk_gate_work);
>   	mutex_lock(&host->clk_gate_mutex);
>   	spin_lock_irqsave(&host->clk_lock, flags);
>   	if (host->clk_gated) {
> @@ -179,7 +206,8 @@ void mmc_host_clk_release(struct mmc_host *host)
>   	host->clk_requests--;
>   	if (mmc_host_may_gate_card(host->card)&&
>   	!host->clk_requests)
> -		queue_work(system_nrt_wq,&host->clk_gate_work);
> +		queue_delayed_work(system_nrt_wq,&host->clk_gate_work,
> +				msecs_to_jiffies(host->clkgate_delay));
>   	spin_unlock_irqrestore(&host->clk_lock, flags);
>   }
>
> @@ -212,8 +240,13 @@ static inline void mmc_host_clk_init(struct mmc_host *host)
>   	host->clk_requests = 0;
>   	/* Hold MCI clock for 8 cycles by default */
>   	host->clk_delay = 8;
> +	/*
> +	 * Default clock gating delay is 200ms.
> +	 * This value can be tuned by writing into sysfs entry.
> +	 */
> +	host->clkgate_delay = 200;
>   	host->clk_gated = false;
> -	INIT_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
> +	INIT_DELAYED_WORK(&host->clk_gate_work, mmc_host_clk_gate_work);
>   	spin_lock_init(&host->clk_lock);
>   	mutex_init(&host->clk_gate_mutex);
>   }
> @@ -228,7 +261,7 @@ static inline void mmc_host_clk_exit(struct mmc_host *host)
>   	 * Wait for any outstanding gate and then make sure we're
>   	 * ungated before exiting.
>   	 */
> -	if (cancel_work_sync(&host->clk_gate_work))
> +	if (cancel_delayed_work_sync(&host->clk_gate_work))
>   		mmc_host_clk_gate_delayed(host);
>   	if (host->clk_gated)
>   		mmc_host_clk_hold(host);
> @@ -236,6 +269,17 @@ static inline void mmc_host_clk_exit(struct mmc_host *host)
>   	WARN_ON(host->clk_requests>  1);
>   }
>
> +static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
> +{
> +	host->clkgate_delay_attr.show = clkgate_delay_show;
> +	host->clkgate_delay_attr.store = clkgate_delay_store;
> +	sysfs_attr_init(&host->clkgate_delay_attr.attr);
> +	host->clkgate_delay_attr.attr.name = "clkgate_delay";
> +	host->clkgate_delay_attr.attr.mode = S_IRUGO | S_IWUSR;
> +	if (device_create_file(&host->class_dev,&host->clkgate_delay_attr))
> +		pr_err("%s: Failed to create clkgate_delay sysfs entry\n",
> +				mmc_hostname(host));
> +}
>   #else
>
>   static inline void mmc_host_clk_init(struct mmc_host *host)
> @@ -246,6 +290,10 @@ static inline void mmc_host_clk_exit(struct mmc_host *host)
>   {
>   }
>
> +static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
> +{
> +}
> +
>   #endif
>
>   /**
> @@ -345,6 +393,7 @@ int mmc_add_host(struct mmc_host *host)
>   #ifdef CONFIG_DEBUG_FS
>   	mmc_add_host_debugfs(host);
>   #endif
> +	mmc_host_clk_sysfs_init(host);
>
>   	mmc_start_host(host);
>   	register_pm_notifier(&host->pm_notify);
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index a3ac9c4..7206c80 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -253,10 +253,12 @@ struct mmc_host {
>   	int			clk_requests;	/* internal reference counter */
>   	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
>   	bool			clk_gated;	/* clock gated */
> -	struct work_struct	clk_gate_work; /* delayed clock gate */
> +	struct delayed_work	clk_gate_work; /* delayed clock gate */
>   	unsigned int		clk_old;	/* old clock value cache */
>   	spinlock_t		clk_lock;	/* lock for clk fields */
>   	struct mutex		clk_gate_mutex;	/* mutex for clock gating */
> +	struct device_attribute clkgate_delay_attr;
> +	unsigned long           clkgate_delay;
>   #endif
>
>   	/* host specific block data */


-- 
Thanks & Regards,
Sujit Reddy Thumma
