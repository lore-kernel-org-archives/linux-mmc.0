From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] mmc: fix handling NULL returned from regulator_get()
Date: Wed, 18 May 2011 19:10:44 -0700
Message-ID: <4DD47C24.1080404@metafoo.de>
References: <1305754664-2917-1-git-send-email-ospite@studenti.unina.it> <m3vcx7el5h.fsf@pullcord.laptop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:57872 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755914Ab1ESCLZ (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 18 May 2011 22:11:25 -0400
In-Reply-To: <m3vcx7el5h.fsf@pullcord.laptop.org>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Chris Ball <cjb@laptop.org>
Cc: Antonio Ospite <ospite@studenti.unina.it>, linux-mmc@vger.kernel.org, Will Newton <will.newton@gmail.com>, Linus Walleij <linus.walleij@stericsson.com>, Rabin Vincent <rabin.vincent@stericsson.com>, Sascha Hauer <s.hauer@pengutronix.de>, Madhusudhan Chikkature <madhu.cr@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On 05/18/2011 02:47 PM, Chris Ball wrote:
> Hi Antonio, thanks for doing this,
> 
> On Wed, May 18 2011, Antonio Ospite wrote:
>> When regulator_get() is stubbed down it returns NULL, handle this case
>> when deciding whether the driver can use the regulator or not.
>>
>> Remember: IS_ERR(NULL) is false, see also this discussion for more
>> insight: http://comments.gmane.org/gmane.linux.kernel.mmc/7934
>>
>> Now that regulator_get() is handled correctly, the ifdef on
>> CONFIG_REGULATOR in mmci.c can go away as well.
>>
>> Signed-off-by: Antonio Ospite <ospite@studenti.unina.it>
>> ---
>>
>>  drivers/mmc/host/dw_mmc.c     |    2 +-
>>  drivers/mmc/host/mmci.c       |    4 +---
>>  drivers/mmc/host/mxcmmc.c     |    2 +-
>>  drivers/mmc/host/omap_hsmmc.c |    4 ++--
>>  drivers/mmc/host/sdhci.c      |    2 +-
>>  5 files changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 87e1f57..5be1325 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -1442,7 +1442,7 @@ static int __init dw_mci_init_slot(struct dw_mci *host, unsigned int id)
>>  #endif /* CONFIG_MMC_DW_IDMAC */
>>  
>>  	host->vmmc = regulator_get(mmc_dev(mmc), "vmmc");
>> -	if (IS_ERR(host->vmmc)) {
>> +	if (IS_ERR_OR_NULL(host->vmmc)) {
>>  		printk(KERN_INFO "%s: no vmmc regulator found\n", mmc_hostname(mmc));
>>  		host->vmmc = NULL;
>>  	} else
>> diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
>> index 259ece0..45fd4fe 100644
>> --- a/drivers/mmc/host/omap_hsmmc.c
>> +++ b/drivers/mmc/host/omap_hsmmc.c
>> @@ -405,7 +405,7 @@ static int omap_hsmmc_reg_get(struct omap_hsmmc_host *host)
>>  	}
>>  
>>  	reg = regulator_get(host->dev, "vmmc");
>> -	if (IS_ERR(reg)) {
>> +	if (IS_ERR_OR_NULL(reg)) {
>>  		dev_dbg(host->dev, "vmmc regulator missing\n");
>>  		/*
>>  		* HACK: until fixed.c regulator is usable,
>>  	} else {
>> [...] 
> I think I like this change for every driver *except* sdhci -- users who
> compile with CONFIG_REGULATOR=n (i.e. most distros) will start seeing
> "mmc0: no vmmc regulator found" when they boot their x86 laptops, and
> printing a cryptic regulator error message when regulator support isn't
> even compiled in seems uncalled for.
> 
> So, I think my suggestion is to merge all but the last hunk of the
> patch.  How do others feel about it?
> 

dw_mmc and omap_hsmmc will also print error messages if the regulator framework
is not build-in. I suggest to use something like:

if (IS_ERR(vmmc)) {
	... do error handling
} else if(vmmc) {
	... use regulator
} else {
	... fallback code to initialize ocr_avail
}

- Lars
