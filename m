From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
Date: Wed, 06 Oct 2010 14:05:13 +0100
Message-ID: <4CAC7409.6060505@csr.com>
References: <CDD4A6CE-487A-4740-87BA-96EEBF1E8217@marvell.com> <20101005023401.GB9044@void.printf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-d.mailcontrol.com ([85.115.60.190]:51133 "EHLO
	cluster-d.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340Ab0JFNGn (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 6 Oct 2010 09:06:43 -0400
Received: from rly24d.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly24d.srv.mailcontrol.com (MailControl) with ESMTP id o96D6FDW032253
	for <linux-mmc@vger.kernel.org>; Wed, 6 Oct 2010 14:06:40 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly24d.srv.mailcontrol.com (MailControl) id o96D5MQT024384
	for <linux-mmc@vger.kernel.org>; Wed, 6 Oct 2010 14:05:22 +0100
In-Reply-To: <20101005023401.GB9044@void.printf.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Philip Rakity <prakity@marvell.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

Chris Ball wrote:
> Hi David,
> 
> On Thu, Sep 30, 2010 at 08:03:14PM -0700, Philip Rakity wrote:
>> From: Philip Rakity <prakity@marvell.com>
>> Date: Thu, 30 Sep 2010 15:34:24 -0700
>> Subject: [PATCH] sdhci: adjust sd 3.0 host controller spec clock divider
>>
>> The sd 3.0 host spec does not require the clock divider to be a power of 2.
>>
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
>>  		}
>>  	} else {
>>  		/* Version 2.00 divisors must be a power of 2. */
>> -- 
> 
> Would you mind reviewing this, please?  I don't have access to the 3.0
> spec.

NAK.  The divisors for 3.00 controllers must be a multiple of two (the
register value N gives a divisor of 2N).

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
