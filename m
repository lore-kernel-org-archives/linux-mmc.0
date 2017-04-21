From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2] mmc: sdhci-esdhc-imx: reset tuning circuit when power
 on mmc card
Date: Fri, 21 Apr 2017 10:40:01 +0200
Message-ID: <CAPDyKFqVH_m_wXGH6Og8s+-SQT-JYqr7NwPVRhwXqioNDU1oRw@mail.gmail.com>
References: <1492509931-3388-1-git-send-email-haibo.chen@nxp.com>
 <CAPDyKFoUj+7y5+xZct=1B7k94_zNV0ML0QOznEa8DwvO1s9Y5w@mail.gmail.com> <CAA+hA=QhRsVLjntp3tjN=hCdbRAOLMrqhybAUqy05wzTqC8gaw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qk0-f174.google.com ([209.85.220.174]:35728 "EHLO
        mail-qk0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1036822AbdDUIkD (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 21 Apr 2017 04:40:03 -0400
Received: by mail-qk0-f174.google.com with SMTP id f133so66789575qke.2
        for <linux-mmc@vger.kernel.org>; Fri, 21 Apr 2017 01:40:02 -0700 (PDT)
In-Reply-To: <CAA+hA=QhRsVLjntp3tjN=hCdbRAOLMrqhybAUqy05wzTqC8gaw@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dong Aisheng <dongas86@gmail.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Adrian Hunter <adrian.hunter@intel.com>, Aisheng Dong <aisheng.dong@nxp.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 21 April 2017 at 07:53, Dong Aisheng <dongas86@gmail.com> wrote:
> Hi Ulf,
>
> On Thu, Apr 20, 2017 at 8:30 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 18 April 2017 at 12:05, Haibo Chen <haibo.chen@nxp.com> wrote:
>>> USDHC tuning circuit should be reset before every time card enumeration
>>> or re-enumeration.
>>>
>>> SD3.0 card need tuning. For SDR104 card, when system suspend in standby
>>> mode, and then resume back, the IO timing is still SDR104(tuned) which
>>> may result in card re-enumeration fail in low card speed(400khz) for some
>>> cards. And we did meet the issue that in certain probability, SDR104
>>> card meet mmc command CRC/Timeout error when send CMD2 during mmc bus
>>> resume.
>>>
>>> This patch reset the tuning circuit when the ios timing is
>>> MMC_TIMING_LEGACY/MMC_TIMING_MMC_HS/MMC_TIMING_SD_HS, which means both
>>> mmc_power_up() and mmc_power_off() will reset the tuning circuit.
>>>
>>> Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
>>> ---
>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 26 ++++++++++++++++++++++++++
>>>  1 file changed, 26 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> index abad67a..23d8b8a 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> @@ -889,6 +889,28 @@ static void esdhc_set_strobe_dll(struct sdhci_host *host)
>>>         }
>>>  }
>>>
>>> +static void esdhc_reset_tuning(struct sdhci_host *host)
>>> +{
>>> +       struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
>>> +       struct pltfm_imx_data *imx_data = sdhci_pltfm_priv(pltfm_host);
>>> +       u32 ctrl;
>>> +
>>> +       /* Rest the tuning circurt */
>>> +       if (esdhc_is_usdhc(imx_data)) {
>>> +               if (imx_data->socdata->flags & ESDHC_FLAG_MAN_TUNING) {
>>> +                       ctrl = readl(host->ioaddr + ESDHC_MIX_CTRL);
>>> +                       ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>>> +                       ctrl &= ~ESDHC_MIX_CTRL_FBCLK_SEL;
>>> +                       writel(ctrl, host->ioaddr + ESDHC_MIX_CTRL);
>>> +                       writel(0, host->ioaddr + ESDHC_TUNE_CTRL_STATUS);
>>> +               } else if (imx_data->socdata->flags & ESDHC_FLAG_STD_TUNING) {
>>> +                       ctrl = readl(host->ioaddr + SDHCI_ACMD12_ERR);
>>> +                       ctrl &= ~ESDHC_MIX_CTRL_SMPCLK_SEL;
>>> +                       writel(ctrl, host->ioaddr + SDHCI_ACMD12_ERR);
>>> +               }
>>> +       }
>>> +}
>>> +
>>>  static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>>>  {
>>>         u32 m;
>>> @@ -932,6 +954,10 @@ static void esdhc_set_uhs_signaling(struct sdhci_host *host, unsigned timing)
>>>                 host->ops->set_clock(host, host->clock);
>>>                 esdhc_set_strobe_dll(host);
>>>                 break;
>>> +       case MMC_TIMING_LEGACY:
>>> +       default:
>>> +               esdhc_reset_tuning(host);
>>> +               break;
>>
>> I understand this fixes the problem.
>>
>> However a more appropriate fix would be to reset tuning when
>> ->ios.power_mode == MMC_POWER_UP, don't you think?
>>
>
> rest_tuning seems all about the timing related stuff and it tends to be
> executed for all non-uhs timings setting in case there's an uhs mode

Yes, you are right. But this is actually why it caught my attention.

Doesn't it seems weird that ->set_ios() invokes sdhci's
->set_uhs_signalling() callback, when in fact the timing isn't for UHS
- but for all timings?

Could you perhaps re-name the callback from ->set_uhs_signalling to
->set_timing(), to better reflect its purpose?

> running before. It looks like not quite depend on MMC_POWER_UP,
> that why we put it in set_uhs_signaling().
>
> However, doing it in MMC_POWER_UP actually almost functions the same as
> it will set MMC_TIMING_LEGACY accordingly.
>
> To me, it looks like ok to keep in set_uhs_signaling, but if you insist,
> we can do it in MMC_POWER_UP, by a new platform specific .set_power().

Alright, it's no big deal for me. Just wanted to raise that seemed a bit weird.

Kind regards
Uffe
