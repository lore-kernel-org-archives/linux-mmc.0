From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: 1217:8520 [Dell Latitude E7450] O2 Micro, SD/MMC Card Reader
 doesn't work
Date: Mon, 28 Dec 2015 12:47:26 +0100
Message-ID: <CAPDyKFr6WE4PpJ8mwsVGEQ0EijySxSVXf5+TG1ZxF2bkh7eNjQ@mail.gmail.com>
References: <CAONpWdsteBnqTcFbKpcOQFueyeJJWEmn9DJitD43f59xV8sDyg@mail.gmail.com>
	<BY2PR04MB184372CAAC1FA0C5373D73238FEF0@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAONpWduF6iH4Rr5Y610KP1RE342nWAajR27KFbu1N2iet4R0ZA@mail.gmail.com>
	<BY2PR04MB18438CFFD181C72EFEF408908FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAPDyKFotgz3czCs8XaXwC4kT53Lp0h=n03OUMtO6BUTwTnDYzQ@mail.gmail.com>
	<BY2PR04MB18432C804C263313D2349C848FE10@BY2PR04MB1843.namprd04.prod.outlook.com>
	<CAONpWdvo+b=Y26zsCYsHFHjJ+8yAnYfoJOsirdS-he2s1unDgg@mail.gmail.com>
	<CAONpWdsHJEHjedfQrjXru0fETRL3NfXG6cyoQAYtLYAKb5i-2Q@mail.gmail.com>
	<CY1PR04MB184843666E915C564A1858CB8FE50@CY1PR04MB1848.namprd04.prod.outlook.com>
	<CAPDyKFqMPfrTdF4JNU-QUBN-va+Xk0EAqHysQ_HpKkmMfQzQNg@mail.gmail.com>
	<20151223111352.GR8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35932 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751381AbbL1Lr0 (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Mon, 28 Dec 2015 06:47:26 -0500
Received: by mail-yk0-f169.google.com with SMTP id v14so8224406ykd.3
        for <linux-mmc@vger.kernel.org>; Mon, 28 Dec 2015 03:47:26 -0800 (PST)
In-Reply-To: <20151223111352.GR8644@n2100.arm.linux.org.uk>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Peter Guo <peter.guo@bayhubtech.com>, Alex Ballas <alex@ballas.org>, "adam8157@gmail.com" <adam8157@gmail.com>, "linux-mmc@VGER.KERNEL.ORG" <linux-mmc@vger.kernel.org>, Adrian Hunter <adrian.hunter@intel.com>

On 23 December 2015 at 12:13, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 22, 2015 at 09:30:00AM +0100, Ulf Hansson wrote:
>> This quirk seems a bit strange. It looks like a generic problem being
>> solved by the wrong approach. Although, my knowledge of sdhci HW is
>> limited so I might be wrong.
>>
>> Why doesn't sdhci *always* reset the related registers when the
>> command or data transfer gets *completed*? Instead as currently,
>> delaying that until the *next* request is started and via using
>> SDHCI_QUIRK2_CLEAR_TRANSFERMODE_REG_BEFORE_CMD?
>
> That would be additional overhead.  The real problem is that the tuning

Well, yes but I wonder if it isn't negligible.

Of course, if it's more suitable to deal with clearing the register
*before* starting a new request, that should work fine as well.

Anyway, my point is that I find it odd to have a quirk for something
that should be common.

> paths compete with the normal request paths over how to set the registers.
> This competition needs to be killed, and a saner structure for dealing
> with requests and tuning commands needs to be created.
>
> This is something I'm working on as I get time: I'm restructuring
> sdhci_send_command() with the aim of getting to the point where the
> tuning code is _not_ writing to any registers at all, and that's all
> handled by code common to both paths.

Sounds great!

>
>> Sdhci's sdhci_execute_tuning() function must be converted to use
>> mmc_send_tuning().
>
> That will make the request path more complex, because we then need to
> detect the tuning commands and have special handling for them.  With
> SDHCI, they are not a standard data transfer command, which is what
> mmc_send_tuning() wants.

If the regular request path isn't used, the core isn't in control of
the request.

I don't like that, as it becomes an exception of how requests are
managed. It also means the host driver will not benefit from the
common error handling paths in the core.

>
> This means we end up with more complexity in what is supposed to be a
> fast path, which means more room for bugs to creep in.

I assume you refer to that the sdhci's host_ops->request() callback
would need to check for the tuning commands and thus treat these as
special cases.

I agree, we should avoid these kind of checks in host drivers.
Typically we can address this by adding a new MMC_CAP* and/or a new
host_ops callback.

In this case I think a new optional host_ops callback, which
mmc_send_tuning() would invoke, should to the trick for sdhci.

What do you think?

Kind regards
Uffe
