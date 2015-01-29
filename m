From: Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 1/7] mmc: sdhci-pxav3: Fix SDR50 and DDR50 capabilities
 for the Armada 38x flavor
Date: Thu, 29 Jan 2015 11:01:44 +0100
Message-ID: <CAPDyKFoq+Z_n0GHkA4tWJp6vV_T+Fo3zm=CBfmNS+KN70qqwZA@mail.gmail.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
	<1422010594-1735-2-git-send-email-gregory.clement@free-electrons.com>
	<CAPDyKFp=TxkL4BPMxVU+pMPoCQ1xPq0XZ+ZPpBFFaDnNtFjynw@mail.gmail.com>
	<54C9EFC9.7090809@free-electrons.com>
	<CAPDyKFqXLb+BOrotBv9UKDeSCriK2k9qmxKoUrWTKK7uM2oLTw@mail.gmail.com>
	<54CA006F.8060108@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54CA006F.8060108-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Chris Ball <chris-OsFVWbfNK3isTnJN9+BGXg@public.gmane.org>, linux-mmc <linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Boris BREZILLON <boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Lior Amsalem <alior-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Tawfik Bayouk <tawfik-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Nadav Haklai <nadavh-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Marcin Wojtas <mw-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: linux-mmc@vger.kernel.org

On 29 January 2015 at 10:42, Gregory CLEMENT
<gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> Hi Ulf,
>
> On 29/01/2015 10:31, Ulf Hansson wrote:
>> [...]
>>
>>>> Seems like this function can be void instead of always returning 0.
>>>
>>> In patch 4 "mmc: sdhci-pxav3: Modify clock settings for the SDR50 and
>>> DDR50 modes", this function can return other values than 0.
>>>
>>> I could change the prototype in patch 4, but it would also imply
>>> removing the test of the return value in this patch and adding in back
>>> patch 4. By returning a value in this patch, it reduced the amount of
>>> change over the patches.
>>>
>>> But if you still prefer than I this function return void in this
>>> patch, I can do it.
>>
>> No worries, let's keep it as an int. But then I have a few other
>> comments, see below.
>
> OK
>
>>
>>>
>>>
>>> Thanks,
>>>
>>> Gregory
>>>
>>>
>>>>
>>>>> +{
>>>>> +       host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>>>>> +       /*
>>>>> +        * According to erratum 'FE-2946959' both SDR50 and DDR50
>>>>> +        * modes require specific clock adjustments in SDIO3
>>>>> +        * Configuration register, if the adjustment is not done,
>>>>> +        * remove them from the capabilities.
>>>>> +        */
>>>>> +       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>>>> +       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
>>>>> +       return 0;
>>>>> +}
>>>>> +
>>>>>  static void pxav3_reset(struct sdhci_host *host, u8 mask)
>>>>>  {
>>>>>         struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
>>>>> @@ -319,6 +333,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>>>>                 clk_prepare_enable(pxa->clk_core);
>>>>>
>>>>>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>>>>> +               ret = armada_38x_quirks(host);
>>>>> +               if (ret < 0)
>>
>> Since in patch 4 you return a proper error code, let's also adopt to
>> that here by changing to:
>>
>> "if (IS_ERR(ret))
>
> The function returns an int and IS_ERR expects a pointer. I am not sure
> this macro would be appropriate here.

You are right. Don't know what I was thinking. :-)

Kind regards
Uffe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
