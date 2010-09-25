From: Philip Rakity <prakity@marvell.com>
Subject: sdhci: Best Practice Question
Date: Sat, 25 Sep 2010 13:08:20 -0700
Message-ID: <E6553F30-7D88-476A-A8AF-3F7793FA4DE0@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog106.obsmtp.com ([74.125.149.77]:55761 "HELO
	na3sys009aog106.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1755237Ab0IYUIX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Sat, 25 Sep 2010 16:08:23 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

and a 
host->ops-> get_max_clock()
function that is used to set the max clock.  The code snippet is below


	host->max_clk =
		(caps & SDHCI_CLOCK_BASE_MASK) >> SDHCI_CLOCK_BASE_SHIFT;
	host->max_clk *= 1000000;
	if (host->max_clk == 0 || host->quirks &
			SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN) {
		if (!host->ops->get_max_clock) {
			printk(KERN_ERR
			       "%s: Hardware doesn't specify base clock "
			       "frequency.\n", mmc_hostname(mmc));
			return -ENODEV;
		}
		host->max_clk = host->ops->get_max_clock(host);
	}


The quirk seems redundant since this could be coded as follows to remove the need for the quirk

> +	if (host->ops->get_max_clock)
> 		host->max_clk = host->ops->get_max_clock(host);
> +	else {
> +		host->max_clk =
> +			(caps & SDHCI_CLOCK_BASE_MASK) 
> +				>> SDHCI_CLOCK_BASE_SHIFT;
> +		host->max_clk *= 1000000;
> +	}
> +
> +	if (host->max_clk == 0) {
> +		printk(KERN_ERR
> +		       "%s: Hardware doesn't specify base clock "
> +		       "frequency.\n", mmc_hostname(mmc));
> +		return -ENODEV;
> 	}
> 


This approach was not used since it was felt a quirk was needed.

http://kerneltrap.org/mailarchive/linux-kernel/2010/2/19/4540115

but the quirk redundant and it requires two items be set; the quirk and the callback.
Defining the quirk and not the callback is meaningless.  

The change proposed by Richard Zhu for handling write protect uses only a callback.

<snip>
static int sdhci_get_ro(struct mmc_host *mmc)
{
	struct sdhci_host *host;
	unsigned long flags;
	int present;

	host = mmc_priv(mmc);

	if (host->ops->get_ro)
		return host->ops->get_ro(host);

	spin_lock_irqsave(&host->lock, flags);

<end snip>

What is the correct practice?  

Philip