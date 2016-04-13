From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/5] mmc: sdhci: Tidy together LED code
Date: Wed, 13 Apr 2016 14:15:43 +0200
Message-ID: <CAPDyKFqjY+qcie7mCJx-mmzO+rXgQPZZtBLY71gz=2Fh9op7OQ@mail.gmail.com>
References: <1460460309-13619-1-git-send-email-adrian.hunter@intel.com>
	<1460460309-13619-6-git-send-email-adrian.hunter@intel.com>
	<CAPDyKFoi-3oLK90Bk68wfccF+D6P3gJq_jUZupR66abQ-wPaZg@mail.gmail.com>
	<570E316C.3010305@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:38093 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965192AbcDMMPp (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Wed, 13 Apr 2016 08:15:45 -0400
Received: by mail-wm0-f43.google.com with SMTP id u206so74146924wme.1
        for <linux-mmc@vger.kernel.org>; Wed, 13 Apr 2016 05:15:44 -0700 (PDT)
In-Reply-To: <570E316C.3010305@intel.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>

On 13 April 2016 at 13:45, Adrian Hunter <adrian.hunter@intel.com> wrote:
> On 13/04/16 14:42, Ulf Hansson wrote:
>> On 12 April 2016 at 13:25, Adrian Hunter <adrian.hunter@intel.com> wrote:
>>> ifdef's make the code more complicated and harder to read.
>>> Move all the LED code together to reduce the ifdef's to
>>> one place.
>>>
>>> Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
>>> ---
>>>  drivers/mmc/host/sdhci.c | 96 +++++++++++++++++++++++++++++++-----------------
>>>  1 file changed, 63 insertions(+), 33 deletions(-)
>>>
>>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>>> index be5b5c95138c..13f3dd8992d5 100644
>>> --- a/drivers/mmc/host/sdhci.c
>>> +++ b/drivers/mmc/host/sdhci.c
>>> @@ -38,11 +38,6 @@
>>>  #define DBG(f, x...) \
>>>         pr_debug(DRIVER_NAME " [%s()]: " f, __func__,## x)
>>>
>>> -#if defined(CONFIG_LEDS_CLASS) || (defined(CONFIG_LEDS_CLASS_MODULE) && \
>>> -       defined(CONFIG_MMC_SDHCI_MODULE))
>>> -#define SDHCI_USE_LEDS_CLASS
>>> -#endif
>>> -
>>>  #define MAX_TUNING_LOOP 40
>>>
>>>  static unsigned int debug_quirks = 0;
>>> @@ -246,7 +241,7 @@ static void sdhci_reinit(struct sdhci_host *host)
>>>         sdhci_enable_card_detection(host);
>>>  }
>>>
>>> -static void sdhci_activate_led(struct sdhci_host *host)
>>> +static void __sdhci_led_activate(struct sdhci_host *host)
>>
>> The renaming here seems a bit unnecessary, but more importantly why
>> can't you move these functions within the "if def sdhci leds" instead?
>
> They get used either way.  Either we use the LEDS subsystem (and mmc core
> controls them) or we turn them on/off directly from sdhci_request() etc.

That seems wrong. Moreover it changes the current behaviour.

I am not sure why you want to use the leds in case of when the LED
subsystem isn't available?

[...]

Kind regards
Uffe
