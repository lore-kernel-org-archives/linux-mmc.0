From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V2 4/4] mmc: pwrseq_simple: Add support for a reset GPIO pin
Date: Fri, 16 Jan 2015 09:44:49 +0100
Message-ID: <CAPDyKFquHA0LJLkRVWUaUJzCuw7pWacY=XFLhD3C+XXK3Kw_kg@mail.gmail.com>
References: <1421240530-7971-1-git-send-email-ulf.hansson@linaro.org>
	<1421240530-7971-5-git-send-email-ulf.hansson@linaro.org>
	<20150115170444.GM16217@leverpostej>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f46.google.com ([209.85.192.46]:45178 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753126AbbAPIou (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Fri, 16 Jan 2015 03:44:50 -0500
Received: by mail-qg0-f46.google.com with SMTP id f51so6665756qge.5
        for <linux-mmc@vger.kernel.org>; Fri, 16 Jan 2015 00:44:49 -0800 (PST)
In-Reply-To: <20150115170444.GM16217@leverpostej>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, Chris Ball <chris@printf.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Alexandre Courbot <gnurou@gmail.com>, Arend van Spriel <arend@broadcom.com>, Sascha Hauer <s.hauer@pengutronix.de>, Olof Johansson <olof@lixom.net>, Russell King <linux@arm.linux.org.uk>, Hans de Goede <hdegoede@redhat.com>, Doug Anderson <dianders@chromium.org>, NeilBrown <neilb@suse.de>, Tomeu Vizoso <tomeu.vizoso@collabora.com>

On 15 January 2015 at 18:04, Mark Rutland <mark.rutland@arm.com> wrote:
> Hi,
>
> On Wed, Jan 14, 2015 at 01:02:10PM +0000, Ulf Hansson wrote:
>> The need for a reset GPIO has several times been pointed out from
>> earlier posted patchsets. Especially some WLAN chips which are
>> attached to an SDIO interface may use a GPIO reset.
>>
>> In this first version, one reset pin is supported. We may want to
>> extend the support to cover more pins, but let's leave that as a future
>> change. The added DT binding for the reset GPIO can easily be extended
>> to manage several pins.
>>
>> The reset GPIO is asserted at initialization and prior we start the
>> power up procedure. It will then be de-asserted right after the power
>> has been provided to the external chip/card, from the ->post_power_on()
>> callback.
>
> This needs to be specified a little more explicitly in the binding
> document below, as it forms part of the contract of the binding.
>
>>
>> Note, the reset GPIO is optional. Thus we don't return an error even if
>> we can't find a GPIO pin for the consumer.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> Changes in v2:
>>       - Adopted to the changed names of the pwrseq callbacks.
>>
>> ---
>>  .../devicetree/bindings/mmc/mmc,pwrseq-simple.txt  |  5 +++
>>  drivers/mmc/core/pwrseq_simple.c                   | 38 ++++++++++++++++++++++
>>  2 files changed, 43 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> index e1b7f9c..6fe0cd6 100644
>> --- a/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> +++ b/Documentation/devicetree/bindings/mmc/mmc,pwrseq-simple.txt
>> @@ -11,8 +11,13 @@ for several SOC designs.
>>  Required properties:
>>  - compatible : contains "mmc,pwrseq-simple".
>>
>> +Optional properties:
>> +- reset-gpios : contains a list of GPIO specifiers, though currently only one
>> +             specifier is supported.
>
> The support is a Linux issue. If the binding is meant to describe a
> list, mention that, and what the expected semantics are.
>
> Is it that difficult to have the driver iterate over the list now?

I was trying to keep code simple, maybe too simple. :-)

I will update the DT document according to your proposal and fix the code.

Thanks for reviewing!

Kind regards
Uffe
