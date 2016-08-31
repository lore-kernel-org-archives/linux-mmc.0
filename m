From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: avoid race condition of cpu and IDMAC
Date: Wed, 31 Aug 2016 15:36:25 +0800
Message-ID: <f70e6723-7a03-e67b-9522-2b39782a1393@rock-chips.com>
References: <1471599615-6249-1-git-send-email-shawn.lin@rock-chips.com>
 <CGME20160819095647epcas1p3e5d5153aa6a15a69285d50ca0dbae3d5@epcas1p3.samsung.com>
 <1471599615-6249-2-git-send-email-shawn.lin@rock-chips.com>
 <30134bdf-bd25-9a7f-8888-a02b83dd178e@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <30134bdf-bd25-9a7f-8888-a02b83dd178e@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: shawn.lin@rock-chips.com, Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Brian Norris <briannorris@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org
List-Id: linux-mmc@vger.kernel.org

On 2016/8/31 14:58, Jaehoon Chung wrote:
> Hi Shawn,
>
> On 08/19/2016 06:40 PM, Shawn Lin wrote:
>> We could see an obvious race condition by test that
>> the former write operation by IDMAC aiming to clear
>> OWN bit reach right after the later configuration of
>> the same desc, which makes the IDMAC be in SUSPEND
>> state as the OWN bit was cleared by the asynchronous
>> write operation of IDMAC. The bug can be very easy
>> reproduced on RK3288 or similar when we reduce the
>> running rate of system buses and keep the CPU running
>> faster. So as two separate masters, IDMAC and cpu
>> write the same descriptor stored on the same address,
>> and this should be protected by adding check of OWN
>> bit before preparing new descriptors.
>>
>> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
>> ---
>>
>>  drivers/mmc/host/dw_mmc.c | 30 ++++++++++++++++++++++++++++++
>>  1 file changed, 30 insertions(+)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 0a5a49f..e640f83 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -473,6 +473,7 @@ static inline void dw_mci_prepare_desc64(struct dw_mci *host,
>>  {
>>  	unsigned int desc_len;
>>  	struct idmac_desc_64addr *desc_first, *desc_last, *desc;
>> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
>>  	int i;
>>
>>  	desc_first = desc_last = desc = host->sg_cpu;
>> @@ -489,6 +490,20 @@ static inline void dw_mci_prepare_desc64(struct dw_mci *host,
>>  			length -= desc_len;
>>
>>  			/*
>> +			 * Wait for the former clear OWN bit operation
>> +			 * of IDMAC to make sure that this descriptor
>> +			 * isn't still owned by IDMAC as IDMAC's write
>> +			 * ops and CPU's read ops are asynchronous.
>> +			 */
>> +			while (readl(&desc->des0) & IDMAC_DES0_OWN) {
>> +				if (time_after(jiffies, timeout)) {
>> +					dev_err(host->dev, "DESC is still owned by IDMAC.\n");
>> +					break;
>
> Doesn't it need the error handling? Just display the message?

One reason for why I didn't add error handling is that
maybe we could add a very large timeout value for this, and
the system could be broken anyway if it does need such a long
time for a peripheral IP to write memory. But you are right maybe, it
is not a good idea to do that. I will propgate a error and let it
fall back to PIO mode.

Thanks.

>
> Best Regards,
> Jaehoon Chung
>
>> +				}
>> +				udelay(10);
>> +			}
>> +
>> +			/*
>>  			 * Set the OWN bit and disable interrupts
>>  			 * for this descriptor
>>  			 */
>> @@ -525,6 +540,7 @@ static inline void dw_mci_prepare_desc32(struct dw_mci *host,
>>  {
>>  	unsigned int desc_len;
>>  	struct idmac_desc *desc_first, *desc_last, *desc;
>> +	unsigned long timeout = jiffies + msecs_to_jiffies(100);
>>  	int i;
>>
>>  	desc_first = desc_last = desc = host->sg_cpu;
>> @@ -541,6 +557,20 @@ static inline void dw_mci_prepare_desc32(struct dw_mci *host,
>>  			length -= desc_len;
>>
>>  			/*
>> +			 * Wait for the former clear OWN bit operation
>> +			 * of IDMAC to make sure that this descriptor
>> +			 * isn't still owned by IDMAC as IDMAC's write
>> +			 * ops and CPU's read ops are asynchronous.
>> +			 */
>> +			while (readl(&desc->des0) & IDMAC_DES0_OWN) {
>> +				if (time_after(jiffies, timeout)) {
>> +					dev_err(host->dev, "DESC is still owned by IDMAC.\n");
>> +					break;
>> +				}
>> +				udelay(10);
>> +			}
>> +
>> +			/*
>>  			 * Set the OWN bit and disable interrupts
>>  			 * for this descriptor
>>  			 */
>>
>
>
>
>


-- 
Best Regards
Shawn Lin
