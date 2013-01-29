From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Add a common clk API based implementation
 of get_timeout_clock
Date: Tue, 29 Jan 2013 10:22:35 +0100
Message-ID: <510794DB.3050606@metafoo.de>
References: <1359397632-31646-1-git-send-email-lars@metafoo.de> <51076205.6040704@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp-out-081.synserver.de ([212.40.185.81]:1225 "EHLO
	smtp-out-081.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755365Ab3A2JVd (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 04:21:33 -0500
In-Reply-To: <51076205.6040704@wwwdotorg.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org

On 01/29/2013 06:45 AM, Stephen Warren wrote:
> On 01/28/2013 11:27 AM, Lars-Peter Clausen wrote:
>> Quite a few drivers have a implementation of the get_timeout_clock callback
>> which simply returns the result of clk_get_rate on devices clock. This patch
>> adds a common implementation of this to the sdhci-pltfm module and replaces all
>> custom implementations with the common one.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>> I've only runtime tested this patch on a platform which is not yet upstream. For
>> the drivers which are modified in this patch I've only done compile time
>> testing. But I think all changes, but maybe the bcm2835 one, are straight
>> forward.
> 
> It seems to work fine for bcm2835. So,
> 
> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
> 
>> @@ -148,9 +131,9 @@ static struct sdhci_ops bcm2835_sdhci_ops = {
>>  	.read_l = bcm2835_sdhci_readl,
>>  	.read_w = bcm2835_sdhci_readw,
>>  	.read_b = bcm2835_sdhci_readb,
>> -	.get_max_clock = bcm2835_sdhci_get_max_clock,
>> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>  	.get_min_clock = bcm2835_sdhci_get_min_clock,
>> -	.get_timeout_clock = bcm2835_sdhci_get_timeout_clock,
>> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>>  };
> 
> Rather than requiring .get_max_clock and .get_timeout_clock to be set by
> each driver, perhaps the SDHCI core can call
> sdhci_pltfm_clk_get_max_clock() if the function pointer is NULL?

Yea, this part of the bcm2835 driver confused me a bit. So there is the
SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK quirk which causes the sdhci core to use
the max clock as a basis to calculate the timeout clock. But it divides it
by 1000. I don't know the bcm2835 sdhci controller hardware, but is it
possible that the current timeout clock value is too large by a factor of
1000? This wouldn't cause problems with normal transfers, but may increase
the timeout delay for failed transfers.

- Lars
