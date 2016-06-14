From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 05/12] mmc: sdhci: add a pre voltage switch callback function
Date: Tue, 14 Jun 2016 09:59:52 +0200
Message-ID: <87h9cwci9z.fsf@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
	<1465456218-28354-6-git-send-email-gregory.clement@free-electrons.com>
	<575E72DC.5090604@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57688 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750789AbcFNIAE (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2016 04:00:04 -0400
In-Reply-To: <575E72DC.5090604@intel.com> (Adrian Hunter's message of "Mon, 13
	Jun 2016 11:46:20 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-arm-kernel@lists.infradead.org, Nadav Haklai <nadavh@marvell.com>, Victor Gu <xigu@marvell.com>, Romain Perier <romain.perier@free-electrons.com>, Omri Itach <omrii@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, Shadi Ammouri <shadi@marvell.com>

Hi Adrian,
 
 On lun., juin 13 2016, Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 09/06/16 10:10, Gregory CLEMENT wrote:
>> From: Victor Gu <xigu@marvell.com>
>> 
>> Some host controller such as Xenon needs additional setting when
>> switching signal voltage in eMMC mode. They also need to re-enable
>> internal clock before a voltage switch.
>> 
>> This commit adds a callback routine "voltage_switch_pre" in the struct
>> sdhci_ops, which is used by some host controllers which need re-enable
>> the internal clock before a voltage switch.
>
> Don't want to add sdhci host ops for the "do something before a mmc host op"
> case.
>
> Instead, export sdhci_start_signal_voltage_switch() and  hook
> host->mmc_host_ops.start_signal_voltage_switch. Then in sdhci-xenon.c:
>
> int xenon__start_signal_voltage_switch(struct mmc_host *mmc,
> 				       struct mmc_ios *ios)
> {
> 	blah blah
> 	return sdhci_start_signal_voltage_switch(mmc, ios);
> }

OK I see your point.

Thanks,

Gregory

>
>
>> 
>> [gregory.clement@free-electrons.com: split the initial commit and
>> reformulate the log]
>> 
>> Signed-off-by: Victor Gu <xigu@marvell.com>
>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 4 ++++
>>  drivers/mmc/host/sdhci.h | 1 +
>>  2 files changed, 5 insertions(+)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index b07219426d39..cad03ffa9d9b 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1729,6 +1729,10 @@ static int sdhci_start_signal_voltage_switch(struct mmc_host *mmc,
>>  	if (host->version < SDHCI_SPEC_300)
>>  		return 0;
>>  
>> +	/* Some controller need to do more before switching */
>> +	if (host->ops->voltage_switch_pre)
>> +		host->ops->voltage_switch_pre(host);
>> +
>>  	ctrl = sdhci_readw(host, SDHCI_HOST_CONTROL2);
>>  
>>  	switch (ios->signal_voltage) {
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 49c6c5b0e33b..6bec1b0368d2 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -550,6 +550,7 @@ struct sdhci_ops {
>>  					 unsigned int max_dtr, int host_drv,
>>  					 int card_drv, int *drv_type);
>>  	void	(*init_card)(struct sdhci_host *host, struct mmc_card *card);
>> +	void	(*voltage_switch_pre)(struct sdhci_host *host);
>>  };
>>  
>>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> 
>

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
