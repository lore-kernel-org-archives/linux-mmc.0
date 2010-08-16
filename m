From: David Vrabel <david.vrabel@csr.com>
Subject: Re: [patch v2 1/1]sdhci support 10 bit divided clock Mode for spec
 3.0
Date: Mon, 16 Aug 2010 19:54:14 +0100
Message-ID: <4C698956.101@csr.com>
References: <AANLkTimBQA+-RLAv-DRb3cv10LH84B=7Rzo92igwyo4A@mail.gmail.com> <4C696233.6000408@csr.com> <20100816182710.GA6338@console-pimps.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:41370 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755979Ab0HPT1f (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 16 Aug 2010 15:27:35 -0400
Received: from rly23g.srv.mailcontrol.com (localhost.localdomain [127.0.0.1])
	by rly23g.srv.mailcontrol.com (MailControl) with ESMTP id o7GIskkg003655
	for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 19:54:48 +0100
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by rly23g.srv.mailcontrol.com (MailControl) id o7GIsHqI029393
	for <linux-mmc@vger.kernel.org>; Mon, 16 Aug 2010 19:54:17 +0100
In-Reply-To: <20100816182710.GA6338@console-pimps.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Matt Fleming <matt@console-pimps.org>
Cc: zhangfei gao <zhangfei.gao@gmail.com>, linux-mmc@vger.kernel.org, Anton Vorontsov <cbouatmailru@gmail.com>, Ben Dooks <ben-linux@fluff.org>, Wolfram Sang <w.sang@pengutronix.de>, Haojian Zhuang <haojian.zhuang@gmail.com>, Eric Miao <eric.y.miao@gmail.com>

Matt Fleming wrote:
> On Mon, Aug 16, 2010 at 05:07:15PM +0100, David Vrabel wrote:
>> zhangfei gao wrote:
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 913555e..32dcac9 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>> [...]
>>> @@ -1001,13 +1001,23 @@ static void sdhci_set_clock(struct sdhci_host
>>> *host, unsigned int clock)
>>>  	if (clock == 0)
>>>  		goto out;
>>>
>>> -	for (div = 1;div < 256;div *= 2) {
>>> -		if ((host->max_clk / div) <= clock)
>>> -			break;
>>> +	if (host->version >= SDHCI_SPEC_300)
>>> +		max_div = 2046;
>>> +	else
>>> +		max_div = 256;
>>> +
>>> +	if(host->max_clk <= clock)
>>> +		div = 1;
>>> +	else {
>>> +		for (div = 2; div < max_div; div += 2) {
>>> +			if ((host->max_clk / div) <= clock)
>>> +				break;
>>> +		}
>> This isn't correct.  The divisor must be a power of two for 2.00
>> controllers.
> 
> Sorry, I did mean to reply to this sooner but I've been travelling. Yeah
> David, you're right. Zhangfei, have you confused the Programmable Clock
> Mode in the 3.00 spec here with 10-bit Divided Clock Mode?
> 
> Both 8-bit Divided Clock Mode and 10-bit Divided Clock Mode require the
> divisor to be a power of two.

The power-of-two requirement only applies to 2.00 controller.  From
section 2.2.14 of the spec.

   "(2) 10-bit Divided Clock Mode
   Host Controller Version 3.00 supports this mandatory mode instead of
   the 8-bit Divided Clock Mode. The length of divider is extended to
   10bits and all divider values shall be supported."

3.00 dividers can be any multiple of two.

David
-- 
David Vrabel, Senior Software Engineer, Drivers
CSR, Churchill House, Cambridge Business Park,  Tel: +44 (0)1223 692562
Cowley Road, Cambridge, CB4 0WZ                 http://www.csr.com/


Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
