From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Runtime: Add helper function to get value of use_autosuspend
Date: Thu, 10 Oct 2013 17:40:08 +0200
Message-ID: <CAPDyKFp_jXQVOwGgsL5xxbge+iL=HwiQuckxwit1QRUcnedupw@mail.gmail.com>
References: <1381399307-21534-1-git-send-email-ulf.hansson@linaro.org>
	<1381399307-21534-2-git-send-email-ulf.hansson@linaro.org>
	<1949708.gMXnLB4oHE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-vc0-f170.google.com ([209.85.220.170]:46461 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755299Ab3JJPkK (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Thu, 10 Oct 2013 11:40:10 -0400
Received: by mail-vc0-f170.google.com with SMTP id lc6so1805694vcb.29
        for <linux-mmc@vger.kernel.org>; Thu, 10 Oct 2013 08:40:09 -0700 (PDT)
In-Reply-To: <1949708.gMXnLB4oHE@vostro.rjw.lan>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Chris Ball <cjb@laptop.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Alan Stern <stern@rowland.harvard.edu>, Mika Westerberg <mika.westerberg@linux.intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 10 October 2013 15:03, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Thursday, October 10, 2013 12:01:46 PM Ulf Hansson wrote:
>> In some cases it will be useful to know whether a device has the
>> autosuspend mode enabled. Provide a helper function that returns the
>> current setting.
>>
>> Cc: Len Brown <len.brown@intel.com>
>> Cc: Pavel Machek <pavel@ucw.cz>
>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>> Cc: Kevin Hilman <khilman@linaro.org>
>> Cc: Alan Stern <stern@rowland.harvard.edu>
>> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
>> Cc: linux-pm@vger.kernel.org
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>  include/linux/pm_runtime.h |    6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
>> index 6fa7cea..bcc2ad4 100644
>> --- a/include/linux/pm_runtime.h
>> +++ b/include/linux/pm_runtime.h
>> @@ -91,6 +91,11 @@ static inline bool pm_runtime_status_suspended(struct device *dev)
>>       return dev->power.runtime_status == RPM_SUSPENDED;
>>  }
>>
>> +static inline bool pm_runtime_autosuspend_used(struct device *dev)
>
> What about pm_runtime_autosuspend_in_use()?

That's better name, I send a new version soon.

Kind regards
Ulf Hansson

>
>> +{
>> +     return dev->power.use_autosuspend;
>> +}
>> +
>>  static inline bool pm_runtime_enabled(struct device *dev)
>>  {
>>       return !dev->power.disable_depth;
>> @@ -140,6 +145,7 @@ static inline void device_set_run_wake(struct device *dev, bool enable) {}
>>  static inline bool pm_runtime_suspended(struct device *dev) { return false; }
>>  static inline bool pm_runtime_active(struct device *dev) { return true; }
>>  static inline bool pm_runtime_status_suspended(struct device *dev) { return false; }
>> +static inline bool pm_runtime_autosuspend_used(struct device *dev) { return false; }
>>  static inline bool pm_runtime_enabled(struct device *dev) { return false; }
>>
>>  static inline int pm_generic_runtime_suspend(struct device *dev) { return 0; }
>>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
