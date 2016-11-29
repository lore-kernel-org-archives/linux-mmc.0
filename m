From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 7/10] mmc: sdhci-xenon: Add support to PHYs of Marvell
 Xenon SDHC
Date: Tue, 29 Nov 2016 12:11:39 +0100
Message-ID: <CAPDyKFp=KHYogJE9WkJUYKphJhsrMfLjxxvNKmiAB+35bER4FQ@mail.gmail.com>
References: <cover.86006f271b60cf7c0b4c5a51762a9dacca4c4718.1477911954.git-series.gregory.clement@free-electrons.com>
 <a05ffd140f4edc02fc3128db8445b2264cf38723.1477911954.git-series.gregory.clement@free-electrons.com>
 <CAPDyKFpkcoVMKbVOwjX1WDyNgc1vvUX60D6XRX6=YHGvkvHvnA@mail.gmail.com>
 <3cd05a26-d340-476e-bab1-8be9d5446f47@marvell.com> <CAPDyKFrskyZvMwhmj8ioyaowU8GL5=d-6ipGQcmmig_a9E9AQQ@mail.gmail.com>
 <436c6925-cb0d-afe7-e3a2-384eca15ff42@marvell.com> <8359307d-5f44-3db9-aae1-eb1fe8e1141d@marvell.com>
 <CAPDyKFo3ezYOywtSZ8GGQ1XK9KPsxCgQNbaiz45EVgbgtnUxjg@mail.gmail.com>
 <10a885f0-82e9-a35c-f62f-3fc4518ea8b4@marvell.com> <CAPDyKFr8rX04iY92OeQpSkS+3HN2-FxijCCiDb2sSKvP+TZPog@mail.gmail.com>
 <c30cead8-17b6-48b0-7355-cd82268842e1@marvell.com> <CAPDyKFqjNy2oJiHHt+8CkTaiiExFKaR0i4GXGKdOMMRX-swPRg@mail.gmail.com>
 <02725a0f-c061-e7f2-9a01-8975c62ab5a7@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f45.google.com ([74.125.82.45]:33349 "EHLO
        mail-wm0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756289AbcK2LLt (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Tue, 29 Nov 2016 06:11:49 -0500
Received: by mail-wm0-f45.google.com with SMTP id c184so46689542wmd.0
        for <linux-mmc@vger.kernel.org>; Tue, 29 Nov 2016 03:11:48 -0800 (PST)
In-Reply-To: <02725a0f-c061-e7f2-9a01-8975c62ab5a7@marvell.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ziji Hu <huziji@marvell.com>
Cc: Gregory CLEMENT <gregory.clement@free-electrons.com>, Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Rob Herring <robh+dt@kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Jimmy Xu <zmxu@marvell.com>, Jisheng Zhang <jszhang@marvell.com>, Nadav Haklai <nadavh@marvell.com>, Ryan Gao <ygao@marvell.com>, Doug Jones <dougj@marvell.com>, Victor Gu <xigu@marvell.com>, "Wei(SOCP) Liu" <liuw@marvell.com>, Wilson Ding <dingwei@marvell.com>

[...]

>>>>
>>>
>>>    Sorry that I didn't make myself clear.
>>>
>>>    Our host PHY delay line consists of hundreds of sampling points.
>>>    Each sampling point represents a different phase shift.
>>>
>>>    In lower speed mode, our host driver will scan the delay line.
>>>    It will select and test multiple sampling points, other than testing
>>>    only single sampling point.
>>>
>>>    If a sampling point fails to transfer cmd/data, our host driver will
>>>    move to test next sampling point, until we find out a group of successful
>>>    sampling points which can transfer cmd/data. At last we will select
>>>    a perfect one from them.
>>
>> Ahh, I see. Unfortunate, this is going to be very hard to implement properly.
>>
>> The main problem is that the host driver has *no* knowledge about the
>> internal state of the card, as that is the responsibility of the mmc
>> core to keep track of.
>>
>> If the host driver would send a command during every update of the
>> "ios" setting, from ->set_ios(), for sure it would lead to commands
>> being sent that are "forbidden" in the current internal state of the
>> card.
>> This would lead to that the card initialization sequence fails,
>> because the card may move to an unknown internal state and the mmc
>> core would have no knowledge about what happened.
>>
>
>    Yes. In theory, host layer should not initiate a command by itself.
>
>    We assume that bus is idle and card is stable in Tran state, when core layer
>    asks host to switch "ios".

Understand, but this is a wrong assumption. The card may very well in
another state than Tran state.

>    Besides, we only select the commands which is valid in the whole procedure,
>    such as CMD8 for eMMC.
>    Those test commands are actually like read operations to card registers.
>    The card will return to Tran state even if transfer fails. It is also easy
>    for host to recover.

For example, I would recommend you to investigate in detail the
sequence for when a CMD6 command is sent to the card.
The host must *not* start sending commands from ->set_ios() during a
CMD6 sequence. For example a CMD8 is not allowed.

Moreover, due to this, I wonder if it is even possible to get this HW
to work properly.

>
>> Hmm..
>>
>> Can you specify, *exactly*, under which "ios updates" you need to
>> verify updated PHY setting changes by sending a cmd/data? Also, please
>> specify if it's enough to only test the CMD line or also DATA lines.
>>
>
>    When one of the three parameters in below changes, our host driver needs
>    to adjust PHY in lower speed mode.
>    1. Speed Mode (timing): like legacy mode --> HS DDR
>    2. Bus Clock: like 400KHz --> 50MHz
>    3. Bus Width: like 1-bit --> 4-bit/8-bit
>
>    For eMMC, we use CMD8 to test sampling point.
>    For SD, we use CMD13.
>    For SDIO, currently CMD52 is used to read a register from CCCR.
>    Those commands in above are all valid during the whole procedure to switch
>    to high speed mode from legacy mode.
>
>    It is the best case if the test command can transfer both on CMD and DAT lines.
>    CMD8 for eMMC can test both CMD line and DAT lines. CMD13 and CMD52 only test
>    CMD line. We might use ACMD51 for SD and CMD53 for SDIO later thus DAT lines
>    are also under test.

Thanks for sharing these details!

So, if possible, I would recommend you to discuss these issues with
some of the HW designers. Perhaps you can figure out an alternative
method of confirming/testing PHY setting changes? Sending commands to
the card just doesn't work well for all cases.

Kind regards
Uffe
