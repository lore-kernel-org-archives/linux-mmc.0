From: Lars Persson <lars.persson-VrBV9hrLPhE@public.gmane.org>
Subject: Re: [PATCH v2 3/3] mmc: usdhi6rol0: add pinctrl to set pin drive
 strength
Date: Wed, 20 Apr 2016 15:41:11 +0200
Message-ID: <571786F7.6040802@axis.com>
References: <cover.1460986983.git.larper@axis.com>	<181127e4ec8bbfbf0f80018ff157b59d63597c44.1460986983.git.larper@axis.com>	<CAPDyKFo60PBkOtLRyuDBHVh+LB_d0vcATSuTMu4TWeLsWgQVSw@mail.gmail.com>	<8190F2E9-1F0C-4A33-90AF-7C594F2EB997@axis.com> <CAPDyKFoV7h73K+7HhkdS7BC1RUAo3dcum_+cRikY=_F2YBeNSA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAPDyKFoV7h73K+7HhkdS7BC1RUAo3dcum_+cRikY=_F2YBeNSA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Lars Persson <larper-VrBV9hrLPhE@public.gmane.org>
Cc: linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Guennadi Liakhovetski <g.liakhovetski-Mmb7MZpHnFY@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, =?UTF-8?B?UGF3ZcWCIE1vbGw=?= <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org



On 04/20/2016 02:15 PM, Ulf Hansson wrote:
> [...]
>
>>>>
>>>> +static int usdhi6_set_pinstates(struct usdhi6_host *host, int voltage)
>>>> +{
>>>> +       if (IS_ERR(host->pinctrl) || IS_ERR(host->pins_default) ||
>>>> +           IS_ERR(host->pins_uhs))
>>>
>>> So this means, if you have UHS support you need both default and uhs
>>> pins. That makes sense but it's not according to the DT documentation
>>> in patch 1/3.
>>
>> No. It means that if this particular board requires distinct settings for UHS then both pin states need to be defined. Otherwise we assume that the default settings are fine also for UHS.
>
> I see.
>
> I would rather see that you bail out in ->probe() when
> IS_ERR(host->pinctrl) instead of testing for that here.
>
> Conforming to the policy you describe here, you should only need to
> test for IS_ERR(host->pins_uhs), as host->pins_default shall then be
> implicitly covered by that test.

Ok.

>
>>
>>>
>>>> +               return 0;
>>>> +
>>>> +       switch (voltage) {
>>>> +       case MMC_SIGNAL_VOLTAGE_180:
>>>> +       case MMC_SIGNAL_VOLTAGE_120:
>>>> +               return pinctrl_select_state(host->pinctrl,
>>>> +                                           host->pins_uhs);
>>>> +
>>>> +       default:
>>>> +               return pinctrl_select_state(host->pinctrl,
>>>> +                                           host->pins_default);
>>>> +       }
>>>> +}
>>>> +
>>>> static int usdhi6_sig_volt_switch(struct mmc_host *mmc, struct mmc_ios *ios)
>>>> {
>>>>         int ret;
>>>>
>>>>         ret = mmc_regulator_set_vqmmc(mmc, ios);
>>>
>>> What if you don't have pins for default and uhs state? Should you
>>> verify that's the case before deciding to switch voltage
>>
>> No see my reply above.
>
> Okay!
>
>>
>>>
>>>>
>>>> -       if (ret < 0)
>>>> +       if (ret < 0) {
>>>>                 dev_warn(mmc_dev(mmc), "Voltage switch failed: %d\n", ret);
>>>> +               return ret;
>>>> +       }
>>>> +
>>>> +       ret = usdhi6_set_pinstates(mmc_priv(mmc), ios->signal_voltage);
>>>> +       if (ret)
>>>> +               dev_warn_once(mmc_dev(mmc),
>>>> +                             "Failed to set pinstate err=%d\n", ret);
>>>>
>>>>         return ret;
>>>> }
>>>> @@ -1817,6 +1848,13 @@ static int usdhi6_probe(struct platform_device *pdev)
>>>>                 mmc->f_max = host->imclk;
>>>>         mmc->f_min = host->imclk / 512;
>>>>
>>>> +       host->pinctrl = devm_pinctrl_get(&pdev->dev);
>>>> +       if (!IS_ERR(host->pinctrl)) {
>>>> +               host->pins_default = pinctrl_lookup_state(host->pinctrl,
>>>> +                                                         PINCTRL_STATE_DEFAULT);
>>>
>>> According to the DT documentation in patch 1/3, the default pins
>>> should be required and not optional. I assume you want them to be
>>> optional, but required when supporting UHS, right?
>>
>> Yes the default is required only when a UHS pin state is defined. Hence all the pinctrl parameters are listed as optional, but the presence of a pinctrl-names parameter makes the default pins required.
>
> I am not sure why you say default state is required when pinctrl-names
> is defined. It's rather a recommendation and it's being selected by
> the driver core if it exist.

I considered the two use-cases for pinctrl in this driver:
- Only using default and letting the core select it.
- Using it for UHS in which case default and pins_uhs are required.

Both cases need the default, that is why it was listed as required. But 
I will change this based on your feedback.

>
> Please update the patch for DT documentation to reflect the policy.
> Moreover you need to deploy this policy properly here and you also
> need to add error handling.
>
> In more detail.
> 1. Check for errors from devm_pinctrl_get() and propagate them.
> 2. Check if "state_uhs" can be fetched and if so try also to fetch
> default state. If the latter fails you need propagate that as an error
> as well.
>
> Does that make sense?

OK, I will implement this error checking.

- Lars

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
