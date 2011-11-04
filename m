From: Giuseppe CAVALLARO <peppe.cavallaro@st.com>
Subject: Re: [PATCH] mmc: debugfs: expose the SDCLK frq in sys ios (V4)
Date: Fri, 04 Nov 2011 07:56:51 +0100
Message-ID: <4EB38CB3.2000009@st.com>
References: <1320302737-32312-1-git-send-email-peppe.cavallaro@st.com> <4EB245BE.2020200@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from eu1sys200aog101.obsmtp.com ([207.126.144.111]:57202 "EHLO
	eu1sys200aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751328Ab1KDG5A (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 4 Nov 2011 02:57:00 -0400
In-Reply-To: <4EB245BE.2020200@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, sebras@gmail.com

On 11/3/2011 8:41 AM, Adrian Hunter wrote:
> On 03/11/11 08:45, Giuseppe CAVALLARO wrote:
>> This patch is to expose the actual SDCLK frequency in
>> /sys/kernel/debug/mmcX/ios entry.
>>
>> For example, if the max clk for a normal speed card is 20MHz
>> this is reported in /sys/kernel/debug/mmcX/ios.
>> Unfortunately the actual SDCLK frequency (i.e. Baseclock / divisor)
>> is not reported at all: for example, in that case, on Arasan HC,
>> it should be 48/4=12 (MHz).
>>
>> Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> 
> This did not apply cleanly to Chris' mmc-next branch.  Maybe you
> could rebase


Yes I could and send again.

Peppe

>> ---
>>  drivers/mmc/core/debugfs.c |    2 ++
>>  drivers/mmc/host/sdhci.c   |    9 +++++++++
>>  include/linux/mmc/host.h   |    2 ++
>>  3 files changed, 13 insertions(+), 0 deletions(-)
>>
>> diff --git a/drivers/mmc/core/debugfs.c b/drivers/mmc/core/debugfs.c
>> index 998797e..0b9a4aa 100644
>> --- a/drivers/mmc/core/debugfs.c
>> +++ b/drivers/mmc/core/debugfs.c
>> @@ -46,6 +46,8 @@ static int mmc_ios_show(struct seq_file *s, void *data)
>>  	const char *str;
>>  
>>  	seq_printf(s, "clock:\t\t%u Hz\n", ios->clock);
>> +	if (host->actual_clock)
>> +		seq_printf(s, "actual clock:\t%u Hz\n", host->actual_clock);
>>  	seq_printf(s, "vdd:\t\t%u ", ios->vdd);
>>  	if ((1 << ios->vdd) & MMC_VDD_165_195)
>>  		seq_printf(s, "(1.65 - 1.95 V)\n");
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 0e02cc1..3ee94dc 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1043,12 +1043,15 @@ static void sdhci_finish_command(struct sdhci_host *host)
>>  static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>  {
>>  	int div = 0; /* Initialized for compiler warning */
>> +	int real_div = div, clk_mul = 1;
>>  	u16 clk = 0;
>>  	unsigned long timeout;
>>  
>>  	if (clock == host->clock)
>>  		return;
>>  
>> +	host->mmc->actual_clock = 0;
>> +
>>  	if (host->ops->set_clock) {
>>  		host->ops->set_clock(host, clock);
>>  		if (host->quirks & SDHCI_QUIRK_NONSTANDARD_CLOCK)
>> @@ -1086,6 +1089,8 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>  				 * Control register.
>>  				 */
>>  				clk = SDHCI_PROG_CLOCK_MODE;
>> +				real_div = div;
>> +				clk_mul = host->clk_mul;
>>  				div--;
>>  			}
>>  		} else {
>> @@ -1099,6 +1104,7 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>  						break;
>>  				}
>>  			}
>> +			real_div = div;
>>  			div >>= 1;
>>  		}
>>  	} else {
>> @@ -1107,9 +1113,12 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>  			if ((host->max_clk / div) <= clock)
>>  				break;
>>  		}
>> +		real_div = div;
>>  		div >>= 1;
>>  	}
>>  
> 
> You dropped the "if (real_div)" from V3 but it is needed in one case
> i.e. (ctrl & SDHCI_CTRL_PRESET_VAL_ENABLE)
> 
> 
>> +	host->mmc->actual_clock = (host->max_clk * clk_mul) / real_div;
>> +
>>  	clk |= (div & SDHCI_DIV_MASK) << SDHCI_DIVIDER_SHIFT;
>>  	clk |= ((div & SDHCI_DIV_HI_MASK) >> SDHCI_DIV_MASK_LEN)
>>  		<< SDHCI_DIVIDER_HI_SHIFT;
>> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
>> index 1d09562..d815311 100644
>> --- a/include/linux/mmc/host.h
>> +++ b/include/linux/mmc/host.h
>> @@ -302,6 +302,8 @@ struct mmc_host {
>>  
>>  	struct mmc_async_req	*areq;		/* active async req */
>>  
>> +	unsigned int		actual_clock;	/* Actual HC clock rate */
>> +
>>  	unsigned long		private[0] ____cacheline_aligned;
>>  };
>>  
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

