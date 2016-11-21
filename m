From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH v8 09/16] mmc: sdhci: Factor out sdhci_enable_clock
Date: Mon, 21 Nov 2016 12:01:19 +0530
Message-ID: <abed48c3-d220-e907-d482-dda074c72764@codeaurora.org>
References: <1479312052-22396-1-git-send-email-riteshh@codeaurora.org>
 <1479312052-22396-10-git-send-email-riteshh@codeaurora.org>
 <df833f0b-041f-67d1-4b91-ef4399ecf15c@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <df833f0b-041f-67d1-4b91-ef4399ecf15c@intel.com>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org, linux-mmc@vger.kernel.org, sboyd@codeaurora.org, andy.gross@linaro.org
Cc: shawn.lin@rock-chips.com, devicetree@vger.kernel.org, linux-clk@vger.kernel.org, david.brown@linaro.org, linux-arm-msm@vger.kernel.org, georgi.djakov@linaro.org, alex.lemberg@sandisk.com, mateusz.nowak@intel.com, Yuliy.Izrailov@sandisk.com, asutoshd@codeaurora.org, david.griego@linaro.org, stummala@codeaurora.org, venkatg@codeaurora.org, rnayak@codeaurora.org, pramod.gurav@linaro.org, jeremymc@redhat.com
List-Id: linux-mmc@vger.kernel.org



On 11/18/2016 7:26 PM, Adrian Hunter wrote:
> On 16/11/16 18:00, Ritesh Harjani wrote:
>> Factor out sdhci_enable_clock from sdhci_set_clock
>> and make it EXPORT_SYMBOL so that it can be called.
>
> This seems fine apart from minor comments below.
>
>>
>> Signed-off-by: Ritesh Harjani <riteshh@codeaurora.org>
>> ---
>>  drivers/mmc/host/sdhci.c | 28 +++++++++++++++++-----------
>>  drivers/mmc/host/sdhci.h |  1 +
>>  2 files changed, 18 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index d08d507..8a89d89 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -1344,20 +1344,10 @@ u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>>  }
>>  EXPORT_SYMBOL_GPL(sdhci_calc_clk);
>>
>> -void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>> +void sdhci_enable_clock(struct sdhci_host *host, unsigned short clk)
>
> We write a u16 so let's make clk a u16 instead of unsigned short.
Ok.
>
> I would have called it sdhci_enable_clk() to go with sdhci_calc_clk() and
> slightly different from sdhci_set_clock() which is a callback whereas the
> other 2 are helpers.
Sure, will make sdhci_enable_clk()

>
>>  {
>> -	u16 clk;
>>  	unsigned long timeout;
>>
>> -	host->mmc->actual_clock = 0;
>> -
>> -	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>> -
>> -	if (clock == 0)
>> -		return;
>> -
>> -	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>> -
>>  	clk |= SDHCI_CLOCK_INT_EN;
>>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>
>> @@ -1378,6 +1368,22 @@ void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>>  	clk |= SDHCI_CLOCK_CARD_EN;
>>  	sdhci_writew(host, clk, SDHCI_CLOCK_CONTROL);
>>  }
>> +EXPORT_SYMBOL_GPL(sdhci_enable_clock);
>> +
>> +void sdhci_set_clock(struct sdhci_host *host, unsigned int clock)
>> +{
>> +	u16 clk;
>> +
>> +	host->mmc->actual_clock = 0;
>> +
>> +	sdhci_writew(host, 0, SDHCI_CLOCK_CONTROL);
>> +
>> +	if (clock == 0)
>> +		return;
>> +
>> +	clk = sdhci_calc_clk(host, clock, &host->mmc->actual_clock);
>> +	sdhci_enable_clock(host, clk);
>> +}
>>  EXPORT_SYMBOL_GPL(sdhci_set_clock);
>>
>>  static void sdhci_set_power_reg(struct sdhci_host *host, unsigned char mode,
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 766df17..8e77a3b 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -681,6 +681,7 @@ static inline bool sdhci_sdio_irq_enabled(struct sdhci_host *host)
>>  u16 sdhci_calc_clk(struct sdhci_host *host, unsigned int clock,
>>  		   unsigned int *actual_clock);
>>  void sdhci_set_clock(struct sdhci_host *host, unsigned int clock);
>> +void sdhci_enable_clock(struct sdhci_host *host, unsigned short clk);
>>  void sdhci_set_power(struct sdhci_host *host, unsigned char mode,
>>  		     unsigned short vdd);
>>  void sdhci_set_power_noreg(struct sdhci_host *host, unsigned char mode,
>>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
