From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH V1 07/11] mmc: cqhci: add quirk for setting DCMD
 CMD_TIMING
Date: Thu, 7 Mar 2019 08:13:55 +0530
Message-ID: <a544bc6d-7b23-53e8-16d0-ee0eaf576eb2@codeaurora.org>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
 <1551504025-3541-7-git-send-email-skomatineni@nvidia.com>
 <a320c841-7e58-4d3e-5df6-61e10520d9d8@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a320c841-7e58-4d3e-5df6-61e10520d9d8@intel.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, Sowjanya Komatineni <skomatineni@nvidia.com>, ulf.hansson@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com, Asutosh Das <asutoshd@codeaurora.org>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, anrao@nvidia.com, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org


On 3/6/2019 6:30 PM, Adrian Hunter wrote:
> On 2/03/19 7:20 AM, Sowjanya Komatineni wrote:
>> This patch adds a quirk for setting CMD_TIMING to 1 in descriptor
>> for DCMD with R1B response type to allow the command to be sent to
>> device during data activity or busy time.
>>
>> Tegra186 CQHCI host has bug where it selects DATA_PRESENT_SELECT
>> to 1 by CQHCI controller for DCMDs with R1B response type and
>> since DCMD does not trigger any data transfer, DCMD task complete
>> happens leaving the DATA FSM of host controller in wait state for
>> data.
>>
>> This effects the data transfer task issued after R1B DCMD task
>> and no interrupt is generated for the data transfer task.
>>
>> SW WAR for this issue is to set CMD_TIMING bit to 1 in DCMD task
>> descriptor and as DCMD task descriptor preparation is done by
>> cqhci driver, this patch adds cqequirk to handle this.
>>
>> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
>> ---
>>   drivers/mmc/host/cqhci.c | 5 ++++-
>>   drivers/mmc/host/cqhci.h | 1 +
>>   2 files changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/cqhci.c b/drivers/mmc/host/cqhci.c
>> index a8af682a9182..b34c07125f32 100644
>> --- a/drivers/mmc/host/cqhci.c
>> +++ b/drivers/mmc/host/cqhci.c
>> @@ -521,7 +521,10 @@ static void cqhci_prep_dcmd_desc(struct mmc_host *mmc,
>>   	} else {
>>   		if (mrq->cmd->flags & MMC_RSP_R1B) {
>>   			resp_type = 0x3;
>> -			timing = 0x0;
>> +			if (cq_host->quirks & CQHCI_QUIRK_CMD_TIMING_R1B_DCMD)
>> +				timing = 0x1;
>> +			else
>> +				timing = 0x0;
> I was thinking it would be nice if there was a generic way for drivers to
> make changes to descriptors before a task is started.  Currently there is
> host->ops->write_l() which would make it possible by checking for CQHCI_TDBR
> register and, in this case, the DCMD tag.  We would need to export
> get_desc(), perhaps rename it cqhci_get_desc() and put it in cqhci.h since
> it is an inline function.

We take spin_lock_irqsave after the descriptor is prepared and before 
writing to TDBR.
Not sure but tomorrow this may become a limitation for drivers to make 
changes to
descriptors if they edit descriptors in host->ops->write_l() call.
Though in this case it is not required here.

>
> Alternatively we could add host->ops for descriptor preparation.

Both ways sounds good to me.
But maybe adding a host->ops for descriptor preparation is better way to go,
since that will be the right interface exposed to make changes to 
descriptors.

>
> What do people think?
>
>>   		} else {
>>   			resp_type = 0x2;
>>   			timing = 0x1;
>> diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
>> index 9e68286a07b4..f96d8565cc07 100644
>> --- a/drivers/mmc/host/cqhci.h
>> +++ b/drivers/mmc/host/cqhci.h
>> @@ -170,6 +170,7 @@ struct cqhci_host {
>>   
>>   	u32 quirks;
>>   #define CQHCI_QUIRK_SHORT_TXFR_DESC_SZ	0x1
>> +#define CQHCI_QUIRK_CMD_TIMING_R1B_DCMD	0x2
>>   
>>   	bool enabled;
>>   	bool halted;
>>
