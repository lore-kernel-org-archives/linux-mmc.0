From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] MMC: move regulator handling closer to core v3
Date: Thu, 09 Sep 2010 09:01:27 +0300
Message-ID: <4C887837.6060508@nokia.com>
References: <1283677538-31121-1-git-send-email-linus.walleij@stericsson.com> <20100908155114.880463fc.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.230]:26782 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996Ab0IIGCa (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 9 Sep 2010 02:02:30 -0400
In-Reply-To: <20100908155114.880463fc.akpm@linux-foundation.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@stericsson.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Tony Lindgren <tony@atomide.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Sundar Iyer <sundar.iyer@stericsson.com>, Daniel Mack <daniel@caiaq.de>, Pierre Ossman <pierre@ossman.eu>, Matt Fleming <matt@console-pimps.org>, David Brownell <dbrownell@users.sourceforge.net>, Russell King <rmk+kernel@arm.linux.org.uk>, Eric Miao <eric.y.miao@gmail.com>, Cliff Brake <cbrake@bec-systems.com>, "Lavinen Jarkko (Nokia-MS/Helsinki)" <jarkko.lavinen@nokia.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

ext Andrew Morton wrote:
> On Sun,  5 Sep 2010 11:05:38 +0200
> Linus Walleij <linus.walleij@stericsson.com> wrote:
> 
>> After discovering a problem in regulator reference counting I
>> took Mark Brown's advice to move the reference count into the
>> MMC core by making the regulator status a member of
>> struct mmc_host.
>>
>>
>> ...
>>
>> -static inline void pxamci_set_power(struct pxamci_host *host, unsigned int vdd)
>> +static inline void pxamci_set_power(struct pxamci_host *host,
>> +				    unsigned char power_mode,
>> +				    unsigned int vdd)
>>  {
>>  	int on;
>>  
>> -#ifdef CONFIG_REGULATOR
>> -	if (host->vcc)
>> -		mmc_regulator_set_ocr(host->vcc, vdd);
>> -#endif
>> +	if (host->vcc) {
>> +		int ret;
>> +
>> +		if (power_mode == MMC_POWER_UP)
>> +			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, vdd);
>> +		else if (power_mode == MMC_POWER_OFF)
>> +			ret = mmc_regulator_set_ocr(host->mmc, host->vcc, 0);
>> +	}
> 
> There's no point in copying the return value into a local then ignoring
> it.  mmc_regulator_set_ocr() can return a negative errno so we should
> test for that, clean up and propagate the error.
> 
> If we really do deliberately ignore the error then there should be a
> code comment which excuses this behaviour and perhaps a warning printk.
> 
> The same comments apply to mmci_set_ios().
> 
> omap_hsmmc_1_set_power() gets it right.
> 
> Why doesn't omap_hsmmc_23_set_sleep() run .before_set_reg() and
> .after_set_reg()?

Mostly because the voltage does not change.  The voltage regulator
switches to a low current mode that reduces leakage but the voltage
does not change.

As an aside, I would like to enhance the regulator framework to
enable boards to hook their code directly into the regulator.
Arguably this is essential to allow pbias configuration (without
which the board may be damaged) so that regulator_enable/disable
can be used independently of the board, or for example to allow
the regulator core to turn the regulator on/off at initialisation.

Anyway, if that was done .before/.after_set_reg would not be
needed anymore.

> 
>> ...
>>
> 

