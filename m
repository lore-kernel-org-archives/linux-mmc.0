From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/2] mmc: sdhci-esdhc-imx: correct the tuning-step setting
Date: Fri, 20 Nov 2015 16:23:58 +0100
Message-ID: <CAPDyKFpvye6Yjy+C2oPHV9Oh56CkygZ-+nQC7W9aPbOMs33Nng@mail.gmail.com>
References: <1447148610-2770-1-git-send-email-haibo.chen@freescale.com>
	<1447148610-2770-2-git-send-email-haibo.chen@freescale.com>
	<CAPDyKFp=DJP0t5Q90E4byuGypcHsK0wU629M=rK-WA20=AGKhA@mail.gmail.com>
	<CAA+hA=RPkQdj0jEPxm4EEQv2-yRN9OJtkBox6sU==OoRmbAraw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAA+hA=RPkQdj0jEPxm4EEQv2-yRN9OJtkBox6sU==OoRmbAraw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>, Haibo Chen <haibo.chen@freescale.com>
Cc: Dong Aisheng <aisheng.dong@freescale.com>, linux-mmc <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-mmc@vger.kernel.org

On 19 November 2015 at 17:34, Dong Aisheng <dongas86@gmail.com> wrote:
> Hi Ulf,
>
> On Thu, Nov 19, 2015 at 7:20 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 10 November 2015 at 10:43, Haibo Chen <haibo.chen@freescale.com> wrote:
>>> Here we use '|=' to set the tuning-step, but before that, we should
>>> clear the tuning-step, otherwise we could got the wrong setting.
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@freescale.com>
>>> ---
>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> index 1508949..64275c7 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> @@ -76,6 +76,7 @@
>>>  #define ESDHC_STD_TUNING_EN            (1 << 24)
>>>  /* NOTE: the minimum valid tuning start tap for mx6sl is 1 */
>>>  #define ESDHC_TUNING_START_TAP         0x1
>>> +#define ESDHC_TUNING_STEP_MASK         0x00070000
>>>  #define ESDHC_TUNING_STEP_SHIFT                16
>>>
>>>  /* pinctrl state */
>>> @@ -489,9 +490,11 @@ static void esdhc_writew_le(struct sdhci_host *host, u16 val, int reg)
>>>                                 m |= ESDHC_MIX_CTRL_FBCLK_SEL;
>>>                                 tuning_ctrl = readl(host->ioaddr + ESDHC_TUNING_CTRL);
>>>                                 tuning_ctrl |= ESDHC_STD_TUNING_EN | ESDHC_TUNING_START_TAP;
>>> -                               if (imx_data->boarddata.tuning_step)
>>> +                               if (imx_data->boarddata.tuning_step) {
>>> +                                       tuning_ctrl &= ~ESDHC_TUNING_STEP_MASK;
>>>                                         tuning_ctrl |= imx_data->boarddata.tuning_step << ESDHC_TUNING_STEP_SHIFT;
>>> -                                       writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
>>> +                               }
>>> +                               writel(tuning_ctrl, host->ioaddr + ESDHC_TUNING_CTRL);
>>>                         } else {
>>>                                 v &= ~ESDHC_MIX_CTRL_EXE_TUNE;
>>>                         }
>>> --
>>> 1.9.1
>>>
>>
>> Looks good to me, but is there a dependency to patch 1/2 that should
>> prevent me from applying this one?
>>
>
> No dependency.
> Acked-by: Dong Aisheng <aisheng.dong@freescale.com>
>

Okay. I have applied it for next, thanks!

Kind regards
Uffe
