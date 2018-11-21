From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH 1/4] mmc: sdhci-omap: Fix DCRC error handling during
 tuning
Date: Wed, 21 Nov 2018 15:09:02 +0530
Message-ID: <c4c73144-eed1-2f34-953f-85da5b7ba955@ti.com>
References: <20181119111618.2745-1-faiz_abbas@ti.com>
 <20181119111618.2745-2-faiz_abbas@ti.com>
 <b4568cfc-55c6-9dfc-6d26-1efc999e95ec@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b4568cfc-55c6-9dfc-6d26-1efc999e95ec@ti.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Kishon Vijay Abraham I <kishon@ti.com>, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: ulf.hansson@linaro.org, adrian.hunter@intel.com
List-Id: linux-mmc@vger.kernel.org

Hi Kishon,

On 20/11/18 10:23 AM, Kishon Vijay Abraham I wrote:
> Hi,
> 
> On 19/11/18 4:46 PM, Faiz Abbas wrote:
>> Commit 7d33c3581536 ("mmc: sdhci-omap: Workaround for Errata i802")
>> disabled DCRC interrupts during tuning. This write to the interrupt
>> enable register gets overwritten in sdhci_prepare_data() and the
>> interrupt is not in fact disabled. Fix this by disabling the interrupt
>> in the host->ier variable.
>>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>   drivers/mmc/host/sdhci-omap.c | 7 +++----
>>   1 file changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci-omap.c
>> b/drivers/mmc/host/sdhci-omap.c
>> index 88347ce78f23..87138067e334 100644
>> --- a/drivers/mmc/host/sdhci-omap.c
>> +++ b/drivers/mmc/host/sdhci-omap.c
>> @@ -290,7 +290,6 @@ static int sdhci_omap_execute_tuning(struct
>> mmc_host *mmc, u32 opcode)
>>       u32 start_window = 0, max_window = 0;
>>       u8 cur_match, prev_match = 0;
>>       u32 length = 0, max_len = 0;
>> -    u32 ier = host->ier;
>>       u32 phase_delay = 0;
>>       int ret = 0;
>>       u32 reg;
>> @@ -317,9 +316,7 @@ static int sdhci_omap_execute_tuning(struct
>> mmc_host *mmc, u32 opcode)
>>        * during the tuning procedure. So disable it during the
>>        * tuning procedure.
>>        */
>> -    ier &= ~SDHCI_INT_DATA_CRC;
>> -    sdhci_writel(host, ier, SDHCI_INT_ENABLE);
>> -    sdhci_writel(host, ier, SDHCI_SIGNAL_ENABLE);
>> +    host->ier &= ~SDHCI_INT_DATA_CRC;
>>         while (phase_delay <= MAX_PHASE_DELAY) {
>>           sdhci_omap_set_dll(omap_host, phase_delay);
>> @@ -366,6 +363,8 @@ static int sdhci_omap_execute_tuning(struct
>> mmc_host *mmc, u32 opcode)
>>     ret:
>>       sdhci_reset(host, SDHCI_RESET_CMD | SDHCI_RESET_DATA);
>> +    /* Reenable forbidden interrupt */
>> +    host->ier |= SDHCI_INT_DATA_CRC;
> 
> It's better to have a backup of host->ier and restore the value here (in
> case DATA_CRC is disabled for other cases).
> 

host->ier is modified everywhere during an mmc request. I would not
expect it to hold its value after so many tuning commands. I can add a
bool to check of DCRC was enabled before and only then re-enable it.

Thanks,
Faiz
