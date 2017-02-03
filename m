From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 2/9] mmc: meson-gx: minor improvements in meson_mmc_set_ios
Date: Fri, 03 Feb 2017 07:52:49 -0600
Message-ID: <m2k297l6tq.fsf@baylibre.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
        <CGME20170131210832epcas2p111e35a63c02a8e4ddc83354a691d92ee@epcas2p1.samsung.com>
        <834a9dbd-9f6b-8dea-6713-e9bdcd09f9ed@gmail.com>
        <a32d463d-2af2-8d20-9585-f76af566d623@samsung.com>
        <939d5c2d-e518-9388-0800-1be1948f8c65@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:33333 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbdBCNwx (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 08:52:53 -0500
Received: by mail-io0-f171.google.com with SMTP id v96so17797583ioi.0
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 05:52:52 -0800 (PST)
In-Reply-To: <939d5c2d-e518-9388-0800-1be1948f8c65@gmail.com> (Heiner
        Kallweit's message of "Wed, 1 Feb 2017 21:16:53 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Am 01.02.2017 um 12:55 schrieb Jaehoon Chung:
>> On 02/01/2017 05:57 AM, Heiner Kallweit wrote:
>>> val isn't used in the switch clause and afterwards there's an
>>> identical statement. So remove it.
>>>
>>> In case of an unexpected bus width the error message indicates
>>> the intention to set the bus width to 4 and to go on.
>>> So remove the return statement. This return statement also
>>> conflicts with "setting to 4" because nothing would be set
>>> actually before returning.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/mmc/host/meson-gx-mmc.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index da3cce31..38edc60d 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -379,7 +379,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  	meson_mmc_clk_set(host, ios->clock);
>>>  
>>>  	/* Bus width */
>>> -	val = readl(host->regs + SD_EMMC_CFG);
>>>  	switch (ios->bus_width) {
>>>  	case MMC_BUS_WIDTH_1:
>>>  		bus_width = CFG_BUS_WIDTH_1;
>>> @@ -394,7 +393,6 @@ static void meson_mmc_set_ios(struct mmc_host *mmc, struct mmc_ios *ios)
>>>  		dev_err(host->dev, "Invalid ios->bus_width: %u.  Setting to 4.\n",
>>>  			ios->bus_width);
>>>  		bus_width = CFG_BUS_WIDTH_4;
>>> -		return;
>> 
>> It's a different question..why does meson-gx-mmc use 4bit buswidth for invalid bus-with? not using 1bit-buswidth?
>> 
> I think this question is best addressed to Kevin as original author.
>

Because that was the fall-back in the vendor driver that this was based
on.

I'm not really an MMC expert, so I don't know if that's the right thing
to do.

Kevin
