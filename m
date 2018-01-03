From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: sdhci-esdhc-imx: Enable/Disable mmc clock during
 runtime suspend
Date: Wed, 3 Jan 2018 17:56:00 +0100
Message-ID: <CAPDyKFqjszhT1C-5KkMVJ9HvEWcow6+QPdJW2dt0i1EFv+Nvcw@mail.gmail.com>
References: <1513862546-20221-1-git-send-email-michael@amarulasolutions.com>
 <CAPDyKFpHG2YsdWWYG_XsVqE05fcVyRp4P7-FgbR9LPDF9OjtYA@mail.gmail.com> <CAOf5uwmd0qJhE8YEJeGdySqsXf1u+28WoeRCvUQ0MQcVSGopkg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-it0-f65.google.com ([209.85.214.65]:42843 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbeACQ4B (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 3 Jan 2018 11:56:01 -0500
Received: by mail-it0-f65.google.com with SMTP id p139so2376082itb.1
        for <linux-mmc@vger.kernel.org>; Wed, 03 Jan 2018 08:56:01 -0800 (PST)
In-Reply-To: <CAOf5uwmd0qJhE8YEJeGdySqsXf1u+28WoeRCvUQ0MQcVSGopkg@mail.gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 3 January 2018 at 17:38, Michael Nazzareno Trimarchi
<michael@amarulasolutions.com> wrote:
> Hi
>
> On Wed, Jan 3, 2018 at 5:26 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> On 21 December 2017 at 14:22, Michael Trimarchi
>> <michael@amarulasolutions.com> wrote:
>>> mmc clock can be stopped during runtime suspend and restart during runtime
>>> resume. This let us know to not have any clock running and this reduce
>>> the EMI of the device when the bus is not in use
>>>
>>> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
>>> ---
>>>  drivers/mmc/host/sdhci-esdhc-imx.c | 5 +++++
>>>  1 file changed, 5 insertions(+)
>>>
>>> diff --git a/drivers/mmc/host/sdhci-esdhc-imx.c b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> index 7123ef9..9a5e96f 100644
>>> --- a/drivers/mmc/host/sdhci-esdhc-imx.c
>>> +++ b/drivers/mmc/host/sdhci-esdhc-imx.c
>>> @@ -196,6 +196,7 @@ struct pltfm_imx_data {
>>>         struct clk *clk_ipg;
>>>         struct clk *clk_ahb;
>>>         struct clk *clk_per;
>>> +       unsigned int actual_clock;
>>>         enum {
>>>                 NO_CMD_PENDING,      /* no multiblock command pending*/
>>>                 MULTIBLK_IN_PROCESS, /* exact multiblock cmd in process */
>>> @@ -1346,6 +1347,9 @@ static int sdhci_esdhc_runtime_suspend(struct device *dev)
>>>
>>>         ret = sdhci_runtime_suspend_host(host);
>>>
>>> +       imx_data->actual_clock = host->mmc->actual_clock;
>>> +       esdhc_pltfm_set_clock(host, 0);
>>
>> I guess want the clock to stay on "if sdhci_sdio_irq_enabled(host)".
>> So you should probably move the above inside the below if statement.
>>
>
> Well I'm not quite sure about it. Some wifi chipset has the wakeup
> interrupt on external gpio
> and someone wakeup from DAT1. Why clock should be required?

The clock should not be needed when using external GPIO (also
described as an out-band IRQ/wakeup), but from DAT1.

When sdhci_sdio_irq_enabled() returns true, that *should* indicate
that DAT1 is used. Although, there may be reasons to re-visit this
later, because the hole SDIO irq thing around wakeups for sdhci, is
being reworked by Adrian [1].

>
> Anyway I should even rebalance resume.

Yes.

[...]

Kind regards
Uffe

[1]
https://www.spinics.net/lists/linux-mmc/msg47512.html
