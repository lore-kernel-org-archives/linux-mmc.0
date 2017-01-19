From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 0/8] Cavium MMC driver
Date: Thu, 19 Jan 2017 22:38:05 +0100
Message-ID: <CAPDyKFrzY1aB-iS0_+hgUS9_Fz2fRRR+XWGBOsARA8g0YexCYw@mail.gmail.com>
References: <20161219121552.18316-1-jglauber@cavium.com> <CAPDyKFqXDt9zBphrSPqMpbzBJsj1zECGBb5DugOEj1eLs9-xPQ@mail.gmail.com>
 <20170119145041.GA11757@hardcore>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:38732 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbdASVjB (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Thu, 19 Jan 2017 16:39:01 -0500
Received: by mail-wm0-f41.google.com with SMTP id r144so14307299wme.1
        for <linux-mmc@vger.kernel.org>; Thu, 19 Jan 2017 13:38:07 -0800 (PST)
In-Reply-To: <20170119145041.GA11757@hardcore>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Jan Glauber <jan.glauber@caviumnetworks.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, David Daney <ddaney@caviumnetworks.com>, "Steven J . Hill" <Steven.Hill@cavium.com>

[...]

> I've added a fixed regulator to DT:
>
>         vcc_3v3: regulator-vcc_3v3 {
>                 compatible = "regulator-fixed";
>                 regulator-name = "VCC_3V3";
>                 regulator-min-microvolt = <3300000>;
>                 regulator-max-microvolt = <3300000>;
>
>                 gpio = <&gpio_6_0 8 0>;
>                 /* enable-gpio = <&gpio_6_0 8 0>; */
>                 enable-active-high;
>         };
>
> This seems to enable the gpio. Is this sufficient or do I need the
> gpio-regulator?

Looks good to me.

[...]

>> > In porting the driver to arm64 I run into some issues.
>> >
>> > 1. mmc_parse_of is not capable of supporting multiple slots behind one
>> >    controller. On arm64 the host controller is presented as one PCI device.
>> >    There are no devices per slot as with the platform variant, so I
>> >    needed to create dummy devices to make mmc_parse_of work.
>> >    IMHO it would be cleaner if mmc_parse_of could be extended to cover
>> >    the multiple slots case.
>>
>> Yes. I agree that this make sense!
>> Seems like we could try to make use of the struct device_node instead
>> of the struct device.
>>
>> I will try to come up with an idea, I keep you posted.
>>
>> >
>> > 2. Without setting MMC_CAP_1_8V_DDR DDR mode is not usable for eMMC.
>> >    I would prefer to introduce a new cap flag, MMC_CAP_3_3V_DDR,
>> >    if possible. Currently I need to add "mmc-ddr-1_8v" to DTS,
>> >    which seems odd for a 3.3v only host controller.
>>
>> This keep coming back. Both DT bindings and changing to the mmc core
>> has been posted.
>>
>> Allow me to help out and re-post a new series. You can build on top of
>> them - I will keep you on cc.
>
> Any news here? Can you give me a pointer?

For 1), I need some more time. Feel free to try it out your self.

For 2), I am working on it. Likely in the beginning of next week I
will post something.

[...]

Kind regards
Uffe
