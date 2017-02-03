From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH 1/9] mmc: meson-gx: fix setting f_min
Date: Fri, 03 Feb 2017 07:58:11 -0600
Message-ID: <m2fujvl6ks.fsf@baylibre.com>
References: <CGME20170131210651epcas5p37ca57e71ecbab37efe9b0227e4449d30@epcas5p3.samsung.com>
        <476265c8-b7e8-acdb-1964-5663c629caa3@gmail.com>
        <1e55512d-1dc3-bd57-82e1-888553ab3a9e@samsung.com>
        <6085c3ea-0a85-458d-bf15-8dcdd2d83186@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:35763 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752169AbdBCN6O (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Fri, 3 Feb 2017 08:58:14 -0500
Received: by mail-io0-f176.google.com with SMTP id j18so17812020ioe.2
        for <linux-mmc@vger.kernel.org>; Fri, 03 Feb 2017 05:58:13 -0800 (PST)
In-Reply-To: <6085c3ea-0a85-458d-bf15-8dcdd2d83186@gmail.com> (Heiner
        Kallweit's message of "Wed, 1 Feb 2017 21:14:00 +0100")
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Carlo Caione <carlo@caione.org>, linux-mmc@vger.kernel.org

Heiner Kallweit <hkallweit1@gmail.com> writes:

> Am 01.02.2017 um 12:49 schrieb Jaehoon Chung:
>> On 02/01/2017 05:57 AM, Heiner Kallweit wrote:
>>> Currently f_min is set to 4 MHz whilst the comment states 400 MHz.
>>> I think the itention is to set f_min to 400 kHz.
>>> Change value and comment accordingly.
>>>
>>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>>> ---
>>>  drivers/mmc/host/meson-gx-mmc.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/mmc/host/meson-gx-mmc.c b/drivers/mmc/host/meson-gx-mmc.c
>>> index 5eca88bc..da3cce31 100644
>>> --- a/drivers/mmc/host/meson-gx-mmc.c
>>> +++ b/drivers/mmc/host/meson-gx-mmc.c
>>> @@ -268,7 +268,7 @@ static int meson_mmc_clk_init(struct meson_host *host)
>>>  	if (f_min != UINT_MAX)
>>>  		f_min = DIV_ROUND_UP(CLK_SRC_XTAL_RATE, CLK_DIV_MAX);
>>>  	else
>>> -		f_min = 4000000;  /* default min: 400 MHz */
>>> +		f_min = 400000;  /* default min: 400 kHz */
>> 
>> I'm not sure but f_min can be 100KHz by default, not 400KHz.
>> Because mmc-core should be try to find frequency from 400KHz to "f_min" value.
>> 
> Actually I wonder how we can ever reach this part of the if clause.
> If at least one parent clock is defined and we can get its clock rate
> then f_min != UINT_MAX.
> Can we think of a case where no parent clock is defined?
> And would it make sense at all to proceed in this case?

This is actually common while adding a new board or SoC and is a useful
fallback/safeguard.

Kevin
