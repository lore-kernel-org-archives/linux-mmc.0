From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 5/8] sdhci: sdhci-esdhc-imx: change pinctrl state
 according to uhs mode
Date: Sat, 14 Sep 2013 00:38:34 +0800
Message-ID: <CAA+hA=Rkpq3O3Cm0B31q_csV1dee77dA2z5suAZx8-h30ThASQ@mail.gmail.com>
References: <1378299257-2980-1-git-send-email-b29396@freescale.com>
	<1378299257-2980-6-git-send-email-b29396@freescale.com>
	<CAPDyKFrCoQ7PMw29krxYsuFHH12NyDsPu7OxGb73QC-dNGXDVg@mail.gmail.com>
	<CAA+hA=QCv4q60iNkeQxB=8dafK7DjMNzG5vYmGx0qmT_xjQvNQ@mail.gmail.com>
	<CAPDyKFpUgA+180jtNcowjZrznbhvxfDyUSCmJYjefpfGRoOkZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:39667 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab3IMQif (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 13 Sep 2013 12:38:35 -0400
Received: by mail-qe0-f54.google.com with SMTP id cy11so1144705qeb.41
        for <linux-mmc@vger.kernel.org>; Fri, 13 Sep 2013 09:38:35 -0700 (PDT)
In-Reply-To: <CAPDyKFpUgA+180jtNcowjZrznbhvxfDyUSCmJYjefpfGRoOkZQ@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Dong Aisheng <b29396@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, anton@enomsg.org, linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

Hi Ulf,

Thanks for the reply.

On Fri, Sep 13, 2013 at 10:01 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 5 September 2013 18:04, Dong Aisheng <dongas86@gmail.com> wrote:
>> Hi Ulf,
>>
>> On Thu, Sep 5, 2013 at 3:38 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>>> On 4 September 2013 14:54, Dong Aisheng <b29396@freescale.com> wrote:
>>>> Without proper pinctrl state, the card may not be able to work
>>>> on high speed stablely. e.g. SDR104.
>>>>
>>>> This patch add pinctrl state switch code according to different
>>>> uhs mode include 100mhz sate, 200mhz sate and normal state
>>>> (50Mhz and below).
>>>>
>>>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>>>> ---
>>>>  drivers/mmc/host/sdhci-esdhc-imx.c          |  110 ++++++++++++++++++++++++++-
>>>>  include/linux/platform_data/mmc-esdhc-imx.h |    4 +
>>>>  2 files changed, 113 insertions(+), 1 deletions(-)
>>>>
>>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>>>> index 36b9f63..3e89863 100644
>>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>>> @@ -49,6 +49,10 @@
>>>>
>>>>  #define ESDHC_TUNING_BLOCK_PATTERN_LEN 64
>>>>
>>>> +/* pinctrl state */
>>>> +#define ESDHC_PINCTRL_STATE_100MHZ     "state_100mhz"
>>>> +#define ESDHC_PINCTRL_STATE_200MHZ     "state_200mhz"
>>>> +
>>>>  /*
>>>>   * Our interpretation of the SDHCI_HOST_CONTROL register
>>>>   */
>>>> @@ -90,6 +94,10 @@ struct pltfm_imx_data {
>>>>         u32 scratchpad;
>>>>         enum imx_esdhc_type devtype;
>>>>         struct pinctrl *pinctrl;
>>>> +       struct pinctrl_state *pins_current;
>>>> +       struct pinctrl_state *pins_default;
>>>> +       struct pinctrl_state *pins_100mhz;
>>>> +       struct pinctrl_state *pins_200mhz;
>>>>         struct esdhc_platform_data boarddata;
>>>>         struct clk *clk_ipg;
>>>>         struct clk *clk_ahb;
>>>> @@ -642,6 +650,75 @@ static int esdhc_executing_tuning(struct sdhci_host *host, u32 opcode)
>>>>         return ret;
>>>>  }
>>>>
>>>> +static int esdhc_change_pinstate(struct sdhci_host *host,
>>>> +                                               unsigned int uhs)
>>>> +{
>>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +       struct pltfm_imx_data *imx_data = pltfm_host->priv;
>>>> +       struct pinctrl_state *pinctrl;
>>>> +       int ret;
>>>> +
>>>> +       dev_dbg(mmc_dev(host->mmc), "change pinctrl state for uhs %d\n", uhs);
>>>> +
>>>> +       if (IS_ERR(imx_data->pinctrl) ||
>>>> +               IS_ERR(imx_data->pins_default) ||
>>>> +               IS_ERR(imx_data->pins_100mhz) ||
>>>> +               IS_ERR(imx_data->pins_200mhz))
>>>> +               return -EINVAL;
>>>> +
>>>> +       switch (uhs) {
>>>> +       case MMC_TIMING_UHS_SDR12:
>>>> +       case MMC_TIMING_UHS_SDR25:
>>>> +       case MMC_TIMING_UHS_DDR50:
>>>> +               pinctrl = imx_data->pins_default;
>>>> +               break;
>>>> +       case MMC_TIMING_UHS_SDR50:
>>>> +               pinctrl = imx_data->pins_100mhz;
>>>> +               break;
>>>> +       case MMC_TIMING_UHS_SDR104:
>>>> +               pinctrl = imx_data->pins_200mhz;
>>>> +               break;
>>>> +       default:
>>>> +               /* back to default state for other legacy timing */
>>>> +               pinctrl = imx_data->pins_default;
>>>> +       }
>>>> +
>>>> +       if (pinctrl == imx_data->pins_current)
>>>> +               return 0;
>>>> +
>>>> +       ret = pinctrl_select_state(imx_data->pinctrl, pinctrl);
>>>> +       if (!ret)
>>>> +               imx_data->pins_current = pinctrl;
>>>> +
>>>> +       return ret;
>>>> +}
>>>> +
>>>> +static int esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned int uhs)
>>>> +{
>>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>>> +       struct pltfm_imx_data *imx_data = pltfm_host->priv;
>>>> +
>>>> +       switch (uhs) {
>>>> +       case MMC_TIMING_UHS_SDR12:
>>>> +               imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR12;
>>>> +               break;
>>>> +       case MMC_TIMING_UHS_SDR25:
>>>> +               imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR25;
>>>> +               break;
>>>> +       case MMC_TIMING_UHS_SDR50:
>>>> +               imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR50;
>>>> +               break;
>>>> +       case MMC_TIMING_UHS_SDR104:
>>>> +               imx_data->uhs_mode = SDHCI_CTRL_UHS_SDR104;
>>>> +               break;
>>>> +       case MMC_TIMING_UHS_DDR50:
>>>> +               imx_data->uhs_mode = SDHCI_CTRL_UHS_DDR50;
>>>> +               break;
>>>> +       }
>>>> +
>>>> +       return esdhc_change_pinstate(host, uhs);
>>>> +}
>>>> +
>>>>  static const struct sdhci_ops sdhci_esdhc_ops = {
>>>>         .read_l = esdhc_readl_le,
>>>>         .read_w = esdhc_readw_le,
>>>> @@ -653,6 +730,7 @@ static const struct sdhci_ops sdhci_esdhc_ops = {
>>>>         .get_min_clock = esdhc_pltfm_get_min_clock,
>>>>         .get_ro = esdhc_pltfm_get_ro,
>>>>         .platform_bus_width = esdhc_pltfm_bus_width,
>>>> +       .set_uhs_signaling = esdhc_set_uhs_signaling,
>>>>         .platform_execute_tuning = esdhc_executing_tuning,
>>>>  };
>>>>
>>>> @@ -695,6 +773,11 @@ sdhci_esdhc_imx_probe_dt(struct platform_device *pdev,
>>>>
>>>>         of_property_read_u32(np, "max-frequency", &boarddata->f_max);
>>>>
>>>> +       if (of_find_property(np, "no-1-8-v", NULL))
>>>> +               boarddata->support_vsel = false;
>>>> +       else
>>>> +               boarddata->support_vsel = true;
>>>> +
>>>>         return 0;
>>>>  }
>>>>  #else
>>>> @@ -757,12 +840,20 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>>>         clk_prepare_enable(imx_data->clk_ipg);
>>>>         clk_prepare_enable(imx_data->clk_ahb);
>>>>
>>>> -       imx_data->pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
>>>> +       imx_data->pinctrl = devm_pinctrl_get(&pdev->dev);
>>>>         if (IS_ERR(imx_data->pinctrl)) {
>>>>                 err = PTR_ERR(imx_data->pinctrl);
>>>>                 goto disable_clk;
>>>>         }
>>>>
>>>> +       imx_data->pins_default = pinctrl_lookup_state(imx_data->pinctrl,
>>>> +                                               PINCTRL_STATE_DEFAULT);
>>>
>>> I believe you should look into the new pinctrl APIs and the new
>>> sequence at device driver core probe, which automatically fetches
>>> default, idle and sleep state pins. Additionally it sets the default
>>> state.
>>>
>>> It should likely simplifies some code in this patch.
>>>
>>
>> After looking into the pinctrl automatically fetch states, it seems
>> above two line may could be replaced as:
>> imx_data->pinctrl = (&pdev->dev)->pins->p;
>> imx_data->pins_default = (&pdev->dev)->pins->default_state;
>
> pinctrl_pm_select_default_state(dev)
> pinctrl_pm_select_ilde_state(dev)
> pinctrl_pm_select_sleep_state(dev)
>
> The states are fetched from device core at probe.
>

I did not use idle and sleep state, instead, i need get another two private
defined states,  state_100mhz, state_200mhz and select between them,
so these API seems not so useful for my case.
Even i want to use this API, i can only use it for default state which seems
not so neccesary.

Regards
Dong Aisheng

> Kind regards
> Ulf Hansson
>
>
>>
>> However, i'm not sure touching the pinctrl internal implementations in
>> device core is a good choice.
>> So i may still like to keep the exist using.
>>
>> Regards
>> Dong Aisheng
>>
>>> Kind regards
>>> Ulf Hansson
>>>
>>>
>>>> +       if (IS_ERR(imx_data->pins_default)) {
>>>> +               err = PTR_ERR(imx_data->pins_default);
>>>> +               dev_err(mmc_dev(host->mmc), "could not get default state\n");
>>>> +               goto disable_clk;
>>>> +       }
>>>> +
>>>>         host->quirks |= SDHCI_QUIRK_BROKEN_TIMEOUT_VAL;
>>>>
>>>>         if (is_imx25_esdhc(imx_data) || is_imx35_esdhc(imx_data))
>>>> @@ -839,6 +930,23 @@ static int sdhci_esdhc_imx_probe(struct platform_device *pdev)
>>>>                 break;
>>>>         }
>>>>
>>>> +       /* sdr50 and sdr104 needs work on 1.8v signal voltage */
>>>> +       if ((boarddata->support_vsel) && is_imx6q_usdhc(imx_data)) {
>>>> +               imx_data->pins_100mhz = pinctrl_lookup_state(imx_data->pinctrl,
>>>> +                                               ESDHC_PINCTRL_STATE_100MHZ);
>>>> +               imx_data->pins_200mhz = pinctrl_lookup_state(imx_data->pinctrl,
>>>> +                                               ESDHC_PINCTRL_STATE_200MHZ);
>>>> +               if (IS_ERR(imx_data->pins_100mhz) ||
>>>> +                               IS_ERR(imx_data->pins_200mhz)) {
>>>> +                       dev_warn(mmc_dev(host->mmc),
>>>> +                               "could not get ultra high speed state, work on normal mode\n");
>>>> +                       /* fall back to not support uhs by specify no 1.8v quirk */
>>>> +                       host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>>> +               }
>>>> +       } else {
>>>> +               host->quirks2 |= SDHCI_QUIRK2_NO_1_8_V;
>>>> +       }
>>>> +
>>>>         err = sdhci_add_host(host);
>>>>         if (err)
>>>>                 goto disable_clk;
>>>> diff --git a/include/linux/platform_data/mmc-esdhc-imx.h b/include/linux/platform_data/mmc-esdhc-imx.h
>>>> index d44912d..a0f5a8f 100644
>>>> --- a/include/linux/platform_data/mmc-esdhc-imx.h
>>>> +++ b/include/linux/platform_data/mmc-esdhc-imx.h
>>>> @@ -10,6 +10,8 @@
>>>>  #ifndef __ASM_ARCH_IMX_ESDHC_H
>>>>  #define __ASM_ARCH_IMX_ESDHC_H
>>>>
>>>> +#include <linux/types.h>
>>>> +
>>>>  enum wp_types {
>>>>         ESDHC_WP_NONE,          /* no WP, neither controller nor gpio */
>>>>         ESDHC_WP_CONTROLLER,    /* mmc controller internal WP */
>>>> @@ -32,6 +34,7 @@ enum cd_types {
>>>>   * @cd_gpio:   gpio for card_detect interrupt
>>>>   * @wp_type:   type of write_protect method (see wp_types enum above)
>>>>   * @cd_type:   type of card_detect method (see cd_types enum above)
>>>> + * @support_vsel:  indicate it supports 1.8v switching
>>>>   */
>>>>
>>>>  struct esdhc_platform_data {
>>>> @@ -41,5 +44,6 @@ struct esdhc_platform_data {
>>>>         enum cd_types cd_type;
>>>>         int max_bus_width;
>>>>         unsigned int f_max;
>>>> +       bool support_vsel;
>>>>  };
>>>>  #endif /* __ASM_ARCH_IMX_ESDHC_H */
>>>> --
>>>> 1.7.1
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> _______________________________________________
>>> linux-arm-kernel mailing list
>>> linux-arm-kernel@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
