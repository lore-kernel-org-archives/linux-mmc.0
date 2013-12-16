From: Dinh Nguyen <dinh.linux-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCHv6 1/5] mmc: dw_mmc: Add support to set the SDR and DDR
 timing through clock framework
Date: Sun, 15 Dec 2013 21:24:40 -0600
Message-ID: <52AE7278.1080506@gmail.com>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com> <1386880245-10192-2-git-send-email-dinguyen@altera.com> <52AD0E7A.50208@linaro.org> <52AD1F17.5040708@gmail.com> <52AD320A.4030502@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <52AD320A.4030502-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: zhangfei <zhangfei.gao-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dinguyen-EIB2kfCEclfQT0dZR+AlfA@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, cjb-2X9k7bc8m7Mdnm+yROfE0A@public.gmane.org, jh80.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, tgih.jun-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, alim.akhtar-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, bzhao-eYqpPyKDWXRBDgjK7y7TUQ@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mmc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-mmc@vger.kernel.org


On 12/14/13 10:37 PM, zhangfei wrote:
>
>
> On 12/15/2013 11:16 AM, Dinh Nguyen wrote:
>> Hi Zhangfei,
>>
>>>> @@ -2478,6 +2480,27 @@ int dw_mci_probe(struct dw_mci *host)
>>>>            dev_dbg(host->dev, "ciu clock not available\n");
>>>>            host->bus_hz = host->pdata->bus_hz;
>>>>        } else {
>>>> +        /* If the CIU clk is available, we check for SDR and DDR
>>>> +         * timing phase shift settings. But not all platforms
>>>> +         * may have populated these settings, the driver will not
>>>> fail
>>>> +         * if these settings are not specified.
>>>> +         */
>>>> +        if (host->pdata->sdr_timing) {
>>>> +            host->sdr_clk = devm_clk_get(host->dev, "sdr_mmc_clk");
>>>> +            if (IS_ERR(host->sdr_clk))
>>>> +                dev_dbg(host->dev, "sdr_mmc clock not available\n");
>>>> +            else
>>>> +                clk_set_rate(host->sdr_clk, host->pdata->sdr_timing);
>>>> +        }
>>>> +
>>>> +        if (host->pdata->ddr_timing) {
>>>> +            host->ddr_clk = devm_clk_get(host->dev, "ddr_mmc_clk");
>>>> +            if (IS_ERR(host->ddr_clk))
>>>> +                dev_dbg(host->dev, "ddr_mmc clock not available\n");
>>>> +            else
>>>> +                clk_set_rate(host->ddr_clk, host->pdata->ddr_timing);
>>>> +        }
>>>> +
>>>
>>> Just curious, does pdata->sdr_timing and pdata->ddr_timing are fixed,
>>> fixed as each controller, or different with different board.
>> Yes, they are fixed for each controller per SoC.
>>> In case they are fixed, or fixed in each controller, and only required
>>> to be set in probe only once, maybe they can be hide in
>>> clk_mmc_ops.prepare
>>> And the clock can be used as ciu_clock, or parent of ciu_clock, which
>>> is called in dw_mmc.c, maybe these code can be ignored.
>>>
>> Please see v5 of this patch: https://patchwork.kernel.org/patch/3311121/
>> The issue with V5 was that there is no way for the dw_mmc driver to pass
>> the clock phase settings
>> in the clk_mmc_ops.prepare function.
>
> Personally, I think v5 is simpler :)
I agree...
>
> Could these fixed para be used as internal para when register.
> Like
> socfpga_gate_clk_init
> rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
>         compatible = "altr,socfpga-gate-clk";
>     clocks = <&mainclk>;
>     div-reg = <0x64 0 2>;
>     clk-gate = <0x60 1>;
> Could we also define mmc-ciu-clock with para clk-init.
Hmm..this was one of Arnd's suggestion. Will this also work for you? If
so then I think I can
proceed down this path, as I think this should be the most direct and
simplest.

Thanks,
Dinh
>
> Thanks

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
