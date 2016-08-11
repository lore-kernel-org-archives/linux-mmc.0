From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v4 2/2] mmc: dw_mmc: add reset support to dwmmc host
 controller
Date: Thu, 11 Aug 2016 19:30:25 +0900
Message-ID: <f2aab41f-26f0-6740-4465-5ac57fdcd72e@samsung.com>
References: <1470816228-8874-1-git-send-email-guodong.xu@linaro.org>
 <1470816228-8874-3-git-send-email-guodong.xu@linaro.org>
 <CGME20160811022348epcas1p1be8c0797538de0a32a58d5c33731aa63@epcas1p1.samsung.com>
 <d39854ef-1a6a-bd58-2500-4db7f62f63c1@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <d39854ef-1a6a-bd58-2500-4db7f62f63c1@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shawn Lin <shawn.lin@rock-chips.com>, Guodong Xu <guodong.xu@linaro.org>, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, ulf.hansson@linaro.org
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mmc@vger.kernel.org, Xinwei Kong <kong.kongxinwei@hisilicon.com>, Zhangfei Gao <zhangfei.gao@linaro.org>
List-Id: linux-mmc@vger.kernel.org

Hi Guodong,

On 08/11/2016 11:23 AM, Shawn Lin wrote:
> On 2016/8/10 16:03, Guodong Xu wrote:
>> Dwmmc host controller may in unknown state when entering kernel boot. One
>> example is when booting from eMMC, bootloader need initialize MMC host
>> controller into some state so it can read. In order to make sure MMC host
>> controller in a clean initial state, this reset support is added.
>>
>> With this patch, a 'resets' property can be added into dw_mmc device
>> tree node. The hardware logic is: dwmmc host controller IP receives a reset
>> signal from a 'reset provider' (eg. power management unit). The 'resets'
>> property points to this reset signal. So, during dwmmc driver probe,
>> it can use this signal to reset itself.
>>
>> Refer to [1] for more information.
>>
>> [1] Documentation/devicetree/bindings/reset/reset.txt
>>
>> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
>> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> 
> Looks good to me,
> 
> Reviewed-by: Shawn Lin <shawn.lin@rock-chips.com>

Could you rebase on https://github.com/jh80chung/dw-mmc.git?
Otherwise, when i apply your patch, i will rebase.

Best Regards,
Jaehoon Chung

> 
>> ---
>>  drivers/mmc/host/dw_mmc.c  | 23 ++++++++++++++++++++++-
>>  include/linux/mmc/dw_mmc.h |  2 ++
>>  2 files changed, 24 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>> index 32380d5..481d441 100644
>> --- a/drivers/mmc/host/dw_mmc.c
>> +++ b/drivers/mmc/host/dw_mmc.c
>> @@ -2915,6 +2915,13 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>>      if (!pdata)
>>          return ERR_PTR(-ENOMEM);
>>
>> +    /* find reset controller when exist */
>> +    pdata->rstc = devm_reset_control_get_optional(dev, NULL);
>> +    if (IS_ERR(pdata->rstc)) {
>> +        if (PTR_ERR(pdata->rstc) == -EPROBE_DEFER)
>> +            return ERR_PTR(-EPROBE_DEFER);
>> +    }
>> +
>>      /* find out number of slots supported */
>>      of_property_read_u32(np, "num-slots", &pdata->num_slots);
>>
>> @@ -2986,7 +2993,9 @@ int dw_mci_probe(struct dw_mci *host)
>>
>>      if (!host->pdata) {
>>          host->pdata = dw_mci_parse_dt(host);
>> -        if (IS_ERR(host->pdata)) {
>> +        if (PTR_ERR(host->pdata) == -EPROBE_DEFER) {
>> +            return -EPROBE_DEFER;
>> +        } else if (IS_ERR(host->pdata)) {
>>              dev_err(host->dev, "platform data not available\n");
>>              return -EINVAL;
>>          }
>> @@ -3040,6 +3049,12 @@ int dw_mci_probe(struct dw_mci *host)
>>          }
>>      }
>>
>> +    if (!IS_ERR(host->pdata->rstc)) {
>> +        reset_control_assert(host->pdata->rstc);
>> +        usleep_range(10, 50);
>> +        reset_control_deassert(host->pdata->rstc);
>> +    }
>> +
>>      setup_timer(&host->cmd11_timer,
>>              dw_mci_cmd11_timer, (unsigned long)host);
>>
>> @@ -3189,6 +3204,9 @@ err_dmaunmap:
>>      if (host->use_dma && host->dma_ops->exit)
>>          host->dma_ops->exit(host);
>>
>> +    if (!IS_ERR(host->pdata->rstc))
>> +        reset_control_assert(host->pdata->rstc);
>> +
>>  err_clk_ciu:
>>      if (!IS_ERR(host->ciu_clk))
>>          clk_disable_unprepare(host->ciu_clk);
>> @@ -3221,6 +3239,9 @@ void dw_mci_remove(struct dw_mci *host)
>>      if (host->use_dma && host->dma_ops->exit)
>>          host->dma_ops->exit(host);
>>
>> +    if (!IS_ERR(host->pdata->rstc))
>> +        reset_control_assert(host->pdata->rstc);
>> +
>>      if (!IS_ERR(host->ciu_clk))
>>          clk_disable_unprepare(host->ciu_clk);
>>
>> diff --git a/include/linux/mmc/dw_mmc.h b/include/linux/mmc/dw_mmc.h
>> index 83b0edfc..f5af2bd 100644
>> --- a/include/linux/mmc/dw_mmc.h
>> +++ b/include/linux/mmc/dw_mmc.h
>> @@ -17,6 +17,7 @@
>>  #include <linux/scatterlist.h>
>>  #include <linux/mmc/core.h>
>>  #include <linux/dmaengine.h>
>> +#include <linux/reset.h>
>>
>>  #define MAX_MCI_SLOTS    2
>>
>> @@ -259,6 +260,7 @@ struct dw_mci_board {
>>      /* delay in mS before detecting cards after interrupt */
>>      u32 detect_delay_ms;
>>
>> +    struct reset_control *rstc;
>>      struct dw_mci_dma_ops *dma_ops;
>>      struct dma_pdata *data;
>>  };
>>
> 
> 
