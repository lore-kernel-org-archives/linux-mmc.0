From: Ritesh Harjani <riteshh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: Re: [PATCH v6 01/14] clk: Add clk_hw_get_clk() helper API to be used
 by clk providers
Date: Tue, 8 Nov 2016 09:38:40 +0530
Message-ID: <22a27198-5659-2442-ce12-e1155a9699e7@codeaurora.org>
References: <1478517877-23733-1-git-send-email-riteshh@codeaurora.org>
 <1478517877-23733-2-git-send-email-riteshh@codeaurora.org>
 <58214862.8080604@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <58214862.8080604-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, adrian.hunter-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david.brown-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, andy.gross-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, georgi.djakov-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, alex.lemberg-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, mateusz.nowak-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, Yuliy.Izrailov-XdAiOPVOjttBDgjK7y7TUQ@public.gmane.org, asutoshd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, kdorfman-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, david.griego-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, stummala-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, venkatg-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, pramod.gurav-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
List-Id: linux-mmc@vger.kernel.org

Hi,

On 11/8/2016 9:07 AM, Rajendra Nayak wrote:
>
>
> On 11/07/2016 04:54 PM, Ritesh Harjani wrote:
>> From: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>>
>> Add a helper API that will allow clk providers to turn their clk_hw
>> structures into struct clk pointer.
>>
>> Signed-off-by: Rajendra Nayak <rnayak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
>
> Please drop this patch, it isn't needed here anyway, besides
> it needs to be reworked as already discussed.
Ok, sure.

>
>> ---
>>  drivers/clk/clk.c            | 6 ++++++
>>  include/linux/clk-provider.h | 1 +
>>  2 files changed, 7 insertions(+)
>>
>> diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
>> index 0fb39fe..52ef035 100644
>> --- a/drivers/clk/clk.c
>> +++ b/drivers/clk/clk.c
>> @@ -186,6 +186,12 @@ const char *clk_hw_get_name(const struct clk_hw *hw)
>>  }
>>  EXPORT_SYMBOL_GPL(clk_hw_get_name);
>>
>> +struct clk *clk_hw_get_clk(const struct clk_hw *hw)
>> +{
>> +	return hw->clk;
>> +}
>> +EXPORT_SYMBOL_GPL(clk_hw_get_clk);
>> +
>>  struct clk_hw *__clk_get_hw(struct clk *clk)
>>  {
>>  	return !clk ? NULL : clk->core->hw;
>> diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
>> index af59638..37022a9 100644
>> --- a/include/linux/clk-provider.h
>> +++ b/include/linux/clk-provider.h
>> @@ -729,6 +729,7 @@ struct clk_hw *clk_hw_register_gpio_mux(struct device *dev, const char *name,
>>  /* helper functions */
>>  const char *__clk_get_name(const struct clk *clk);
>>  const char *clk_hw_get_name(const struct clk_hw *hw);
>> +struct clk *clk_hw_get_clk(const struct clk_hw *hw);
>>  struct clk_hw *__clk_get_hw(struct clk *clk);
>>  unsigned int clk_hw_get_num_parents(const struct clk_hw *hw);
>>  struct clk_hw *clk_hw_get_parent(const struct clk_hw *hw);
>>
>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
