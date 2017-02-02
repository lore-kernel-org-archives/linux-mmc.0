From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/9] mmc: meson-gx: improve meson_mmc_clk_set
Date: Thu, 2 Feb 2017 10:09:47 +0100
Message-ID: <CAPDyKFrSQxahO-QyQCuBO5L2bfmgCjW-RXE7rUFSSHG5xL0H6Q@mail.gmail.com>
References: <24e8bf35-50ce-270d-c0aa-12bb90d2e3d8@gmail.com>
 <CGME20170131210730epcas2p231e0ff8a05a2eb6223f1717d5929635d@epcas2p2.samsung.com>
 <daf8b18a-adf5-7dc1-7b3b-45db83af0af3@gmail.com> <92a17f7a-c197-d6ce-a255-0adf9030bb7e@samsung.com>
 <fadf4270-4a64-e853-387f-49008aaacd64@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wj0-f172.google.com ([209.85.210.172]:36292 "EHLO
        mail-wj0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750921AbdBBJJt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 2 Feb 2017 04:09:49 -0500
Received: by mail-wj0-f172.google.com with SMTP id n2so127580wjq.3
        for <linux-mmc@vger.kernel.org>; Thu, 02 Feb 2017 01:09:49 -0800 (PST)
In-Reply-To: <fadf4270-4a64-e853-387f-49008aaacd64@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Jaehoon Chung <jh80.chung@samsung.com>, Carlo Caione <carlo@caione.org>, Kevin Hilman <khilman@baylibre.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

[...]

>>> +    if (clk_rate != clk_get_rate(host->cfg_div_clk))
>>> +            dev_dbg(host->dev,
>>> +                    "divider requested rate %lu != actual rate %lu\n",
>>> +                    clk_rate, clk_get_rate(host->cfg_div_clk));
>>> +
>>> +    mmc->actual_clock = clk_rate;
>>
>> debug message is described actual_rate as clk_get_rate()..
>> What is correct "actual_clock"?
>>
> Indeed this might be a little misleading.
> "actual_clock" is a member of struct mmc_host and for now we have to live
> with this name. However the meaning in our context is: "currently requested
> clock rate".

I think this is wrong. The intent with mmc->actual_clock is to show
what the real rate of the clock is, not the requested rate.

The requested clock rate is already available via "mmc->ios.clock".

Hopes this clarifies it.

[...]

Kind regards
Uffe
