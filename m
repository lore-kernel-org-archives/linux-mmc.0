From: Adrian Hunter <adrian.hunter@nokia.com>
Subject: Re: [PATCH] sdhci: allow for eMMC 74 clock generation by controller
Date: Wed, 22 Sep 2010 10:57:28 +0300
Message-ID: <4C99B6E8.2050008@nokia.com>
References: <43E4817426ED174AA81263BCECB4351D131745CF98@sc-vexch3.marvell.com> <53E1B390-48DD-4E33-B51F-1B039AFD13A2@marvell.com> <4B9DEAE2.3030707@nokia.com> <3A9599CE-49EE-4A18-89E0-22B17090CA43@marvell.com> <4BA72971.1070804@nokia.com> <639D1595-D908-473C-9A41-71B493DCD0C0@marvell.com> <4BB052F6.5080808@nokia.com> <A9891FF4-9D4D-4F5C-ACE9-B272B53CCC08@marvell.com> <20100920061459.GA9353@pengutronix.de> <5F58EC42-069D-4469-BF13-F741674BE763@marvell.com> <57E26860-E2EC-4510-B928-62BCC7DC1AF8@marvell.com> <4C984B01.2000005@nokia.com> <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mx3.nokia.com ([192.100.105.134]:31307 "EHLO mgw-mx09.nokia.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750838Ab0IVH5x (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
	Wed, 22 Sep 2010 03:57:53 -0400
In-Reply-To: <F0EF1C13-8902-4839-9D76-C3045018660E@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Philip Rakity <prakity@marvell.com>
Cc: Wolfram Sang <w.sang@pengutronix.de>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Mark Brown <markb@marvell.com>

On 21/09/10 18:06, Philip Rakity wrote:
>
> Our hardware needs to be programmed to handle this case.  The host-ops option is only needed from h/w that does not handle this.
>
> If you can suggest a way to do this in the mmc layer I would welcome implementing it.

No, I misunderstood sorry :(.  The 74-clocks requirement is standard and
drivers handle it via set_ios.

>
> I looked and the solution requires a call into the driver from the mmc layer after the all setting POWER_ON call.  This was more intrusive than doing it in the driver but if you think this makes sense I can do a patch for that.
>
> eg
>
> /*
>   * Apply power to the MMC stack.  This is a two-stage process.
>   * First, we enable power to the card without the clock running.
>   * We then wait a bit for the power to stabilise.  Finally,
>   * enable the bus drivers and clock to the card.
>   *
>   * We must _NOT_ enable the clock prior to power stablising.
>   *
>   * If a host does all the power sequencing itself, ignore the
>   * initial MMC_POWER_UP stage.
>   */
> static void mmc_power_up(struct mmc_host *host)
> {
> 	int bit = fls(host->ocr_avail) - 1;
>
> 	host->ios.vdd = bit;
> 	if (mmc_host_is_spi(host)) {
> 		host->ios.chip_select = MMC_CS_HIGH;
> 		host->ios.bus_mode = MMC_BUSMODE_PUSHPULL;
> 	} else {
> 		host->ios.chip_select = MMC_CS_DONTCARE;
> 		host->ios.bus_mode = MMC_BUSMODE_OPENDRAIN;
> 	}
> 	host->ios.power_mode = MMC_POWER_UP;
> 	host->ios.bus_width = MMC_BUS_WIDTH_1;
> 	host->ios.timing = MMC_TIMING_LEGACY;
> 	mmc_set_ios(host);
>
> 	/*  CALL INTO DRIVER HERE TO SEND 74 CLOCKS */<==========
> Philip
>
>
> On Sep 20, 2010, at 11:04 PM, Adrian Hunter wrote:
>
>> On 21/09/10 08:43, ext Philip Rakity wrote:
>>>
>>> Wolfram,
>>>
>>> I generated the patch for eMMC 74 clocks.  I do not know if you want to incorporate into your submission or let it stand on its own.
>>
>> Wouldn't it be better to fix it in MMC core rather than duplicate it in every driver?
>>
>>>
>>> regards,
>>>
>>> Philip
>>>
>>>
>>>
>>> From: Philip Rakity<prakity@marvell.com>
>>> Subject: [PATCH] sdhci: allow for eMMC 74 clock generation by controller
>>> Signed-off-by: Philip Rakity<prakity@marvell.com>
>>>
>>> Patch is below and sample usage in sdhci-xxxx.c adaption code is below.
>>>
>>> /*
>>>   * eMMC spec calls for the host to send 74 clocks to the card
>>>   * during initialization, right after voltage stabilization.
>>>   * create the clocks manually right here.
>>>   */
>>> void generate_init_clocks_A0(struct sdhci_host *host, u8 power_mode)
>>> {
>>> 	struct sdhci_mmc_slot *slot = sdhci_priv(host);
>>>
>>> 	DBG ("%s: ENTER %s: slot->power_mode = %d, ios->power_mode = %d\n",
>>> 	 	__func__,
>>> 		mmc_hostname(host->mmc),
>>> 		slot->power_mode,
>>> 		power_mode);
>>>
>>> 	if (slot->power_mode == MMC_POWER_UP
>>> 	&&   power_mode == MMC_POWER_ON) {
>>> 	
>>> 		/* controller specific code here */
>>> 		/* slot->power_mode holds previous power setting */
>>>
>>> 	}
>>> 	slot->power_mode = power_mode;
>>> }
>>>
>>>
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index 401527d..6aadd0f 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -1168,6 +1168,9 @@ static void sdhci_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>   	else
>>>   		sdhci_set_power(host, ios->vdd);
>>>
>>> +	if (host->ops->platform_generate_initial_74_clocks)
>>> +		host->ops->platform_generate_initial_74_clocks(host, ios->power_mode);
>>> +
>>>   	ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
>>>
>>>   	if (ios->bus_width == MMC_BUS_WIDTH_8)
>>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>>> index d316bc7..70c5806 100644
>>> --- a/drivers/mmc/host/sdhci.h
>>> +++ b/drivers/mmc/host/sdhci.h
>>> @@ -323,6 +323,8 @@ struct sdhci_ops {
>>>   	unsigned int	(*get_max_clock)(struct sdhci_host *host);
>>>   	unsigned int	(*get_min_clock)(struct sdhci_host *host);
>>>   	unsigned int	(*get_timeout_clock)(struct sdhci_host *host);
>>> +	void		(*platform_generate_initial_74_clocks)(struct sdhci_host *host,
>>> +				u8 power_mode);
>>>   };
>>>
>>>   #ifdef CONFIG_MMC_SDHCI_IO_ACCESSORS
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>
>

