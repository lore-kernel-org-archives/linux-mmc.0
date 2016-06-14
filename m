From: Gregory CLEMENT <gregory.clement@free-electrons.com>
Subject: Re: [PATCH 01/12] mmc: sdhci: add init_card callback to sdhci
Date: Tue, 14 Jun 2016 09:58:12 +0200
Message-ID: <87lh28cicr.fsf@free-electrons.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
	<1465456218-28354-2-git-send-email-gregory.clement@free-electrons.com>
	<575E6F92.6090305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:57621 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750712AbcFNH60 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 14 Jun 2016 03:58:26 -0400
In-Reply-To: <575E6F92.6090305@intel.com> (Adrian Hunter's message of "Mon, 13
	Jun 2016 11:32:18 +0300")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Romain Perier <romain.perier@free-electrons.com>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Omri Itach <omrii@marvell.com>, linux-mmc@vger.kernel.org, Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>, Shadi Ammouri <shadi@marvell.com>, Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>, Wilson Ding <dingwei@marvell.com>, linux-arm-kernel@lists.infradead.org, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

Hi Adrian,
 
 On lun., juin 13 2016, Adrian Hunter <adrian.hunter@intel.com> wrote:

> On 09/06/16 10:10, Gregory CLEMENT wrote:
>> From: Marcin Wojtas <mw@semihalf.com>
>> 
>> Some sdhci hosts may require handling quirks during card initialization
>> at the time when its type is already known. Hence a new callback
>> (init_card) is added in sdhci_ops.
>
> I plan to remove init_card and other host ops that sdhci doesn't use (like
> sdhci_select_drive_strength).  The driver must provide the mmc op instead.
> e.g. in sdhci-xenon.c
>
> 	host->mmc_host_ops.init_card = sdhci_xenon_init_card

OK I will do this.

Thanks for your review.

Gregory

>
>> 
>> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
>> ---
>>  drivers/mmc/host/sdhci.c | 9 +++++++++
>>  drivers/mmc/host/sdhci.h | 1 +
>>  2 files changed, 10 insertions(+)
>> 
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 0e3d7c056cb1..fd4e9a84f739 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -2117,6 +2117,14 @@ static void sdhci_card_event(struct mmc_host *mmc)
>>  	spin_unlock_irqrestore(&host->lock, flags);
>>  }
>>  
>> +static void sdhci_init_card(struct mmc_host *mmc, struct mmc_card *card)
>> +{
>> +	struct sdhci_host *host = mmc_priv(mmc);
>> +
>> +	if (host->ops->init_card)
>> +		host->ops->init_card(host, card);
>> +}
>> +
>>  static const struct mmc_host_ops sdhci_ops = {
>>  	.request	= sdhci_request,
>>  	.post_req	= sdhci_post_req,
>> @@ -2132,6 +2140,7 @@ static const struct mmc_host_ops sdhci_ops = {
>>  	.select_drive_strength		= sdhci_select_drive_strength,
>>  	.card_event			= sdhci_card_event,
>>  	.card_busy	= sdhci_card_busy,
>> +	.init_card	= sdhci_init_card,
>>  };
>>  
>>  /*****************************************************************************\
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 609f87ca536b..49c6c5b0e33b 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -549,6 +549,7 @@ struct sdhci_ops {
>>  					 struct mmc_card *card,
>>  					 unsigned int max_dtr, int host_drv,
>>  					 int card_drv, int *drv_type);
>> +	void	(*init_card)(struct sdhci_host *host, struct mmc_card *card);
>>  };
>>  
>>  #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>> 
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
