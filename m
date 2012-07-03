From: Chris Ball <cjb@laptop.org>
Subject: Re: [PATCH 2/2] mmc: only support voltage (vdd) that regulator agree's with
Date: Tue, 03 Jul 2012 02:12:07 -0400
Message-ID: <877gul8jbc.fsf@octavius.laptop.org>
References: <prakity@marvell.com>
	<1339183573-21688-1-git-send-email-prakity@marvell.com>
	<87pq8haeq0.fsf@octavius.laptop.org>
	<20120703060655.GA10350@aarontestpc.amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from void.printf.net ([89.145.121.20]:49904 "EHLO void.printf.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933204Ab2GCGMO (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Tue, 3 Jul 2012 02:12:14 -0400
In-Reply-To: <20120703060655.GA10350@aarontestpc.amd.com> (Aaron Lu's message
	of "Tue, 3 Jul 2012 14:06:55 +0800")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Aaron Lu <aaron.lu@amd.com>
Cc: philipspatches@gmail.com, linux-mmc@vger.kernel.org, mark.brown314@gmail.com, Philip Rakity <prakity@marvell.com>

Hi Aaron,

On Tue, Jul 03 2012, Aaron Lu wrote:
> On Fri, Jun 29, 2012 at 07:19:19PM -0400, Chris Ball wrote:
>> Hi,
>> 
>> On Fri, Jun 08 2012, philipspatches@gmail.com wrote:
>> > From: Philip Rakity <prakity@marvell.com>
>> >
>> > If we are using a regulator the SD Host Controller and the
>> > regulator should agree about the voltages supported.  Use
>> > the common subset that is supported.
>> >
>> > Signed-off-by: Philip Rakity <prakity@marvell.com>
>> 
>> This breaks the build when CONFIG_REGULATOR=n -- I've applied what looks
>> like the correct fix to me:
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index eae7c3c..caba999 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2832,51 +2832,53 @@ int sdhci_add_host(struct sdhci_host *host)
>> +#ifdef CONFIG_REGULATOR
>>  	/*
>>  	 * According to SD Host Controller spec v3.00, if the Host System
>>  	 * can afford more than 150mA, Host Driver should set XPC to 1. Also
>>  	 * the value is meaningful only if Voltage Support in the Capabilities
>>  	 * register is set. The actual current value is 4 times the register
>>  	 * value.
>>  	 */
> The above comments does not belong to regulator code, it should be
> placed on top of the max_current_caps variable like this:

Thanks for catching that!  I've rebased your change into the original patch.

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
