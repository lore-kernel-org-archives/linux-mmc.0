From: Hein_Tibosch <hein_tibosch@yahoo.es>
Subject: Re: [PATCH 2/5 v2] MMC/core: Add f_min to mmc_power_on()
Date: Tue, 06 Dec 2011 20:18:03 +0800
Message-ID: <4EDE07FB.70606@yahoo.es>
References: <1323163107-32619-1-git-send-email-r66093@freescale.com> <1323163107-32619-2-git-send-email-r66093@freescale.com> <4EDE06DA.7010108@yahoo.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from bosmailout01.eigbox.net ([66.96.188.1]:38108 "EHLO
	bosmailout01.eigbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933318Ab1LFM6x (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 6 Dec 2011 07:58:53 -0500
Received: from bosmailscan04.eigbox.net ([10.20.15.4])
	by bosmailout01.eigbox.net with esmtp (Exim)
	id 1RXtyo-0007YC-LM
	for linux-mmc@vger.kernel.org; Tue, 06 Dec 2011 07:18:38 -0500
In-Reply-To: <4EDE06DA.7010108@yahoo.es>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: r66093@freescale.com
Cc: linux-mmc@vger.kernel.org, Jerry Huang <Chang-Ming.Huang@freescale.com>, Chris Ball <cjb@laptop.org>

On 12/6/2011 8:13 PM, Hein_Tibosch wrote:
> On 12/6/2011 5:18 PM, r66093@freescale.com wrote:
>> When f_init is zero, the SDHC can't work correctly. So f_min will replace
>> f_init, when f_init is zero.
>>
>> -	host->ios.clock = host->f_init;
>> +	if (host->f_init)
>> +		host->ios.clock = host->f_init;
>> +	else
>> +		host->ios.clock = host->f_min;
> Are you sure f_min can have a value of zero?
> It should have been set mmc_rescan_try_freq(), when trying a list
> of frequencies: 400000, 300000, 200000, 100000

Oops: I meant: Are you sure "f_init" can have a value of zero?

Hein
