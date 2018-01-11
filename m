From: Adrian Hunter <adrian.hunter@intel.com>
Subject: Re: [PATCH v3] sdhci: Advertise 2.0v supply on SDIO host interface
Date: Thu, 11 Jan 2018 09:57:00 +0200
Message-ID: <78b0dccb-f9a9-8916-db4f-1473ec021c9a@intel.com>
References: <20180110153250.13094-1-andriy.shevchenko@linux.intel.com>
 <CAPDyKFoRDhx9VzyUjxK=5u+JLcBait29hLozbhX_B9Zov61COA@mail.gmail.com>
 <1515607481.7000.885.camel@linux.intel.com>
 <CAPDyKFrtZqX4n-5F8d9PpmJ+RrmVuAziMKw+srBpqugZjKpT9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:18455 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753715AbeAKH5d (ORCPT <rfc822;linux-mmc@vger.kernel.org>);
        Thu, 11 Jan 2018 02:57:33 -0500
In-Reply-To: <CAPDyKFrtZqX4n-5F8d9PpmJ+RrmVuAziMKw+srBpqugZjKpT9Q@mail.gmail.com>
Content-Language: en-US
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>

On 10/01/18 22:06, Ulf Hansson wrote:
> On 10 January 2018 at 19:04, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
>> On Wed, 2018-01-10 at 18:01 +0100, Ulf Hansson wrote:
>>> On 10 January 2018 at 16:32, Andy Shevchenko
>>> <andriy.shevchenko@linux.intel.com> wrote:
>>>> On Intel Edison the Broadcom WiFi card, which is connected to SDIO,
>>>> requires 2.0v, while the host, according to Intel Merrifield TRM,
>>>> supports 1.8v supply only.
>>
>>>> +       /*
>>>> +        * Without a regulator, SDHCI does not support 2.0v but we
>>>> get
>>>> +        * here because we advertised 2.0v support for compatibility
>>>> +        * with the SDIO card's OCR. Map it to 1.8v for the purpose
>>>> of
>>>> +        * turning on the power.
>>>> +        */
>>>> +       if (IS_ERR(host->mmc->supply.vmmc) && vdd ==
>>>> ilog2(MMC_VDD_20_21))
>>>> +               vdd = ilog2(MMC_VDD_165_195);
>>>
>>> Why not instead extend the range in sdhci_set_power_noreg() to also
>>> check for MMC_VDD_20_21?
>>>
>>> Or is there a problem with that?
>>
>> Do we have any grounds to do this in generic code?
>>
>> Moreover, if we check for 2.0v what should we do in generic code?
>> For my understanding
>>
>> case _20_21:
>>  pwr = _180;
> 
> Yeah, why is that a problem?

Shouldn't be a problem.  Just add a comment:

		/*
		 * Without a regulator, SDHCI does not support 2.0v so we only
		 * get here if the driver deliberately added the 2.0v range to
		 * ocr_avail. Map it to 1.8V for the purpose of turning on the
		 * power.
		 */
		case MMC_VDD_20_21:
			pwr = SDHCI_POWER_180;
			break;

> 
> You should never reach this point, unless the host announce support
> via the ocr mask, for the _20_21 VDD.
> 
> What does other variants do in this regards?

Use regulators or 3V I expect.
