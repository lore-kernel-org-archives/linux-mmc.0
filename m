From: Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 09/12] mmc: sdhci-xenon: add initial Xenon eMMC driver
Date: Tue, 14 Jun 2016 11:36:22 +0300
Message-ID: <575FC206.4030903@intel.com>
References: <1465456218-28354-1-git-send-email-gregory.clement@free-electrons.com>
 <1465456218-28354-10-git-send-email-gregory.clement@free-electrons.com>
 <575FA9BF.6070703@intel.com> <878ty8chdr.fsf@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <878ty8chdr.fsf-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Romain Perier <romain.perier-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Omri Itach <omrii-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>, Wilson Ding <dingwei-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Shadi Ammouri <shadi-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 14/06/16 11:19, Gregory CLEMENT wrote:
> Hi Adrian,
>  
>  On mar., juin 14 2016, Adrian Hunter <adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
>> On 09/06/16 10:10, Gregory CLEMENT wrote:
>>> From: Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>>
>>> This path adds the driver for the Marvell Xenon eMMC host controller
>>> which supports eMMC 5.1, SD 3.0.
>>>
>>> However this driver supports only up to eMMC 5.0 since the command queue
>>> feature is not included (yet) in the driver.
>>>
>>> [gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org:
>>>  - reformulate commit log
>>>  - overload the sdhci_set_uhs_signaling function instead of using a quirk
>>>  - fix a kconfig dependency
>>>  - remove dead code]
>>>
>>> Signed-off-by: Victor Gu <xigu-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>
>>> Signed-off-by: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
>>> ---
>>>  drivers/mmc/host/Kconfig       |   10 +
>>>  drivers/mmc/host/Makefile      |    1 +
>>>  drivers/mmc/host/sdhci-xenon.c | 1164 ++++++++++++++++++++++++++++++++++++++++
>>>  3 files changed, 1175 insertions(+)
>>>  create mode 100644 drivers/mmc/host/sdhci-xenon.c
>>>
>>
>> <SNIP>
>>
>>> diff --git a/drivers/mmc/host/sdhci-xenon.c b/drivers/mmc/host/sdhci-xenon.c
>>> new file mode 100644
>>> index 000000000000..43c06db95872
>>> --- /dev/null
>>> +++ b/drivers/mmc/host/sdhci-xenon.c
>>
>> <SNIP>
>>
>>> +static int sdhci_xenon_delay_adj_test(struct sdhci_host *host,
>>> +		struct mmc_card *card, unsigned int delay,
>>> +		bool invert, bool phase)
>>> +{
>>> +	int ret;
>>> +	struct mmc_card *oldcard;
>>> +
>>> +	sdhci_xenon_set_fix_delay(host, delay, invert, phase);
>>> +
>>> +	/*
>>> +	 * If the card is not yet associated to the host, we
>>> +	 * temporally do it
>>> +	 */
>>> +	oldcard = card->host->card;
>>> +	if (!oldcard)
>>> +		card->host->card = card;
>>> +	ret =  card_alive(card);
>>
>> This looks like an abuse of bus_ops->alive().  You will need to get
>> agreement with Ulf how to handle this.  I will wait for Ulf's comments
>> before reviewing this patch set further.
> 
> Actually I modified this part of the driver to use
> bus_ops->alive(). Initially, the alive() code was more or less copied
> and paste from the mmc core with ugly include from mmc_ops.h and
> sdio_ops.h to make it work. I find it cleaner to directly access the
> alive() function.
> 
> Could you explain why it is an abuse of  bus_ops->alive()?

bus_ops->alive() is used to determine if the card is present and able to
respond.  You seem to be using it for a different purpose.  I will wait for
Ulf's comments.

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
