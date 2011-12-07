From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
Date: Wed, 07 Dec 2011 11:37:06 +0800
Message-ID: <4EDEDF62.70705@yahoo.es>
References: <1323163107-32619-1-git-send-email-r66093@freescale.com> <1323163107-32619-2-git-send-email-r66093@freescale.com> <4EDE06DA.7010108@yahoo.es> <8A2FC72B45BB5A4C9F801431E06AE48F116342A2@039-SN1MPN1-005.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout13.eigbox.net ([66.96.187.13]:57340 "EHLO
	bosmailout13.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755379Ab1LGET7 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 23:19:59 -0500
Received: from bosmailscan04.eigbox.net ([10.20.15.4])
	by bosmailout13.eigbox.net with esmtp (Exim)
	id 1RY8LI-0002lE-6j
	for linux-mmc@vger.kernel.org; Tue, 06 Dec 2011 22:38:48 -0500
In-Reply-To: <8A2FC72B45BB5A4C9F801431E06AE48F116342A2@039-SN1MPN1-005.039d.mgd.msft.net>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Huang Changming-R66093 <r66093@freescale.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, ulf.hansson@stericsson.com, Chris Ball <cjb@laptop.org>

Hi Jerry,
On 12/7/2011 10:23 AM, Huang Changming-R66093 wrote:
>
>> -----Original Message-----
>> From: Hein_Tibosch [mailto:hein_tibosch@yahoo.es]
>> Sent: Tuesday, December 06, 2011 8:13 PM
>> To: Huang Changming-R66093
>> Cc: linux-mmc@vger.kernel.org; Huang Changming-R66093; Chris Ball
>> Subject: Re: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
>>
>> <cut>
>>> diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c index
>>> a08e6b1..2d40c04 100644
>>> --- a/drivers/mmc/core/core.c
>>> +++ b/drivers/mmc/core/core.c
>>> @@ -1253,7 +1253,10 @@ static void mmc_power_up(struct mmc_host *host)
>>>  	 */
>>>  	mmc_delay(10);
>>>
>>> -	host->ios.clock = host->f_init;
>>> +	if (host->f_init)
>>> +		host->ios.clock = host->f_init;
>>> +	else
>>> +		host->ios.clock = host->f_min;
>> Are you sure f_min can have a value of zero?
>> It should have been set mmc_rescan_try_freq(), when trying a list of
>> frequencies: 400000, 300000, 200000, 100000
>>
> But, mmc_power_up is called not only by mmc_rescan_try_freq, so the value of f_init may be zero.

Ok, I see: mmc_power_up() used to be called only after mmc_rescan_try_freq(),
but now you want to call it earlier, because get_cd() *might* need it,
even if get_cd is not defined...

Still I wonder whether it's good to power-up each and every card:

+	mmc_power_up(host);
 	if (host->ops->get_cd && host->ops->get_cd(host) == 0)
 		goto out;
+	mmc_power_off(host);

before initialization starts. Remember earlier complaints that f_min is
extremely low on some platforms and therefor f_init was introduced.

Hein
