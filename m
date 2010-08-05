From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: + mmc-use-regulator-framework-correctly.patch added to -mm tree
Date: Thu, 5 Aug 2010 22:43:34 +0100
Message-ID: <D7F4B8A4-C756-44EC-AD90-0460DCEC80FC@opensource.wolfsonmicro.com>
References: <201008052132.o75LWlge006062@imap1.linux-foundation.org> (sfid-20100805_223331_781659_8428289E)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:52403 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1756844Ab0HEVnh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Thu, 5 Aug 2010 17:43:37 -0400
In-Reply-To: <201008052132.o75LWlge006062@imap1.linux-foundation.org> (sfid-20100805_223331_781659_8428289E)
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: akpm@linux-foundation.org
Cc: mm-commits@vger.kernel.org, adrian.hunter@nokia.com, linux-mmc@vger.kernel.org, lrg@slimlogic.co.uk, sameo@linux.intel.com

On 5 Aug 2010, at 22:32, akpm@linux-foundation.org wrote:

> Subject: mmc: use regulator framework correctly
> From: Adrian Hunter <adrian.hunter@nokia.com>

> Issues with the regulator framework no longer exist, so regulator_enable()
> / regulator_disable() should be used correctly.

There have been no changes in the regulator framework here. David had some strong ideas about what he wanted the regulator API to do which caused him to make a number of forceful statements but that's not the same thing.

> -	int			enabled;
> -
> -	enabled = regulator_is_enabled(supply);
> -	if (enabled < 0)
> -		return enabled;
> 
> 	if (vdd_bit) {
> 		int		tmp;
> @@ -819,9 +814,9 @@ int mmc_regulator_set_ocr(struct regulat
> 		else
> 			result = 0;
> 
> -		if (result == 0 && !enabled)
> +		if (result == 0)
> 			result = regulator_enable(supply);
> -	} else if (enabled) {
> +	} else {
> 		result = regulator_disable(supply);
> 	}

This is only going to do the right thing if we can rely on the MMC framework matching the number of enables it does with the number of disables, including handling of startup with an already enabled regulator causing the refcount to start at one if regulator_get_exclusive() is used (which the current code does rely on). I'd rather see the analysis in the changelog explaining why the new code is safe.