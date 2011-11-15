From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH V3] mmc: core: Use delayed work in clock gating framework
Date: Tue, 15 Nov 2011 10:51:15 -0800
Message-ID: <4EC2B4A3.3030700@codeaurora.org>
References: <1321259009-22626-1-git-send-email-sthumma@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1321259009-22626-1-git-send-email-sthumma@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Sujit Reddy Thumma <sthumma@codeaurora.org>
Cc: linux-mmc@vger.kernel.org, linux-arm-msm@vger.kernel.org, cjb@laptop.org
List-Id: linux-mmc@vger.kernel.org

On 11/14/11 00:23, Sujit Reddy Thumma wrote:
> diff --git a/Documentation/mmc/mmc-dev-attrs.txt b/Documentation/mmc/mmc-dev-attrs.txt
> index 8898a95..b024556 100644
> --- a/Documentation/mmc/mmc-dev-attrs.txt
> +++ b/Documentation/mmc/mmc-dev-attrs.txt
> @@ -64,3 +64,13 @@ Note on Erase Size and Preferred Erase Size:
>  	size specified by the card.
>  
>  	"preferred_erase_size" is in bytes.
> +
> +SD/MMC/SDIO Clock Gating Attribute
> +==================================
> +
> +Read and write access is provided to following attribute.
> +This attribute appears only if CONFIG_MMC_CLKGATE is enabled.
> +
> +	clkgate_delay	Tune the clock gating delay with desired value in milli seconds.

milliseconds is one word.

> diff --git a/drivers/mmc/core/host.c b/drivers/mmc/core/host.c
> index ca2e4f5..ba4cc5d 100644
> --- a/drivers/mmc/core/host.c
> +++ b/drivers/mmc/core/host.c
> @@ -53,6 +53,31 @@ static DEFINE_IDR(mmc_host_idr);
>  static DEFINE_SPINLOCK(mmc_host_lock);
>  
>  #ifdef CONFIG_MMC_CLKGATE
> +static ssize_t clkgate_delay_show(struct device *dev,
> +		struct device_attribute *attr, char *buf)
> +{
> +	struct mmc_host *host = cls_dev_to_mmc_host(dev);
> +	return snprintf(buf, PAGE_SIZE, "%lu millisecs\n",

Perhaps this should just be %lu to simplify userspace parsing.

> +static ssize_t clkgate_delay_store(struct device *dev,
> +		struct device_attribute *attr, const char *buf, size_t count)
> +{
> +	struct mmc_host *host = cls_dev_to_mmc_host(dev);
> +	unsigned long flags, value;
> +
> +	if (kstrtoul(buf, 0, &value))
> +		return -EINVAL;
> +
> +	spin_lock_irqsave(&host->clk_lock, flags);
> +	host->clkgate_delay = value;
> +	spin_unlock_irqrestore(&host->clk_lock, flags);
> +
> +	pr_info("%s: clock gate delay set to %lu ms\n",
> +			mmc_hostname(host), value);

Is this pr_info() necessary?

> @@ -236,6 +269,17 @@ static inline void mmc_host_clk_exit(struct mmc_host *host)
>  	WARN_ON(host->clk_requests > 1);
>  }
>  
> +static inline void mmc_host_clk_sysfs_init(struct mmc_host *host)
> +{
> +	host->clkgate_delay_attr.show = clkgate_delay_show;
> +	host->clkgate_delay_attr.store = clkgate_delay_store;
> +	sysfs_attr_init(&host->clkgate_delay_attr.attr);
> +	host->clkgate_delay_attr.attr.name = "clkgate_delay";
> +	host->clkgate_delay_attr.attr.mode = S_IRUGO | S_IWUSR;
> +	if (device_create_file(&host->class_dev, &host->clkgate_delay_attr))
> +		pr_err("%s: Failed to create clkgate_delay sysfs entry\n",
> +				mmc_hostname(host));
> +}

Would it be simpler to assign dev_attrs in the mmc_host_class instead?

> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
> index a3ac9c4..7206c80 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -253,10 +253,12 @@ struct mmc_host {
>  	int			clk_requests;	/* internal reference counter */
>  	unsigned int		clk_delay;	/* number of MCI clk hold cycles */
>  	bool			clk_gated;	/* clock gated */
> -	struct work_struct	clk_gate_work; /* delayed clock gate */
> +	struct delayed_work	clk_gate_work; /* delayed clock gate */
>  	unsigned int		clk_old;	/* old clock value cache */
>  	spinlock_t		clk_lock;	/* lock for clk fields */
>  	struct mutex		clk_gate_mutex;	/* mutex for clock gating */
> +	struct device_attribute clkgate_delay_attr;

If you used the class device attributes then this would probably go away.

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
