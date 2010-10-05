From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
Date: Wed, 06 Oct 2010 01:22:30 +0800
Message-ID: <4CAB5ED6.7090708@yahoo.es>
References: <CDD4A6CE-487A-4740-87BA-96EEBF1E8217@marvell.com> <20101005023401.GB9044@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout06.eigbox.net ([66.96.187.6]:58890 "EHLO
	bosmailout06.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab0JER4G (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 5 Oct 2010 13:56:06 -0400
Received: from bosmailscan07.eigbox.net ([10.20.15.7])
	by bosmailout06.eigbox.net with esmtp (Exim)
	id 1P3BEc-0000jY-Ta
	for linux-mmc@vger.kernel.org; Tue, 05 Oct 2010 13:23:26 -0400
In-Reply-To: <20101005023401.GB9044@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Chris Ball <cjb@laptop.org>, David Vrabel <david.vrabel@csr.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Hi Philip, Chris,

On 5-10-2010 10:34, Chris Ball wrote:
> Hi David,
>
> On Thu, Sep 30, 2010 at 08:03:14PM -0700, Philip Rakity wrote:
>> From: Philip Rakity <prakity@marvell.com>
>> Date: Thu, 30 Sep 2010 15:34:24 -0700
>> Subject: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
>>
>> The sd 3.0 host spec does not require the clock divider to be a power of 2.

The text and code for sd 3.0 was talking about a multiple of 2, not a power of 2

>> Signed-off-by: Philip Rakity <prakity@marvell.com>
>> ---
>>  drivers/mmc/host/sdhci.c |    8 +++-----
>>  1 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 96c7f60..73a94fe 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1003,14 +1003,12 @@ static void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>  		goto out;
>>  
>>  	if (host->version >= SDHCI_SPEC_300) {
>> -		/* Version 3.00 divisors must be a multiple of 2. */
>>  		if (host->max_clk <= clock)
>>  			div = 1;
>>  		else {
>> -			for (div = 2; div < SDHCI_MAX_DIV_SPEC_300; div += 2) {
>> -				if ((host->max_clk / div) <= clock)
>> -					break;
>> -			}
>> +			div = host->max_clk/clock;
>> +			if (host->max_clk % clock)
>> +				div++;
If you mean to divide and round up, wouldn't :

+			div = DIV_ROUND_UP (host->max_clk, clock);

be nicer and cheaper?

Can SDHCI_MAX_DIV_SPEC_300 be dropped safely?

(don't have access to the sd 3.0 specs neither)

Hein

