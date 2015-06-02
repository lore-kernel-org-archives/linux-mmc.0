From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] mmc: core: Attach PM domain prior probing of SDIO func driver
Date: Tue, 2 Jun 2015 09:54:13 +0200
Message-ID: <CAPDyKFr+SucSGZRigc4a6zei9TR4f5TuNHXTqWDDj2YQK1yn5A@mail.gmail.com>
References: <1433153905-25204-1-git-send-email-ulf.hansson@linaro.org>
	<20150601194209.GB30024@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mmc-owner@vger.kernel.org>
Received: from mail-qg0-f52.google.com ([209.85.192.52]:36770 "EHLO
	mail-qg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752854AbbFBHyO (ORCPT
	<rfc822;linux-mmc@vger.kernel.org>); Tue, 2 Jun 2015 03:54:14 -0400
Received: by qgf2 with SMTP id 2so56082830qgf.3
        for <linux-mmc@vger.kernel.org>; Tue, 02 Jun 2015 00:54:13 -0700 (PDT)
In-Reply-To: <20150601194209.GB30024@dtor-ws>
Sender: linux-mmc-owner@vger.kernel.org
List-Id: linux-mmc@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-mmc <linux-mmc@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>, Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Aaron Lu <aaron.lu@intel.com>

On 1 June 2015 at 21:42, Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> Hi Ulf,
>
> On Mon, Jun 01, 2015 at 12:18:25PM +0200, Ulf Hansson wrote:
>> Other subsystem buses attach PM domains during probe, but prior calling
>> the driver's ->probe() method. During the removal phase, detaching the PM
>> domain will be done after invoking the driver's ->remove() callback.
>>
>> Convert the SDIO bus to follow this behavior and add error handling.
>>
>> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>> ---
>>
>> A similar patch as $subject patch has been posted and discussed earlier.
>>
>> According to Aaron Lu, who added the initial support for the ACPI PM domain to
>> the SDIO bus, this change is safe.
>> http://www.spinics.net/lists/linux-mmc/msg28946.html
>>
>> ---
>>  drivers/mmc/core/sdio_bus.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/mmc/core/sdio_bus.c b/drivers/mmc/core/sdio_bus.c
>> index bee02e6..7e327a6 100644
>> --- a/drivers/mmc/core/sdio_bus.c
>> +++ b/drivers/mmc/core/sdio_bus.c
>> @@ -137,6 +137,10 @@ static int sdio_bus_probe(struct device *dev)
>>       if (!id)
>>               return -ENODEV;
>>
>> +     ret = dev_pm_domain_attach(dev, false);
>> +     if (ret == -EPROBE_DEFER)
>> +             return ret;
>
> Why do we handle only -EPROBE_DEFER? What about other errors? Maybe
> dev_pm_domain_attach() is too chatty?

Agree.

>
>> +
>>       /* Unbound SDIO functions are always suspended.
>>        * During probe, the function is set active and the usage count
>>        * is incremented.  If the driver supports runtime PM,
>> @@ -166,6 +170,7 @@ static int sdio_bus_probe(struct device *dev)
>>  disable_runtimepm:
>>       if (func->card->host->caps & MMC_CAP_POWER_OFF_CARD)
>>               pm_runtime_put_noidle(dev);
>> +     dev_pm_domain_detach(dev, false);
>
> If dev_pm_domain_attach() returned -EEXIST (which means that someone
> else attached the device to the domain) should we be detaching it?
>
> I realize that the other buses do the same thing, so these questions are
> general.

dev_pm_domain_attach() could take a closer look at what errors it gets
from acpi_dev_pm_attach() and genpd_dev_pm_attach(). In principle we
want the caller of dev_pm_domain_attach() to be able to consider all
returned error codes as errors, instead of just -EPROBE_DEFER.

On the other hand, the "long term plan" is to have PM domain pointers
assigned at device registration point instead of at probe. Since
driver core then invokes the ->activate|sync|dismiss() callbacks, it
will make the dev_pm_domain_attach|detach() APIs redundant.

So, I wonder if it's worth to update the buses/APIs in an intermediate
step (even if it would be an improvement), instead of working on
adopting the "long term plan". What do you think?

Kind regards
Uffe
