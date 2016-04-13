From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/5] mmc: sdhci: Tidy together LED code
Date: Wed, 13 Apr 2016 15:45:43 +0200
Message-ID: <CAPDyKFrDyvghsojWty8kiWDv0KPYrabF+-y826NzTk8cE46mfA@mail.gmail.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
	<1460460309-13619-6-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFoi-3oLK90Bk68wfccF+D6P3gJq_jUZupR66abQ-wPaZg@mail.gmail.com>
	<570E316C.3010305@intel.com>
	<CAPDyKFqjY+qcie7mCJx-mmzO+rXgQPZZtBLY71gz=2Fh9op7OQ@mail.gmail.com>
	<570E3D49.9030204@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:37538 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030640AbcDMNpp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 09:45:45 -0400
Received: by mail-wm0-f49.google.com with SMTP id n3so79259309wmn.0
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 06:45:44 -0700 (PDT)
In-Reply-To: <570E3D49.9030204@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

[...]

>>>>>
>>>>> -static void sdhci_activate_led(struct sdhci_host *host)
>>>>> +static void __sdhci_led_activate(struct sdhci_host *host)
>>>>
>>>> The renaming here seems a bit unnecessary, but more importantly why
>>>> can't you move these functions within the "if def sdhci leds" instead?
>>>
>>> They get used either way.  Either we use the LEDS subsystem (and mmc core
>>> controls them) or we turn them on/off directly from sdhci_request() etc.
>>
>> That seems wrong. Moreover it changes the current behaviour.
>
> How does it change the current behaviour?  It was meant to be exactly the
> same.  Perhaps looking closely at whether the original code was 'ifdef' or
> 'ifndef' will help.

Huh. Yes, indeed you are right! Sorry for noise, again.

>
>>
>> I am not sure why you want to use the leds in case of when the LED
>> subsystem isn't available?
>
> I am attempting to preserve the existing behaviour, so that is just how it was.
>

I have applied all five patches for next! Thanks!

Still, perhaps a future clean-up can adopt to my proposal above!?

Kind regards
Uffe
