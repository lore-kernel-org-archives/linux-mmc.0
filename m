From: Philip Rakity <prakity@marvell.com>
Subject: Re: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
Date: Tue, 5 Oct 2010 16:30:45 -0700
Message-ID: <7F4DBED0-9C9A-47B2-B417-D9B15A42E335@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from na3sys009aog114.obsmtp.com ([74.125.149.211]:33703 "HELO
	na3sys009aog114.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1756451Ab0JEXb0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 5 Oct 2010 19:31:26 -0400
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Cc: Hein_Tibosch <hein_tibosch@yahoo.es>

>
>On 5-10-2010 10:34, Chris Ball wrote:
>> Hi David,
>>
>> On Thu, Sep 30, 2010 at 08:03:14PM -0700, Philip Rakity wrote:
>>> From: Philip Rakity <prakity@marvell.com>
>>> Date: Thu, 30 Sep 2010 15:34:24 -0700
>>> Subject: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
>>>
>>> The sd 3.0 host spec does not require the clock divider to be a power of 2.
>
>The text and code for sd 3.0 was talking about a multiple of 2, not a power of 2
>
>>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c |    8 +++-----
>>>  1 files changed, 3 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 96c7f60..73a94fe 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1003,14 +1003,12 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>>  		goto out;
>>>  
>>>  	if (host->version >= SDHCI_SPEC_300) {
>>> -		/* Version 3.00 divisors must be a multiple of 2. */
>>>  		if (host->max_clk <= clock)
>>>  			div = 1;
>>>  		else {
>>> -			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
>>> -				if ((host->max_clk / div) <= clock)
>>> -					break;
>>> -			}
>>> +			div = host->max_clk/clock;
>>> +			if (host->max_clk % clock)
>>> +				div++;
>If you mean to divide and round up, wouldn't :
>
>+			div = DIV_ROUND_UP (host->max_clk, clock);
>
>be nicer and cheaper?
nicer -- yes
cheaper -- code is executed normally to set the clock for f_min and then for max frequency.

>
>Can SDHCI_MAX_DIV_SPEC_300 be dropped safely?
I believe so -- code should not be called from mmc layerwith speed lower then f_min nor more then f_max

>
>(don't have access to the sd 3.0 specs neither)
>
>Hein
>