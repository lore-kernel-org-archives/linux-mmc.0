From: "Chaithrika U S" <chaithrika@ti.com>
Subject: RE: [PATCH] davinci: MMC: add cpufreq support
Date: Tue, 24 Nov 2009 10:03:26 +0530
Message-ID: <009901ca6cbf$43862aa0$ca927fe0$@com>
References: <1256040610-30684-1-git-send-email-chaithrika@ti.com> <008101ca5d06$644e23f0$2cea6bd0$@com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:50837 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757451AbZKXEfv (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 23 Nov 2009 23:35:51 -0500
In-Reply-To: <008101ca5d06$644e23f0$2cea6bd0$@com>
Content-Language: en-us
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: 'Chaithrika U S' <chaithrika@ti.com>, linux-kernel@vger.kernel.org
Cc: akpm@linux-foundation.org, davinci-linux-open-source@linux.davincidsp.com, vipin.bhandari@ti.com, khilman@deeprootsystems.com, linux-mmc@vger.kernel.org

Andrew,

Can you please push this patch to mmotm tree as there are no review
comments for this patch.

Regards, 
Chaithrika

On Wed, Nov 04, 2009 at 09:52:16, Chaithrika U S wrote:
> Do you have any review comments or suggestions for this patch?
> 
> Regards, 
> Chaithrika
> 
> On Tue, Oct 20, 2009 at 17:40:10, Chaithrika U S wrote:
> > Add cpufreq support to MMC driver. The clock divider value has to be
> > modified according to the controller input frequency.
> > 
> > Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> > ---
> > This patch applies on top of the following two patches submitted to LKML
> > http://patchwork.kernel.org/patch/54013/
> > http://patchwork.kernel.org/patch/50914/
> > 
> >  drivers/mmc/host/davinci_mmc.c |  100 +++++++++++++++++++++++++++++++++------
> >  1 files changed, 84 insertions(+), 16 deletions(-)
> > 
> > diff --git a/drivers/mmc/host/davinci_mmc.c b/drivers/mmc/host/davinci_mmc.c
> > index fe8f613..b54c779 100644
> > --- a/drivers/mmc/host/davinci_mmc.c
> > +++ b/drivers/mmc/host/davinci_mmc.c
> > @@ -25,6 +25,7 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/clk.h>
> >  #include <linux/err.h>
> > +#include <linux/cpufreq.h>
> >  #include <linux/mmc/host.h>
> >  #include <linux/io.h>
> >  #include <linux/irq.h>
> > @@ -200,6 +201,9 @@ struct mmc_davinci_host {
> >  	u8 version;
> >  	/* for ns in one cycle calculation */
> >  	unsigned ns_in_one_cycle;
> > +#ifdef CONFIG_CPU_FREQ
> > +	struct notifier_block	freq_transition;
> > +#endif
> >  };
> >  
> >  
> > @@ -739,27 +743,12 @@ static unsigned int calculate_freq_for_card(struct mmc_davinci_host *host,
> >  	return mmc_push_pull_divisor;
> >  }
> >  
> > -static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +static void calculate_clk_divider(struct mmc_host *mmc, struct mmc_ios *ios)
> >  {
> >  	unsigned int open_drain_freq = 0, mmc_pclk = 0;
> >  	unsigned int mmc_push_pull_freq = 0;
> >  	struct mmc_davinci_host *host = mmc_priv(mmc);
> >  
> > -	mmc_pclk = host->mmc_input_clk;
> > -	dev_dbg(mmc_dev(host->mmc),
> > -		"clock %dHz busmode %d powermode %d Vdd %04x\n",
> > -		ios->clock, ios->bus_mode, ios->power_mode,
> > -		ios->vdd);
> > -	if (ios->bus_width == MMC_BUS_WIDTH_4) {
> > -		dev_dbg(mmc_dev(host->mmc), "Enabling 4 bit mode\n");
> > -		writel(readl(host->base + DAVINCI_MMCCTL) | MMCCTL_WIDTH_4_BIT,
> > -			host->base + DAVINCI_MMCCTL);
> > -	} else {
> > -		dev_dbg(mmc_dev(host->mmc), "Disabling 4 bit mode\n");
> > -		writel(readl(host->base + DAVINCI_MMCCTL) & ~MMCCTL_WIDTH_4_BIT,
> > -			host->base + DAVINCI_MMCCTL);
> > -	}
> > -
> >  	if (ios->bus_mode == MMC_BUSMODE_OPENDRAIN) {
> >  		u32 temp;
> >  
> > @@ -798,6 +787,29 @@ static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> >  
> >  		udelay(10);
> >  	}
> > +}
> > +
> > +static void mmc_davinci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
> > +{
> > +	unsigned int mmc_pclk = 0;
> > +	struct mmc_davinci_host *host = mmc_priv(mmc);
> > +
> > +	mmc_pclk = host->mmc_input_clk;
> > +	dev_dbg(mmc_dev(host->mmc),
> > +		"clock %dHz busmode %d powermode %d Vdd %04x\n",
> > +		ios->clock, ios->bus_mode, ios->power_mode,
> > +		ios->vdd);
> > +	if (ios->bus_width == MMC_BUS_WIDTH_4) {
> > +		dev_dbg(mmc_dev(host->mmc), "Enabling 4 bit mode\n");
> > +		writel(readl(host->base + DAVINCI_MMCCTL) | MMCCTL_WIDTH_4_BIT,
> > +			host->base + DAVINCI_MMCCTL);
> > +	} else {
> > +		dev_dbg(mmc_dev(host->mmc), "Disabling 4 bit mode\n");
> > +		writel(readl(host->base + DAVINCI_MMCCTL) & ~MMCCTL_WIDTH_4_BIT,
> > +			host->base + DAVINCI_MMCCTL);
> > +	}
> > +
> > +	calculate_clk_divider(mmc, ios);
> >  
> >  	host->bus_mode = ios->bus_mode;
> >  	if (ios->power_mode == MMC_POWER_UP) {
> > @@ -1040,6 +1052,52 @@ static struct mmc_host_ops mmc_davinci_ops = {
> >  
> >  /*----------------------------------------------------------------------*/
> >  
> > +#ifdef CONFIG_CPU_FREQ
> > +static int mmc_davinci_cpufreq_transition(struct notifier_block *nb,
> > +				     unsigned long val, void *data)
> > +{
> > +	struct mmc_davinci_host *host;
> > +	unsigned int mmc_pclk;
> > +	struct mmc_host *mmc;
> > +	unsigned long flags;
> > +
> > +	host = container_of(nb, struct mmc_davinci_host, freq_transition);
> > +	mmc = host->mmc;
> > +	mmc_pclk = clk_get_rate(host->clk);
> > +
> > +	if (val == CPUFREQ_POSTCHANGE) {
> > +		spin_lock_irqsave(&mmc->lock, flags);
> > +		host->mmc_input_clk = mmc_pclk;
> > +		calculate_clk_divider(mmc, &mmc->ios);
> > +		spin_unlock_irqrestore(&mmc->lock, flags);
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static inline int mmc_davinci_cpufreq_register(struct mmc_davinci_host *host)
> > +{
> > +	host->freq_transition.notifier_call = mmc_davinci_cpufreq_transition;
> > +
> > +	return cpufreq_register_notifier(&host->freq_transition,
> > +					 CPUFREQ_TRANSITION_NOTIFIER);
> > +}
> > +
> > +static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
> > +{
> > +	cpufreq_unregister_notifier(&host->freq_transition,
> > +				    CPUFREQ_TRANSITION_NOTIFIER);
> > +}
> > +#else
> > +static inline int mmc_davinci_cpufreq_register(struct mmc_davinci_host *host)
> > +{
> > +	return 0;
> > +}
> > +
> > +static inline void mmc_davinci_cpufreq_deregister(struct mmc_davinci_host *host)
> > +{
> > +}
> > +#endif
> >  static void __init init_mmcsd_host(struct mmc_davinci_host *host)
> >  {
> >  	/* DAT line portion is diabled and in reset state */
> > @@ -1169,6 +1227,12 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, host);
> >  
> > +	ret = mmc_davinci_cpufreq_register(host);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "failed to register cpufreq\n");
> > +		goto cpu_freq_fail;
> > +	}
> > +
> >  	ret = mmc_add_host(mmc);
> >  	if (ret < 0)
> >  		goto out;
> > @@ -1186,6 +1250,8 @@ static int __init davinci_mmcsd_probe(struct platform_device *pdev)
> >  	return 0;
> >  
> >  out:
> > +	mmc_davinci_cpufreq_deregister(host);
> > +cpu_freq_fail:
> >  	if (host) {
> >  		davinci_release_dma_channels(host);
> >  
> > @@ -1215,6 +1281,8 @@ static int __exit davinci_mmcsd_remove(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, NULL);
> >  	if (host) {
> > +		mmc_davinci_cpufreq_deregister(host);
> > +
> >  		mmc_remove_host(host->mmc);
> >  		free_irq(host->irq, host);
> >  
> > -- 
> > 1.5.6
> > 
> 
> 



