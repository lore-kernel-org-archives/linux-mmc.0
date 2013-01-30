From: Stephen Warren <swarren@wwwdotorg.org>
Subject: Re: [PATCH] mmc: sdhci-pltfm: Add a common clk API based implementation
 of get_timeout_clock
Date: Tue, 29 Jan 2013 21:22:04 -0700
Message-ID: <51089FEC.6040603@wwwdotorg.org>
References: <1359397632-31646-1-git-send-email-lars@metafoo.de> <51076205.6040704@wwwdotorg.org> <510794DB.3050606@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:34884 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752990Ab3A3EWH (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Jan 2013 23:22:07 -0500
In-Reply-To: <510794DB.3050606@metafoo.de>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Chris Ball <cjb@laptop.org>, Shawn Guo <shawn.guo@linaro.org>, Kevin Liu <kliu5@marvell.com>, linux-mmc@vger.kernel.org, Simon Arlott <simon@fire.lp0.eu>, Dom Cobley <dc4@broadcom.com>, "linux-rpi-kernel@lists.infradead.org" <linux-rpi-kernel@lists.infradead.org>

On 01/29/2013 02:22 AM, Lars-Peter Clausen wrote:
> On 01/29/2013 06:45 AM, Stephen Warren wrote:
>> On 01/28/2013 11:27 AM, Lars-Peter Clausen wrote:
>>> Quite a few drivers have a implementation of the get_timeout_clock callback
>>> which simply returns the result of clk_get_rate on devices clock. This patch
>>> adds a common implementation of this to the sdhci-pltfm module and replaces all
>>> custom implementations with the common one.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>>> ---
>>> I've only runtime tested this patch on a platform which is not yet upstream. For
>>> the drivers which are modified in this patch I've only done compile time
>>> testing. But I think all changes, but maybe the bcm2835 one, are straight
>>> forward.
>>
>> It seems to work fine for bcm2835. So,
>>
>> Tested-by: Stephen Warren <swarren@wwwdotorg.org>
>>
>>> @@ -148,9 +131,9 @@ static struct sdhci_ops bcm2835_sdhci_ops = {
>>>  	.read_l = bcm2835_sdhci_readl,
>>>  	.read_w = bcm2835_sdhci_readw,
>>>  	.read_b = bcm2835_sdhci_readb,
>>> -	.get_max_clock = bcm2835_sdhci_get_max_clock,
>>> +	.get_max_clock = sdhci_pltfm_clk_get_max_clock,
>>>  	.get_min_clock = bcm2835_sdhci_get_min_clock,
>>> -	.get_timeout_clock = bcm2835_sdhci_get_timeout_clock,
>>> +	.get_timeout_clock = sdhci_pltfm_clk_get_max_clock,
>>>  };
>>
>> Rather than requiring .get_max_clock and .get_timeout_clock to be set by
>> each driver, perhaps the SDHCI core can call
>> sdhci_pltfm_clk_get_max_clock() if the function pointer is NULL?
> 
> Yea, this part of the bcm2835 driver confused me a bit. So there is the
> SDHCI_QUIRK_DATA_TIMEOUT_USES_SDCLK quirk which causes the sdhci core to use
> the max clock as a basis to calculate the timeout clock.

It's quite possible that sdhci-bcm2835.c should simply be modified to
set that quirk, and the implementation of .get_timeout_clock() removed
from sdhci-bcm2835.c. I see that a couple of downstream drivers for this
HW do in fact set that quirk, so it should be safe. I made this change
and it seems to work fine; I'll send the patch.

> But it divides it by 1000.

I wonder if that's just the units the clock is stored in; I see various
"* 1000" in the usage of host->timeout_clk. Unfortunately, there don't
appear to be any other implementations of .get_timeout_clock() to
compare with.

> I don't know the bcm2835 sdhci controller hardware, but is it
> possible that the current timeout clock value is too large by a factor of
> 1000? This wouldn't cause problems with normal transfers, but may increase
> the timeout delay for failed transfers.

Quite possibly.
