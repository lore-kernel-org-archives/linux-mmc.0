From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 1/2] mmc: sdhci: add sdma_buffer_boundary_arg member to
 sdhci_host
Date: Thu, 3 Aug 2017 12:50:05 +0100
Message-ID: <583ab75b-4a54-d928-2827-33fc4126ad46@linaro.org>
References: <20170802083807.26280-1-srinivas.kandagatla@linaro.org>
 <20170802083807.26280-2-srinivas.kandagatla@linaro.org>
 <62dd4283-fb06-234e-ea8e-883e97de46b7@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <62dd4283-fb06-234e-ea8e-883e97de46b7@intel.com>
Content-Language: en-US
Sender: linux-arm-msm-owner@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>, ulf.hansson@linaro.org
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org



On 03/08/17 12:39, Adrian Hunter wrote:
> On 02/08/17 11:38, srinivas.kandagatla@linaro.org wrote:
>> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>>
>> This patch adds sdma_buffer_boundary_arg member to struct sdhci_host to
>> give more flexibility to drivers to control the sdma boundary buffer value
>> and also to fix issue on some sdhci controllers which are broken when
>> HOST SDMA Buffer Boundary is programmed in Block Size Register (0x04)
>> when using ADMA. Qualcomm sdhci controller is one of such type, writing
>> to this bits is un-supported.
>>
>> Default value of sdma_buffer_boundary_arg is set to SDHCI_DEFAULT_BOUNDARY_ARG.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> There are a couple of minor suggestions below
> 
>> ---
>>   drivers/mmc/host/sdhci.c | 14 ++++++++++----
>>   drivers/mmc/host/sdhci.h |  3 +++
>>   2 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index ecd0d4350e8a..4a7b5dcfc55b 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -897,7 +897,7 @@ static void sdhci_prepare_data(struct sdhci_host *host, struct mmc_command *cmd)
>>   	sdhci_set_transfer_irqs(host);
>>   
>>   	/* Set the DMA boundary value and block size */
>> -	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG,
>> +	sdhci_writew(host, SDHCI_MAKE_BLKSZ(host->sdma_buffer_boundary_arg,
>>   		data->blksz), SDHCI_BLOCK_SIZE);
>>   	sdhci_writew(host, data->blocks, SDHCI_BLOCK_COUNT);
>>   }
>> @@ -2037,6 +2037,7 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>>   	struct mmc_command cmd = {};
>>   	struct mmc_request mrq = {};
>>   	unsigned long flags;
>> +	u32 barg = host->sdma_buffer_boundary_arg;
> 
> Might as well use a 2-character variable name and avoid the line wrapping
> e.g. 'barg' -> 'sb'

Sure, that would work.

> 
>>   
>>   	spin_lock_irqsave(&host->lock, flags);
>>   
>> @@ -2052,9 +2053,11 @@ static void sdhci_send_tuning(struct sdhci_host *host, u32 opcode)
>>   	 */
>>   	if (cmd.opcode == MMC_SEND_TUNING_BLOCK_HS200 &&
>>   	    mmc->ios.bus_width == MMC_BUS_WIDTH_8)
>> -		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 128), SDHCI_BLOCK_SIZE);
>> +		sdhci_writew(host,
>> +			     SDHCI_MAKE_BLKSZ(barg, 128), SDHCI_BLOCK_SIZE);
>>   	else
>> -		sdhci_writew(host, SDHCI_MAKE_BLKSZ(7, 64), SDHCI_BLOCK_SIZE);
>> +		sdhci_writew(host,
>> +			     SDHCI_MAKE_BLKSZ(barg, 64), SDHCI_BLOCK_SIZE);
>>   
>>   	/*
>>   	 * The tuning block is sent by the card to the host controller.
>> @@ -2998,7 +3001,8 @@ void sdhci_cqe_enable(struct mmc_host *mmc)
>>   		ctrl |= SDHCI_CTRL_ADMA32;
>>   	sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
>>   
>> -	sdhci_writew(host, SDHCI_MAKE_BLKSZ(SDHCI_DEFAULT_BOUNDARY_ARG, 512),
>> +	sdhci_writew(host,
>> +		     SDHCI_MAKE_BLKSZ(host->sdma_buffer_boundary_arg, 512),
>>   		     SDHCI_BLOCK_SIZE);
>>   
>>   	/* Set maximum timeout */
>> @@ -3119,6 +3123,8 @@ struct sdhci_host *sdhci_alloc_host(struct device *dev,
>>   
>>   	host->tuning_delay = -1;
>>   
>> +	host->sdma_buffer_boundary_arg = SDHCI_DEFAULT_BOUNDARY_ARG;
>> +
>>   	return host;
>>   }
>>   
>> diff --git a/drivers/mmc/host/sdhci.h b/drivers/mmc/host/sdhci.h
>> index 0469fa191493..6ff2294e55b3 100644
>> --- a/drivers/mmc/host/sdhci.h
>> +++ b/drivers/mmc/host/sdhci.h
>> @@ -541,6 +541,9 @@ struct sdhci_host {
>>   	/* Delay (ms) between tuning commands */
>>   	int			tuning_delay;
>>   
>> +	/* Host SDMA buffer boundary. */
>> +	u32			sdma_buffer_boundary_arg;
> 
> The name seems a bit long.  What about just 'sdma_boundary'?
> 
sounds good, I will spin a new version with sdma_boundary .

thanks,
srini

>> +
>>   	unsigned long private[0] ____cacheline_aligned;
>>   };
>>   
>>
> 
