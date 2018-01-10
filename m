From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v3] sdhci: Advertise 2.0v supply on SDIO host interface
Date: Wed, 10 Jan 2018 21:06:00 +0100
Message-ID: <CAPDyKFrtZqX4n-5F8d9PpmJ+RrmVuAziMKw+srBpqugZjKpT9Q@mail.gmail.com>
References: <20180110153250.13094-1-andriy.shevchenko@linux.intel.com>
 <CAPDyKFoRDhx9VzyUjxK=5u+JLcBait29hLozbhX_B9Zov61COA@mail.gmail.com> <1515607481.7000.885.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-io0-f180.google.com ([209.85.223.180]:46675 "EHLO
        mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751002AbeAJUGC (ORCPT
        <rfc822;linux-mmc@vger.kernel.org>); Wed, 10 Jan 2018 15:06:02 -0500
Received: by mail-io0-f180.google.com with SMTP id z130so724458ioe.13
        for <linux-mmc@vger.kernel.org>; Wed, 10 Jan 2018 12:06:01 -0800 (PST)
In-Reply-To: <1515607481.7000.885.camel@linux.intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10 January 2018 at 19:04, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, 2018-01-10 at 18:01 +0100, Ulf Hansson wrote:
>> On 10 January 2018 at 16:32, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> wrote:
>> > On Intel Edison the Broadcom WiFi card, which is connected to SDIO,
>> > requires 2.0v, while the host, according to Intel Merrifield TRM,
>> > supports 1.8v supply only.
>
>> > +       /*
>> > +        * Without a regulator, SDHCI does not support 2.0v but we
>> > get
>> > +        * here because we advertised 2.0v support for compatibility
>> > +        * with the SDIO card's OCR. Map it to 1.8v for the purpose
>> > of
>> > +        * turning on the power.
>> > +        */
>> > +       if (IS_ERR(host->mmc->supply.vmmc) && vdd ==
>> > ilog2(MMC_VDD_20_21))
>> > +               vdd = ilog2(MMC_VDD_165_195);
>>
>> Why not instead extend the range in sdhci_set_power_noreg() to also
>> check for MMC_VDD_20_21?
>>
>> Or is there a problem with that?
>
> Do we have any grounds to do this in generic code?
>
> Moreover, if we check for 2.0v what should we do in generic code?
> For my understanding
>
> case _20_21:
>  pwr = _180;

Yeah, why is that a problem?

You should never reach this point, unless the host announce support
via the ocr mask, for the _20_21 VDD.

What does other variants do in this regards?

Kind regards
Uffe
