From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 1/7] mmc: sdhci-pxav3: Fix SDR50 and DDR50 capabilities
 for the Armada 38x flavor
Date: Thu, 29 Jan 2015 10:31:02 +0100
Message-ID: <CAPDyKFqXLb+BOrotBv9UKDeSCriK2k9qmxKoUrWTKK7uM2oLTw@mail.gmail.com>
References: <1422010594-1735-1-git-send-email-gregory.clement@free-electrons.com>
	<1422010594-1735-2-git-send-email-gregory.clement@free-electrons.com>
	<CAPDyKFp=TxkL4BPMxVU+pMPoCQ1xPq0XZ+ZPpBFFaDnNtFjynw@mail.gmail.com>
	<54C9EFC9.7090809@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <54C9EFC9.7090809@free-electrons.com>
Sender: stable-owner@vger.kernel.org
To: Gregory CLEMENT <gregory.clement@free-electrons.com>
Cc: Chris Ball <chris@printf.net>, linux-mmc <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, Boris BREZILLON <boris.brezillon@free-electrons.com>, Lior Amsalem <alior@marvell.com>, Tawfik Bayouk <tawfik@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, stable@vger.kernel.org, Marcin Wojtas <mw@semihalf.com>
List-Id: linux-mmc@vger.kernel.org

[...]

>> Seems like this function can be void instead of always returning 0.
>
> In patch 4 "mmc: sdhci-pxav3: Modify clock settings for the SDR50 and
> DDR50 modes", this function can return other values than 0.
>
> I could change the prototype in patch 4, but it would also imply
> removing the test of the return value in this patch and adding in back
> patch 4. By returning a value in this patch, it reduced the amount of
> change over the patches.
>
> But if you still prefer than I this function return void in this
> patch, I can do it.

No worries, let's keep it as an int. But then I have a few other
comments, see below.

>
>
> Thanks,
>
> Gregory
>
>
>>
>>> +{
>>> +       host->quirks |= SDHCI_QUIRK_MISSING_CAPS;
>>> +       /*
>>> +        * According to erratum 'FE-2946959' both SDR50 and DDR50
>>> +        * modes require specific clock adjustments in SDIO3
>>> +        * Configuration register, if the adjustment is not done,
>>> +        * remove them from the capabilities.
>>> +        */
>>> +       host->caps1 = sdhci_readl(host, SDHCI_CAPABILITIES_1);
>>> +       host->caps1 &= ~(SDHCI_SUPPORT_SDR50 | SDHCI_SUPPORT_DDR50);
>>> +       return 0;
>>> +}
>>> +
>>>  static void pxav3_reset(struct sdhci_host *host, u8 mask)
>>>  {
>>>         struct platform_device *pdev = to_platform_device(mmc_dev(host->mmc));
>>> @@ -319,6 +333,9 @@ static int sdhci_pxav3_probe(struct platform_device *pdev)
>>>                 clk_prepare_enable(pxa->clk_core);
>>>
>>>         if (of_device_is_compatible(np, "marvell,armada-380-sdhci")) {
>>> +               ret = armada_38x_quirks(host);
>>> +               if (ret < 0)

Since in patch 4 you return a proper error code, let's also adopt to
that here by changing to:

"if (IS_ERR(ret))

>>> +                       goto err_quirks;
>>>                 ret = mv_conf_mbus_windows(pdev, mv_mbus_dram_info());
>>>                 if (ret < 0)
>>>                         goto err_mbus_win;
>>> @@ -400,6 +417,7 @@ err_mbus_win:
>>>         if (!IS_ERR(pxa->clk_core))
>>>                 clk_disable_unprepare(pxa->clk_core);
>>>  err_clk_get:
>>> +err_quirks:

You don't need the new label, you could use "err_clk_get".

>>>         sdhci_pltfm_free(pdev);
>>>         return ret;
>>>  }
>>> --
>>> 2.1.0
>>>

Kind regards
Uffe
