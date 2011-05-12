From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH V2 13/16] OMAP: hsmmc: implement clock switcher
Date: Thu, 12 May 2011 03:37:23 -0700
Message-ID: <20110512103723.GJ31483@atomide.com>
References: <1304673255-31634-1-git-send-email-adrian.hunter@nokia.com>
 <1304673255-31634-14-git-send-email-adrian.hunter@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:60872 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756023Ab1ELKh2 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 12 May 2011 06:37:28 -0400
Content-Disposition: inline
In-Reply-To: <1304673255-31634-14-git-send-email-adrian.hunter@nokia.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@nokia.com>
Cc: Madhusudhan Chikkature <madhu.cr@ti.com>, linux-omap Mailing List <linux-omap@vger.kernel.org>, linux-mmc Mailing List <linux-mmc@vger.kernel.org>, linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

* Adrian Hunter <adrian.hunter@nokia.com> [110506 02:13]:
> From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
> 
> There are 3 new platform data methods which should help us to do a clock
> switching when notification is happened or request is started.
> 
> The purpose of the patch is to avoid high frequency of MMC controller on low
> OPPs due to an HW bug in OMAP 3630.
...

> +static int hsmmc_clk_notifier(struct notifier_block *nb, unsigned long event,
> +			      void *data)
> +{
> +	struct cpufreq_freqs *freqs = data;
> +	unsigned int threshold = 400000; /* between opp1 and opp2 */
> +
> +	switch (event) {
> +	case CPUFREQ_PRECHANGE:
> +		if (freqs->new < threshold && freqs->old >= threshold) {
> +			/* opp2 -> opp1 */
> +			hsmmc_max_freq = HSMMC_MAX_FREQ >> 1;
> +
> +			/* Timeout is 1 sec */
> +			if (!wait_event_timeout(hsmmc_max_freq_wq,
> +						hsmmc_max_freq_ok(),
> +						msecs_to_jiffies(1000)))
> +				pr_err("MMC violates maximum frequency "
> +				       "constraint\n");
> +		}
> +		break;
> +	case CPUFREQ_POSTCHANGE:
> +		if (freqs->old < threshold && freqs->new >= threshold) {
> +			/* opp1 -> opp2 */
> +			hsmmc_max_freq = HSMMC_MAX_FREQ;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return NOTIFY_DONE;
> +}

I think the cpufreq notifier code should be in the driver, the platform
init code should just prepare things for the driver.

Regards,

Tony
