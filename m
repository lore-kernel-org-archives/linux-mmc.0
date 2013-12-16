From: Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: Re: [PATCHv6 1/5] mmc: dw_mmc: Add support to set the SDR and DDR
 timing through clock framework
Date: Mon, 16 Dec 2013 11:38:34 +0800
Message-ID: <CABQgh9FVkA=VNPddRqQk07neL-vU1NSFaNf8B+tFKAsiTJQd-g@mail.gmail.com>
References: <1386880245-10192-1-git-send-email-dinguyen@altera.com>
	<1386880245-10192-2-git-send-email-dinguyen@altera.com>
	<52AD0E7A.50208@linaro.org>
	<52AD1F17.5040708@gmail.com>
	<52AD320A.4030502@linaro.org>
	<52AE7278.1080506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-ie0-f178.google.com ([209.85.223.178]:45527 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752522Ab3LPDie (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Sun, 15 Dec 2013 22:38:34 -0500
Received: by mail-ie0-f178.google.com with SMTP id lx4so5875324iec.9
        for <linux-mmc@vger.kernel.org>; Sun, 15 Dec 2013 19:38:34 -0800 (PST)
In-Reply-To: <52AE7278.1080506@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dinh Nguyen <dinh.linux@gmail.com>
Cc: Dinh Nguyen <dinguyen@altera.com>, Arnd Bergmann <arnd@arndb.de>, Chris Ball <cjb@laptop.org>, Jaehoon Chung <jh80.chung@samsung.com>, Seungwon Jeon <tgih.jun@samsung.com>, =?ISO-8859-1?Q?Heiko_St=FCbner?= <heiko@sntech.de>, Douglas Anderson <dianders@chromium.org>, alim.akhtar@samsung.com, Bing Zhao <bzhao@marvell.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, mark.rutland@arm.com, Ian Campbell <ian.campbell@citrix.com>, Mike Turquette <mturquette@linaro.org>, devicetree@vger.kernel.org, linux-mmc@vger.kernel.org, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>

On 16 December 2013 11:24, Dinh Nguyen <dinh.linux@gmail.com> wrote:
>
>>>>> @@ -2478,6 +2480,27 @@ int dw_mci_probe(struct dw_mci *host)
>>>>>            dev_dbg(host->dev, "ciu clock not available\n");
>>>>>            host->bus_hz = host->pdata->bus_hz;
>>>>>        } else {
>>>>> +        /* If the CIU clk is available, we check for SDR and DDR
>>>>> +         * timing phase shift settings. But not all platforms
>>>>> +         * may have populated these settings, the driver will not
>>>>> fail
>>>>> +         * if these settings are not specified.
>>>>> +         */
>>>>> +        if (host->pdata->sdr_timing) {
>>>>> +            host->sdr_clk = devm_clk_get(host->dev, "sdr_mmc_clk");
>>>>> +            if (IS_ERR(host->sdr_clk))
>>>>> +                dev_dbg(host->dev, "sdr_mmc clock not available\n");
>>>>> +            else
>>>>> +                clk_set_rate(host->sdr_clk, host->pdata->sdr_timing);
>>>>> +        }
>>>>> +
>>>>> +        if (host->pdata->ddr_timing) {
>>>>> +            host->ddr_clk = devm_clk_get(host->dev, "ddr_mmc_clk");
>>>>> +            if (IS_ERR(host->ddr_clk))
>>>>> +                dev_dbg(host->dev, "ddr_mmc clock not available\n");
>>>>> +            else
>>>>> +                clk_set_rate(host->ddr_clk, host->pdata->ddr_timing);
>>>>> +        }
>>>>> +
>>>>
>>>> Just curious, does pdata->sdr_timing and pdata->ddr_timing are fixed,
>>>> fixed as each controller, or different with different board.
>>> Yes, they are fixed for each controller per SoC.
>>>> In case they are fixed, or fixed in each controller, and only required
>>>> to be set in probe only once, maybe they can be hide in
>>>> clk_mmc_ops.prepare
>>>> And the clock can be used as ciu_clock, or parent of ciu_clock, which
>>>> is called in dw_mmc.c, maybe these code can be ignored.
>>>>
>>> Please see v5 of this patch: https://patchwork.kernel.org/patch/3311121/
>>> The issue with V5 was that there is no way for the dw_mmc driver to pass
>>> the clock phase settings
>>> in the clk_mmc_ops.prepare function.
>>
>> Personally, I think v5 is simpler :)
> I agree...
>>
>> Could these fixed para be used as internal para when register.
>> Like
>> socfpga_gate_clk_init
>> rc = of_property_read_u32_array(node, "clk-gate", clk_gate, 2);
>>         compatible = "altr,socfpga-gate-clk";
>>     clocks = <&mainclk>;
>>     div-reg = <0x64 0 2>;
>>     clk-gate = <0x60 1>;
>> Could we also define mmc-ciu-clock with para clk-init.
> Hmm..this was one of Arnd's suggestion. Will this also work for you? If
> so then I think I can
> proceed down this path, as I think this should be the most direct and
> simplest.
>

Yes, go ahead.
sdr_timing & ddr_timing only takes effect on socfpga-mmc.
It is good to put in clk driver specifically for socfpga, instead of
putting in common dw_mmc.c

Thanks
