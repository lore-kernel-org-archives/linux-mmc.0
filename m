From: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
Subject: Re: [RFC 2/3] mmc: sdhci: add host_ops->voltage_switch callback for
 all other voltages
Date: Wed, 2 Sep 2015 13:49:53 +0530
Message-ID: <55E6B129.1030002@linaro.org>
References: <1441135938-8056-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1441135938-8056-3-git-send-email-vaibhav.hiremath@linaro.org>
 <20150902150442.118d3305@xhacker>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150902150442.118d3305@xhacker>
Sender: linux-kernel-owner@vger.kernel.org
To: Jisheng Zhang <jszhang@marvell.com>
Cc: linux-mmc@vger.kernel.org, ulf.hansson@linaro.org, linus.walleij@linaro.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org



On Wednesday 02 September 2015 12:34 PM, Jisheng Zhang wrote:
> On Wed, 2 Sep 2015 01:02:17 +0530
> Vaibhav Hiremath <vaibhav.hiremath@linaro.org> wrote:
>
>> Currently, the sdhci_do_start_signal_voltage_switch() function invokes
>> controller specific voltage switch configuration only for 1.8v usecase;
>> but it is required for others as well.
>>
>> For example, in case of PXA1928 SDH controller, we need to set different
>> configuration for 3.3, 1.8 and 1.2 volt support (I/O domain power
>> control register).
>>
>> Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
>> ---
>> Note:
>> Currently ->voltage_switch() callback is only supported
>> in f_sdh30 driver. And I am not sure on the dependency of execution
>> sequence for that device. I could have moved ->voltage_switch() call
>> at one common place (above/below), but was not quite sure about it.
>> So, replicated/duplicated the call for other voltages.
>>
>>   drivers/mmc/host/sdhci.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 3dd295f..b59b76d 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1753,6 +1753,10 @@ static int sdhci_do_start_signal_voltage_switch(struct sdhci_host *host,
>>   		/* Wait for 5ms */
>>   		usleep_range(5000, 5500);
>>
>> +		/* Some controller need to do more when switching */
>> +		if (host->ops->voltage_switch)
>> +			host->ops->voltage_switch(host, MMC_SIGNAL_VOLTAGE_330);
>
> Could this be implemented by regulator API? From patch set 3/3, the pxa1928
> voltage_switch hook is to operate the IO pad registers, this seems not belong
> to the SDHC IP core.
>

Not quite sure whether regulator would be right fit for this.

Initially I was thinking of making use of pinconf framework, using
PIN_CONFIG_POWER_SOURCE, but that too I am not sure is the right way of
doing it.

Probably, question for pinctrl maintainer. Looping Linus Walleji.

Also note that, this configuration is not applicable to all pins/pads,
only handpicked pads have this configuration (voltage selection on
pads).
And this configuration is not part of the same register map.

It is part of separate register map (AIB_EXT_REG_BASE), called IO
domain power control register.
And that

Thanks,
Vaibhav
