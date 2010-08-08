From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: + mmc-use-regulator-framework-correctly.patch added to -mm tree
Date: Sun, 08 Aug 2010 14:41:40 +0300
Message-ID: <4C5E97F4.8050501@nokia.com>
References: <201008052132.o75LWlge006062@imap1.linux-foundation.org> (sfid-20100805_223331_781659_8428289E) <D7F4B8A4-C756-44EC-AD90-0460DCEC80FC@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.105.134]:21678 "EHLO
	mgw-mx09.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab0HHLmB (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 8 Aug 2010 07:42:01 -0400
In-Reply-To: <D7F4B8A4-C756-44EC-AD90-0460DCEC80FC@opensource.wolfsonmicro.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "mm-commits@vger.kernel.org" <mm-commits@vger.kernel.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>, "sameo@linux.intel.com" <sameo@linux.intel.com>

Mark Brown wrote:
> On 5 Aug 2010, at 22:32, akpm@linux-foundation.org wrote:
> 
>> Subject: mmc: use regulator framework correctly
>> From: Adrian Hunter <adrian.hunter@nokia.com>
> 
>> Issues with the regulator framework no longer exist, so regulator_enable()
>> / regulator_disable() should be used correctly.
> 
> There have been no changes in the regulator framework here. David had some strong ideas about what he wanted the regulator API to do which caused him to make a number of forceful statements but that's not the same thing.
> 
>> -	int			enabled;
>> -
>> -	enabled = regulator_is_enabled(supply);
>> -	if (enabled < 0)
>> -		return enabled;
>>
>> 	if (vdd_bit) {
>> 		int		tmp;
>> @@ -819,9 +814,9 @@ int mmc_regulator_set_ocr(struct regulat
>> 		else
>> 			result = 0;
>>
>> -		if (result == 0 && !enabled)
>> +		if (result == 0)
>> 			result = regulator_enable(supply);
>> -	} else if (enabled) {
>> +	} else {
>> 		result = regulator_disable(supply);
>> 	}
> 
> This is only going to do the right thing if we can rely on the MMC framework matching the number of enables it does with the number of disables, including handling of startup with an already enabled regulator causing the refcount to start at one if regulator_get_exclusive() is used (which the current code does rely on). I'd rather see the analysis in the changelog explaining why the new code is safe.

Yes, the patch is no good.  If I had tried to make a decent commit message,
as you pointed out, I would not have sent the patch.  Sorry all.

Andrew please remove this patch.
