From: zhangfei <zhangfei.gao@linaro.org>
Subject: Re: [PATCH 2/2] mmc: dw_mmc: add resets support to dw_mci_parse_dt()
Date: Fri, 04 Mar 2016 11:27:36 +0800
Message-ID: <56D900A8.9070204@linaro.org>
References: <1456968818-22140-1-git-send-email-guodong.xu@linaro.org> <1456968818-22140-2-git-send-email-guodong.xu@linaro.org> <56D79AB4.7050809@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <56D79AB4.7050809@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Guodong Xu <guodong.xu@linaro.org>, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, jh80.chung@samsung.com, ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org
Cc: shawn.lin@kernel-upstream.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>
List-Id: linux-mmc@vger.kernel.org



On 03/03/2016 10:00 AM, Shawn Lin wrote:
> Hi Guodong,
>
> On 2016/3/3 9:33, Guodong Xu wrote:
>> With this, user can add a 'resets' property into dw_mmc dts
>> node, and when driver probe and parse_dt, it will call
>> reset APIs to reset dw_mmc host controller.
>>
>> Please also refer to Documentation/devicetree/bindings/reset/reset.txt
>
> I have no hard objection for this patch, but I'd rather not add it
> unless we actually need it. Could you elaborate more about any futher
> actions you will take if it's applied(i.e: deal with some unrecoverable
> broken case)?  If we just reset the controller while probing, actually I
> can't find any problems without it based on tons of my reboot test.

mmc register maybe abnormal state, if mmc is used in uefi, like boot 
from emmc.
So we need reset mmc register when kernel boot up, instead of assuming 
mmc is in clean state.
Next step is adding reset node in dts for drivers/mmc/host/dw_mmc-k3.c 
as reset driver is already there.

>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 242f9a0..d3a7376 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2878,6 +2878,13 @@ static struct dw_mci_board
>> *dw_mci_parse_dt(struct dw_mci *host)
>>       if (!pdata)
>>           return ERR_PTR(-ENOMEM);
>>
>> +    /* find reset controller when exist */
>> +    pdata->rstc = devm_reset_control_get_optional(dev, NULL);
>> +    if (IS_ERR(pdata->rstc))
>> +        pdata->rstc = NULL;
>> +    else
>> +        reset_control_deassert(pdata->rstc);
>> +
>
> if the PTR_ERR(pdata->rstc) is -EPROBE_DEFER, should we defer probing
> the driver?
Yes, good catch.

Thanks
