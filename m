From: Jaehoon Chung <jh80.chung@samsung.com>
Subject: Re: [PATCH v5 4/9] mmc: dw_mmc: lookup for optional biu and ciu clocks
Date: Fri, 31 Aug 2012 15:02:20 +0900
Message-ID: <5040536C.30407@samsung.com>
References: <1346237295-7116-1-git-send-email-thomas.abraham@linaro.org>
 <1346237295-7116-5-git-send-email-thomas.abraham@linaro.org>
 <503F28E7.1060608@samsung.com>
 <CAJuYYwQtAe7kC4DC5Ao04qU_9TSjcREw7ktuf6KNmgXHAvUzKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <CAJuYYwQtAe7kC4DC5Ao04qU_9TSjcREw7ktuf6KNmgXHAvUzKg@mail.gmail.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Thomas Abraham <thomas.abraham@linaro.org>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, linux-mmc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, will.newton@imgtec.com, cjb@laptop.org, grant.likely@secretlab.ca, rob.herring@calxeda.com, linux-samsung-soc@vger.kernel.org, kgene.kim@samsung.com, girish.shivananjappa@linaro.org, tgih.jun@samsung.com, patches@linaro.org
List-Id: linux-mmc@vger.kernel.org

On 08/31/2012 02:29 PM, Thomas Abraham wrote:
> On 30 August 2012 14:18, Jaehoon Chung <jh80.chung@samsung.com> wrote:
>> Hi Thomas,
>>
>> On 08/29/2012 07:48 PM, Thomas Abraham wrote:
>>> Some platforms allow for clock gating and control of bus interface unit clock
>>> and card interface unit clock. Add support for clock lookup of optional biu
>>> and ciu clocks for clock gating and clock speed determination.
>>>
>>> Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
>>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>>> Acked-by: Will Newton <will.newton@imgtec.com>
>>> ---
>>>  drivers/mmc/host/dw_mmc.c  |   42 +++++++++++++++++++++++++++++++++++++++---
>>>  include/linux/mmc/dw_mmc.h |    4 ++++
>>>  2 files changed, 43 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
>>> index 227c42e..90c7c7b 100644
>>> --- a/drivers/mmc/host/dw_mmc.c
>>> +++ b/drivers/mmc/host/dw_mmc.c
>>> @@ -1960,18 +1960,38 @@ int dw_mci_probe(struct dw_mci *host)
>>>               return -ENODEV;
>>>       }
>>>
>>> -     if (!host->pdata->bus_hz) {
>>> +     host->biu_clk = clk_get(host->dev, "biu");
>>> +     if (IS_ERR(host->biu_clk))
>>> +             dev_dbg(host->dev, "biu clock not available\n");
>>> +     else
>>> +             clk_prepare_enable(host->biu_clk);
>> biu is clock for bus interface?
>> if didn't get "biu_clk" or didn't clk_prepare_enable(), then can we initialize the card?
> 
> Hi Jaehoon,
> 
> Yes, the biu clock is for bus interface. The biu and ciu clock lookup
> and enable here is optional in the above change. If a platform does
> not define these clocks, then the platform code is responsible for
> enabling these clocks.
If biu_clk is presented...
Is there no probability that clk_prepare_enable is failed?
> 
>>> +
>>> +     host->ciu_clk = clk_get(host->dev, "ciu");
>>> +     if (IS_ERR(host->ciu_clk))
>>> +             dev_dbg(host->dev, "ciu clock not available\n");
>>> +     else
>>> +             clk_prepare_enable(host->ciu_clk);
>>> +
>>> +     if (IS_ERR(host->ciu_clk))
>>> +             host->bus_hz = host->pdata->bus_hz;
>>> +     else
>>> +             host->bus_hz = clk_get_rate(host->ciu_clk);
>> if clk_get_rate() is incorrect value(ex,400MHz),
>> then mmc->f_min value is too high.
>> because mmc->f_min is assigned to DIV_ROUND_UP(host->bus_hz, 510) into dw_mc_init_slot.
>> Do you have any opinion for solving this?
> 
> One option on Exynos5250 is to use the clock divider in the CLKSEL
> register to divide the ciu clock to a lower value. For Exynos4, since
> there is no clock divider in CLKSEL register, the platform code should
> ensure that the ciu clock has a valid range.
I know that can use div-ratio filed at the clksel register.
On Exynos5, i known that is used the div-ratio at CLKSEL register.
If ciu-clock is 400MHz, host->bus_hz is assigned to 400MHz.
1) host->bus_hz -> 400MHz (at dw-mmc-pltfm.c)
2) mmc->f_min = DIV_ROUND_UP(host->bus_hz, 510) then mmc->f_min is set to 784KHz.
3) then host->bus_hz is re-assigned to value that is divided to div-ratio at CLKSEL register.
   at this time, host->bus_hz = 100MHz...

I think this sequence is something wrong.
(Is 784KHz too high for init card?)

It's just my thinking..if my understanding is wrong, let me know plz.

Best Regards,
Jaehoon Chung

> 
> Thanks,
> Thomas.
> 
> [...]
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
